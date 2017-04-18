<!DOCTYPE html>
<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>候诊查询</title>
</head>
<body>
<div id="body">
    <div id="guoHaoJiLv">
        <div id="nav"></div>
        <div id="js-navContent" >
        	<div id="myCenter" style="display: none;">
	        	<div class="box-list">
		        	<ul class="yx-list">
		        		<#list rule.queueType?split(",") as item>
		        			<#switch item>
		        				<#case 1>
		        					<li class="pic" data-type="1">
		        						<img src="${basePath}mobileApp/images/man-def.png" width="60" height="60">
		        						<div class="info">
		        							<div class="name">候诊排队查询</div>        	
		        							<div class="color999">查询门诊候诊排队情况</div>
		        						</div>
		        						<i class="icon-arrow"></i>
		        					</li>
		        				<#break>
		                		<#case 2>
		                			<li class="pic" data-type="2">
		        						<img src="${basePath}mobileApp/images/man-def.png" width="60" height="60">
		        						<div class="info">
		        							<div class="name">检查检验排队查询</div>        	
		        							<div class="color999">查询做检查检验排队情况</div>
		        						</div>
		        						<i class="icon-arrow"></i>
		        					</li>
		                		<#break>
		                		<#case 3>
		                			<li class="pic" data-type="3">
		        						<img src="${basePath}mobileApp/images/man-def.png" width="60" height="60">
		        						<div class="info">
		        							<div class="name">取药排队查询</div>        	
		        							<div class="color999">查询取药排队情况</div>
		        						</div>
		        						<i class="icon-arrow"></i>
		        					</li>
		                		<#break>
		                		<#case 4>
		                			<li class="pic" data-type="4">
		        						<img src="${basePath}mobileApp/images/man-def.png" width="60" height="60">
		        						<div class="info">
		        							<div class="name">报告进度查询</div>        	
		        							<div class="color999">查询报告出具时间</div>
		        						</div>
		        						<i class="icon-arrow"></i>
		        					</li>
		                		<#break>
		                		<#default>
		        			</#switch>
		        		</#list>
		        	</ul>
		        </div>
	        </div>
		</div>
    </div>
</div>
<form id="voForm" method="post" action="${basePath}mobileApp/queue/queueDetail">
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
	<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
	<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
	<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
	<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
	<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
	<input type="hidden" id="patCardType" name="patCardType" value="" />
	<input type="hidden" id="patCardNo" name="patCardNo" value="" />
	<input type="hidden" id="patCardName" name="patCardName" value="" />
	<input type="hidden" id="queueType" name="queueType" value="" />
</form>
<input type="hidden" id="forward" name="forward" value="${basePath}mobileApp/queue/index" />
<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery.cookie.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/card-list.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/nav-list.js"></script>
<script>
	function loadData() {
		console.log('load what load.');
		$('#appCode').val('${commonParams.appCode}');
		$('#myCenter').hide();
		$('#myCenter').show();
	}
	
	$(function() {
		$('.pic').off('click').on('click', function() {
			if ($('#selectedCard') && $('#selectedCard').attr('data-no')) {
				$("#patCardType").val($("#selectedCard").attr("data-type"));
	    		$("#patCardNo").val($("#selectedCard").attr("data-no"));
	    		$("#patCardName").val($("#selectedCard").attr("data-name"));
	    		$("#queueType").val($(this).attr("data-type"));
	    		$('#voForm').submit();
	    	}
		});
	});
	
	function doRefresh()
	{
		var freshFrom=$("<form></form>");
		freshFrom.append($('<input type="hidden" name="appId" value="${commonParams.appId}"/>'));
		freshFrom.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}"/>'));
		freshFrom.append($('<input type="hidden" name="openId" value="${commonParams.openId}" />'));
		freshFrom.append($('<input type="hidden" name="areaCode" value="${commonParams.areaCode}"/>'));
		freshFrom.append($('<input type="hidden" name="hospitalId" value="${commonParams.hospitalId}"/>'));
		freshFrom.append($('<input type="hidden" name="hospitalCode" value="${commonParams.hospitalCode}"/>'));
		freshFrom.append($('<input type="hidden" name="hospitalName" value="${commonParams.hospitalName}"/>'));
		freshFrom.append($('<input type="hidden" name="branchHospitalName" value="${commonParams.branchHospitalName}" />'));
		freshFrom.append($('<input type="hidden" name="branchHospitalId" value="${commonParams.branchHospitalId}" />'));
		freshFrom.append($('<input type="hidden" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />'));
		freshFrom.appendTo("body");
		freshFrom.css('display','none');
		freshFrom.attr("method","post");
		freshFrom.attr("action","${basePath}mobileApp/queue/index");
		freshFrom.submit();
	}
	
	function doGoBack()
	{
		window.location.href="${basePath}mobileApp/queue/hospitalList?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng";
	}
</script>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>