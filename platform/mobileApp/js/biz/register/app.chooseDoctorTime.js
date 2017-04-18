$(function () {
    var previous = $("#previous");
    var next = $("#next");
    if (selectedIndex == 0) {
        previous.addClass("t-btn t-btn_left noData");
    }
    if (selectedIndex == (indexCount - 1)) {
        next.addClass("t-btn t-btn_right noData");
    }
    loadDoctorTimes();
    $("#next").click(function () {
        if (selectedIndex < 0) {
            selectedIndex = 0;
        }
        if (selectedIndex >= indexCount - 1) {
            selectedIndex = indexCount - 1;
            return;
        }
        if (selectedIndex < indexCount) {
            selectedIndex++;
            $("#selectDate").text(dateArray[selectedIndex]);
            $("#selectRegDate").val(dateArray[selectedIndex]);
            if (selectedIndex == (indexCount - 1)) {
                next.addClass("t-btn t-btn_right noData");
            }
            previous.removeClass("noData");
        }
        loadDoctorTimes();
    });

    $("#previous").click(function () {
        if (selectedIndex <= 0) {
            selectedIndex = 0;
            return;
        }
        if (selectedIndex >= 0) {
            selectedIndex--;
            $("#selectDate").text(dateArray[selectedIndex]);
            $("#selectRegDate").val(dateArray[selectedIndex]);
            if (selectedIndex == 0) {
                previous.addClass("t-btn t-btn_left noData");
            }
            next.removeClass("noData");
        }
        loadDoctorTimes();
    });
});

$('.t-header .t-btn').click(function () {
    var o = $(this);
    if (!o.hasClass('noData')) {
        o.addClass('active');
        setTimeout(function () {
            o.removeClass('active');
        }, 250)
    }
});

function doctorCart_show(obj) {
    var obj = $(obj).parents('.des')
    if (obj.hasClass('show')) {
        obj.removeClass('show');
        $("#hiddenInfo").hide();
        $("#hideLable").hide();
        $("#showInfo").show();
        $("#showLable").show();
    } else {
        obj.addClass('show');
        $("#hiddenInfo").show();
        $("#hideLable").show();
        $("#showInfo").hide();
        $("#showLable").hide();
    }
}

