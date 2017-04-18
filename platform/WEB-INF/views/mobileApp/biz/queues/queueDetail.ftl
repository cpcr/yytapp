<!DOCTYPE html>
<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>
    	<#switch commonParams.queueType>
    		<#case 1>门诊候诊排队<#break>
			<#case 2>检查排队<#break>
			<#case 3>取药排队<#break>
			<#case 4>报告出具进度<#break>
    	</#switch>
    </title>
</head>
<body>
<div id="body">
    <div id="queue-msg"></div>
</div>

<form id="voForm" method="post" >
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
	<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
	<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
	<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
	<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
	<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
	<input type="hidden" id="patCardType" name="patCardType" value="${commonParams.patCardType}" />
	<input type="hidden" id="patCardNo" name="patCardNo" value="${commonParams.patCardNo}" />
	<input type="hidden" id="patCardName" name="patCardName" value="${commonParams.patCardName}" />
	<input type="hidden" id="queueType" name="queueType" value="${commonParams.queueType}" />
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
<script>
	$(function() {
		var url = "";
		var queueType = $('#queueType').val();
		if (queueType == "1") {
			url = "${basePath}mobileApp/queue/getMzQueue";
		} else if (queueType == "2") {
			url = "${basePath}mobileApp/queue/getExamineQueue";
		} else if (queueType == "3") {
			url = "${basePath}mobileApp/queue/getMedicineQueue";
		} else {
			// 报告出具暂时没做。
			// url = "${basePath}mobileApp/queue/getMzQueue";
		}
		
		var datas = $("#voForm").serializeArray();
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
	       		if (data.status == 'OK' && data.message.queues && data.message.queues.length > 0) {
	       			if (queueType == "1") {
						formatMzQueue(data.message.queues);
					} else if (queueType == "2") {
						formatExamineQueue(data.message.queues);
					} else if (queueType == "3") {
						formatMedicineQueue(data.message.queues);
					} else {
						// 报告出具暂时没做。
					}
	       		} else {
	       			showNoData();
	       		}
	       	}
		})
	});
	
	function formatMzQueue(data) {
		var sHtml = '';
		
		$.each(data, function(i, item) {
			sHtml += '<div class="box-list">';
			sHtml += '	<ul class="yx-list">';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">就诊医生</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.doctorName) + '</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">挂号科室</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.deptName) + '</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">科室地址</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.deptLocation) + '</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">您的序号</div>';
	        sHtml += '      	<div class="values color666"><span class="yellow fontSize140">' + getValue(item.serialNum) + '</span>号</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">当前的序号</div><span class="yellow fontSize140">';
	        sHtml += '      	<div class="values color666">';
	        if (getValue(item.currentNum)) {
	        	sHtml += getValue(item.currentNum) + '</span>号';
	        } else {
	        	sHtml += '</span>';
	        }
	        
	        sHtml += '			</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">前面用户数</div>';
	        sHtml += '      	<div class="values color666"><span class="yellow fontSize140">';
	        if (getValue(item.frontNum)) {
	        	sHtml += getValue(item.frontNum) + '</span>位';
	        } else {
	        	sHtml += '</span>';
	        }
	        sHtml += '</div>';
	        sHtml += '		</li>';
	        sHtml += '		<li>';
	        sHtml += '			<div class="label">预计时间</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.visitTime) + '</div>';
	        sHtml += '		</li>';
			sHtml += '	</ul>';
			sHtml += '</div>';
		});
		
		$('#queue-msg').html('');
		$('#queue-msg').html(sHtml);
	}
	
	function formatMedicineQueue(data) {
		var sHtml = '';
		
		$.each(data, function(i, item) {
			sHtml += '<div class="box-list">';
			sHtml += '	<ul class="yx-list">';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">药房名称</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.pharmacy) + '</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">药房位置</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.localtion) + '</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">您的序号</div>';
	        sHtml += '      	<div class="values color666"><span class="yellow fontSize140">' + getValue(item.serialNum) + '</span>号</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">当前的序号</div>';
	        sHtml += '      	<div class="values color666"><span class="yellow fontSize140">';
	        if (getValue(item.currentNum)) {
	        	sHtml += getValue(item.currentNum) + '</span>号</div>';
	        } else {
	        	sHtml += '</span></div>';
	        } 
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">前面用户数</div>';
	        sHtml += '      	<div class="values color666"><span class="yellow fontSize140">';
	        if (getValue(item.frontNum)) {
	        	sHtml += getValue(item.frontNum) + '</span>位';
	        } else {
	        	sHtml += '</span>';
	        }
	        sHtml += '</div>';
	        sHtml += '		</li>';
	        sHtml += '		<li>';
	        sHtml += '			<div class="label">预计时间</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.getTime) + '</div>';
	        sHtml += '		</li>';
			sHtml += '	</ul>';
			sHtml += '</div>';
		});
		
		$('#queue-msg').html('');
		$('#queue-msg').html(sHtml);
	}
	
	function formatExamineQueue(data) {
		var sHtml = '';
		
		$.each(data, function(i, item) {
			sHtml += '<div class="box-list">';
			sHtml += '	<ul class="yx-list">';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">名称</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.checkName) + '</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">执行科室</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.deptName) + '</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">科室地址</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.deptLocation) + '</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">我的序号</div>';
	        sHtml += '      	<div class="values color666"><span class="yellow fontSize140">' + getValue(item.serialNum) + '</span>号</div>';
	        sHtml += '		</li>';
			sHtml += '		<li>';
	        sHtml += '			<div class="label">前面序号</div>';
	        sHtml += '      	<div class="values color666"><span class="yellow fontSize140">';
	        if (getValue(item.currentNum)) {
	        	sHtml += getValue(item.currentNum) + '</span>位</div>';
	        } else {
	        	sHtml += '</span></div>';
	        } 
	        sHtml += '		</li>';
	        sHtml += '		<li>';
	        sHtml += '			<div class="label">前面人数</div>';
	        sHtml += '      	<div class="values color666"><span class="yellow fontSize140">';
	        if (getValue(item.frontNum)) {
	        	sHtml += getValue(item.frontNum) + '</span>位';
	        } else {
	        	sHtml += '</span>';
	        }
	        sHtml += '</div>';
	        sHtml += '		</li>';
	        sHtml += '		<li>';
	        sHtml += '			<div class="label">预计时间</div>';
	        sHtml += '      	<div class="values color666">' + getValue(item.dutyTime) + '</div>';
	        sHtml += '		</li>';
			sHtml += '	</ul>';
			sHtml += '</div>';
		});
		
		$('#queue-msg').html('');
		$('#queue-msg').html(sHtml);
	}
	
	function showNoData() {
		var sHtml = '';
		
		sHtml += '<div class="box-list">';
	    sHtml += '	<p class="color666" style="text-align: center">没有查到您排队信息。</p>';
	    sHtml += '</div>';
		
		$('#queue-msg').html('');
		$('#queue-msg').append(sHtml);
	}
	
	function getValue(data) {
		if (!data || data == 'null') {
			data = '';
		}
		return data;
	}
	
	function doRefresh()
	{
		var freshFrom=$("<form></form>");
		freshFrom.append($('<input type="hidden"  name="openId" value="${commonParams.openId}" />'));
		freshFrom.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}" />'));
		freshFrom.append($('<input type="hidden"  name="appId" value="${commonParams.appId}" />'));
		freshFrom.append($('<input type="hidden"  name="hospitalCode" value="${commonParams.hospitalCode}" />'));
		freshFrom.append($('<input type="hidden"  name="hospitalId" value="${commonParams.hospitalId}">'));
		freshFrom.append($('<input type="hidden" name="hospitalName" value="${commonParams.hospitalName}" />'));
		freshFrom.append($('<input type="hidden"  name="branchHospitalName" value="${commonParams.branchHospitalName}" />'));
		freshFrom.append($('<input type="hidden"  name="branchHospitalId" value="${commonParams.branchHospitalId}" />'));
		freshFrom.append($('<input type="hidden"  name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />'));
		freshFrom.append($('<input type="hidden"  name="patCardType" value="${commonParams.patCardType}" />'));
		freshFrom.append($('<input type="hidden"  name="patCardNo" value="${commonParams.patCardNo}" />'));
		freshFrom.append($('<input type="hidden" name="patCardName" value="${commonParams.patCardName}" />'));
		freshFrom.append($('<input type="hidden"  name="queueType" value="${commonParams.queueType}" />'));
		freshFrom.appendTo("body");
		freshFrom.css('display','none');
		freshFrom.attr("method","post");
		freshFrom.attr("action","${basePath}mobileApp/queue/queueDetail");
		freshFrom.submit();
	}
	
	function doGoBack()
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
</script>
</html>