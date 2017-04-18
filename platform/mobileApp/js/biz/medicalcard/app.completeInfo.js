var completeInfo = {
	init: function() {
		$('.page-select').hide().eq(ownership - 1).show();
		
		$('.patCardNo').focus(function() {
    		$(this).siblings('.placeholder-text').hide();
    		$(this).val('');
    	}).blur(function() {
    		if (!$(this).val()) {
    			$(this).siblings('.placeholder-text').show();
    		}
    	});
		
		$('.admissionNo').focus(function() {
			$(this).siblings('.placeholder-text').hide();
			$(this).val('');
		}).blur(function() {
			if (!$(this).val()) {
    			$(this).siblings('.placeholder-text').show();
    		}
		});
		
		$.each($('.yx-input'), function(i, item) {
			if ($(item).val() && $(item).val() != 'null') {
				$(this).siblings('.placeholder-text').hide();
				$(item).attr('readOnly', true);
				$(item).off('focus');
				$(item).off('blur');
			}
		});
	},
	completeAdultInfo: function() {
		var data = {
			personId: $('#personId').val(),
			openId: $('#openId').val(),
			cardType:$('#adultPatCardType').attr('data-value'),
			cardNo: $('#adultPatCardNo').val(),
			admissionNo: $('#adultAdmissionNo').val()
		}
		completeInfo.ajaxCompleteInfo(data);
	}, 
	completeChildInfo: function() {
		var data = {
			personId: $('#personId').val(),
			openId: $('#openId').val(),
			cardType:$('#childPatCardType').attr('data-value'),
			cardNo: $('#childPatCardNo').text(),
			admissionNo: $('#childAdmissionNo').val()
		}
		completeInfo.ajaxCompleteInfo(data);
	},
	ajaxCompleteInfo: function(data) {
		console.log(data);
		var url = "";
		if (completeType == 1) {
			// 完善就诊卡信息
			url = appPath + 'mobileApp/medicalcard/completeCardInfo';
		} else {
			// 完善住院信息
			url = appPath + 'mobileApp/medicalcard/completeAdmissionInfo';
		}
		
		if (completeInfo.validateComplete()) {
			// 验证成功
			return $.ajax({
				type: "POST",
				url: url,
				data: data,
				cache: false, 
				dataType: "json", 
				timeout: 7900,
				error: function(data) {
					$Y.loading.hide();
					new $Y.confirm({
			            ok:{title:'确定'},
			            content:'网络超时，请稍后在个人中心查看修改结果。'
			        });
				},
				success: function(data) {
					$Y.loading.hide();
					console.log(data);
					if (data.status == 'OK') {
						var code = data.message.isSuccess;
						if (code == 'success' && data.message.card && data.message.card != 'null') {
							var forward = $('#forwardForm').attr('action');
							if (forward) {
								$('#forwardForm').append('<input type="hidden" name="appId" value="' + $('input[name="appId"]').val() + '" />');
								$('#forwardForm').append('<input type="hidden" name="appCode" value="' + $('input[name="appCode"]').val() + '" />');
								$('#forwardForm').append('<input type="hidden" name="openId" value="' + $('input[name="openId"]').val() + '" />');
								$('#forwardForm').submit();
							} else {
								new $Y.confirm({
						            ok:{title:'确定'},
						            content: '更新信息成功！'
						        });
							}
						} else if (code == 'fail') {
							new $Y.confirm({
					            ok:{title:'确定'},
					            content: '添加失败'
					        });
							
						} else {
							new $Y.confirm({
					            ok:{title:'确定'},
					            content: data.message.msgInfo ? data.message.msgInfo : '添加失败'
					        });
							
						}
					}
				}
			});
		} else {
			// 验证失败
			if (completeType == 1) {
				$Y.tips('请输入就诊卡信息');
			} else {
				$Y.tips('请输入住院号信息');
			}
		}
	},
	validateComplete() {
		var isValid = false;
		
		if (ownership == 1) {
			if (completeType == 1) {
				isValid = $('#adultPatCardType').attr('data-value') && $('#adultPatCardNo').val();
			} else {
				isValid = $('#adultAdmissionNo').val() && true;
			}
		} else {
			if (completeType == 1) {
				isValid = $('#childPatCardType').attr('data-value') && $('#childPatCardNo').val();
			} else {
				isValid = $('#childAdmissionNo').val() && true;
			}
		}
		
		return isValid;
	}
}

var completeType = $('#completeType').val();
var ownership = Number($('#userType').attr('data-value'));
if (ownership == 3) {
	ownership = 2;
} else {
	ownership = 1;
}

$(function() {
	completeInfo.init();
});