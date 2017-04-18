<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
    <title>可转医保挂号记录</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">

<div id="body">
    <div id="guoHao">
        <div class="screeningBox"></div>
        <div class="space15"></div>
        <div id="records" >
            <#if recordsSize == '0'>
                <div id="success">
                    <div class="noticeEmpty"></div>
                    <div class="p color666">没有可转医保的挂号记录</div>
                </div>
            <#else>
                <#list records as record>
                    <ul class="yx-list recordList">
                        <li class="ok flex arrow boxTable" onclick="showOrderInfo('${record.hisOrdNum}')">
                            <div class="flexItem">
                                <div class="name fontSize110">${record.deptName}</div>
                                <div class="mate">${record.doctorName}</div>
                                <div class="mate color999">${record.bookDate} ${record.beginTime}-${record.endTime}</div>
                            </div>
                            <div class="flexItem w120 textRight vertical states" style="margin-top:18px;">去转医保&nbsp;&nbsp;&nbsp;</div>
                        </li>
                    </ul>
                </#list>
            </#if>
        </div>
    </div>
</div>

<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}">
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
    <input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}" />
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
    <input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
    <input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
    <input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
    <input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
    <input type="hidden" id="hisOrderNo" name="hisOrderNo" value="" />
</form>
<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script>
    function showOrderInfo(hisOrderNo){
        $("#hisOrderNo").val(hisOrderNo);

        var reqUrl =  "${basePath}mobileApp/conversion/checkOrderInfo";
        var datas = $("#voForm").serializeArray();
        $.ajax({
            type: 'POST',
            url: reqUrl,
            data: datas,
            dataType: 'json',
            timeout: 120000,
            success: function (data) {
                $Y.loading.hide()
                if (data.status == 'OK') {
                    $("#voForm").attr("action" , appPath + "mobileApp/conversion/showOrderInfo");
                    $("#voForm").submit();
                } else {
                    $Y.loading.hide();
                    $Y.mask.remove();
                    errorBox = new $Y.confirm({
                        content: '<div>'+data.message+'</div>',
                        ok: {title: '确定'}
                    })
                }
            },
            error: function (data) {
                $Y.loading.hide();
                $Y.mask.remove();
                errorBox = new $Y.confirm({
                    content: '<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                    ok: {title: '确定'}
                })
            }
        });
    }
</script>