var cardList = {
	getCardList: function(appId, openId) {
		var platform = '';
		if ($('input[name="appCode"]').val() != 'easyHealth') {
			$('input[name="appCode"]').val() == 'wechat' ? '1' : '2';
		}
		$.ajax({
			url: appPath + 'mobileApp/common/findAllCards',
		 	data: {
			 	// 注意参数的大小写
		 		appId: $('#appId').val(),
				appCode: $('#appCode').val(),
			 	openId: $('#openId').val(),
			 	branchId: $('#branchHospitalId').val(),
			 	branchCode: $('#branchHospitalCode').val(),
			 	hospitalCode: $('#hospitalCode').val(),
			 	hospitalId: $('#hospitalId').val(),
			 	userId:$('#userId').val(),
			 	platform: platform
			 },
		 	dataType: 'json',
		 	timeout: '10000',
		 	type: 'POST',
		 	async: false,
		 	error: function(XMLHQ, errorMsg) {
				//$Y.loading.hide();
		 	},
		 	complete : function(XMLHttpRequest,status) { 
		 		if(status=='timeout'){
		 			ajaxTimeoutTest.abort();
		 		}
		 	},
		 	success: function(data) {
		 		console.log(data);
		 		if (data.status == 'OK') {
				 	var cards = data.message;
				 	cardList.formatData(cards);
		 		}
		 	}
		});
	},
	setDefaultCard: function() {
		var cardId = $.cookie($('#appId').val() + '_' + $('#openId').val() + '_defaultCard'); 
		console.log(cardId);
		if (cardId) {
			var jsItem = $('.js-item[userid="' + cardId + '"]');
			$('#selectedCard').attr('userId', $(jsItem).attr('userId'));
			$('#selectedCard').attr('data-no', $(jsItem).attr('data-no'));
			$('#selectedCard').attr('data-admissionNo', $(jsItem).attr('data-admissionNo'));
			$('#selectedCard').attr('data-type', $(jsItem).attr('data-type'));
			$('#selectedCard').attr('data-name', $(jsItem).attr('data-name'));
			$('#selectedCard').attr('data-branchCode', $(jsItem).attr('data-branchCode'));
			$('#selectedCard').attr('data-branchId', $(jsItem).attr('data-branchId'));
			$('#selectedCard').attr('data-mobile', $(jsItem).attr('data-mobile'));
			$('#selectedCard').html($(jsItem).find('.js-title').html());
		}
	},
	init: function() {
		cardList.getCardList();
	},
	formatData: function(data) {
		var sHtml = '';
		var sList = '';
		
		var cardNo = '';
		var name = '';
		var cardId = '';
		var cardType = '';
		var admission = '';
		
		var hospitalCode;
		var hospitalId;
		
		$('#nav').html("");
		
		if (data.length > 0) {
			sList += '<div class="navList" id="js-navList" style="display: none;">';
			sList += '	<ul class="yx-list">';
			sList += '		<li class="Title_label color999">选择就诊人<i class="icon-arrow-push"></i></li>';
			$.each(data, function(i, item) {
				if (i == 0) {
					name = item.name;
					cardNo = item.cardNo;
					admission = item.admission;
					cardId = item.id;
					cardType = item.cardType;
					branchCode = item.branchCode;
					branchId = item.branchId;
					mobile = item.mobile;
					hospitalCode = item.hospitalCode;
					hospitalId = item.hospitalId;
				}
				sList += '<li class="js-item" ' + 
							'userId="' + item.id + 
							'" data-no="' + getValue(item.cardNo) + 
							'" data-admissionNo="' + getValue(item.admissionNo) + 
							'" data-type="' + getValue(item.cardType) + 
							'" data-name="' + item.name + 
							'" data-hospitalCode="' + item.hospitalCode + 
							'" data-hospitalId="' + item.hospitalId + 
							'" data-branchCode="' + item.branchCode + 
							'" data-branchId="' + item.branchId + 
							'" data-mobile="' + item.mobile + '">'; 
				sList += '	<div class="js-title">*' + item.name.substring(1, item.name.length); 
				if (getValue(item.admissionNo)) {
					sList += '<span class="color999">（' + getValue(item.admissionNo) + '）</span>';
				} else {
					sList += '<span class="color999">（暂无住院号）</span>';
				}
				sList += '	</div>';
				sList += '</li>';
			});
			sList += '	</ul>';
			sList += '</div>';
			
	        sHtml += '<div class="navView" id="js-navView" style="display: block;">';
	        sHtml += '	就诊人：';
	        sHtml += '	<span class="js-value skinColor" id="selectedCard" ' + 
	        			'userId="' + cardId + 
	        			'" data-no="' + cardNo + 
	        			'" data-admissionNo="' + getValue(admissionNo) + 
	        			'" data-type="' + getValue(cardType) + 
	        			'" data-name="' + getValue(name) + 
	        			'" data-hospitalCode="' + hospitalCode + 
	        			'" data-hospitalId="' + hospitalId + 
	        			'" data-branchCode=' + branchCode +
	        			'" data-branchId="' + branchId + 
	        			'" data-mobile="' + mobile + '">*' + name.substring(1, name.length);
	        if (getValue(admissionNo)) {
	        	sHtml += '		<span class="color999">（' + getValue(admissionNo) + '）</span>';
	        }
	        sHtml += '	</span>';
	        sHtml += '	<i class="icon-arrow-pull"></i>';
	        sHtml += '</div>';
	        
	        $('#nav').append(sHtml + sList);
			cardList.bindEvent();
			cardList.setDefaultCard();
			// 调用业务方法
			if ($('#selectedCard').attr('data-admissionNo')) {
				loadData();
			} else {
				toBindAdmissionNo();
			}
		} else {
			cardList.showNoRecord('您还没有添加任何就诊人，请先添加。');
		}
		
		
	},
	bindEvent: function(appId, openId) {
		$('.navView').click(function() {
			showNavList();
		});
	},
	showNoRecord: function(data) {
		var obj = $('#nav').parent();
		obj.html('');
		var sHtml = '';
		sHtml += '<div id="nav">';
		sHtml += '	<div id="success">';
		sHtml += '		<img src="' + appPath + 'mobileApp/images/noData-pic.png" width="110">';
		sHtml += '		<div class="p color666">' + data + '</div>';
		sHtml += '	</div>';
		sHtml += '	<div class="section btn-w">';
		sHtml += '		<div class="btn btn-block btn-ok bindCard" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">添加就诊人</div>';
		sHtml += '	</div>';
		sHtml += '</div>';
		
		obj.append(sHtml);
		
		var sForm = '';
		sForm += '<form id="bindForm" method="post">';
		sForm += '	<input type="hidden" name="openId" value="" />';
		sForm += '	<input type="hidden" name="appCode" value="" />';
		sForm += '	<input type="hidden" name="appId" value="" />';
		sForm += '	<input type="hidden" name="hospitalCode" value="" />';
		sForm += '	<input type="hidden" name="hospitalId" value="" />';
		sForm += '	<input type="hidden" name="hospitalName" value="" />';
		sForm += '	<input type="hidden" name="branchHospitalCode" value="" />';
		sForm += '	<input type="hidden" name="branchHospitalId" value="" />';
		sForm += '	<input type="hidden" name="branchHospitalName" value="" />';
		sForm += '	<input type="hidden" name="forward" value="" />';
		sForm += '</form>';
		$('#body').append(sForm);
		$('.bindCard').click(function() {
			cardList.bindCard();
		});
	},
	bindCard: function() {
		$('#bindForm input[name="appId"]').val($('#appId').val());
		$('#bindForm input[name="appCode"]').val($('#appCode').val());
		$('#bindForm input[name="openId"]').val($('#openId').val());
		$('#bindForm input[name="hospitalCode"]').val($('#hospitalCode').val());
		$('#bindForm input[name="hospitalId"]').val($('#hospitalId').val());
		$('#bindForm input[name="hospitalName"]').val($('#hospitalName').val());
		$('#bindForm input[name="branchHospitalCode"]').val($('#branchHospitalCode').val());
		$('#bindForm input[name="branchHospitalId"]').val($('#branchHospitalId').val());
		$('#bindForm input[name="branchHospitalName"]').val($('#branchHospitalName').val());
		$('#bindForm input[name="forward"]').val($('#forward').val());
		$("#bindForm").attr("action", appPath + 'mobileApp/medicalcard/bind/toView');
	    $("#bindForm").submit();
	}
};

