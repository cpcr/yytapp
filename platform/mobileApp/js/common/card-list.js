var cardList = {
	getCardList: function(appId, openId) {
		var platform = '';
		if ($('input[name="appCode"]').val() != 'easyHealth') {
			platform = ($('input[name="appCode"]').val() == 'wechat') ? '1' : '2';
		} else {
			platform = 3;
		}
		$.ajax({
			url: appPath + 'mobileApp/common/findAllCards',
		 	data: {
			 	// 注意参数的大小写
		 		appId: $('#appId').val(),
		 		userId: $('#userId').val(),
				appCode: $('#appCode').val(),
			 	openId: $('#openId').val(),
			 	branchId: $('#branchHospitalId').val(),
			 	branchCode: $('#branchHospitalCode').val(),
			 	branchHospitalName: $('#branchHospitalName').val(),
			 	hospitalCode: $('#hospitalCode').val(),
			 	hospitalId: $('#hospitalId').val(),
			 	hospitalName: $('#hospitalName').val(),
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
		if ($('#defaultCardNo') && $('#defaultCardNo').val()) {
			var cardNo = $('#defaultCardNo').val();
			if (cardNo) {
				var jsItem = $('.js-item[data-no="' + cardNo + '"]');
				$('#selectedCard').attr('userId', $(jsItem).attr('userId'));
				$('#selectedCard').attr('data-no', $(jsItem).attr('data-no'));
				$('#selectedCard').attr('data-type', $(jsItem).attr('data-type'));
				$('#selectedCard').attr('data-name', $(jsItem).attr('data-name'));
				$('#selectedCard').attr('data-idNo', $(jsItem).attr('data-idNo'));
				$('#selectedCard').attr('data-branchCode', $(jsItem).attr('data-branchCode'));
				$('#selectedCard').attr('data-branchId', $(jsItem).attr('data-branchId'));
				$('#selectedCard').attr('data-mobile', $(jsItem).attr('data-mobile'));
				$('#selectedCard').html($(jsItem).find('.js-title').html());
			}
		} else {
			var cardId = $.cookie($('#appId').val() + '_' + $('#openId').val() + '_defaultCard'); 
			console.log(cardId);
			if (cardId) {
				var jsItem = $('.js-item[userid="' + cardId + '"]');
				$('#selectedCard').attr('userId', $(jsItem).attr('userId'));
				$('#selectedCard').attr('data-no', $(jsItem).attr('data-no'));
				$('#selectedCard').attr('data-type', $(jsItem).attr('data-type'));
				$('#selectedCard').attr('data-name', $(jsItem).attr('data-name'));
				$('#selectedCard').attr('data-idNo', $(jsItem).attr('data-idNo'));
				$('#selectedCard').attr('data-branchCode', $(jsItem).attr('data-branchCode'));
				$('#selectedCard').attr('data-branchId', $(jsItem).attr('data-branchId'));
				$('#selectedCard').attr('data-mobile', $(jsItem).attr('data-mobile'));
				$('#selectedCard').html($(jsItem).find('.js-title').html());
			}
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
					idNo = item.idNo;
					cardNo = item.cardNo;
					cardId = item.id;
					cardType = item.cardType;
					branchCode = item.branchCode;
					branchId = item.branchId;
					mobile = item.mobile;
					hospitalCode = item.hospitalCode;
					hospitalId = item.hospitalId;
				}
				sList += '<li class="js-item" userId="' + item.id + '" data-no="' + item.cardNo + '" data-type="' + item.cardType + 
						 '" data-name="' + item.name + '" data-idNo="' + item.idNo +  '" data-hospitalCode="' + item.hospitalCode + 
						 '" data-hospitalId="' + item.hospitalId + '" data-branchCode="' + item.branchCode + 
						 '" data-branchId="' + item.branchId + '" data-mobile="' + item.mobile + '">'; 
				sList += '	<div class="js-title">*' + item.name.substring(1, item.name.length); 
				sList += '		<span class="color999">（' + item.cardNo + '）</span>';
				sList += '	</div>';
				sList += '</li>';
			});
			sList += '	</ul>';
			sList += '</div>';
			
	        sHtml += '<div class="navView" id="js-navView" style="display: block;">';
	        sHtml += '	就诊人：';
	        sHtml += '	<span class="js-value skinColor" userId="' + cardId + '" data-no="' + cardNo + '" data-type="' + cardType + '" data-name="' + name + 
	        		'" data-hospitalCode="' + hospitalCode + '" data-hospitalId="' + hospitalId + '" data-idNo="' + idNo +  
	        		'" id="selectedCard" data-branchCode=' + branchCode +'" data-branchId="' + branchId + 
	        		'" data-mobile="' + mobile + '">*' + name.substring(1, name.length);
	        sHtml += '		<span class="color999">（' + cardNo + '）</span>';
	        sHtml += '	</span>';
	        sHtml += '	<i class="icon-arrow-pull"></i>';
	        sHtml += '</div>';
	        
	        $('#nav').append(sHtml + sList);
			cardList.bindEvent();
			cardList.setDefaultCard();
			// 调用业务方法
			// loadData();
			if (typeof loadData === 'function' ) {
            	setTimeout(function() {
            		loadData();
            	}, 100);
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
		sHtml += '		<div class="btn btn-block btn-ok" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">添加就诊人</div>';
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
		$('.btn-ok').click(function() {
			cardList.bindCard();
		});
	},
	bindCard: function() {
		$('#bindForm input[name="appId"]').val($('#appId').val());
		var appCode = $('#appCode').val();
		if (appCode != 'easyHealth') {
			appCode = '';
		}
		$('#bindForm input[name="appCode"]').val(appCode);
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

$(function() {
	cardList.init();
 });