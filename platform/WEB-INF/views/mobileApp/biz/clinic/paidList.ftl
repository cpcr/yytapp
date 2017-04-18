<!DOCTYPE html>
<html>
<head>
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
	<meta HTTP-EQUIV="expires" CONTENT="0"> 
  	<#include "/mobileApp/common/common.ftl">
    <title>已缴费项</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
    <div id="guoHaoJiLv">
        <div id="nav"></div>
        <div id="js-navContent" style="display: block;">
            <div class="box-list baoGaoList">
            	<div class="baoGao-tag js-tag">
                </div>
                <ul id="clinic-list" class="yx-list js-tagContent show">

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
	<input type="hidden" id="maxMonths" name="maxMonths" value="${rule.paymentRecordQueryMaxMonths}" />
	<input type="hidden" id="clinicStatus" name="clinicStatus" value="" />
	<input type="hidden" id="cardType" name="cardType" value="" />
	<input type="hidden" id="cardNo" name="cardNo" value="" />
	<input type="hidden" id="patientName" name="patientName" value="" />
	<input type="hidden" id="mzFeeId" name="mzFeeId" value="" />
	<input type="hidden" id="totalFee" name="totalFee" value="" />
	<input type="hidden" id="medicareFee" name="medicareFee" value="" />
	<input type="hidden" id="payFee" name="payFee" value="" />
	<input type="hidden" id="medicareType" name="medicareType" value="" />
	<input type="hidden" id="hisOrdNum" name="hisOrdNum" value="" />
	<input type="hidden" id="receiptNum" name="receiptNum" value="" />
	<input type="hidden" id="hisMessage" name="hisMessage" value="" />
	<input type="hidden" id="barcode" name="barcode" value="" />
	<input type="hidden" id="orderNo" name="orderNo" value="" />
