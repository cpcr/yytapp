<#--
	证件类型  1：二代身份证  2：港澳居民身份证  3：台湾居民身份证 4：护照
	就诊人类型  1 本人   2 他人   3 儿童
-->
<!DOCTYPE html>
<html>
<head>
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
	<meta HTTP-EQUIV="expires" CONTENT="0"> 
    <#include "/mobileApp/common/common.ftl">
    <title>添加住院号</title>
</head>
<body>

<div id="body">
    <div class="box-list">
        <ul class="yx-list">
        	<#-- 分院信息 -->
        	<#if branchs?size gt 1>
            <li>
                <div class="label">分院</div>
                <div class="values color999 select_box">
                    <div class="select_value">
                        <span class="text" data-value="" data-id="" id="show_branch">请选择</span>
                        <i class="icon-icur"></i>
                    </div>
                    <select name="branches" id="branches" class="yx-select aSelect branches">
                        <#list branchs as item>
                        	<option value="${item.code}" data-id="${item.id}">${item.name}</option>
                        </#list>
                    </select>
                </div>
            </li>
            <#else>
            	<li style="display: none;">
	                <div class="label">分院</div>
	                <div class="values color999 select_box">
	                    <div class="select_value">
	                        <span class="text" data-value="" data-id="" id="show_branch">请选择</span>
	                        <i class="icon-icur"></i>
	                    </div>
	                    <select name="branches" id="branches" class="yx-select aSelect branches">
	                        <#list branchs as item>
	                        	<option value="${item.code}" data-id="${item.id}">${item.name}</option>
	                        </#list>
	                    </select>
	                </div>
	            </li>
            </#if>
	        <#-- end 分院信息 -->
	        <#-- 就诊人类型 -->
	        <li>
	            <div class="label">就诊人</div>
	            <div class="values color999 select_box">
	                <div class="select_value">
	                    <span class="text" data-value="" id="show_userType">请选择</span>
	                    <i class="icon-icur"></i>
	                </div>
	                <select name="ownership" id="ownership" class="yx-select ownership">
	                	<#list rule.visitingPersonType?split(",") as userType>
                			<option value="${userType}">
	                    		<#switch userType>
	                    			<#case 1>本人<#break>
	                    			<#case 2>他人<#break>
	                    			<#default>儿童
	                    		</#switch>
	                    	</option>
	                    </#list>
	                </select>
	            </div>
	        </li>
		    <#-- end 就诊人类型 -->
        </ul>
    </div>
    <!--本人-->
    <div class="page-select">
        <!--患者信息-->
        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">患者姓名</div>
                    <div class="values">
                    	<div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patName" type="text" id="selfName"/>
	                    </div>
                    </div>
                </li>
                <#-- 本人证件类型配置 -->
                <li>
                    <div class="label">证件类型</div>
                    <div class="values color999 select_box">
                        <div class="select_value">
                            <span class="text" data-value="" id="show_selfIdType">请选择</span>
                            <i class="icon-icur"></i>
                        </div>
                        <select name="selfIdType" id="selfIdType" class="yx-select aType idType">
                        	<#list rule.certificatesType?split(",") as idType>
                            	<option value="${idType}">
	                            	<#switch idType>
	                            		<#case 1>二代身份证<#break>
	                            		<#case 2>港澳居民身份证<#break>
	                            		<#case 3>台湾居民身份证<#break>
	                            		<#case 4>护照<#break>
	                            		<#default>
	                            	</#switch>
	                            </option>
                           	</#list>
                        </select>
                    </div>
                </li>
	            <#-- end of 本人证件类型配置 -->
                <li>
                    <div class="label">证件号码</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patIdNo" type="text" id="selfIdNo" maxlength="18"/>
	                    </div>
	                </div>
                </li>
                <li  class="sex_w" style="display: none">
                    <div class="label">患者性别</div>
                    <div class="values fontSize0" id="selfSex" data-value="1">
                        <span class="sex-btn active" data-value="1">男</span>
                        <span class="sex-btn" data-value="2">女</span>
                    </div>

                </li>
                <li class="birth" style="display: none">
                    <div class="label">出生日期</div>
                    <div class="values color999" id="selfBirth">请选择</div>
                </li>
                <li>
                    <div class="label">手机号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patMobile" type="text" id="selfMobile" maxlength="11"/>
	                    </div>
	                </div>
                </li>
                <#-- 本人住院号 -->
                <li>
                    <div class="label">住院号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder admissionNo" type="text" id="selfAdmissionNo" maxlength="30"/>
	                    </div>
	                </div>
                </li>
            </ul>
        </div>
        
        <div class="section">
	        <div class="box-tips warnTips" > <i class="icon-warn"></i>
	           	 以上信息请务必和您在医院登记的信息保持一致，否则将无法完成绑定。
	        </div>
	    </div>
	
	    <div class="section btn-w">
	        <button class="btn btn-block" id="bindSelf" onclick="">确定</button>
	    </div>
    </div>
    <!--本人 end-->
    
    <!--他人-->
    <div class="page-select">
        <!--患者信息-->
        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">患者姓名</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patName" type="text" id="otherName"/>
	                    </div>
	                </div>
                </li>
                <#-- 他人证件类型配置 -->
                <li>
                    <div class="label">证件类型</div>
                    <div class="values color999 select_box">
                        <div class="select_value">
                            <span class="text" data-value="" id="show_otherIdType">请选择</span>
                            <i class="icon-icur"></i>
                        </div>
                        <select name="otherIdType" id="otherIdType" class="yx-select aType idType">
                        	<#list rule.certificatesType?split(",") as idType>
                            	<option value="${idType}">
	                            	<#switch idType>
	                            		<#case 1>二代身份证<#break>
	                            		<#case 2>港澳居民身份证<#break>
	                            		<#case 3>台湾居民身份证<#break>
	                            		<#case 4>护照<#break>
	                            		<#default>
	                            	</#switch>
	                            </option>
                           	</#list>
                        </select>
                    </div>
                </li>
	            <#-- end of 他人证件类型配置 -->
                <li>
                    <div class="label">证件号码</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patIdNo" type="text" id="otherIdNo" maxlength="18"/>
	                    </div>
	                </div>
                </li>
                <li  class="sex_w" style="display: none">
                    <div class="label">患者性别</div>
                    <div class="values fontSize0" id="otherSex" data-value="1">
                        <span class="sex-btn active" data-value="1">男</span>
                        <span class="sex-btn" data-value="2">女</span>
                    </div>
                </li>
                <li class="birth" style="display: none">
                    <div class="label">出生日期</div>
                    <div class="values color999" id="otherBirth">请选择</div>
                </li>
                <li>
                    <div class="label">手机号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patMobile" type="text" id="otherMobile" maxlength="11"/>
	                    </div>
	                </div>
                </li>
                <li>
                    <div class="label">住院号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder admissionNo" type="text" id="otherAdmissionNo" maxlength="30"/>
	                    </div>
	                </div>
                </li>
            </ul>
        </div>
        
        <div class="section">
	        <div class="box-tips warnTips"> <i class="icon-warn"></i>
	           	 以上信息请务必和您在医院登记的信息保持一致，否则将无法完成绑定。
	        </div>
	    </div>
	
	    <div class="section btn-w">
	        <button class="btn btn-block" id="bindOther" onclick="">确定</button>
	    </div>
    </div>
    <!--他人 end-->

    <!--儿童-->
    <div class="page-select">
        <!--患者信息-->
        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">患者姓名</div>
                   	<div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patName" type="text" id="childName"/>
	                    </div>
	                </div>
                </li>
                <li>
                    <div class="label">身份证</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patIdNo" type="text" id="childIdNo" maxlength="18">
	                    </div>
	                </div>
                </li>
                <li>
                    <div class="label">患者性别</div>
                    <div class="values fontSize0" id="childSex" data-value="1">
                        <span class="sex-btn active" data-value="1">男</span>
                        <span class="sex-btn" data-value="2">女</span>
                    </div>
                </li>
                <li class="birth">
                    <div class="label">出生日期</div>
                    <div class="values color999" id="childBirth">请选择</div>
                </li>
                <li>
                    <div class="label">住院号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder admissionNo" type="text" id="childAdmissionNo" maxlength="30"/>
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
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patName" type="text" id="guardName"/>
	                    </div>
	                </div>
                </li>
                <#-- 监护人证件类型配置 -->
                <li>
                    <div class="label">监护人证件</div>
                    <div class="values color999 select_box">
                        <div class="select_value">
                            <span class="text" data-value="" id="show_guardIdType">请选择</span>
                            <i class="icon-icur"></i>
                        </div>
                        <select name="guardIdType" id="guardIdType" class="yx-select aType idType">
                        	<#list rule.certificatesType?split(",") as idType>
                            	<option value="${idType}">
	                            	<#switch idType>
	                            		<#case 1>二代身份证<#break>
	                            		<#case 2>港澳居民身份证<#break>
	                            		<#case 3>台湾居民身份证<#break>
	                            		<#case 4>护照<#break>
	                            		<#default>
	                            	</#switch>
	                            </option>
                           	</#list>
                        </select>
                    </div>
                </li>
	            <#-- end of 监护人证件类型配置 -->
                <li>
                    <div class="label">证件号码</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patIdNo" type="text" maxlength="18" id="guardIdNo"/>
	                    </div>
	                </div>
                </li>
                <li>
                    <div class="label">手机号</div>
                    <div class="values">
	                    <div class="input-placeholder">
	                    	<span class="placeholder-text">请输入</span>
	                    	<input class="yx-input noBorder patMobile" type="text" maxlength="11" id="guardMobile"/>
	                    </div>
	                </div>
                </li>
            </ul>
        </div>
        
        <div class="section">
	        <div class="box-tips warnTips"> <i class="icon-warn"></i>
	           	 以上信息请务必和您在医院登记的信息保持一致，否则将无法完成绑定。
	        </div>
	    </div>
	
	    <div class="section btn-w">
	        <button class="btn btn-block" id="bindChild" onclick="">确定</button>
	    </div>
    </div>
    <!--儿童 end-->
