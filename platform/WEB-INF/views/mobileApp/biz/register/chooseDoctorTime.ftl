<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <title>选时间</title>
</head>
<body>
<div id="body">
    <div class="section doctor-list">
        <ul>
            <li class="doctorCart" style="margin:0 0 1px">
                <div class="pic">
                <#if commonParams.doctorPic == "">
                    <img src="${basePath}/mobileApp/images/touxiang.png" width="65" height="65"/>
                <#else>
                    <img src="${commonParams.doctorPic}" width="65" height="65"/>
                </#if>
                </div>
                <div class="info">
                    <div class="name">${commonParams.doctorName}</div>
                    <div>${commonParams.doctorTitle}</div>
                </div>
                <div class="li-right">
                <#if commonParams.category == "1">
                    <span class="tag skinBgColor">专家号</span>
                </#if>
                </div>
                <div style="clear: both;height:2px;"></div>
            <#if commonParams.doctorIntrodution ??>
                <div class="des">
                    <#if commonParams.doctorIntrodution?length < 50 >
                        ${commonParams.doctorIntrodution}
                    <#else>
                        <span id="showInfo" style="display:''">${commonParams.doctorIntrodution?substring(0,30)}...</span>
                        <span id="showLable" style="display:''" class="more skinColor" onclick="doctorCart_show(this)">展开</span>
                        <span id="hiddenInfo" style="display:none">${commonParams.doctorIntrodution}</span>
                        <span id="hideLable" style="display:none" class="more skinColor" onclick="doctorCart_show(this)">收起</span>
                    </#if>
                </div>
            </#if>
            </li>
        </ul>
    </div>

    <div class="section time-list">
        <ul id="doctimes_header">
            <li class="t-header-w">
                <div class="t-header">
                    <div id="previous" class="t-btn t-btn_left"></div>
                    <div id="selectDate">${selectedDate}</div>
                    <div id="next" class="t-btn t-btn_right"></div>
                </div>
            </li>
        </ul>
        <ul id="doctimes">
        </ul>
    </div>
