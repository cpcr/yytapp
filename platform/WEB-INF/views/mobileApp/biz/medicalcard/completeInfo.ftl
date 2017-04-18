<#--
	证件类型  1：二代身份证  2：港澳居民身份证  3：台湾居民身份证 4：护照
	就诊卡类型  1：就诊卡、2：医保卡、3：社保卡、4：住院号 
	就诊人类型  1 本人   2 他人   3 儿童
-->
<!DOCTYPE html>
<html>
<head>
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
	<meta HTTP-EQUIV="expires" CONTENT="0"> 
    <#include "/mobileApp/common/common.ftl">
    <title>完善个人信息</title>
</head>
<body>

<div id="body">
    <div class="box-list">
        <ul class="yx-list">
            <li>
                <div class="label">分院</div>
                <div class="values color999">
                    <div class="select_value">
                        <span class="text" data-value="${commonParams.branchHospitalCode}" data-id="${commonParams.branchHospitalId}">${commonParams.branchHospitalName}</span>
                    </div>
                </div>
            </li>
	        <li>
	            <div class="label">就诊人</div>
	            <div class="values color999">
	                <div class="select_value">
	                    <span class="text" data-value="${medicalcard.ownership}" id="userType">
	                    	<#switch medicalcard.ownership>
	                    		<#case 1>本人<#break>
	                    		<#case 2>他人<#break>
	                    		<#case 3>儿童<#break>
	                    		<#default>
	                    	</#switch>
	                    </span>
	                </div>
	            </div>
	        </li>
        </ul>
    </div>
    <!--大人-->
    <div class="page-select">
        <!--患者信息-->
        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">患者姓名</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text patName">${medicalcard.encryptedPatientName}</span>
	                    </div>
	                </div>
                </li>
                <#-- 他人证件类型配置 -->
                <li>
                    <div class="label">证件类型</div>
                    <div class="values color999">
                        <div class="select_value">
                            <span class="text patIdType" data-value="${medicalcard.idType}">
                            	<#switch medicalcard.idType>
                            		<#case 1>二代身份证<#break>
                            		<#case 2>港澳居民身份证<#break>
                            		<#case 3>台湾居民身份证<#break>
                            		<#case 4>护照<#break>
                            		<#default>
                            	</#switch>
                            </span>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="label">证件号码</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text patIdType">${medicalcard.encryptedIdNo}</span>
	                    </div>
	                </div>
                </li>
                <li  class="sex_w" style="display: none;">
                    <div class="label">患者性别</div>
                    <div class="values fontSize0 patSex" data-value="${medicalcard.sex}">
                        <span class="sex-btn ${(medicalcard.sex == '1')?string('active','')}" data-value="1">男</span>
                        <span class="sex-btn ${(medicalcard.sex == '2')?string('active','')}" data-value="2">女</span>
                    </div>
                </li>
                <li class="birth" style="display: none;">
                    <div class="label">出生日期</div>
                    <div class="values color999 patBirth">${medicalcard.birth}</div>
                </li>
                <li>
                    <div class="label">手机号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text patMobile">${medicalcard.encryptedMobile}</span>
	                    </div>
	                </div>
                </li>
                <#if completeType == 1>
	                <li>
	                    <div class="label">卡类型</div>
	                    <div class="values color999 select_box">
	                        <div class="select_value">
	                            <span class="text" data-value="">请选择</span>
	                            <i class="icon-icur"></i>
	                        </div>
	                        <select name="adultCardType" class="yx-select aSelect cardType">
	                        	<#list rule.cardType?split(",") as item>
		                            <option value="${item}">
		                            	<#switch item>
		                            		<#case 1>就诊卡<#break>
		                            		<#case 2>社保卡<#break>
		                            		<#case 3>医保卡<#break>
		                            		<#case 4>健康卡<#break>
		                            		<#case 5>身份证<#break>
		                            		<#case 6>市民卡<#break>
		                            		<#case 7>患者唯一标识<#break>
		                            		<#case 8>临时诊疗卡<#break>
		                            		<#default>
		                            	</#switch>
		                            </option>
		                        </#list>>
	                        </select>
	                    </div>
	                </li>
	                <li>
	                    <div class="label">卡号</div>
	                    <div class="values">
		                    <div class="input-placeholder">
		                    	<span class="placeholder-text">请输入</span>
		                    	<input class="yx-input noBorder patCardNo" type="text" id="adultPatCardNo" maxlength="30" value="${medicalcard.cardNo}"/>
		                    </div>
		                </div>
	                </li>
	            <#else>
	            	<li>
	                    <div class="label">卡类型</div>
	                    <div class="values color999">
	                    	<div class="select_value">
	                            <span class="text" data-value="${medicalcard.cardType}" id="adultPatCardType">
	                            	<#switch medicalcard.cardType>
	                            		<#case 1>就诊卡<#break>
		                            		<#case 2>社保卡<#break>
		                            		<#case 3>医保卡<#break>
		                            		<#case 4>健康卡<#break>
		                            		<#case 5>身份证<#break>
		                            		<#case 6>市民卡<#break>
		                            		<#case 7>患者唯一标识<#break>
		                            		<#case 8>临时诊疗卡<#break>
		                            		<#default>
	                            	</#switch>
	                            </span>
	                        <div>
	                    </div>
	                </li>
	                <li>
	                	<div class="label">卡号</div>
	                    <div class="values">
		                    <div class="input-placeholder">
		                    	<span class="placeholder-text">请输入</span>
		                    	<input class="yx-input noBorder patCardNo" type="text" id="adultPatCardNo" maxlength="30" value="${medicalcard.cardNo}"/>
		                    </div>
		                </div>
	                </li>
	            </#if>
                <li>
                    <div class="label">住院号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<#if medicalcard.admissionNo?exists>
	                    		<span class="placeholder-text">${medicalcard.admissionNo}</span>
	                    		<input class="yx-input noBorder admissionNo" type="text" id="adultAdmissionNo" maxlength="20" value="${medicalcard.admissionNo}"/>
	                    	<#else>
	                    		<span class="placeholder-text">请输入</span>
	                    		<input class="yx-input noBorder admissionNo" type="text" id="adultAdmissionNo" maxlength="20"/>
	                    	</#if>
	                    </div>
	                </div>
                </li>
            </ul>
        </div>
        
        <div class="section">
	        <div class="box-tips warnTips"> <i class="icon-warn"></i>
	           	<#if completeType == 1>
	           		请输入就诊卡号，完善个人信息。
	           	<#else>
	           		请输入住院号，完善个人信息。
	           	</#if>
	        </div>
	    </div>
	
	    <div class="section btn-w">
	        <button class="btn btn-block" id="bindOther" onclick="completeInfo.completeAdultInfo(this);">确定</button>
	    </div>
    </div>
    <!--大人 end-->

    <!--儿童-->
    <div class="page-select">
        <!--患者信息-->
        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">患者姓名</div>
                   	<div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text patName">${medicalcard.encryptedPatientName}</span>
	                    </div>
	                </div>
                </li>
                <li>
                    <div class="label">身份证</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text patIdNo">${medicalcard.encryptedIdNo}</span>
	                    </div>
	                </div>
                </li>
                <li>
                    <div class="label">患者性别</div>
                    <div class="values fontSize0 patSex" data-value="${medicalcard.sex}">
                        <span class="sex-btn active" data-value="1">男</span>
                        <span class="sex-btn" data-value="2">女</span>
                    </div>
                </li>
                <li class="birth">
                    <div class="label">出生日期</div>
                    <div class="values color999 patBirth">${medicalcard.birth}</div>
                </li>
                <#if completeType == 1>
	                <li>
	                    <div class="label">卡类型</div>
	                    <div class="values color999 select_box">
	                        <div class="select_value">
	                            <span class="text">请选择</span>
	                            <i class="icon-icur"></i>
	                        </div>
	                        <select name="childCardType" class="yx-select aSelect cardType">
	                        	<#list rule.cardType?split(",") as item>
		                            <option value="${item}">
		                            	<#switch item>
		                            		<#case 1>就诊卡<#break>
		                            		<#case 2>社保卡<#break>
		                            		<#case 3>医保卡<#break>
		                            		<#case 4>健康卡<#break>
		                            		<#case 5>身份证<#break>
		                            		<#case 6>市民卡<#break>
		                            		<#case 7>患者唯一标识<#break>
		                            		<#case 8>临时诊疗卡<#break>
		                            		<#default>
		                            	</#switch>
		                            </option>
		                        </#list>>
	                        </select>
	                    </div>
	                </li>
	                <li>
	                    <div class="label">卡号</div>
	                    <div class="values">
		                    <div class="input-placeholder">
		                    	<span class="placeholder-text">请输入</span>
		                    	<input class="yx-input noBorder patCardNo" type="text" id="childPatCardNo" maxlength="30" value="${medicalcard.cardNo}"/>
		                    </div>
		                </div>
	                </li>
	            <#else>
	            	<li>
	                    <div class="label">卡类型</div>
	                    <div class="values color999">
	                    	<div class="select_value">
	                            <span class="text" data-value="${medicalcard.cardType}" id="childPatCardType">
	                            	<#switch medicalcard.cardType>
	                            		<#case 1>就诊卡<#break>
		                            		<#case 2>社保卡<#break>
		                            		<#case 3>医保卡<#break>
		                            		<#case 4>健康卡<#break>
		                            		<#case 5>身份证<#break>
		                            		<#case 6>市民卡<#break>
		                            		<#case 7>患者唯一标识<#break>
		                            		<#case 8>临时诊疗卡<#break>
		                            		<#default>
	                            	</#switch>
	                            </span>
	                        <div>
	                    </div>
	                </li>
	                <li>
	                	<div class="label">卡号</div>
	                    <div class="values">
		                    <div class="input-placeholder">
		                    	<span class="placeholder-text">请输入</span>
		                    	<input class="yx-input noBorder patCardNo" type="text" id="childPatCardNo" maxlength="30" value="${medicalcard.cardNo}"/>
		                    </div>
		                </div>
	                </li>
	            </#if>
                <li>
                    <div class="label">住院号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<#if medicalcard.admissionNo?exists>
	                    		<span class="placeholder-text">${medicalcard.admissionNo}</span>
	                    		<input class="yx-input noBorder admissionNo" type="text" id="childAdmissionNo" maxlength="20" value="${medicalcard.admissionNo}"/>
	                    	<#else>
	                    		<span class="placeholder-text">请输入</span>
	                    		<input class="yx-input noBorder admissionNo" type="text" id="childAdmissionNo" maxlength="20"/>
	                    	</#if>
	                    </div>
	                </div>
                </li>
            </ul>
        </div>
        <!--监护人信息-->
        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">监护人姓名</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">${medicalcard.encryptedGuardName}</span>
	                    </div>
	                </div>
                </li>
                <li>
                    <div class="label">监护人证件</div>
                    <div class="values color999">
                        <div class="select_value">
                            <span class="text guardIdType" data-value="${medicalcard.guardIdType}">
                            	<#switch medicalcard.guardIdType>
	                            	<#case 1>二代身份证<#break>
	                        		<#case 2>港澳居民身份证<#break>
	                        		<#case 3>台湾居民身份证<#break>
	                        		<#case 4>护照<#break>
	                        		<#default>
	                        	</#switch>
                            </span>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="label">证件号码</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text guardIdNo">${medicalcard.encryptedGuardIdNo}</span>
	                    </div>
	                </div>
                </li>
                <li>
                    <div class="label">手机号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text guardMobile">${medicalcard.encryptedGuardMobile}</span>
	                    </div>
	                </div>
                </li>
            </ul>
        </div>
        
        <div class="section">
	        <div class="box-tips warnTips"> <i class="icon-warn"></i>
	        	<#if completeType == 1>
	           		请输入就诊卡号，完善个人信息。
	           	<#else>
	           		请输入住院号，完善个人信息。
	           	</#if>
	        </div>
	    </div>
	
	    <div class="section btn-w">
	        <button class="btn btn-block" id="bindChild" onclick="completeInfo.completeChildInfo(this);">确定</button>
	    </div>
    </div>
    <!--儿童 end-->
</div>

<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
<input type="hidden" id="hospitalCode" name="hospitalCode" value="${medicalcard.hospitalCode}" />
<input type="hidden" id="hospitalId" name="hospitalId" value="${medicalcard.hospitalId}" />
<input type="hidden" id="branchCode" name="branchCode" value="${medicalcard.branchCode}" />
<input type="hidden" id="branchId" name="branchId" value="${medicalcard.branchId}" />
<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
<input type="hidden" id="personId" name="personId" value="${commonParams.personId}" />
<input type="hidden" id="admissionNo" name="admissionNo" />
<input type="hidden" id="cardType" name="cardType" />
<input type="hidden" id="cardNo" name="cardNo" />
<input type="hidden" id="completeType" name="completeType" value="${completeType}"/>

<!-- 跳转参数 -->
<form name="forwardForm" id="forwardForm" method="POST" action="${forward}">
</form>
<!-- end of 跳转参数 -->

<#include "/mobileApp/common/yxw_footer.ftl">

<!-- 引入js -->
<script type="text/javascript" src="${basePath}mobileApp/js/common/base64.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/app.completeInfo.js"></script>
</body>
</html>