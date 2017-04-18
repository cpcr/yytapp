<!DOCTYPE html>
<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>查看报告</title>
</head>
<body>
<div id="body">
    <div id="guoHaoJiLv">
        <div id="nav"></div>
        <div id="js-navContent" >
            <div class="box-list baoGaoList">
                <div class="baoGao-tag js-tag">

                </div>
                <ul id="report_list" class="yx-list js-tagContent show">

                </ul>
            </div>
        </div>
    </div>
</div>
<form id="voForm" method="post">
<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
<input type="hidden" id="reportType" name="reportType" value="${commonParams.checkType}" />
<input type="hidden" id="patCardType" name="patCardType" value="" />
<input type="hidden" id="patCardNo" name="patCardNo" value="" />
<input type="hidden" id="detailId" name="detailId" value="" />
<input type="hidden" id="admissionNo" name="admissionNo" value="" />
<input type="hidden" id="doctorName" name="doctorName" value="" />
<input type="hidden" id="deptName" name="deptName" value="" />
<input type="hidden" id="reportTime" name="reportTime" value="" />
<input type="hidden" id="executeTime" name="executeTime" value="" />
<input type="hidden" id="patCardName" name="patCardName" value="" />
<input type="hidden" id="checkType" name="checkType" value="" />
<input type="hidden" id="idNo" name="idNo" value="" />
<input type="hidden" id="reportViewCssType" name="reportViewCssType" value="${rule.reportViewCssType}" />
<input type="hidden" id="fileAddress" name="fileAddress" />
</form>
<input type="hidden" id="forward" name="forward" value="${basePath}mobileApp/reports/index" />
	<script type="text/javascript">
		$(function() {
			initData();
		});
    	function initData() {
    		var sHtml = '';
    		var reportTypes = '${rule.reportCouldQueryType}'.split(',');
    		
    		$.each(reportTypes, function(i, item) {
    			sHtml += '<div class="item item_tag" data-value="' + item + '" onclick="initQryCondition(' + item +');">';
    			if (item == 1) {
    				sHtml += '检验';
    			} else if (item == 2) {
    				sHtml += '检查';
    			} else if (item == 3) {
    				sHtml += '体检';
    			}
    			sHtml += '</div>';
    		});
    		$('.baoGao-tag').html('');
        	$('.baoGao-tag').append(sHtml);
        	
        	$('.baoGao-tag div:first').addClass('active');
    	}
    	
    	function initQryCondition(reportType) {
    		$('#reportType').val(reportType);
    		$('#report_list').html('');
    		loadData();
    	}
    	
    	function loadData(){
    		$('#appCode').val('${commonParams.appCode}');
    		$("#patCardType").val($("#selectedCard").attr("data-type"));
    		$("#patCardNo").val($("#selectedCard").attr("data-no"));
    		$("#patCardName").val($("#selectedCard").attr("data-name"));
    		$("#branchHospitalCode").val($("#selectedCard").attr("data-branchCode"));
    		$("#idNo").val($("#selectedCard").attr("data-idNo"));
    		$("#branchHospitalId").val($("#selectedCard").attr("data-branchId"));
    		if (!$('#reportType').val()) {
    			$("#reportType").val($(".active").attr('data-value'));
    		}
    		
    		var url = "${basePath}mobileApp/reports/getReports";
    		var datas = $("#voForm").serializeArray();
    		console.log(datas);
    		$Y.loading.show('正在为您加载数据');
    		$.ajax({
	           	type : 'POST',  
	           	url : url,  
	           	data : datas,  
	           	dataType : 'json',  
	           	timeout:120000,
	           	error: function(data) {
	           		$Y.loading.hide();
	           		showNoData();
	           	},
	           	success : function(data) {
	           		console.log(data);
	           		$Y.loading.hide();
	           		if (data.status == 'OK') {
	           			formatData(data.message);
	           		} else {
	           			showNoData();
	           		}
	           	}
	    	})
    	}
    	
    	function formatData(data) {
    		if (data.reportType == '1') {
    			formatInspectData(data.list);
    		} else if (data.reportType == '2') {
    			formatExamineData(data.list);
    		} else {
    			formatCheckupData(data.list);
    		}
    	}
    	
    	function bindEvent() {
    		$('.list_item').click(function() {
    			var cssType = '${rule.reportViewCssType}';
    			// 暂时使用，貌似缓存里面没有存进去
    			if (!cssType) {
    				cssType = '1';
    			}
    			
    			if (cssType == '1') {
    				// 看数据
    				showDataDetail(this);
    			} else {
    				var fileAddress = $(this).attr('data-graphAddress');
    				if (cssType =='2' && fileAddress && fileAddress != 'null') {
    					// 看报表
    					showGraphDetail(this);
    				}
    			}
    		});
    	}
    	
    	/*图表查询方式跳转*/
    	function showGraphDetail(obj) {
    		var fileAddress = $(obj).attr('data-graphAddress');
    		if (fileAddress && fileAddress != 'null') {
	    		$("#fileAddress").val(fileAddress);
	    		$("#voForm").attr("action", "${basePath}mobileApp/reports/reportGraph");
	   		 	$("#voForm").submit();
	   		 } else {
	   		 	new $Y.confirm({
		            ok:{title:'确定'},
		            content:'该项报告没有报告单'
		        });
	   		 }
    	}
    	
    	/*数据查询方式跳转*/
    	function showDataDetail(obj) {
    		$("#doctorName").val($(obj).attr('data-doctor'));
    		$("#reportTime").val($(obj).find('.time').text());
    		$("#detailId").val($(obj).attr('data-id'));
    		$("#deptName").val($(obj).attr('data-dept'));
    		$("#executeTime").val($(obj).attr('data-executeTime'));
    		$("#checkType").val($(obj).attr('data-checkType'));
    		
    		var reportType = $('#reportType').val();
    		$("#voForm").attr("action" , '${basePath}' + 'mobileApp/reports/reportDetail');
   		 	$("#voForm").submit();
    	}
    	
    	/*检查列表*/
    	function formatExamineData(data) {
    		if (data.length > 0) {
	    		var sHtml = '';
	    		$('#report_list').html('');
	    		
	    		$.each(data, function(i, item) {
	    			// 测试用 
	    			// item.fileAddress = '${basePath}mobileApp/images/baoGaoDemo.jpg';
	    			sHtml += '<li class="list_item" ' + 
	    						'data-id="' + getValue(item.checkId) + 
	    						'" data-dept="' + getValue(item.deptName) + 
	    						'" data-doctor="' + getValue(item.doctorName) + 
	    						'" data-executeTime="' + getValue(item.checkTime) + 
	    						'" data-graphAddress="' + getValue(item.fileAddress) + 
	    						'" data-checkType="' + getValue(item.checkType) + '">';
	    			sHtml += '	<div class="mate">点击查看 <i class="icon-arrow"></i></div>';
	    			sHtml += '	<div class="title">' + item.checkName;
					sHtml += '		<span class="time">' + ((item.reportTime && item.reportTime != 'null') ? item.reportTime : '&nbsp;') + '</span>';
	    			sHtml += '	</div>';
	    			sHtml += '</li>';
	    		}); 
	    		
	    		$('#report_list').append(sHtml);
	    		$('#report_list').show();
	    	} else {
	    		showNoData();
	    	}
	    	
	    	bindEvent();
    	} 
    	
    	/*检验列表*/
    	function formatInspectData(data) {
    		if (data.length > 0) {
	    		var sHtml = '';
	    		$('#report_list').html('');
	    		
	    		$.each(data, function(i, item) {
	    			// 测试用 
	    			// item.fileAddress = '${basePath}mobileApp/images/baoGaoDemo.jpg';
	    			sHtml += '<li class="list_item" ' + 
	    						'data-id="' + getValue(item.inspectId) + 
	    						'" data-dept="' + getValue(item.deptName) + 
	    						'" data-doctor="' + getValue(item.inspectDoctor) + 
	    						'" data-executeTime="' + getValue(item.provingTime) + 
	    						'" data-graphAddress="' + getValue(item.fileAddress) + '">';
	    			sHtml += '	<div class="mate">点击查看 <i class="icon-arrow"></i></div>';
	    			sHtml += '	<div class="title">' + item.inspectName;
	    			sHtml += '		<span class="time">' + ((item.reportTime && item.reportTime != 'null') ? item.reportTime : '') + '</span>';
	    			sHtml += '	</div>';
	    			sHtml += '</li>';
	    		}); 
	    		
	    		$('#report_list').append(sHtml);
	    		$('#report_list').show();
	    	} else {
	    		showNoData();
	    	}
	    	
	    	bindEvent();
    	}
    	
    	/*体检列表*/
    	function formatCheckupData(data) {
    		
    	}
    	
    	function showNoData() {
    		var sHtml = '';
    		$('#report_list').html('');
    		
    		sHtml += '<li class="noData">';
            sHtml += '	<img src="${basePath}/images/noData2.png" width="110">';
            sHtml += '  <p class="color999">没有查到您的报告单</p>';
            sHtml += '</li>';
    		
    		$('#report_list').append(sHtml);
    		$('#report_list').show();
    	}
    	
    	function getValue(data) {
    		if (data && data != 'null') {
    			return data;
    		} else {
    		 	return "";
    		}
    	}
    	
    	function doRefresh()
		{
			var freshFrom=$("<form></form>");
			freshFrom.append($('<input type="hidden"  name="openId" value="${commonParams.openId}" />'));
			freshFrom.append($('<input type="hidden"  name="appCode" value="${commonParams.appCode}" />'));
			freshFrom.append($('<input type="hidden"  name="appId" value="${commonParams.appId}" />'));
			freshFrom.append($('<input type="hidden"  name="hospitalCode" value="${commonParams.hospitalCode}" />'));
			freshFrom.append($('<input type="hidden"  name="hospitalId" value="${commonParams.hospitalId}">'));
			freshFrom.append($('<input type="hidden"  name="hospitalName" value="${commonParams.hospitalName}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalName" value="${commonParams.branchHospitalName}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalId" value="${commonParams.branchHospitalId}" />'));
			freshFrom.append($('<input type="hidden" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />'));
			freshFrom.append($('<input type="hidden"  name="reportType" value="${commonParams.checkType}" />'));
			freshFrom.appendTo("body");
			freshFrom.css('display','none');
			freshFrom.attr("method","post");
			freshFrom.attr("action","${basePath}mobileApp/reports/index");
			freshFrom.submit();
		}
		
		function doGoBack()
		{
			window.location.href="${basePath}mobileApp/reports/hospitalList?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng";
		}
    </script>
<#include "/mobileApp/common/yxw_footer.ftl">
	<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery.cookie.js"></script>
    <script type="text/javascript" src="${basePath}mobileApp/js/common/card-list.js"></script>
	<script type="text/javascript" src="${basePath}mobileApp/js/common/nav-list.js"></script>
</body>
</html>