</div>

<#-- r means real -->
<!-- 本人的信息 -->
<input type="hidden" name="rSelfName" id="rSelfName" value="" class="user_input"/>
<input type="hidden" name="rSelfIdNo" id="rSelfIdNo" value="" class="user_input"/>
<input type="hidden" name="rSelfMobile" id="rSelfMobile" value="" class="user_input"/>
<input type="hidden" name="selfAge" id="selfAge" value="" class="user_input"/>
<!-- end 他人的信息 -->

<!-- 他人的信息 -->
<input type="hidden" name="rOtherName" id="rOtherName" value="" class="user_input"/>
<input type="hidden" name="rOtherIdNo" id="rOtherIdNo" value="" class="user_input"/>
<input type="hidden" name="rOtherMobile" id="rOtherMobile" value="" class="user_input"/>
<input type="hidden" name="otherAge" id="otherAge" value="" class="user_input"/>
<!-- end 他人的信息 -->

<!-- 儿童的信息 -->
<input type="hidden" name="rChildName" id="rChildName" value="" class="user_input"/>
<input type="hidden" name="rChildIdNo" id="rChildIdNo" value="" class="user_input"/>
<input type="hidden" name="rGuardName" id="rGuardName" value="" class="user_input"/>
<input type="hidden" name="rGuardIdNo" id="rGuardIdNo" value="" class="user_input"/>
<input type="hidden" name="rGuardMobile" id="rGuardMobile" value="" class="user_input"/>
<input type="hidden" name="childAge" id="childAge" value="" class="user_input"/>
<!-- end 儿童的信息 -->

