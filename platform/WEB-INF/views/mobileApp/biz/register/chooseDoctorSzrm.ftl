<html>
<head>
<#include "/mobileApp/common/common.ftl">
    <title>${commonParams.deptName}</title>
    <style>
        <#if commonParams.isBqReg=='true'>
            #body #select-date .date {
                color: #bbb;
                font-weight: normal;
            }

            #select-date .week {
                color: #999999;
                font-weight: normal;
            }
        <#else>
            #body #select-date .date {
                color: #333333;
                font-weight: normal;
            }

            #select-date .week {
                color: #333333;
                font-weight: normal;
            }
        </#if>

        #select-date .active .week {
            color: #2297f7;
            font-weight: bold;
        }

        #body #select-date .active .date {
            color: #2297f7;
            font-weight: bold;
        }

        #body .desc {
            color: #ccc;
        }
    </style>
</head>
<body>
<div id="body">
    <div id="select-date"></div>
    <#if isHasDutyReg == 1>
        <#if onDutyRegTipContent ? if_exists>
            <div class="section">
                <div class="box-tips"><i class="icon-warn"></i> 温馨提示：${onDutyRegTipContent}</div>
            </div>
        </#if>
    </#if>
    <div class="section doctor-list">
        <ul id="doctorList">
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
    <input type="hidden" id="doctorTitle" name="doctorTitle" value="${commonParams.doctorTitle}">
    <input type="hidden" id="doctorCode" name="doctorCode" value="${commonParams.doctorCode}">
    <input type="hidden" id="doctorName" name="doctorName" value="${commonParams.doctorName}">
    <input type="hidden" id="selectRegDate" name="selectRegDate" value="${commonParams.selectRegDate}">
    <input type="hidden" id="category" name="category" value="${commonParams.category}">
    <input type="hidden" id="isHasDutyReg" name="isHasDutyReg" value="${isHasDutyReg}"/>
    <input type="hidden" id="nextDay" name="nextDay" value="${nextDay}"/>
    <input type="hidden" id="isSearchDoctor" name="isSearchDoctor" value="${commonParams.isSearchDoctor}"/>
    <input type="hidden" id="isHasAppointmentReg" name="isHasAppointmentReg" value="${isHasAppointmentReg}"/>
    <input type="hidden" id="regType" name="regType" value="${commonParams.regType}"/>
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}"/>
    <input type="hidden" id="viaFlag" name="viaFlag" value="${viaFlag}"/>
    <input type="hidden" id="regFee" name="regFee" value="${commonParams.regFee}"/>
    <input type="hidden" id="treatFee" name="treatFee" value="${commonParams.treatFee}"/>
    <input type="hidden" id="sStreatFee" name="sStreatFee" value="${commonParams.sStreatFee}"/>
    <!--深圳人民附加参数-->
    <input type="hidden" id="isBqReg" name="isBqReg" value="${commonParams.isBqReg}"/>
    <input type="hidden" id="tcInfo" name="tcInfo" value="${commonParams.tcInfo}" />
    <input type="hidden" id="workId" name="workId" value="${commonParams.workId}" />
    <!--<button type="button" onclick="doRefresh()">doRefresh</button>
    <button type="button" onclick="doGoBack()">doGoBack</button> -->
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
<#--<script type="text/javascript" src="${basePath}mobileApp/js/biz/register/app.chooseDoctor.js"></script>-->
<script type="text/javascript">
    var viaFlag = '${viaFlag}';
    function doRefresh() {
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
        freshForm.append($('<input type="hidden"  name="searchType" value="${searchType}"/>'));
        freshForm.append($('<input type="hidden"  name="searchStr" value="${searchStr}"/>'));
        freshForm.appendTo("body");
        freshForm.css('display', 'none');
        freshForm.attr("method", "post");
        freshForm.attr("action", "${basePath}mobileApp/register/doctor/index");
        freshForm.submit();
    }

    function doGoBack() {
        if (viaFlag.indexOf('search') != -1) {
            var freshFrom = $("<form></form>");
            freshFrom.append($('<input type="hidden" name="openId" value="${commonParams.openId}"/>'));
            freshFrom.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}"/>'));
            freshFrom.append($('<input type="hidden" name="areaCode" value="${commonParams.areaCode}"/>'));
            freshFrom.append($('<input type="hidden" id="searchType" name="searchType" value="${searchType}">'));
            freshFrom.append($('<input type="hidden" id="searchStr" name="searchStr" value="${searchStr}">'));
            freshFrom.append($('<input type="hidden" id="viaFlag" name="viaFlag" value="searchDoctor">'));
            freshFrom.append($('<input type="hidden" id="isSearchDoctor" name="isSearchDoctor" value="1">'));
            freshFrom.appendTo("body");
            freshFrom.css('display', 'none');
            freshFrom.attr("method", "post");
            freshFrom.attr("action", "${basePath}easyhealth/search/index");
            freshFrom.submit();
        } else {
            var freshFrom = $("<form></form>");
            freshFrom.append($('<input type="hidden" name="branchHospitalId" value="${commonParams.branchHospitalId}"/>'));
            freshFrom.append($('<input type="hidden" name="branchHospitalCode" value="${commonParams.branchHospitalCode}"/>'));
            freshFrom.append($('<input type="hidden" name="branchHospitalName" value="${commonParams.branchHospitalName}"/>'));
            freshFrom.append($('<input type="hidden" name="appId" value="${commonParams.appId}"/>'));
            freshFrom.append($('<input type="hidden" name="openId" value="${commonParams.openId}"/>'));
            freshFrom.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}"/>'));
            freshFrom.append($('<input type="hidden" name="areaCode" value="${commonParams.areaCode}"/>'));
            freshFrom.append($('<input type="hidden" name="regType" value="${commonParams.regType}"/>'));
            freshFrom.append($('<input type="hidden" name="hospitalId" value="${commonParams.hospitalId}"/>'));
            freshFrom.append($('<input type="hidden" name="hospitalCode" value="${commonParams.hospitalCode}"/>'));
            freshFrom.append($('<input type="hidden" name="hospitalName" value="${commonParams.hospitalName}"/>'));
            freshFrom.appendTo("body");
            freshFrom.css('display', 'none');
            freshFrom.attr("method", "post");
            freshFrom.attr("action", "${basePath}mobileApp/register/refreshDepts");
            freshFrom.submit();
        }
    }

    /**
     * Yuce
     * 2015-06-10
     * yu.ce@foxmail.com
     */
    // 时间插件
    var isHadInit = false;

    var isBqReg = $("#isBqReg").val();

    var tcInfo = $("#tcInfo").val();

    $(function () {
        var Time = {};

        function getToday() {
            var myDate = new Date();
            var Y = myDate.getFullYear();
            var M = myDate.getMonth();
            var D = myDate.getDate();
//                var date = Y + '-' + M + '-' + D;
            Time.Y = Y;
            Time.M = M;
            Time.D = D;
        }

        getToday();

        //获取月份的天数
        Time.getDaysInMonth = function (year, month) {
            return 32 - new Date(year, month, 32).getDate();
        }

        //获取月份中的第一天是所在星期的第几天
        // month：(0--11) 月份从0开始
        // return (0-6) 0：星期日 1：星期一 ...
        Time.getFirstDayOfMonth = function (year, month, day) {
            var day = day || 1;
            return new Date(year, month, day).getDay();
        };

        window.myDate = Time;

        //计算日历显示的高度  add by yuce
        var showDays = 7;
        var isHasDutyReg = 1;
        var showDaysDom = $("#showDays");
        var isHasDutyRegDom = $("#isHasDutyReg");
        var isHasAppointmentReg = $("#isHasAppointmentReg").val();

        if (showDaysDom) {
            showDays = $(showDaysDom).val();
        }

        if (isHasDutyRegDom) {
            isHasDutyReg = $(isHasDutyRegDom).val();
        }

        var height = 90 * ( 1 + Math.ceil((showDays - 4) / 5));

        Time.Run = function () {
            //如果是病区号源，则只能选择当天
            var str_class = 'd-grid noHook clickable';
            if(isBqReg == 'true'){
                isHasAppointmentReg = 0;
                str_class = 'd-grid noHook';
            }
            var my_width = $(window).width() / 5;
            my_width++;
            var html = '';
            var p = Time.D;
            var week = Time.getFirstDayOfMonth(Time.Y, Time.M, Time.D);
            for (var i = 1; i <= showDays; i++) {
                if (p > Time.getDaysInMonth(Time.Y, Time.M)) {
                    p = 1;
                }
                if (week > 6) {
                    week = 0;
                }
                var w = '';
                switch (week) {
                    case 0:
                        w += '日';
                        break;
                    case 1:
                        w += '一';
                        break;
                    case 2:
                        w += '二';
                        break;
                    case 3:
                        w += '三';
                        break;
                    case 4:
                        w += '四';
                        break;
                    case 5:
                        w += '五';
                        break;
                    case 6:
                        w += '六';
                        break;
                }
                if (p == Time.D) {
                    if (isHasDutyReg == 1) {
                        html += '<div class="d-grid goHook active clickable" style="width:'
                    } else {
                        html += '<div class="'+str_class+'" style="width:'
                    }
                    html += my_width
                            + 'px"> <div class="d-grid-content"><span class="week">'
                            + w
                            + '</span><span class="date">今</span></div><div class="border"></div><div class="right-border"></div><div class="border-arrow"></div></div>';
                } else if (i == 5) {
                    html += '<div class="d-grid" style="width:'
                            + (my_width - 1)
                            + 'px" onclick="$Time.toggle(this)" > <div class="d-grid-content"><div class="d-title"><i class="icon-arrow-show"></i><br/><span>展开</span></div></div><div class="border"></div><div class="right-border" style="border: none"></div><div class="border-arrow"></div> </div>';
                    if (isHasAppointmentReg == 1) {
                        html += '<div class="d-grid goHook clickable" style="width:';
                    } else {
                        html += '<div class="'+str_class+'" style="width:'
                    }
                    html += my_width
                            + 'px"> <div class="d-grid-content"><span class="week">'
                            + w
                            + '</span><span class="date">'
                            + p
                            + '</span></div><div class="border"></div><div class="right-border"></div><div class="border-arrow"></div> </div>';
                } else {
                    if (i == 9 || i == 14 || i == 19 || i == 24 || i == 29 || i == 34) {
                        if (isHasAppointmentReg == 1) {
                            html += '<div class="d-grid goHook clickable" style="width:';
                        } else {
                            html += '<div class="'+str_class+'" style="width:'
                        }
                        html += (my_width - 1)
                                + 'px;"> <div class="d-grid-content"> <span class="week">'
                                + w
                                + '</span><span class="date">'
                                + p
                                + '</span></div><div class="border"></div><div class="right-border" style="border: none"></div><div class="border-arrow"></div> </div>';
                    } else {
                        if (isHasDutyReg == 0 && i == 2) {
                            html += '<div class="d-grid goHook active clickable" style="width:'
                        } else {
                            if (isHasAppointmentReg == 1) {
                                html += '<div class="d-grid goHook clickable" style="width:';
                            } else {
                                html += '<div class="'+str_class+'" style="width:'
                            }
                        }
                        html += my_width
                                + 'px"> <div class="d-grid-content"> <span class="week">'
                                + w
                                + '</span><span class="date">'
                                + p
                                + '</span></div><div class="border"></div><div class="right-border" ></div><div class="border-arrow"></div> </div>';
                    }
                }
                p++;
                week++;
            }

            $('#select-date').html(html);

            Time.toggle = function (obj) {
                var index = $('.d-grid.active').index();
                var obj = $(obj);
                var t = obj.find('.d-title');
                if (t.hasClass('up')) {
                    t.removeClass('up');
                    t.find('span').html('展开');
                    $('#select-date').removeClass('show');
                    $('#select-date').css({height: 89});

                    if (index > 3) {
                        $('.d-grid.active .border-arrow').hide();
                    }
                } else {
                    t.addClass('up');
                    t.find('span').html('收起')
                    $('#select-date').addClass('show');
                    $('#select-date').css({height: height});
                    //                    $('#select-date').animate({height:268},200)
                    $('.d-grid.active .border-arrow').show();
                    var size = $('.d-grid').size();
                    var yu = size % 5;
                    $('.d-grid').slice(size - yu).find('.border').hide();
                }
            }

            Time.goHook = function () {
                if ($(this).hasClass('active')) {
                    return false;
                }

                $("#select-date .active").addClass("noHook").removeClass("goHook").removeClass("active");
                $(this).removeClass("noHook").addClass("goHook").addClass("active");

                if (!$(this).hasClass('noNum')) {
                    $('.d-grid.goHook').removeClass('active');
                    $('.d-grid.goHook .border-arrow').removeAttr('style')
                    $(this).addClass('active')
                    var hookDate;
                    var hookDays = $(this).find(".date").text();
                    //大于今天的日期  可判断为本月的日期
                    if (hookDays > Time.D) {
                        hookDate = Time.Y + "-" + completeDateNum(Time.M + 1) + "-" + completeDateNum(hookDays);
                    } else if (hookDays < Time.D) {
                        //小于今天的日期  可判断为下个月的日期
                        //判断本月是否为12月 若是 则年要加1
                        if (Time.M == 11) {
                            hookDate = (Time.Y + 1) + "-01-" + completeDateNum(hookDays);
                        } else {
                            hookDate = Time.Y + "-" + completeDateNum(Time.M + 2) + "-" + completeDateNum(hookDays);
                        }
                    } else {
                        hookDate = Time.Y + "-" + completeDateNum(Time.M + 1) + "-" + completeDateNum(Time.D)
                    }
                    loadDoctorList(hookDate);
                }
            }

            $('.clickable').on('click', Time.goHook);
        }

        Time.Run();
        window.$Time = Time;

        if (!isHadInit && isHasDutyReg == 1) {
            loadDoctorList(Time.Y + "-" + completeDateNum(Time.M + 1) + "-" + completeDateNum(Time.D));
        }
        if (!isHadInit && isHasDutyReg == 0) {
            var nextDay = $("#nextDay").val()
            loadDoctorList(nextDay);
        }
    });

    function completeDateNum(num) {
        if (num < 10) {
            return "0" + num;
        } else {
            return num;
        }
    }

    function loadDoctorList(hookDate) {
        $("#selectRegDate").val(hookDate);

        var url = appPath + "mobileApp/register/doctor/queryDoctorList?timeTemp=" + new Date().valueOf();

        var datas = $("#paramsForm").serializeArray();
        var doctorList = $("#doctorList");
        if (doctorList) {
            $Y.loading.show();
            $.ajax({
                type: 'POST',
                url: url,
                data: datas,
                dataType: 'json',
                timeout: 120000,
                success: function (data) {
                    $Y.loading.hide();
                    successExe(data);
                },
                error: function () {
                    //解决3星手机使用物理返回时数据加载
                    $("#paramsForm").attr("action", appPath + "mobileApp/register/doctor/index?timeTemp=" + timeTemp);
                    $("#paramsForm").submit();
                }
            });
        }
    }

    function successExe(data) {
        var doctorList = $("#doctorList");
        var isTimeValid = data.message.isTimeValid;
        var htmlStr = "";
        if (isTimeValid) {
            var doctors = data.message.doctors;
            if (doctors) {
                if (doctors.length > 0) {
                    for (var i = 0; i < doctors.length; i++) {
                        var workId = doctors[i].details==null?'':doctors[i].details[0].workId;
                        var regFee = doctors[i].details==null?0:(doctors[i].details[0].regFee==null?0:doctors[i].details[0].regFee);
                        var treatFee = doctors[i].details==null?0:(doctors[i].details[0].treatFee==null?0:doctors[i].details[0].treatFee);
                        var sStreatFee = doctors[i].details==null?0:(doctors[i].details[0].sStreatFee==null?0:doctors[i].details[0].sStreatFee);

                        //测试
//                        workId='8756||936';
//                        regFee = 1000;
//                        treatFee = 0;
//                        sStreatFee=0;

                        var picUrl = doctors[i].picture==null?'':doctors[i].picture;
                        if (picUrl == "null" || picUrl == "" || picUrl == null) {
                            picUrl = appPath + "mobileApp/images/touxiang.png"
                        }
                        var doctorTitle = doctors[i].doctorTitle==null?'':doctors[i].doctorTitle;
                        // alert(doctors[i].doctorCode);
                        //病区号源
                        if(isBqReg == 'true'){
                            htmlStr += "<li onclick='confirmRegisterInfo(\"" + workId + "\",\"" + regFee + "\",\"" + treatFee + "\",\"" + sStreatFee + "\",\"" + doctors[i].doctorName + "\",\"" + doctors[i].doctorCode + "\",\"" + doctorTitle + "\")' >";
                        }else{
                            htmlStr += "<li onclick='goDoctorTimeList(\"" + doctors[i].doctorCode + "\",\"" + doctors[i].deptCode + "\",\"" + doctors[i].deptName + "\",\"" + doctors[i].category + "\",\"" + doctors[i].picture + "\")' >";
                        }
                        htmlStr += "    <div class='pic'><img src='" + picUrl + "'  width='65' height='65'/></div>";
                        htmlStr += "    <div class='info'>"
                        htmlStr += "         <div class='name'>" + doctors[i].doctorName + "</div>"
                        htmlStr += "         <div> " + ((doctors[i].doctorTitle == "null" || doctors[i].doctorTitle == null) ? "" : doctors[i].doctorTitle) + "</div>"
                        //病区号源
                        var tcList = tcInfo.split("|");
                        htmlStr += "<div>挂号费<span class='price'>"+((parseInt(regFee) + parseInt(treatFee)) / 100)+"</span><span class='desc'>元</span>";
                        if(tcList.length>0 && tcList[2]!=''){
                            htmlStr += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;检查费<span class='price'>"+parseInt(tcList[2]) / 100+"</span><span class='desc'>元</span></div>";
                            //<span class='desc'>"+tcList[1]+"</span>
                        }else{
                            htmlStr += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class='price'></span></div>";
                        }

                        if (doctors[i].leftTotalNum != 'NaN') {
                            htmlStr += " <div>剩余<span class='skinColor fontSize120'>" + (doctors[i].leftTotalNum < 0 ? 0 : doctors[i].leftTotalNum) + "</span>个号</div>"
                        }
                        htmlStr += "	</div>";
                        htmlStr += "    <div class='li-right'>";
                        if (doctors[i].category == "1") {
                            htmlStr += "    <span class='tag skinBgColor label'>专家号</span>";
                        }
                        htmlStr += "    	<i class='icon-arrow'></i>";
                        htmlStr += "    </div>";
                        htmlStr += "</li>"
                    }
                } else {
                    htmlStr += "<li class='noData'>";
                    htmlStr += data.message.noSourceTipContent;
                    htmlStr += "</li>";
                }
            } else {
                htmlStr += "<li class='noData'>";
                htmlStr += "网络异常,获取号源信息失败,请您重新操作!";
                htmlStr += "</li>";
            }
        } else {
            htmlStr += "<li class='noData'>";
            htmlStr += data.message.timeValidTip;
            htmlStr += "</li>";
        }
        doctorList.html(htmlStr);
    }

    /**
     * 分时号源查询
     *
     * @returns
     */
    function goDoctorTimeList(doctorCode, deptCode, deptName, category, picture) {
        $("#doctorCode").val(doctorCode);
        $("#deptCode").val(deptCode);
        if (deptName != '' && deptName != null && deptName != "null") {
            $("#deptName").val(deptName);
        }
        $("#category").val(category);
        //添加时间戳  解决移动段 返回不请求服务端的bug
        var now = new Date();
        var timeTemp = now.getTime();
        $("#paramsForm").attr("action", appPath + "mobileApp/register/doctorTime/index?timeTemp=" + timeTemp);
        $("#paramsForm").submit();
    }

    /**
     * 确认病区挂号
     *
     * @returns
     */
    function confirmRegisterInfo(workId, regFee, treatFee, sStreatFee, doctorName, doctorCode, doctorTitle) {
        $("#workId").val(workId);
        $("#doctorName").val(doctorName);
        $("#doctorCode").val(doctorCode);
        $("#doctorTitle").val(doctorTitle);
        $("#regFee").val(convertInt(regFee));
        $("#treatFee").val(convertInt(treatFee));
        $("#sStreatFee").val(convertInt(sStreatFee));
        $("#paramsForm").attr("action", appPath + "mobileApp/register/confirm/registerInfo");
        $("#paramsForm").submit();
    }

    function convertInt(fee) {
        if (fee) {
            var index = fee.indexOf(".");
            if (index > -1) {
                fee = fee.substring(0, index);
            }
        }
        return fee;
    }
</script>
</body>
</html>
