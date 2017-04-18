<html>
<head>
    <#include "/mobileApp/common/common.ftl">
    <title>挂号记录</title>
</head>
<body>
<div id="body">
    <div id="guoHaoJiLv">
        <div id="nav"></div>
        <div id="js-navContent" >
            <div class="boxLi">
                <ul class="yx-list" id="recordList">
                </ul>
            </div>
        </div>
    </div>
</div>
<#include "/mobileApp/common/yxw_footer.ftl">
<form id="paramsForm" method="post">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
    <input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
    <input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
    <input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
    <input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
    <input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
    <input type="hidden" id="cardNo" name="cardNo"    />
    <input type="hidden" id="orderNo" name="orderNo"  />
    <input type="hidden" id="regStatus" name="regStatus"  />
</form>
<input type="hidden" id="forward" name="forward" value="${basePath}mobileApp/register/infos/regsiterInfos" />
</body>
</html>
<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery.cookie.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/card-list.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/nav-list.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/registerinfo/app.regRecordList.js"></script>
