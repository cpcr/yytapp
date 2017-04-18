var cardList = {
	getCardList: function(appId, openId) {
		$.ajax({
			url: appPath + 'mobileApp/common/findAllCards',
		 	data: {
			 	// 注意参数的大小写
		 		appId: $('#appId').val(),
				appCode: $('#appCode').val(),
			 	openId: $('#openId').val(),
			 	branchId: $('#branchHospitalId').val(),
			 	branchCode: $('#branchHospitalCode').val(),
			 	branchHospitalName: $('#branchHospitalName').val(),
			 	hospitalCode: $('#hospitalCode').val(),
			 	hospitalId: $('#hospitalId').val(),
			 	hospitalName: $('#hospitalName').val(),
			 },
		 	dataType: 'json',
		 	timeout: '10000',
		 	type: 'POST',
		 	async: false,
		 	error: function(XMLHQ, errorMsg) {
				//$Y.loading.hide();
		 		cardList.showNoRecord();
		 	},
		 	complete : function(XMLHttpRequest,status) { 
		 		if(status=='timeout'){
		 			ajaxTimeoutTest.abort();
		 		}
		 	},
		 	success: function(data) {
		 		console.log(data);
		 		if (data.status == 'OK' && data.message) {
				 	var cards = data.message;
				 	cardList.formatData(cards);
		 		} else {
		 			cardList.showNoRecord();
		 		}
		 	}
		});
	},
	setDefaultCard: function() {
		var appCode = $('#appCode').val();
		var cardId = '';
		if (appCode == 'easyHealth') {
			var areaCode = $('#areaCode').val();
			cardId = $.cookie(areaCode + '_' + $('#openId').val() + '_defaultCard'); 
		} else {
			cardId = $.cookie($('#appId').val() + '_' + $('#openId').val() + '_defaultCard'); 
		}
		console.log(cardId);
		if (cardId) {
			var jsItem = $('.js-item[userid="' + cardId + '"]');
			$('#selectedCard').attr('userId', $(jsItem).attr('userId'));
			$('#selectedCard').attr('data-no', $(jsItem).attr('data-no'));
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
		var hospitalCode;
		var hospitalId;
		
		$('#nav').html("");
		
		if (data.length > 0) {
			sList += '<div class="navList" id="js-navList" style="display: none;">';
			sList += '	<ul class="yx-list">';
			sList += '		<li class="Title_label color999">选择就诊人<i class="iconfont">&#xe604;</i></li>';
			$.each(data, function(i, item) {
				if (i == 0) {
					name = item.name;
					cardNo = item.cardNo;
					cardId = item.id;
					cardType = item.cardType;
					branchCode = item.branchCode;
					branchId = item.branchId;
					mobile = item.mobile;
					hospitalCode = item.hospitalCode;
					hospitalId = item.hospitalId;
				}
				sList += '<li class="js-item" userId="' + item.id + '" data-no="' + item.cardNo + '" data-type="' + item.cardType + '" data-name="' + item.name + '" data-hospitalCode="' + item.hospitalCode + '" data-hospitalId="' + item.hospitalId
								+ '" data-branchCode="' + item.branchCode + '" data-branchId="' + item.branchId + '" data-mobile="' + item.mobile + '">'; 
				sList += '	<div class="js-title">*' + item.name.substring(1, item.name.length); 
				sList += '		<span class="color999">（' + item.cardNo + '）</span>';
				sList += '	</div>';
				sList += '	<div class="js-title color999 fontSize100">' + item.hospitalName + '</div>';
				sList += '</li>';
			});
			sList += '	</ul>';
			sList += '</div>';
			
	        sHtml += '<div class="navView" id="js-navView" style="display: block;" onclick="showNavList()">';
	        sHtml += '	就诊人：';
	        sHtml += '	<span class="js-value skinColor" userId="' + cardId + '" data-no="' + cardNo + '" data-type="' + cardType + '" data-name="' + name + '" data-hospitalCode="' + hospitalCode + '" data-hospitalId="' + hospitalId
	        			+ '" id="selectedCard" data-branchCode=' + branchCode +'" data-branchId="' + branchId + '" data-mobile="' + mobile + '">*' + name.substring(1, name.length);
	        sHtml += '		<span class="color999">（' + cardNo + '）</span>';
	        sHtml += '	</span>';
	        sHtml += '	<i class="iconfont">&#xe600;</i>';
	        sHtml += '</div>';
	        
	        $('#nav').append(sHtml + sList);
			cardList.setDefaultCard();
			// 调用业务方法
			loadData();
		} else {
			cardList.showNoRecord();
		}
		
		
	}, 
	showNoRecord: function() {
		if (typeof showNoRecord === 'function' ) {
			showNoRecord();
        } else {
			var sHtml = '';
			
			sHtml += '<div id="success">';
		    sHtml += '	<div class="noticeEmpty"></div>';
		    sHtml += '	<div class="p color666">没有任何挂号记录</div>';
		    sHtml += '</div>';
		    
		    $('#body').html('');
		    $('#body').append(sHtml);
        }
	}
};

$(function() {
	cardList.init();
 });