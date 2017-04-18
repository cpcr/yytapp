<html>
<head>
    <#include "/mobileApp/common/common.ftl">
    <title>${commonParams.deptName}</title>
</head>
<body>
<div id="body">
    <div id="select-date"></div>
    <#if isHasDutyReg == 1>
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i> 温馨提示：${onDutyRegTipContent}</div>
    </div>
    </#if>
    <div class="section doctor-list">
        <ul id="doctorList">
        </ul>
    </div>
</div>
<form id="paramsForm" method="post">
<input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
<input type="hidden" id="showDays" name="showDays" value="${showDays}" >
<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
<input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}" />
<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${branchHospitalId}" />
<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${branchHospitalCode}" />
<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${branchHospitalName}" />
<input type="hidden" id="category" name="category" value="${commonParams.category}">
<input type="hidden" id="deptCode" name="deptCode" value="${commonParams.deptCode}">
<input type="hidden" id="deptName" name="deptName" value="${commonParams.deptName}">
<input type="hidden" id="doctorCode" name="doctorCode" value="${commonParams.doctorCode}">
<input type="hidden" id="selectRegDate" name="selectRegDate" value="${commonParams.selectRegDate}">
<input type="hidden" id="isHasDutyReg" name="isHasDutyReg" value="${isHasDutyReg}" />
<input type="hidden" id="nextDay" name="nextDay" value="${nextDay}" />
<input type="hidden" id="isSearchDoctor" name="isSearchDoctor" value="${commonParams.isSearchDoctor}" />
<input type="hidden" id="isHasAppointmentReg" name="isHasAppointmentReg" value="${isHasAppointmentReg}" />
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>
<script src="${basePath}mobileApp/js/biz/askDoctor/ask.chooseDoctor.js" type="text/javascript"></script>
