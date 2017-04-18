<#--
	1、明细信息异步查询
	2、明细信息若是查询不到，则不允许支付
-->
<!DOCTYPE html>
<html>
<head>
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
	<meta HTTP-EQUIV="expires" CONTENT="0"> 
  	<#include "/mobileApp/common/common.ftl">
    <title>待缴费项</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
    <div id="guoHaoJiLv">
        <div id="nav"></div>
        <div id="js-navContent" style="display: block;">
            <div class="boxLi">
                <ul id="clinic-list" class="yx-list">

                </ul>
            </div>
        </div>
    </div>
</div>
<form id="voForm" method="post">
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
	<input type="hidden" id="cardType" name="cardType" value="" />
	<input type="hidden" id="cardNo" name="cardNo" value="" />
	<input type="hidden" id="patientName" name="patientName" value="" />
	<input type="hidden" id="mzFeeId" name="mzFeeId" value="" />
	<input type="hidden" id="totalFee" name="totalFee" value="" />
	<input type="hidden" id="payFee" name="payFee" value="" />
	<input type="hidden" id="medicareFee" name="medicareFee" value="" />
	<input type="hidden" id="medicareType" name="medicareType" value="" />
	<input type="hidden" id="deptName" name="deptName" value="" />
	<input type="hidden" id="doctorName" name="doctorName" value="" />
	<input type="hidden" id="patientMobile" name="patientMobile" value="" />