</form>
<input type="hidden" id="paymentRecordQueryType" name="paymentRecordQueryType" value="" />
<input type="hidden" id="forward" name="forward" value="${basePath}mobileApp/clinic/paidIndex" />
<script type="text/javascript">
	$(function() {
		initData();
	});
	
	function initData() {
		var sHtml = '';
		var paidTypes = '${rule.paymentRecordQueryType}'.split(',');
		if (paidTypes.length == 0) {
			alert('后台没有配置好');
		} else if (paidTypes.length == 1) {
			$('#paymentRecordQueryType').val(paidTypes[0]);
		} else {
			$.each(paidTypes, function(i, item) {
				sHtml += '<div class="item item_tag" data-value="' + item + '" onclick="doLoadData(' + item + ');">';
				if (item == 1) {
					sHtml += '门诊缴费';
				} else if (item == 2) {
					sHtml += '住院缴费';
				}
				
				sHtml += '</div>';
			});
			
			$('.baoGao-tag').html('');
			$('.baoGao-tag').append(sHtml);
			
			// 设定首个为默认查询
			$('.baoGao-tag div:first').addClass('active');
			$('#paymentRecordQueryType').val($('.active').data('value'));
		}
	}
	
	function doLoadData(queryType) {
		$('#paymentRecordQueryType').val(queryType);
		loadData();
	}
	
	function loadData(){
		// $('#appCode').val('${commonParams.appCode}');
		$("#cardType").val($("#selectedCard").attr("data-type"));
		$("#cardNo").val($("#selectedCard").attr("data-no"));
		$("#patientName").val($("#selectedCard").attr("data-name"));
		
		var url = '';
		var queryType = $('#paymentRecordQueryType').val();
		if (queryType && queryType==2) {
			console.log('要查住院缴费');
			url = '${basePath}mobileApp/clinic/getClinicPaidList2';
		} else {
			console.log('要查门诊缴费');
			url = '${basePath}mobileApp/clinic/getClinicPaidList';
		}
		
		var datas = $("#voForm").serializeArray();
		// console.log(datas);
		$Y.loading.show('正在为您加载数据');
		$.ajax({
           	type: 'POST',  
           	url: url,  
           	data: datas,  
           	dataType: 'json',  
           	timeout: 120000,
           	error: function(data) {
           		$Y.loading.hide();
           		showNoData(queryType);
           	},
           	success : function(data) {
           		//console.log(data);
           		$Y.loading.hide();
           		if (data.status == 'OK' && data.message) {
           			if (queryType == 1) {
           				formatPaidData(data.message);
           			} else {
           				showNoData(queryType);
           			}
           		} else {
           			showNoData(queryType);
           		}
           	}
    	})
	}
	
	function formatPaidData(data) {
		if (data.list.length > 0) {
			var sHtml = '';
			
			$.each(data.list, function(i, item) {
				//console.log("orderNo=" + item.orderNo + ", receiptNum=" + item.receiptNum + ", hisMessage=" + item.hisMessage);
				sHtml += '<li class="detail-item" data-id="' + item.mzFeeId + 
									           '" data-total="' + item.totalFee + 
									           '" data-medicare="' + item.medicareFee + 
									           '" data-pay="' + item.payFee + 
									           '" data-type="' + item.medicareType + 
									           '" data-hisOrdNum="' + item.hisOrdNo +
									           '" data-receiptNum="' + item.receiptNum + 
									           '" data-branchHospitalCode="' + item.branchHospitalCode + 
									           '" data-barcode="' + item.barcode + 
									           '" data-status="' + item.clinicStatus + 
									           '" data-orderNo="' + item.orderNo + 
									           '" data-hisMessage="' + encodeURIComponent(item.hisMessage) + '">';
                sHtml += '	<div class="mate">';
                if (item.statusLabel == '缴费成功' || item.statusLabel == '部分退费') {
                 	sHtml += '	<div class="status color666">' + item.statusLabel;
                	sHtml += '		<i class="icon-arrow"></i>';
                } else {
                	if (item.statusLabel == '缴费失败') {
                		sHtml += '	<div class="status red">' + item.statusLabel;
                	} else {
                		sHtml += '	<div class="status color666">' + item.statusLabel;
                	}
                	sHtml += '　&nbsp;&nbsp;';
                }
                sHtml += '		</div>';
                sHtml += '	</div>';
                sHtml += '	<div class="title">' + item.recordTitle;
                sHtml += '		<br>';
                sHtml += '		<span class="cost yellow">' + Number(item.payFee / 100).toFixed(2) + '元</span>';
                sHtml += '		<span class="time">' + item.payTimeLabel + '</span>';
                sHtml += '	</div>';
                sHtml += '</li>'
			});
			
			
			$('#clinic-list').html('');
			$('#clinic-list').append(sHtml);
			$('#clinic-list').show();
			
			bindClinicEvent();
		} else {
			showNoData(1);
		}
	}
	
	function bindClinicEvent() {
		$('.detail-item').off('click').on('click', function(event) {
			event.stopPropagation();
	        event.preventDefault();
	        
	        showPaidDetail(this);
		});
	}
	
	function showPaidDetail(obj) {
		if (obj && ($(obj).attr('data-status') == '1' || $(obj).attr('data-status') == '30')) {
			$('#mzFeeId').val(getValue($(obj).attr('data-id')));
			$('#payFee').val(getValue($(obj).attr('data-pay')));
			$('#totalFee').val(getValue($(obj).attr('data-total')));
			$('#medicareFee').val(getValue($(obj).attr('data-medicare')));
			$('#medicareType').val(getValue($(obj).attr('data-type')));
			$('#hisOrdNum').val(getValue($(obj).attr('data-hisOrdNum')));
			$('#orderNo').val(getValue($(obj).attr('data-orderNo')));
			$('#clinicStatus').val(getValue($(obj).attr('data-status')));
			$('#receiptNum').val(getValue($(obj).attr('data-receiptNum')));
			$('#hisMessage').val(getValue($(obj).attr('data-hisMessage')));
			$('#barcode').val(getValue($(obj).attr('data-barcode')));
			$('#branchHospitalCode').val(getValue($(obj).attr('data-branchHospitalCode')));
			$('#voForm').attr('action', '${basePath}mobileApp/clinic/paidDetail');
			$('#voForm').submit();
		}
	}
	
	function showNoData(queryType) {
		var sHtml = '';
		
		sHtml += '<li class="noData">';
        sHtml += '	<img src="${basePath}/images/noData2.png" width="110">';
        sHtml += '  <p class="color666" style="text-align: center">';
        if (queryType == 2) {
        	sHtml += '没有查到您的住院押金缴费信息';
        } else {
        	sHtml += '没有查到您的门诊缴费信息';
        }
        sHtml += '	</p>';
        sHtml += '</li>';
		
		$('#clinic-list').html('');
		$('#clinic-list').append(sHtml);
		$('#clinic-list').show();
	}
	
	function getValue(data) {
		if (!data || data == 'null') {
			data = '';
		}
		return data;
	}
</script>
<#include "/mobileApp/common/yxw_footer.ftl">
<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery.cookie.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/card-list.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/nav-list.js"></script>
</body>
</html>