function loadDoctorTimes() {
    var doctimesDom = $("#doctimes");
    if (doctimesDom) {
        var datas = $("#paramsForm").serializeArray();
        var url = appPath + "mobileApp/register/doctorTime/loadDoctorTime";
        $Y.loading.show();
        $.ajax({
            type: 'POST',
            url: url,
            data: datas,
            dataType: 'json',
            timeout: 120000,
            success: function (data) {
                $Y.loading.hide();
                var doctorTimes = data.message.doctorTimes;
                var curTime = data.message.curTime;
                var curDate = data.message.curDate;
                var selectDate = $("#selectDate").text().substring(0, 10);
                if (doctorTimes) {
                    var htmlStr = "";
                    if (doctorTimes.length > 0) {
                        for (var i = 0; i < doctorTimes.length; i++) {
                            var workId = doctorTimes[i].workId;
                            if (!workId) {
                                workId = "";
                            }
                            var beginTime = doctorTimes[i].beginTime;
                            var endTime = doctorTimes[i].endTime;
                            var regFee = doctorTimes[i].regFee;
                            var treatFee = doctorTimes[i].treatFee == "" ? 0 : doctorTimes[i].treatFee;
                            var timeFlag = doctorTimes[i].timeFlag;
                            var sStreatFee = doctorTimes[i].sStreatFee;
                            // 该号源是否支持医保挂号，默认为1支持，0不支持
                            var regInsurance = doctorTimes[i].regInsurance;

                            if (isNull(endTime) || (doctorTimes[i].leftNum > 0 && (endTime > curTime || curDate < selectDate))) {
                                htmlStr += "<li class='t-item' onclick='confirmRegisterInfo(\"" + workId + "\",\"" + beginTime + "\",\""
                                    + endTime + "\",\"" + regFee + "\",\"" + treatFee + "\",\"" + sStreatFee + "\",\"" + timeFlag + "\",\""
                                    + regInsurance + "\")'>";
                            } else {
                                htmlStr += "<li class='t-item noData'>";
                            }

                            htmlStr += "    <div class='li-left'>"
                            if (!isNull(endTime)) {
                                htmlStr += "         <span class='time skinBgColor'>" + beginTime + " - " + endTime + "</span>";
                            } else {
                                if (timeFlag == '1') {
                                    htmlStr += "         <span class='time skinBgColor'>上午</span>";
                                } else if (timeFlag == '2') {
                                    htmlStr += "         <span class='time skinBgColor'>下午</span>";
                                } else if (timeFlag == '3') {
                                    htmlStr += "         <span class='time skinBgColor'>晚上</span>";
                                } else {
                                    htmlStr += "         <span class='time skinBgColor'>全天</span>";
                                }
                            }

                            htmlStr += "    </div>";
                            // htmlStr += "	   <span class='price'>" + ((parseInt(regFee) + parseInt(treatFee)) / 100) + "</span><span class='des'>元</span>";
                            // htmlStr += "    <div class='li-right'>";

                            htmlStr += "	   <span class='price'>";
                            // var branchHospitalCode = $('input[name="branchHospitalCode"]').val();
                            if(((parseInt(regFee) + parseInt(treatFee)) / 100) != 0){
                                htmlStr += ((parseInt(regFee) + parseInt(treatFee)) / 100);
                                htmlStr += "</span><span class='des'>";
                                htmlStr += "元";
                            }
                            htmlStr += "</span>"

                            htmlStr += "    <div class='li-right'>";

                            if (doctorTimes[i].leftNum > 0 && (!isNull(endTime) && (endTime > curTime || curDate < selectDate))) {
                                htmlStr += "可挂号   <i class='icon-arrow'></i>";
                            } else if (doctorTimes[i].leftNum == 0) {
                                htmlStr += "满号";
                            } else {
                                if (!isNull(endTime) && curTime > endTime && curDate == selectDate) {
                                    htmlStr += "过期";
                                } else if (isNull(endTime) && !isNull(beginTime)
                                        && (curDate < selectDate || (beginTime >= curTime && curDate == selectDate))) {
                                    htmlStr += "可挂号 <i class='icon-arrow'></i>";
                                } else if (isNull(endTime) && isNull(beginTime)) {
                                    //显示上下午时间格式的判断
                                    htmlStr += "可挂号 <i class='icon-arrow'></i>";
                                } else if (isNull(endTime) && !isNull(beginTime) && beginTime >= curTime && curDate == selectDate) {
                                    //时间点过期的判断
                                    htmlStr += "过期";
                                }
                            }

                            htmlStr += "	    </div>";
                            htmlStr += "</li>";
                        }
                    } else {
                        htmlStr = "<li style='text-align: left;height:auto;min-height:53px;'>无分时号源信息,请您选择其它医生进行挂号!</li>";
                    }
                    doctimesDom.html(htmlStr)
                } else {
                    new $Y.confirm({
                        content: '<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                        ok: {title: '确定'}
                    })
                }
            },
            error: function (data) {
                $("#paramsForm").attr("action", appPath + "mobileApp/register/doctorTime/index");
                $("#paramsForm").submit();
            }
        });
    }
}

function confirmRegisterInfo(workId, beginTime, endTime, regFee, treatFee, sStreatFee, timeFlag, regInsurance) {
    $("#workId").val(workId);
    if (!isNull(endTime)) {
        $("#doctorEndTime").val(endTime);
    }
    if (!isNull(beginTime)) {
        $("#doctorBeginTime").val(beginTime);
    }
    if (!isNull(timeFlag)) {
        $("#timeFlag").val(timeFlag);
    }
    if (!isNull(regInsurance)) {
        $("#regInsurance").val(regInsurance);
    } else {
    	$("#regInsurance").val(null);
    }
    
    $("#regFee").val(convertInt(regFee));
    $("#treatFee").val(convertInt(treatFee));
    $("#sStreatFee").val(convertInt(sStreatFee));
    $("#paramsForm").attr("action", appPath + "mobileApp/register/confirm/registerInfo");
    $("#paramsForm").submit();
}

function convertInt(fee) {
    if (regFee) {
        var index = fee.indexOf(".");
        if (index > -1) {
            fee = fee.substring(0, index);
        }
    }
    return fee;
}

function isNull(str) {
    var flag = false;
    if (str === window.undefined || str == null || str == "" || str.length == 0 || str == "null") {
        flag = true;
    }
    return flag;
}