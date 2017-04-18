<!DOCTYPE html>
<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>报告详情</title>
    <script type="text/javascript" src="${basePath}mobileApp/js/common/nav-list.js"></script>
    <style>
        #detailInfo table {border-collapse:collapse;}
        #detailInfo td:first-child { padding-left: 5px;}
        #detailInfo tr:nth-child(odd) td { background: #f1f1f1; }
        #detailInfo table tr.hd td { padding: 8px 5px; color: #333; font-weight: bold}
    </style>
</head>
<body>
<div id="body">
    <div class="box-list">
        <ul class="yx-list">
            <li>
                <div class="label">姓名</div>
                <div class="values color666">*${commonParams.patCardName?substring(1)}</div>
            </li>
            <li>
                <div class="label">就诊卡</div>
                <div class="values color666">${commonParams.patCardNo}</div>
            </li>
            <li>
                <div class="label">报告医生</div>
                <div class="values color666"><#if vo.doctorName != 'null' >${commonParams.doctorName}<#else>---</#if></div>
            </li>
            <li>
                <div class="label">报告时间</div>
                <div class="values color666"><#if vo.reportTime != 'null' >${commonParams.reportTime}<#else>---</#if></div>
            </li>
        </ul>
    </div>
    <div id="detailInfo" class="box-list accordion js-accordion">
    </div>
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i> 提示：该报告结果仅供临床参考。请以医院打印的纸质报告单为准。</div>
    </div>
</div>
	<form id="voForm" method="post">
		<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
		<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
		<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
		<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}" />
		<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
		<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
		<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
		<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
		<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
		<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
		<input type="hidden" id="reportType" name="reportType" value="${commonParams.reportType}" />
		<input type="hidden" id="patCardType" name="patCardType" value="${commonParams.patCardType}" />
		<input type="hidden" id="patCardNo" name="patCardNo" value="${commonParams.patCardNo}" />
		<input type="hidden" id="detailId" name="detailId" value="${commonParams.detailId}" />
		<input type="hidden" id="admissionNo" name="admissionNo" value="" />
	</form>
	<script type="text/javascript">
    	var basePath = '${basePath}';
    	$(function() {
    		$Y.loading.show('正在为您加载报告详情');
    		var url =  basePath + "mobileApp/reports/getInspectDetail";
    		var params = $("#voForm").serializeArray();
    		console.dir(params);
    		$.ajax({
	           	type: 'POST',  
	           	url: url,  
	           	data: params,  
	           	dataType: 'json',  
	           	timeout: 120000,
	           	error: function(data) {
	           		$Y.loading.hide();
	           		showNoData('查询超时，请稍后重试');
	           	},
	           	success : function(data) {
	           		console.log(data);
	           		$Y.loading.hide();
	           		if (data.status == 'OK') {
	           			formatData(data.message);
	           		} else {
	           			showNoData('查询超时，请稍后重试');
	           		}
	           	}
	    	})
    	})
    	
    	function showNoData(data) {
    		var msg = '没有查询到您的报告详情';
    		if (data) {
    			msg = 'data';
    		}
    		
    		var sHtml = '';
    		$('#detailInfo').html('');

    		sHtml += '<div class="noData" style="padding: 5px; margin: 0 auto;">';
            /*sHtml += '	<img src="${basePath}/images/noData2.png" width="110">';*/
            sHtml += '  <p class="color999" style="padding-left: .4em;">' + data + '</p>';
            sHtml += '</div>';
    		
    		$('#detailInfo').append(sHtml);
    	}
    	
    	function formatData(data) {
    		if (data.detail && data.detail.length > 0) {
    			var sHtml = '';
    			$('#detailInfo').html('');
    			sHtml += '<table><tr class="hd"><td width="30%" class="label">检查项目</td><td class="label" align="center">结果</td><td class="label" align="center">单位</td><td class="label" align="center">参考值</td></tr>';
                $.each(data.detail, function(i, item) {
                    var abnormal = item.abnormal;
                    if (abnormal) {
                        if (abnormal == '1' || abnormal == '2' || abnormal == '4') {
                            sHtml += '<tr class="acc-li highlight">';
                        } else {
                            sHtml += '<tr class="acc-li">';
                        }
                    } else {
                        sHtml += '<tr class="acc-li">';
                    }
                    
                    sHtml += '  <td>' + item.itemName + '</td>';
                    sHtml += '  <td align="center">' + ((item.result == 'null' || !item.result) ? '&nbsp;' : item.result);
                    switch (abnormal) {
                        case '1':
                            sHtml += '↑';
                            break;
                         case '2':
                            sHtml += '↓';
                            break;
                        case '4':
                            sHtml += '注意';
                            break;
                        default:
                            // 不做操作 (0[正常]不显示。3[未知]不显示。中文，也不显示。)
                    }
                    sHtml += '  </td>';
                    sHtml += '  <td align="center">' + ((item.unit == 'null' || !item.unit) ? '&nbsp;' : item.unit) + '</td>';
                    sHtml += '  <td align="center">' + ((item.refRange == 'null' || !item.refRange) ? '&nbsp;' : item.refRange) + '</td>';
                    sHtml += '</tr>';
                });
                sHtml += '</table>';
                $('#detailInfo').append(sHtml);
    		} else {
    			showNoData('暂时查不到该报告的详细内容，请稍候再试。');
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
			freshFrom.append($('<input type="hidden" name="checkType" value="${commonParams.checkType}" />'));
			freshFrom.append($('<input type="hidden" name="reportType" value="${commonParams.reportType}" />'));
			freshFrom.append($('<input type="hidden" name="patCardType" value="${commonParams.patCardType}" />'));
			freshFrom.append($('<input type="hidden" name="patCardNo" value="${commonParams.patCardNo}" />'));
			freshFrom.append($('<input type="hidden" name="detailId" value="${commonParams.detailId}" />'));
			freshFrom.append($('<input type="hidden"  name="patCardName" value="${commonParams.patCardName}" />'));
			freshFrom.append($('<input type="hidden" name="doctorName" value="${commonParams.doctorName}" />'));
			freshFrom.append($('<input type="hidden" name="reportTime" value="${commonParams.reportTime}" />'));
			freshFrom.appendTo("body");
			freshFrom.css('display','none');
			freshFrom.attr("method","post");
			freshFrom.attr("action","${basePath}mobileApp/reports/reportDetail");
			freshFrom.submit();
		}
		
		function doGoBack()
		{
			var freshFrom=$("<form></form>");
			freshFrom.append($('<input type="hidden"  name="openId" value="${commonParams.openId}" />'));
			freshFrom.append($('<input type="hidden"  name="appCode" value="${commonParams.appCode}" />'));
			freshFrom.append($('<input type="hidden"  name="appId" value="${commonParams.appId}" />'));
			freshFrom.append($('<input type="hidden"  name="areaCode" value="${commonParams.areaCode}" />'));
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
			// freshFrom.attr("action","${basePath}mobileApp/reports/index");
			freshFrom.attr("action","${basePath}easyhealth/report/reportIndex");
			freshFrom.submit();
		}
	</script>
<#include "/mobileApp/common/yxw_footer.ftl">

</body>
</html>