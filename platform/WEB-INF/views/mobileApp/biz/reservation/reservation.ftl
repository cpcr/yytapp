<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <title>预约取号</title>
    <link rel="stylesheet" href="${basePath}easyhealth/css/style.css"/>
    <style>
        .yx-list li:after {
            width: 0;
        }

        .content-title {
            margin: 30px 0px 10px 10px;
        }

        .yx-list {
            width: 95%;
            margin: auto;
        }

        .frm-group {
            text-align: center;
        }

        .frm-input {
            position: relative;
            box-sizing: border-box;
            width: 95%;
            height: 60px;
            padding: 5px 5px 5px 30px;
            border: 0;
            outline: none;
            color: #9e9e9e;
        }

        .btn-w {
            margin-top: 7% !important;
        }

        .box-list {
            border: none;
            margin: 0 0 1rem;
        }

        .select-hospital {
            padding-left: 30px;
            color: #2297f7;
            border: none;
            border-radius: 4px;
        }

        .yx-list li.no-border {
            border: none;
        }
    </style>
</head>
<body>
<div id="body">
    <div class="box-list">
        <ul class="yx-list">
            <li>
                <div class="label">姓名</div>
                <div class="values color666">
                    <div class="values color666">${user.encryptedName}</div>
                </div>
            </li>
            <li>
                <div class="label">证件号</div>
                <div class="values color666">${user.encryptedCardNo}</div>
            </li>
        </ul>
    </div>
    <div class="screeningBox">
        <div class="content-title">请选择医院</div>
        <ul class="yx-list">
            <li class="flex no-border">
                <div class="flexItem">
                    <label>
                        <select id="hospitals" class="select-hospital"
                                onchange="javascript:$(this).siblings('.text').text($(this).find('option:selected').text());">
                            <#list hospitals as hospital>
                                <option value="${hospital.hospitalCode}" id="${hospital.hospitalId}">${hospital.hospitalName}</option>
                            </#list>
                        </select>
                        <i class="iconfont">&#xe66d;</i>
                    </label>
                </div>
            </li>
        </ul>
    </div>
    <div class="screeningBox">
        <div class="content-title">请输入预约号码</div>
        <div class="frm-box">
            <div class="frm-group">
                <input type="text" id="reservationNo" name="reservationNo" class="frm-input" placeholder="预约号"/>
            </div>
        </div>
    </div>
    <form id="takeForm" method="post" action="${basePath}mobileApp/reservation/takeno">
        <input type="hidden" name="appId" value="${serviceId}">
        <input type="hidden" name="appCode" value="${appCode}">
        <input type="hidden" id="hospitalCodeVal" name="branchCode">
        <input type="hidden" id="hospitalIdVal" name="hospitalId">
        <input type="hidden" id="reservationNoVal" name="orderNo">
    </form>

    <!------------------------------------------------->
    <#--<div class="screeningBox">-->
        <#--<div class="content-title">请输入信息</div>-->
        <#--<div class="frm-box">-->
            <#--<div class="frm-group">-->
                <#--<input type="text" id="pName" name="pName" class="frm-input" placeholder="姓名"/>-->
            <#--</div>-->
            <#--<div class="frm-group">-->
                <#--<input type="text" id="pCard" name="pCard" class="frm-input" placeholder="证件号"/>-->
            <#--</div>-->
            <#--<div class="frm-group">-->
                <#--<input type="text" id="reservationNo" name="reservationNo" class="frm-input" placeholder="预约号"/>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
    <#--<form id="takeTestForm" method="post" action="${basePath}mobileApp/reservation/takeno">-->
        <#--<input type="hidden" name="appId" value="${serviceId}">-->
        <#--<input type="hidden" name="appCode" value="${appCode}">-->
        <#--<input type="hidden" id="hospitalCodeVal" name="branchCode">-->
        <#--<input type="hidden" id="hospitalIdVal" name="hospitalId">-->
        <#--<input type="hidden" id="reservationNoVal" name="orderNo">-->
        <#--<input type="hidden" id="pNameVal" name="pName">-->
        <#--<input type="hidden" id="pCardVal" name="pCard">-->
    <#--</form>-->
    <!------------------------------------------------->

    <div class="section btn-w">
        <button type="button" class="btn btn-block" onclick="javascript: goReservation();">去取号</button>
    </div>
</div>
<#include "/mobileApp/common/yxw_footer.ftl">
<script type="text/javascript">
    function goReservation() {
        var hospital = $("#hospitals option:selected");
        var len = hospital.length;
        if (len && len === 1) {
            var reservationNo = $("#reservationNo").val();
            if ($.trim(reservationNo)) {
                $("#hospitalCodeVal").val(hospital.val());
                $("#hospitalIdVal").val(hospital.attr("id"));
                $("#reservationNoVal").val(reservationNo);
                $("#takeForm").submit();
            } else {
//                $Y.tips("请输入预约号码");
//                return false;
                new $Y.confirm({
                    ok: {title: '确定'},
                    content: "请输入预约号码"
                });
                return false;
            }
        } else {
            new $Y.confirm({
                ok: {title: '确定'},
                content: "请选择医院"
            });
            return false;
        }
    }

    function goTestReservation() {
        var hospital = $("#hospitals option:selected");
        var len = hospital.length;
        if (len && len === 1) {
            var reservationNo = $("#reservationNo").val();
            var pName = $("#pName").val();
            var pCard = $("#pCard").val();
            if ($.trim(reservationNo) && $.trim(pName) && $.trim(pCard)) {
                $("#pNameVal").val(pName);
                $("#pCardVal").val(pCard);
                $("#hospitalCodeVal").val(hospital.val());
                $("#hospitalIdVal").val(hospital.attr("id"));
                $("#reservationNoVal").val(reservationNo);
                $("#takeTestForm").submit();
            } else {
                new $Y.confirm({
                    ok: {title: '确定'},
                    content: "请输入完整信息"
                });
                return false;
            }
        } else {
            new $Y.confirm({
                ok: {title: '确定'},
                content: "请选择医院"
            });
            return false;
        }
    }
</script>
</body>
</html>