</div>
<form id="paramsForm" method="post">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}"/>
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
    <input type="hidden" id="showDays" name="showDays" value="${showDays}">
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
    <input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}"/>
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}"/>
    <input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}"/>
    <input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}"/>
    <input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}"/>
    <input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}"/>
    <input type="hidden" id="deptCode" name="deptCode" value="${commonParams.deptCode}">
    <input type="hidden" id="deptName" name="deptName" value="${commonParams.deptName}">
    <input type="hidden" id="doctorCode" name="doctorCode" value="${commonParams.doctorCode}">
    <input type="hidden" id="doctorName" name="doctorName" value="${commonParams.doctorName}">
    <input type="hidden" id="selectRegDate" name="selectRegDate" value="${commonParams.selectRegDate}">
    <input type="hidden" id="category" name="category" value="${commonParams.category}">
    <input type="hidden" id="doctorTitle" name="doctorTitle" value="${commonParams.doctorTitle}">
    <input type="hidden" id="doctorBeginTime" name="doctorBeginTime" value="${commonParams.doctorBeginTime}">
    <input type="hidden" id="doctorEndTime" name="doctorEndTime" value="${commonParams.doctorEndTime}">
    <input type="hidden" id="regFee" name="regFee" value="${commonParams.regFee}">
    <input type="hidden" id="treatFee" name="treatFee" value="${commonParams.treatFee}"/>
    <input type="hidden" id="regType" name="regType" value="${commonParams.regType}"/>
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}"/>
    <input type="hidden" id="workId" name="workId" value="${commonParams.workId}"/>
    <input type="hidden" id="timeFlag" name="timeFlag" value="${commonParams.timeFlag}"/>
    <input type="hidden" id="sStreatFee" name="sStreatFee" value="${commonParams.sStreatFee}"/>
    <input type="hidden" id="viaFlag" name="viaFlag" value="${viaFlag}"/>
    <!--深圳人民附加参数-->
    <input type="hidden" id="isBqReg" name="isBqReg" value="${commonParams.isBqReg}"/>
    <input type="hidden" id="tcInfo" name="tcInfo" value="${commonParams.tcInfo}" />
    <!-- add by zw 2016-07-05 该号源是否支持医保支付 -->
    <input type="hidden" id="regInsurance" name="regInsurance" value="${commonParams.regInsurance}">

    <!--<button type="button" onclick="doRefresh()">doRefresh</button>
    <button type="button" onclick="doGoBack()">doGoBack</button>-->
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
<#--<script type="text/javascript" src="${basePath}mobileApp/js/biz/register/app.chooseDoctorTime.js?v=1.0"></script>-->
</body>
</html>
<script type="text/javascript">
    var selectedIndex = ${selectedIndex};
    var indexCount = ${showDays};
    var optionalDates = '${optionalDates}';
    var viaFlag = '${viaFlag}';
    var dateArray = optionalDates.split(",");

    function doRefresh() {
        var now = new Date();
        var timeTemp = now.getTime();
        var selectDate = $("#selectDate").text().substring(0, 10);
        if (viaFlag.indexOf('history') != -1 || viaFlag.indexOf('search') != -1 || viaFlag.indexOf('regDoctor') != -1) {
            window.location.href = "${basePath}mobileApp/register/doctorTime/index?timeTemp=" + timeTemp + "&branchHospitalId=${commonParams.branchHospitalId}&branchHospitalCode=${commonParams.branchHospitalCode}"
                    + "&branchHospitalName=${commonParams.branchHospitalName}&selectRegDate=" + selectDate + "&category=${commonParams.category}&isHasDutyReg=${isHasDutyReg}&nextDay=${nextDay}"
                    + "&isSearchDoctor=${commonParams.isSearchDoctor}&isHasAppointmentReg=${isHasAppointmentReg}&showDays=${showDays}&deptCode=${commonParams.deptCode}&deptName=${commonParams.deptName}"
                    + "&doctorCode=${commonParams.doctorCode}&appId=${commonParams.appId}&openId=${commonParams.openId}&appCode=${commonParams.appCode}&areaCode=${commonParams.areaCode}&userId=${commonParams.userId}"
                    + "&regType=${commonParams.regType}&hospitalId=${commonParams.hospitalId}&hospitalCode=${commonParams.hospitalCode}&hospitalName=${commonParams.hospitalName}&viaFlag=${viaFlag}";
        } else {
            window.location.href = "${basePath}mobileApp/register/doctorTime/index?timeTemp=" + timeTemp + "&branchHospitalId=${commonParams.branchHospitalId}&branchHospitalCode=${commonParams.branchHospitalCode}"
                    + "&branchHospitalName=${commonParams.branchHospitalName}&selectRegDate=" + selectDate + "&category=${commonParams.category}&isHasDutyReg=${isHasDutyReg}&nextDay=${nextDay}"
                    + "&isSearchDoctor=${commonParams.isSearchDoctor}&isHasAppointmentReg=${isHasAppointmentReg}&showDays=${showDays}&deptCode=${commonParams.deptCode}&deptName=${commonParams.deptName}"
                    + "&doctorCode=${commonParams.doctorCode}&appId=${commonParams.appId}&openId=${commonParams.openId}&appCode=${commonParams.appCode}&areaCode=${commonParams.areaCode}"
                    + "&regType=${commonParams.regType}&hospitalId=${commonParams.hospitalId}&hospitalCode=${commonParams.hospitalCode}&hospitalName=${commonParams.hospitalName}&userId=${commonParams.userId}";
        }
    }

    function doGoBack() {
        if (viaFlag.indexOf('history') != -1) {
            window.location.href = "${basePath}/easyhealth/usercenter/historyRegDoctorIndex?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng";
        }
        else if (viaFlag.indexOf('search') != -1) {
            var freshForm = $("<form></form>");
            freshForm.append($('<input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />'));
            freshForm.append($('<input type="hidden" name="branchHospitalId" value="${commonParams.branchHospitalId}"/>'));
            freshForm.append($('<input type="hidden" name="branchHospitalCode" value="${commonParams.branchHospitalCode}"/>'));
            freshForm.append($('<input type="hidden" name="branchHospitalName" value="${commonParams.branchHospitalName}"/>'));
            freshForm.append($('<input type="hidden"  name="deptCode" value="${commonParams.deptCode}">'));
            freshForm.append($('<input type="hidden"  name="deptName" value="${commonParams.deptName}">'));
            freshForm.append($('<input type="hidden"  name="doctorCode" value="${commonParams.doctorCode}">'));
            freshForm.append($('<input type="hidden" name="appId" value="${commonParams.appId}"/>'));
            freshForm.append($('<input type="hidden" name="openId" value="${commonParams.openId}"/>'));
            freshForm.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}"/>'));
            freshForm.append($('<input type="hidden" name="areaCode" value="${commonParams.areaCode}"/>'));
            freshForm.append($('<input type="hidden" name="regType" value="${commonParams.regType}"/>'));
            freshForm.append($('<input type="hidden" name="hospitalId" value="${commonParams.hospitalId}"/>'));
            freshForm.append($('<input type="hidden" name="hospitalCode" value="${commonParams.hospitalCode}"/>'));
            freshForm.append($('<input type="hidden" name="hospitalName" value="${commonParams.hospitalName}"/>'));
            freshForm.append($('<input type="hidden" name="viaFlag" value="${viaFlag}"/>'));
            freshForm.appendTo("body");
            freshForm.css('display', 'none');
            freshForm.attr("method", "post");
            freshForm.attr("action", "${basePath}mobileApp/register/doctor/index");
            freshForm.submit();
        } else if (viaFlag.indexOf('regDoctor') != -1) {
            window.location.href = appPath + "easyhealth/healthlist/regDoctor/index?openId=${commonParams.openId}&appCode=easyHealth&areaCode=ShenZheng";
        } else {
            var freshForm = $("<form></form>");
            freshForm.append($('<input type="hidden" name="branchHospitalId" value="${commonParams.branchHospitalId}"/>'));
            freshForm.append($('<input type="hidden" name="branchHospitalCode" value="${commonParams.branchHospitalCode}"/>'));
            freshForm.append($('<input type="hidden" name="branchHospitalName" value="${commonParams.branchHospitalName}"/>'));
            freshForm.append($('<input type="hidden"  name="deptCode" value="${commonParams.deptCode}">'));
            freshForm.append($('<input type="hidden"  name="deptName" value="${commonParams.deptName}">'));
            freshForm.append($('<input type="hidden"  name="doctorCode" value="${commonParams.doctorCode}">'));
            freshForm.append($('<input type="hidden" name="appId" value="${commonParams.appId}"/>'));
            freshForm.append($('<input type="hidden" name="openId" value="${commonParams.openId}"/>'));
            freshForm.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}"/>'));
            freshForm.append($('<input type="hidden" name="areaCode" value="${commonParams.areaCode}"/>'));
            freshForm.append($('<input type="hidden" name="regType" value="${commonParams.regType}"/>'));
            freshForm.append($('<input type="hidden" name="hospitalId" value="${commonParams.hospitalId}"/>'));
            freshForm.append($('<input type="hidden" name="hospitalCode" value="${commonParams.hospitalCode}"/>'));
            freshForm.append($('<input type="hidden" name="hospitalName" value="${commonParams.hospitalName}"/>'));
            freshForm.appendTo("body");
            freshForm.css('display', 'none');
            freshForm.attr("method", "post");
            freshForm.attr("action", "${basePath}mobileApp/register/doctor/index");
            freshForm.submit();
        }
    }

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

                                var hospitalCode = $('#hospitalCode').val();

                                htmlStr += "    </div>";
                                if(hospitalCode == 'szsrmyy' || hospitalCode == 'szsrmyylhfy'){
                                    htmlStr += "	   <span class='price'></span>";
                                }else{
//                                    htmlStr += "	   <span class='price'>" + ((parseInt(regFee) + parseInt(treatFee)) / 100) + "</span><span class='des'>元</span>";
                                    //挂号零元不显示 wwb 20161209
                                    htmlStr += "	   <span class='price'>";
                                    // var branchHospitalCode = $('input[name="branchHospitalCode"]').val();
                                    if(((parseInt(regFee) + parseInt(treatFee)) / 100) != 0){
                                        htmlStr += ((parseInt(regFee) + parseInt(treatFee)) / 100);
                                        htmlStr += "</span><span class='des'>";
                                        htmlStr += "元";
                                    }
                                    htmlStr += "</span>"
                                }
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
</script>
