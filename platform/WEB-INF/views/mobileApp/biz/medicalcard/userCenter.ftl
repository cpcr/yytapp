<!DOCTYPE html>
<html>
<head>
<#include "/mobileApp/common/common.ftl">
<title>个人中心</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)">
	<div id="body">
	    <div id="myCenter">
	        <div class="box-list">
	            <ul class="yx-list">
	            	<#if card?exists>
		                <li class="pic postForm" data-value="${basePath}mobileApp/medicalcard/userinfo/toView">
	                		<img src="${basePath}mobileApp/images/${(card.sex==1)?string("man-def.png", "girl-def.png")}" width="60" height="60">
			            	<div class="info">
			                	<div class="name">${card.encryptedPatientName} <i class="icon-myCenter ${(card.sex==1)?string("icon-man", "icon-girl")}"></i></div>
			                    <div class="color999" id="age"></div>
			                </div>
			                <i class="icon-arrow"></i>
				        </li>
	                <#else>
	                	<li class="pic">
		                    <img src="${basePath}mobileApp/images/pic-def.png" width="60" height="60">
		                    <div class="info">
		                        <div style="margin-bottom: 3px;">您尚未绑定本人就诊卡</div>
		                        <button class="btn btn-Invert" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">去绑定</button>
		                    </div>
		                </li>
	               	</#if>
	               	<#list rule.indexContent?split(",") as item>
	               		<#switch item>
	               			<#case 1><li class="postForm" data-value="${basePath}mobileApp/medicalcard/family/toView"><i class="icon-myCenter icon-family"></i> 我的就诊人 <i class="icon-arrow"></i></li><#break>
	               			<#-- 挂号记录 -->
                            <#case 2><li class="postForm" data-value="${basePath}mobileApp/register/infos/index"><i class="icon-myCenter icon-register"></i> 挂号记录 <i class="icon-arrow"></i></li><#break>
	               			<#-- 缴费记录 -->
	               			<#case 3><li class="postForm" data-value="${basePath}mobileApp/clinic/paidIndex"><i class="icon-myCenter icon-payment"></i> 缴费记录 <i class="icon-arrow"></i></li><#break>
	               			<#-- 我的医生 -->
	               			<#case 4><li class="postForm" data-value="${basePath}mobileApp/askDoctor/gotoDoctor?goUrl=2"><i class="icon-myCenter icon-doctor"></i> 我的医生 <i class="icon-arrow"></i></li><#break>
	               			<#-- 我的咨询 -->
	               			<#case 5><li class="postForm" data-value="${basePath}mobileApp/askDoctor/gotoDoctor?goUrl=3"><i class="icon-myCenter icon-ask"></i> 我的咨询 <i class="icon-arrow"></i></li><#break>
	               			<#-- 我的消息 -->
	               			<#case 6><li class="postForm" data-value="${basePath}mobileApp/askDoctor/gotoDoctor?goUrl=9"><i class="icon-myCenter icon-mySsg"></i> 我的消息 <i class="icon-arrow"></i></li><#break>
	               			<#-- 我的服务 -->
	               			<#case 7><li class="postForm" data-value=""><i class="icon-myCenter icon-service"></i> 我的服务 <i class="icon-arrow"></i></li><#break>
	               			<#-- 健康记录 -->
	               			<#case 8><li class="postForm" data-value=""><i class="icon-myCenter icon-record"></i> 健康记录 <i class="icon-arrow"></i></li><#break>
	               			<#-- 服务评价 -->
	               			<#case 9><li class="postForm" data-value=""><i class="icon-myCenter icon-vote"></i> 服务评价 <i class="icon-arrow"></i></li><#break>
		                </#switch>
	                </#list>
	                <#--
	                	http://hw10.www.yunyichina.cn/mobileApp/askDoctor/gotoDoctor?appId=wxa3ba664bb288a4a8&appCode=wechat&goUrl=2
	                	1：问医生
						2：我的医生
						3：我的咨询
						4：入院须知
						5：我的病历
						6：就医指南
						7：医院资讯
						8：病案复印
						9：我的消息
						10：健康问卷
						11：找医生
	                -->
	            </ul>
	        </div>
	    </div>
	</div>
	
	<form id="voForm" method="post" action="">
		<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
		<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
		<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
		<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
		<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
		<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
		<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
		<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
		<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
		<input type="hidden" id="id" name="id" value="${card.id}" />
		<input type="hidden" id="bindCardType" name="bindCardType" value="1" />
	</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/idCardUtils.js"></script>
<script type="text/javascript">
	$(function() {
		initAge('${card.birth}');
	});
	
	$('.postForm').off('click').on('click', function(event) {
		event.stopPropagation();
        event.preventDefault();
        $Y.loading.show('加载中...');
		// 提交表单跳转
		var action = $(this).attr('data-value');
		console.log($(this).text() + '跳转地址：' + action);
		if (action) {
			$('#voForm').attr('action', action);
			$('#voForm').submit();
		} else {
			$Y.loading.hide();
			new $Y.confirm({
	            ok: {title:'确定'},
	            content: '正在努力开发中，敬请期待。'
	        });
		}
	});
	
	$('.btn').off('click').on('click', function(event) {
		event.stopPropagation();
	    event.preventDefault();
    	
    	// 本人的，不需要检测，直接可以绑卡
    	$('#voForm').attr('action', '${basePath}mobileApp/medicalcard/bind/toView');
		$('#voForm').submit();
	});
	
	function initAge(birth) {
		if (birth) {
			var age = idCardUtils.getAge(birth);
			if (age) {
				$('#age').text(age + '岁');
			}
		}
	}
</script>
</html>