</form>
<input type="hidden" id="forward" name="forward" value="${basePath}mobileApp/clinic/payIndex" />
<input type="hidden" id="defaultCardNo" name="defaultCardNo" value="${commonParams.cardNo}" />
<script type="text/javascript">
	
	function loadData(){
		$('#appCode').val('${commonParams.appCode}');
		$("#cardType").val($("#selectedCard").attr("data-type"));
		$("#cardNo").val($("#selectedCard").attr("data-no"));
		$("#patientName").val($("#selectedCard").attr("data-name"));
		$("#patientMobile").val($("#selectedCard").attr("data-mobile"));
		
		var url = "${basePath}mobileApp/clinic/getClinicPayList";
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
           		if (data.status == 'OK' && data.message) {
           			formatData(data.message);
           		} else {
           			showNoData();
           		}
           	}
    	})
	}
	
	function formatData(data) {
		if (data.list.length > 0) {
			var sHtml = '';
			
			$.each(data.list, function(i, item) {
				// item.medicareAmout = 0;
				sHtml += '<li data-id="' + getValue(item.mzFeeId) + 
						   '" data-total="' + getValue(item.totalAmout) + 
						   '" data-medicare="' + getValue(item.medicareAmout) + 
						   '" data-pay="' + getValue(item.payAmout) + 
						   '" data-doctor="' + getValue(item.doctorName) + 
						   '" data-dept="' + getValue(item.deptName) + 
						   '" data-branchCode="' + getValue(item.branchCode) +
						   '" data-type="' + getValue(item.payType) + '">';
                sHtml += '	<div class="name">门诊缴费</div>';
                sHtml += '	<div class="time">' + (getValue(item.time) ? item.time : '&nbsp;') + '</div>';
                sHtml += '	<div class="status color666 showDetail" style="top: 42px;">查看详细 <i class="icon-arrow"></i></div>';
                sHtml += '	<div class="inlineCost">';
                sHtml += '		<p class="color666">总金额: <span class="fontSize150 yellow" style="line-height: 1;  vertical-align: text-bottom;">' + Number(item.totalAmout / 100).toFixed(2) + '</span> 元</p>';
                sHtml += '		<div class="btn btn-auto showDetail" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">去缴费</div>';
                sHtml += '	</div>';
                sHtml += '</li>';
			});
			
			$('#clinic-list').html('');
			$('#clinic-list').append(sHtml);
			
			bindDetailEvent();
		} else {
			showNoData();
		}
	}
	
	function showNoData() {
		var sHtml = '';
		$('#clinic-list').html('');
		
		sHtml += '<li class="noData">';
        // sHtml += '	<img src="${basePath}images/noData2.png" width="110">';
        sHtml += '  <p class="color666" style="text-align: center">没有查到您的待缴费信息</p>';
        sHtml += '</li>';
		
		$('#clinic-list').append(sHtml);
	}
	
	function bindDetailEvent() {
		$('.showDetail').off('click').on('click', function() {
			var obj = "";
			if ($(this).is('.status')) {
				obj = $(this).parent();
			} else {
				obj = $(this).parent().parent();
			}
			
			$('#mzFeeId').val($(obj).attr('data-id'));
			$('#totalFee').val(Number($(obj).attr('data-total')));
			$('#medicareFee').val(Number($(obj).attr('data-medicare')));
			$('#payFee').val(Number($(obj).attr('data-pay')));
			$('#deptName').val($(obj).attr('data-dept'));
			$('#doctorName').val($(obj).attr('data-doctor'));
			$('#medicareType').val($(obj).attr('data-type'));
			// 这个地方一开始会带有一个分院，但是在查看明细的时候，应该从列表中拿到分院数据。
			var branchCode = $(obj).attr('data-branchCode')
			if (branchCode && branchCode != 'null') {
				$('#branchHospitalCode').val(branchCode);
			}
			
			$('#voForm').attr('action', '${basePath}mobileApp/clinic/payDetail');
			$('#voForm').submit();
		});
	}
	
	function getValue(data) {
		if (data && data != 'null') {
			return data;
		} else {
		 	return "";
		}
	}
	
	// 0 常规访问
	// 1消息推送访问
	var visitWay = 0;
	
	$(function() {
		var defaultCardNo = '${commonParams.cardNo}';
		if (defaultCardNo) {
			visitWay = 1;
		} 
	});
	
	function doRefresh()
	{
		if (visitWay == 0) {
			var freshFrom=$("<form></form>");
			freshFrom.append($('<input type="hidden"  name="openId" value="${commonParams.openId}" />'));
			freshFrom.append($('<input type="hidden"  name="appCode" value="${commonParams.appCode}" />'));
			freshFrom.append($('<input type="hidden"  name="appId" value="${commonParams.appId}" />'));
			freshFrom.append($('<input type="hidden"  name="hospitalCode" value="${commonParams.hospitalCode}" />'));
			freshFrom.append($('<input type="hidden"  name="hospitalId" value="${commonParams.hospitalId}">'));
			freshFrom.append($('<input type="hidden"  name="hospitalName" value="${commonParams.hospitalName}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalName" value="${commonParams.branchHospitalName}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalId" value="${commonParams.branchHospitalId}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />'));
			freshFrom.appendTo("body");
			freshFrom.css('display','none');
			freshFrom.attr("method","post");
			freshFrom.attr("action","${basePath}mobileApp/clinic/payIndex");
			freshFrom.submit();
		} else {
			var freshFrom=$("<form></form>");
			freshFrom.append($('<input type="hidden"  name="openId" value="${commonParams.openId}" />'));
			freshFrom.append($('<input type="hidden"  name="appCode" value="${commonParams.appCode}" />'));
			freshFrom.append($('<input type="hidden"  name="appId" value="${commonParams.appId}" />'));
			freshFrom.append($('<input type="hidden"  name="hospitalCode" value="${commonParams.hospitalCode}" />'));
			freshFrom.append($('<input type="hidden"  name="hospitalId" value="${commonParams.hospitalId}">'));
			freshFrom.append($('<input type="hidden"  name="hospitalName" value="${commonParams.hospitalName}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalName" value="${commonParams.branchHospitalName}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalId" value="${commonParams.branchHospitalId}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />'));
			freshFrom.append($('<input type="hidden"  name="cardNo" value="${commonParams.cardNo}" />'));
			freshFrom.appendTo("body");
			freshFrom.css('display','none');
			freshFrom.attr("method","post");
			freshFrom.attr("action","${basePath}mobileApp/clinic/payIndexFromMsg");
			freshFrom.submit();
		}
	}
	
	function doGoBack()
	{
		if (visitWay == 0) {
			window.location.href="${basePath}mobileApp/clinic/hospitalList?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng";
		} else {
			// 关闭页面
		}
	}
</script>
<#include "/mobileApp/common/yxw_footer.ftl">
<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery.cookie.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/card-list.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/nav-list.js"></script>
</body>
</html>