<!-- 规则信息 -->
<input type="hidden" name="inputIncompleteTip" id="inputIncompleteTip" value="${rule.inputIncompleteTip}" />
<input type="hidden" name="tiedCardTip" id="tiedCardTip" value="${rule.tiedCardTip?replace('\r\n', '&lt;br /&gt;')}" />
<input type="hidden" name="inputIncorrectTip" id="inputIncorrectTip" value="${rule.inputIncorrectTip}" />
<input type="hidden" name="tipWarmContent" id="tipWarmContent" value="${rule.tipWarmContent}" />
<input type="hidden" name="cardTypes" id="cardTypes" value="${rule.cardType}" />
<input type="hidden" name="certificatesTypes" id="certificatesTypes" value="${rule.certificatesType}" />
<input type="hidden" name="verifyConditionTypes" id="verifyConditionTypes" value="${rule.verifyConditionType}" />
<input type="hidden" name="isShowCardNo" id="isShowCardNo" value="${rule.isShowCardNo}" />
<input type="hidden" name="userType" id="userType" value="" />
<!-- end 规则信息 -->

<!-- 接受平台返回的个人信息 -->
	<input type="hidden" name="base64Name" id="base64Name" value="${userInfo.base64Name}" />
	<input type="hidden" name="desName" id="desName" value="${userInfo.desName}" />
	<input type="hidden" name="base64IdNo" id="base64IdNo" value="${userInfo.base64IdNo}" />
	<input type="hidden" name="desIdNo" id="desIdNo" value="${userInfo.desIdNo}" />
	<input type="hidden" name="base64Mobile" id="base64Mobile" value="${userInfo.base64Mobile}" />
	<input type="hidden" name="desMobile" id="desMobile" value="${userInfo.desMobile}" />
	<input type="hidden" name="sex" id="sex" value="${userInfo.sex}" />
	<input type="hidden" name="birth" id="birth" value="${userInfo.birth}" />
	<input type="hidden" name="age" id="age" value="${userInfo.age}" />
	<input type="hidden" name="idType" id="idType" value="${userInfo.idType}" />
	<!-- end 接受支付宝的信息 -->