function getValue(data) {
	if (data && data != 'null') {
		return data;
	} else {
	 	return "";
	}
}

function toBindAdmissionNo() {
	var sHtml = '';
	sHtml += '<div id="pay_detail"></div>';
	sHtml += '<div id="no_data">';
	sHtml += '	<div id="success">';
	sHtml += '		<img src="../images/noData-pic.png" width="150">';
	sHtml += '		<div class="p color666"> 该就诊人还没有住院号信息， 请先输入住院号。</div>';
	sHtml += '	</div>';
	sHtml += '	<div class="section btn-w">';
	sHtml += '		<div class="btn btn-block btn-ok inputAdmissionNo" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">输入住院号</div>';
	sHtml += '	</div>';
	sHtml += '</div>';
	
	$('#js-navContent').html('');
	$('#js-navContent').html(sHtml);
	
	var sForm = '';
	sForm += '<form id="completeForm" method="post">';
	sForm += '	<input type="hidden" name="openId" value="" />';
	sForm += '	<input type="hidden" name="appCode" value="" />';
	sForm += '	<input type="hidden" name="appId" value="" />';
	sForm += '	<input type="hidden" name="hospitalCode" value="" />';
	sForm += '	<input type="hidden" name="hospitalId" value="" />';
	sForm += '	<input type="hidden" name="hospitalName" value="" />';
	sForm += '	<input type="hidden" name="branchHospitalCode" value="" />';
	sForm += '	<input type="hidden" name="branchHospitalId" value="" />';
	sForm += '	<input type="hidden" name="branchHospitalName" value="" />';
	sForm += '	<input type="hidden" name="forward" value="" />';
	sForm += '	<input type="hidden" name="personId" value="" />';
	sForm += '</form>';
	$('#body').append(sForm);
	
	$('.inputAdmissionNo').click(function() {
		completeInfo();
	});
}

function completeInfo() {
	$('#completeForm input[name="appId"]').val($('#appId').val());
	$('#completeForm input[name="appCode"]').val($('#appCode').val());
	$('#completeForm input[name="openId"]').val($('#openId').val());
	$('#completeForm input[name="hospitalCode"]').val($('#hospitalCode').val());
	$('#completeForm input[name="hospitalId"]').val($('#hospitalId').val());
	$('#completeForm input[name="hospitalName"]').val($('#hospitalName').val());
	$('#completeForm input[name="branchHospitalCode"]').val($('#branchHospitalCode').val());
	$('#completeForm input[name="branchHospitalId"]').val($('#branchHospitalId').val());
	$('#completeForm input[name="branchHospitalName"]').val($('#branchHospitalName').val());
	$('#completeForm input[name="forward"]').val($('#forward').val());
	$('#completeForm input[name="personId"]').val($('#selectedCard').attr('userId'));
	$("#completeForm").attr("action", appPath + 'mobileApp/medicalcard/completeInfo');
    $("#completeForm").submit();
}

$(function() {
	cardList.init();
 });