<!-- 跳转参数 -->
<form name="forwardForm" id="forwardForm" method="POST" action="${forward}">
</form>
<form name="baseForm" id="baseForm" method="POST" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
	<input type="hidden" name="openId" id="openId" value="${commonParams.openId}" />
	<input type="hidden" name="hospitalCode" id="hospitalCode" value="${commonParams.hospitalCode}" />
	<input type="hidden" name="hospitalId" id="hospitalId" value="${commonParams.hospitalId}" />
	<input type="hidden" name="hospitalName" id="hospitalName" value="${commonParams.hospitalName}" />
	<input type="hidden" name="appId" id="appId" value="${commonParams.appId}" />
	<input type="hidden" name="appCode" id="appCode" value="${commonParams.appCode}" />
	<input type="hidden" name="bindInpatientType" id="bindInpatientType" value="${commonParams.bindInpatientType}" />
	<input type="hidden" name="forward" id="forward" value="${forward}" />
</form>
<#if branchs?size == 1>
<input type="hidden" name="branchHospitalId" id="branchHospitalId" value="${branchs[0].id}" />
<input type="hidden" name="branchHospitalCode" id="branchHospitalCode" value="${branchs[0].code}" />
<input type="hidden" name="branchHospitalName" id="branchHospitalName" value="${branchs[0].name}" />
<#else>
<input type="hidden" name="branchHospitalId" id="branchHospitalId" value="${commonParams.branchHospitalId}" />
<input type="hidden" name="branchHospitalCode" id="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
<input type="hidden" name="branchHospitalName" id="branchHospitalName" value="${commonParams.branchHospitalName}" />
</#if>
<!-- end of 跳转参数 -->

<#include "/mobileApp/common/yxw_footer.ftl">

<!-- 引入js -->
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/idCardUtils.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/desensitize.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/yxCalendar.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/base64.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/inpatient/app.bindInpatient.js"></script>
</body>
</html>