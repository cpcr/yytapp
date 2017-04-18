var bindCard = {
	// 建档按钮
	createCard: function(obj) {
		obj.className = 'btn-jianDang hover';
        setTimeout(function(){
            obj.className = 'btn-jianDang';
        }, 250);
        
        $('#baseForm').attr('action', appPath + 'mobileApp/medicalcard/create/toView');
        $('#baseForm').submit();
	},
	// 与本人关系
	select_page: function (obj){
		if ($(obj).is('select')) {
			var index = Number($('#show_userType').attr('data-value'));
			$('.page-select').hide().eq(index - 1).show();
		} else {
			$('.page-select').hide().eq(Number($('#show_userType').attr('data-value')) - 1).show();
			$('#userType').val($('#show_userType').attr('data-value'));
    		userType = $('input[name="userType"]').val();
		}
    },
    // 改变生日
    changeBirth: function (obj){
        var index = $(obj)[0].selectedIndex;
        if(index == 0){
            $(obj).closest('ul').eq(0).find('li.birth').hide();
            $(obj).closest('ul').eq(0).find('li.sex_w').hide();
        }else{
            $(obj).closest('ul').eq(0).find('li.birth').show();
            $(obj).closest('ul').eq(0).find('li.sex_w').show();
        }
    },
    // 选择框
    select_box: function (obj){
        var option = obj.children[obj.selectedIndex];
        var html = option.innerHTML;
        // console.log(html);
        obj.previousElementSibling.querySelector('.text').innerHTML = html;
    },
    // 改变性别
    switchSex: function (obj){
    	$(obj).attr('class', 'sex-btn active');
    	$(obj).siblings('.sex-btn').attr('class', 'sex-btn');
    	$(obj).parent().attr('data-value', $(obj).attr('data-value'));
    },
    bindSelfCard: function(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行绑卡');
    	
    	// console.log(ajaxBind.state);
    	
    	/**
		 * 本人绑卡
		 * 1.姓名
		 * 2.证件号码(证件类型)
		 * 3.性别(不验证,生成)
		 * 4.出生日期(不验证，生成)
		 * 5.手机号码
		 * 6.就诊卡号(卡类型)
		 */
		if (!$('input[name="rSelfName"]').val()) {
			if ($('#selfName').val()) {
				bindCard.showIncorrectTip('姓名');
			} else {
				bindCard.showIncompleteTip('姓名');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rSelfIdNo"]').val()) {
			if ($('#selfIdNo').val()) {
				bindCard.showIncorrectTip('证件号码');
			} else {
				bindCard.showIncompleteTip('证件号码');
			}	
			$(obj).attr('disabled', false);	
			return false;
		}
		
		if (!$('#selfBirth').text() || $('#selfBirth').text() == '请选择') {
			bindCard.showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rSelfMobile"]').val()) {
			if ($('#selfMobile').val()) {
				bindCard.showIncorrectTip('手机号码');
			} else {
				bindCard.showIncompleteTip('手机号码');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#selfCardNo').val()) {
			bindCard.showIncompleteTip('卡号');
			$(obj).attr('disabled', false);
			return false;
		}
		// 本人异步绑卡
		console.log('本人异步绑卡流程...');
		
		var platform = 1;
		var appCode = $('input[name="appCode"]').val();
		if (appCode == 'wechat') {
			platform = 1;
		} else if (appCode == 'alipay') {
			platform = 2;
		} else if (appCode == 'easyHealth') {
			platform = 3;
		}
		var data = {
			appId: $('input[name="appId"]').val(),
			appCode: $('input[name="appCode"]').val(),
			hospitalCode: $('input[name="hospitalCode"]').val(),
			hospitalId: $('input[name="hospitalId"]').val(),
			hospitalName: $('input[name="hospitalName"]').val(),
			branchCode: $('input[name="branchHospitalCode"]').val(),
			branchId: $('input[name="branchHospitalId"]').val(),
			branchHospitalName: $('input[name="branchHospitalName"]').val(),
			platform: platform,
			openId: $('input[name="openId"]').val(),
			verifyConditionType: $('input[name="verifyConditionTypes"]').val(),
			name: $('input[name="rSelfName"]').val(),
			mobile: $('input[name="rSelfMobile"]').val(),
			idType: $('#show_selfIdType').attr('data-value'),
			idNo: $('input[name="rSelfIdNo"]').val(),
			birth: $('#selfBirth').text(),
			sex: $('#selfSex').attr('data-value'),
			age: $('#selfAge').val(),
			ownership: 1,
			cardType: $('#show_selfCardType').attr('data-value'),
			cardNo: $('#selfCardNo').val(),
			bindWay: "0"
		};
		console.log(data);
		bindCard.ajaxBindCard(obj, data);
    }, 
    bindOtherCard: function(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行绑卡');
    	
    	/**
		 * 他人绑卡
		 * 1.姓名
		 * 2.证件号码(证件类型)
		 * 3.性别
		 * 4.出生日期
		 * 5.手机号码
		 * 6.就诊卡号(卡类型)
		 */
		
		if (!$('input[name="rOtherName"]').val()) {
			if ($('#otherName').val()) {
				bindCard.showIncorrectTip('姓名');
			} else {
				bindCard.showIncompleteTip('姓名');
			}
			
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rOtherIdNo"]').val()) {
			if ($('#otherIdNo').val()) {
				bindCard.showIncorrectTip('证件号码');
			} else {
				bindCard.showIncompleteTip('证件号码');
			}	
			
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#otherBirth').text() || $('#otherBirth').text() == '请选择') {
			bindCard.showIncompleteTip('出生日期');
			
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rOtherMobile"]').val()) {
			if ($('#otherMobile').val()) {
				bindCard.showIncorrectTip('手机号码');
			} else {
				bindCard.showIncompleteTip('手机号码');
			}
			
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#otherCardNo').val()) {
			bindCard.showIncompleteTip('卡号');
			
			$(obj).attr('disabled', false);
			return false;
		}
		
    	// 他人异步绑卡
		console.log('他人异步绑卡流程...');
		var platform = 1;
		var appCode = $('input[name="appCode"]').val();
		if (appCode == 'wechat') {
			platform = 1;
		} else if (appCode == 'alipay') {
			platform = 2;
		} else if (appCode == 'easyHealth') {
			platform = 3;
		}
		var data = {
			appId: $('input[name="appId"]').val(),
			appCode: $('input[name="appCode"]').val(),
			hospitalCode: $('input[name="hospitalCode"]').val(),
			hospitalId: $('input[name="hospitalId"]').val(),
			hospitalName: $('input[name="hospitalName"]').val(),
			branchCode: $('input[name="branchHospitalCode"]').val(),
			branchId: $('input[name="branchHospitalId"]').val(),
			branchHospitalName: $('input[name="branchHospitalName"]').val(),
			platform: platform,
			openId: $('input[name="openId"]').val(),
			verifyConditionType: $('input[name="verifyConditionTypes"]').val(),
			name: $('input[name="rOtherName"]').val(),
			mobile: $('input[name="rOtherMobile"]').val(),
			idType: $('#show_otherIdType').attr('data-value'),
			idNo: $('input[name="rOtherIdNo"]').val(),
			birth: $('#otherBirth').text(),
			sex: $('#otherSex').attr('data-value'),
			age: $('#otherAge').val(),
			ownership: 2,
			cardType: $('#show_otherCardType').attr('data-value'),
			cardNo: $('#otherCardNo').val(),
			bindWay: "0"
		};
		console.log(data);
		bindCard.ajaxBindCard(obj, data);
    }, 
    bindChildCard: function(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行绑卡');
    	
    	/**
		 * 儿童绑卡，必要：
		 * 1.姓名
		 * 2.性别(不需要)
		 * 3.出生日期
		 * 4.就诊卡号(卡类型)
		 * 5.监护人姓名
		 * 6.监护人证件(证件类型)
		 * 7.监护人手机号码
		 */
    	if (!$('input[name="rChildName"]').val()) {
    		if ($('#childName').val()) {
				bindCard.showIncorrectTip('姓名');
			} else {
				bindCard.showIncompleteTip('姓名');
			}
    		$(obj).attr('disabled', false);
			return false;
		}
    	
		if (!$('#childBirth').text() || $('#childBirth').text() == '请选择') {
			bindCard.showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#childCardNo').val()) {
			bindCard.showIncompleteTip('卡号');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardName"]').val()) {
			if ($('#guardName').val()) {
				bindCard.showIncorrectTip('监护人姓名');
			} else {
				bindCard.showIncompleteTip('监护人姓名');
			}	
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardIdNo"]').val()) {
			if ($('#guardIdNo').val()) {
				bindCard.showIncorrectTip('证件号码');
			} else {
				bindCard.showIncompleteTip('证件号码');
			}	
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardMobile"]').val()) {
			if ($('#guardMobile').val()) {
				bindCard.showIncorrectTip('监护人手机号码');
			} else {
				bindCard.showIncompleteTip('监护人手机号码');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
    	// 儿童异步绑卡
		console.log('儿童异步绑卡流程...');
		var platform = 1;
		var appCode = $('input[name="appCode"]').val();
		if (appCode == 'wechat') {
			platform = 1;
		} else if (appCode == 'alipay') {
			platform = 2;
		} else if (appCode == 'easyHealth') {
			platform = 3;
		}
		var data = {
			appId: $('input[name="appId"]').val(),
			appCode: $('input[name="appCode"]').val(),
			hospitalCode: $('input[name="hospitalCode"]').val(),
			hospitalId: $('input[name="hospitalId"]').val(),
			hospitalName: $('input[name="hospitalName"]').val(),
			branchCode: $('input[name="branchHospitalCode"]').val(),
			branchId: $('input[name="branchHospitalId"]').val(),
			branchHospitalName: $('input[name="branchHospitalName"]').val(),
			platform: platform,
			openId: $('input[name="openId"]').val(),
			verifyConditionType: $('input[name="verifyConditionTypes"]').val(),
			name: $('input[name="rChildName"]').val(),
			idType: '1',
			idNo: $('input[name="rChildIdNo"]').val(),
			birth: $('#childBirth').text(),
			sex: $('#childSex').attr('data-value'),
			age: $('#childAge').val(),
			ownership: 3,
			cardType: $('#show_childCardType').attr('data-value'),
			cardNo: $('#childCardNo').val(),
			guardName: $('#rGuardName').val(),
			guardIdType: $('#show_guardIdType').attr('data-value'),
			guardIdNo: $('#rGuardIdNo').val(),
			guardMobile: $('#rGuardMobile').val(),
			bindWay: "0"
		};
		console.log(data);
		bindCard.ajaxBindCard(obj, data);
    },
    ajaxBindCard: function(obj, data) {
    	// $Y.loading.show('正在为您绑卡');
		return $.ajax({
			type: "POST",
			url: appPath + "mobileApp/medicalcard/bind/bindCard",
			data: data,
			cache: false, 
			dataType: "json", 
			timeout: 7900,
			error: function(data) {
				$Y.loading.hide();
				new $Y.confirm({
		            ok:{title:'确定'},
		            content:'网络超时，请稍后在个人中心查看绑卡结果。'
		        });
				$(obj).attr('disabled', false);
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				if (data.status == 'OK') {
					var code = data.message.isSuccess;
					if (code == 'success') {
						// 执行成功，设定默认卡	appId_openId_card , 保存Id
						$.cookie($('#appId').val() + '_' + $('#openId').val() + '_defaultCard', data.message.card, {expires: 365, path: '/'});
						
						var forward = $('#forwardForm').attr('action');
						if (forward) {
							$('#forwardForm').append('<input type="hidden" name="appId" value="' + $('input[name="appId"]').val() + '" />');
							$('#forwardForm').append('<input type="hidden" name="appCode" value="' + $('input[name="appCode"]').val() + '" />');
							$('#forwardForm').append('<input type="hidden" name="openId" value="' + $('input[name="openId"]').val() + '" />');
							$('#forwardForm').submit();
						} else {
							var bindCardType = $('#bindCardType').val();
							if ($('#appCode').val() == 'easyHealth') {
								$('#baseForm').attr('action', appPath + 'mobileApp/medicalcard/family/toView');
								$('#baseForm').submit();
							} else {
								if (bindCardType == '1') {
									$('#baseForm').attr('action', appPath + 'mobileApp/medicalcard/usercenter/toView');
									$('#baseForm').submit();
								} else if (bindCardType == '2') {
									$('#baseForm').attr('action', appPath + 'mobileApp/medicalcard/family/toView');
									$('#baseForm').submit();
								} else {
									if ($('#appCode').val() == 'easyHealth') {
										// 健康易个人中心进去绑卡是0
										$('#baseForm').attr('action', appPath + 'mobileApp/medicalcard/family/toView');
										$('#baseForm').submit();
									} else {
										new $Y.confirm({
								            ok:{title:'确定'},
								            content: '绑卡成功',
								            callback:function() {
								            	var platform = $('#appCode').val();
								            	if (platform == 'wechat') {
								            		// 下面的代码页面调试时，应当关闭
								            		WeixinJSBridge.invoke('closeWindow',{},function(res){});
								            	} else if (platform = 'alipay') {
								            		// 下面的代码页面调试时，应当关闭
								            		AlipayJSBridge.call('closeWebview');
								            	}
								            }
								        });
									}
								}
							}
						}
					} else if (code == 'fail') {
						new $Y.confirm({
				            ok:{title:'确定'},
				            content: '绑卡失败'
				        });
						$(obj).attr('disabled', false);
					} else {
						new $Y.confirm({
				            ok:{title:'确定'},
				            content: data.message.msgInfo ? data.message.msgInfo : '绑卡失败'
				        });
						$(obj).attr('disabled', false);
					}
				}
			}
		});
    },
    bindEvent: function() {
    	// 性别
    	$('.sex-btn').click(function() {
    		bindCard.switchSex(this);
    	});
    	
    	// 在线建档
    	$('.btn-jianDang').click(function() {
    		bindCard.createCard(this);
    	});
    	
    	// 选择框
    	$('.aSelect').change(function() {
    		bindCard.select_box(this);
    		$(this).parent('div').children('div').children('.text').attr('data-value', $(this).val());
    		
    		if ($(this).attr('id') == 'branches') {
    			$('#branchHospitalCode').val($(this).val());
    			$('#branchHospitalId').val($(this).find('option:selected').attr('data-id'));
    			$('#branchHospitalName').val($(this).find('option:selected').attr('data-name'));
    		}
    	});
    	
    	// 切换生日
    	$('.aType').change(function() {
    		bindCard.select_box(this);
    		bindCard.changeBirth(this);
    		$(this).parent('div').children('div').children('.text').attr('data-value', $(this).val());
    		
    		if ($(this).is('.idType')) {
	    		// 需要清空他对应的卡号
	    		var inputBox = $(this).parent().parent().next('li').children('.values').children('.input-placeholder').children('.yx-input');
	    		inputBox.val('');
	    		inputBox.siblings('.placeholder-text').show();
	    		$('#r' + bindCard.getFormatName(inputBox)).val('');
    		}
    	});
    	
    	// 切换页面（与本人关系）
    	$('.ownership').change(function() {
    		$(this).parent('div').children('div').children('.text').attr('data-value', $(this).val());
    		$('input[name="userType"]').val($(this).val());
    		userType = $(this).val();
    		bindCard.select_box(this);
    		bindCard.select_page(this);
    	});
    	
    	// 点击获取生日
    	$('.birth').click(function(event) {
    		var initDate = '';
    		var obj = $(this).find('.values');
    		if (obj && obj.text() && obj.text() != '请选择') {
    			initDate = obj.text();
    		}
    		
    		event.stopPropagation();
	        event.preventDefault();
    		var obj = $(this);
    		new yxCalendar({
    			position: 'slide_up',
                date: initDate,
                callback:function(date){
                    console.log(date);
                    obj.find('.color999').text(date);
                    var age = idCardUtils.getAge(date);
                    console.log('从生日中获取到的年龄：' + age);
                    var id = obj.children('div.values').attr('id');
                    id = id.substring(0, id.length - 5) + 'Age';
                    //alert('找到的年龄的id=' + id);
                    $('#' + id).val(age);
                }
            });
    	});
    	// 姓名脱敏
    	$('.patName').blur(function() {
    		bindCard.patNameBlur(this);
    		if (!$(this).val()) {
    			$(this).siblings('.placeholder-text').show();
    		}
    	});
    	
    	// 证件号码脱敏
    	$('.patIdNo').blur(function() {
    		bindCard.idNoBlur(this);
    		if (!$(this).val()) {
    			$(this).siblings('.placeholder-text').show();
    		}
    	});
    	
    	// 手机号码脱敏
    	$('.patMobile').blur(function() {
    		bindCard.mobileBlur(this);
    		if (!$(this).val()) {
    			$(this).siblings('.placeholder-text').show();
    		}
    	});
    	
    	// 诊疗卡
    	$('.patCardNo').blur(function() {
    		if (!$(this).val()) {
    			$(this).siblings('.placeholder-text').show();
    		}
    	});
    	
    	// 获取焦点时清空姓名
    	$('.patName').focus(function() {
    		$(this).siblings('.placeholder-text').hide();
    		$(this).val('');
    	});
    	
    	// 获取焦点时清空证件号码
    	$('.patIdNo').focus(function() {
    		$(this).siblings('.placeholder-text').hide();
    		$(this).val('');
    	});
    	
    	// 获取焦点时清空手机号码
    	$('.patMobile').focus(function() {
    		$(this).siblings('.placeholder-text').hide();
    		$(this).val('');
    	});
    	
    	// 获取焦点时清空诊疗卡号码
    	$('.patCardNo').focus(function() {
    		$(this).siblings('.placeholder-text').hide();
    	});
    	
    	// 获取焦点时清空诊疗卡号码
    	$('.patAddress').focus(function() {
    		$(this).siblings('.placeholder-text').hide();
    	});
    	
    },
    patNameBlur: function(obj) {
    	var name = $(obj).val();
		var formatName = bindCard.getFormatName(obj);
		var desName = '';
		var rName = '';
		
		if (name) {
			if (bindCard.validateName(name)) {
    			desName = desensitize.desName(name);
    			$(obj).val(desName);
    			rName = base64.encode(name);
    			$('#r' + formatName).val(rName);
			} else {
				bindCard.showIncorrectTip('姓名');
				$('#r' + formatName).val('');
			}
		} else {
			rName = $('#r' + formatName).val();
			if (rName) {
				name = base64.decode(rName);
				desName = desensitize.desName(name);
				$(obj).val(desName);
			}
		}
		
		// 自动带出卡号
		// bindCard.autoGetCardNo();
    }, 
    mobileBlur: function(obj) {
    	var mobile = $(obj).val();
		var formatName = bindCard.getFormatName(obj);
		var desMobile = '';
		var rMobile = '';
		
		if (mobile) {
			if (bindCard.validateMobile(mobile)) {
    			desMobile = desensitize.desMobile(mobile);
    			$(obj).val(desMobile);
    			rMobile = base64.encode(mobile);
    			$('#r' + formatName).val(rMobile);
			} else {
				bindCard.showIncorrectTip('手机号');
				$('#r' + formatName).val('');
			}
		} else {
			rMobile = $('#r' + formatName).val();
			if (rMobile) {
				mobile = base64.decode(rMobile);
				desMobile = desensitize.desMobile(mobile);
				$(obj).val(desMobile);
			}
		}
    }, 
    idNoBlur: function(obj) {
    	var idNo = $(obj).val();
		var formatName = bindCard.getFormatName(obj);
		var desIdNo = '';
		var rIdNo = '';
		
		if (idNo) {
			if ($(obj).attr('id') == 'childIdNo') {
				// 儿童的身份证（非必填） 不需要带出性别，身份证
				if (bindCard.validateIdNo(idNo, 1)) {
    				desIdNo = desensitize.desIdNo(idNo);
	    			$(obj).val(desIdNo);
	    			rIdNo = base64.encode(idNo);
	    			$('#r' + formatName).val(rIdNo);
    			} else {
    				bindCard.showIncorrectTip('证件号码');
    				$('#r' + formatName).val('');
    			}
			} else {
				// 本人、他人、监护证件类型（有证件类型选择框的）
    			var type = $(obj).parent().parent().parent('li').prev().children('.values').children('.select_value').children('span').attr('data-value');
    			console.log('idType=' + type);
    			if (bindCard.validateIdNo(idNo, Number(type))) {
    				desIdNo = desensitize.desIdNo(idNo);
	    			$(obj).val(desIdNo);
	    			rIdNo = base64.encode(idNo);
	    			$('#r' + formatName).val(rIdNo);
	    			
	    			// 本人和他人的时候，并且证件类型时1的时候
	    			if (Number(type) == 1 && $(obj).attr('id') != 'guardIdNo') {
	    				var sex = Number(idCardUtils.getGender(idNo));
	    				console.log('性别：' + sex);
	    				var birth = idCardUtils.getBirth(idNo);
	    				console.log('生日：' + birth);
	    				var age = idCardUtils.getAge(birth);
	    				console.log('年龄：' + age);
	    				
	    				if (userType == '1') {
	    					$($('#selfSex').find('span')[sex - 1]).trigger('click');
	    					$('#selfSex').attr('data-value', sex);
	    					$('#selfBirth').text(birth);
	    					$('#selfAge').val(age);
	    				} else if (userType == '2') {
	    					$($('#otherSex').find('span')[sex - 1]).trigger('click');
	    					$('#otherSex').attr('data-value', sex);
	    					$('#otherBirth').text(birth);
	    					$('#otherAge').val(age);
	    				} 
	    			}
    			} else {
    				bindCard.showIncorrectTip('证件号码');
    				$('#r' + formatName).val('');
    			}
			}
		} else {
			rIdNo = $('#r' + formatName).val();
			if (rIdNo) {
				idNo = base64.decode(rIdNo);
				desIdNo = desensitize.desIdNo(idNo);
				$(obj).val(desIdNo);
			}
		}
		
		// 自动带出诊疗卡
		bindCard.autoGetCardNo();
    },
    init: function() {
    	bindCard.bindEvent();
    	// 绑卡提示
    	bindCard.initTiedCardTip();
    	// 温馨提示
    	bindCard.initTipWarmContent();
    	// 设定分院 
    	bindCard.initBranch();
    	// 设定就诊人
    	bindCard.initUserType();
    	// 默认选中本人的分页 
    	bindCard.select_page($('#ownership'));
    	// 设定关联的卡类型（二代身份证...）
    	bindCard.initCertificatesType();
    	// 设定就诊卡类型  
    	bindCard.initCardType();
    	// 清空数据
    	bindCard.initInputData();
    	// 初始化从平台中获取的个人用户信息
    	bindCard.initSelfInfo();
    },
    // 设定下拉框的默认值
    setDefaultType: function(selectId, optValue) {
    	var obj;
    	if (!optValue) {
    		obj = $('#' + selectId + ' option:first');
    		obj.prop('selected', 'selected');
    	} else {
    		$('#' + selectId).val(optValue);
    		obj = $('#' + selectId + ' option[selected]');
    	}
		
		obj.parent('select').parent('div').children('div').children('.text').text(obj.text());
		obj.parent('select').parent('div').children('div').children('.text').attr('data-value', obj.val());
    },
    // 初始化分院
    initBranch: function() {
		bindCard.setDefaultType('branches', $('#branchHospitalCode').val());
		$('#branchHospitalCode').val($('select[name="branches"]').val());
		$('#branchHospitalId').val($('select[name="branches"]').find('option:selected').attr('data-id'));
		$('#branchHospitalName').val($('select[name="branches"]').find('option:selected').text());
    },
    // 初始化用户类型
    initUserType: function() {
		bindCard.setDefaultType('ownership');
		userType = $('select[name="ownership"]').val();
    	$('#userType').val(userType);
    },
    // 初始化证件类型
    initCertificatesType: function() {
		bindCard.setDefaultType('selfIdType');
		bindCard.setDefaultType('otherIdType');
		bindCard.setDefaultType('guardIdType');
    },
    // 初始化卡类型
    initCardType: function() {
    	var isShowCardNo = Number($('#isShowCardNo').val());
    	if (isShowCardNo == 1) {
			bindCard.setDefaultType('selfCardType');
			bindCard.setDefaultType('otherCardType');
			bindCard.setDefaultType('childCardType');
    	}
    },
    // 进入绑卡的提示
    initTiedCardTip: function() {
    	new $Y.confirm({
            ok:{title:'知道了'},
            content:'<div style="text-align:left">' + $('#tiedCardTip').val() + '</div>'
        });
    },
    // 输出温馨提示
    initTipWarmContent: function() {
    	$('.warnTips').text($('input[name="tipWarmContent"]').val());
    },
    // 转换函数，将对象Id的首字母变成大写
    getFormatName: function(obj, i) {
    	var id = $(obj).attr('id');
    	return id.substring(0, 1).toUpperCase() + id.substring(1, id.length);
    },
    // 验证姓名
    validateName: function(data) {
    	var reg = /^[a-zA-Z0-9\u4e00-\u9fa5]{1,30}$/;		// 30位大写，小写，数字，中文
    	return reg.exec(data);
    },
    // 验证身份证
    validateIdNo: function(data, type) {
    	// 1：二代身份证  2：港澳居民身份证  3：台湾居民身份证 4：护照
    	var result = false;
    	switch (type) {
    		case 1: 
    			result = idCardUtils.validateIdNo(data);
    			break;
    		case 2:
    			result = true;
    			break;
    		case 3:
    			result = true;
    			break;
    		case 4:
    			result = true;
    			break;
    	}
    	
    	return result;
    },
    // 验证手机号码
    validateMobile: function(data) {
    	var reg = /^1\d{10}$/;								// 1开头的号码
    	return reg.exec(data);
    },
    // 验证就诊卡号
    validateCardNo: function(data) {
    	var reg = /^[a-zA-Z0-9]{1,30}/;						// 30位大写、小写、数字。
    	return reg.exec(data);
    },
    // 信息不正确提示
    showIncorrectTip: function(data) {
    	$Y.loading.hide();
    	var tip = $('#inputIncorrectTip').val();
    	if (!tip || tip.indexOf('%replace%') < 0) {
    		tip = '您输入的%replace%不正确';
    	}
    	$Y.tips(tip.replace('%replace%', data));
    },
    // 信息不完整提示
    showIncompleteTip: function(data) {
    	$Y.loading.hide();
    	var tip = $('#inputIncorrectTip').val();
    	if (!tip || tip.indexOf('%replace%') < 0) {
    		tip = '%replace%不能为空';
    	} 
    	$Y.tips(tip.replace('%replace%', data));
    },
    autoGetCardNo: function() {
    	// 不显示卡号，则不进行自动带出就诊卡的操作
    	var isShowCardNo = $('#isShowCardNo').val();
    	if (!isShowCardNo || isShowCardNo == 0) {
    		return false;
    	}
    	
		var bindType = Number($('#userType').val());
		var name = '';
		var idNo = '';
		var idType = '';
		
		if (bindType == 1) {
			name = $('#rSelfName').val();
			idType = $('#show_selfIdType').attr('data-value');
			idNo = $('input[name="rSelfIdNo"]').val();
			if (!name || !idNo) {
				return false;
			}
		} else if (bindType == 2) {
			name = $('#rOtherName').val();
			idType = $('#show_otherIdType').attr('data-value');
			idNo = $('input[name="rOtherIdNo"]').val();
			if (!name || !idNo) {
				return false;
			}
		}
		
		if (idType != '1') {
			return false;
		}
		
		// 就诊卡类型，直接用身份证
		var data = {
			appId: $('input[name="appId"]').val(),
			appCode: $('input[name="appCode"]').val(),
			openId: $('input[name="openId"]').val(),
			hospitalCode: $('input[name="hospitalCode"]').val(),
			branchCode: $('input[name="branchHospitalCode"]').val(),
			branchId: $('input[name="branchHospitalId"]').val(),
			name: name,
			cardType: 5,
			idNo: idNo,
		};
		
		$Y.loading.show('正在查找您的卡号，请稍候。');
		$.ajax({
			type: "POST",
			url: appPath + "mobileApp/medicalcard/bind/autoGetCardNo",
			data: data,
			cache: false, 
			dataType: "json", 
			timeout: 5000,
			error: function(data) {
				$Y.loading.hide();
				/*new $Y.confirm({
		            ok:{title:'确定'},
		            content:'没有查到您的卡号，请手动输入。'
		        });*/
			},
			success: function(data) {
				$Y.loading.hide();
				console.log('异步接收自动带卡：' + data);
				if (data.status == 'OK') {
					var cardNo = data.message.cardNo;
					var cardType = data.message.cardType;
					if (cardNo && cardType) {
						if (bindType == 1) {
							// 本人
							$('#show_selfCardType').attr('data-value', cardType);
							$('#show_selfCardType').text(bindCard.getCardName(cardType));
							bindCard.setDefaultType('selfCardType', cardType);
							$('#selfCardNo').val(cardNo);
							$('#selfCardNo').siblings('.placeholder-text').hide();
						} else {
							// 他人
							$('#show_otherCardType').attr('data-value', cardType);
							$('#show_otherCardType').text(bindCard.getCardName(cardType));
							bindCard.setDefaultType('otherCardType', cardType);
							$('#otherCardNo').val(cardNo);
							$('#otherCardNo').siblings('.placeholder-text').hide();
						} 
						// 儿童的还没做
					} else {
						/*
						new $Y.confirm({
				            ok:{title:'确定' },
				            content:'没有查到您的卡号，请手动输入。'
				        });
				        */
					}
				} else {
					/*
					new $Y.confirm({
			            ok:{title:'确定'},
			            content:'没有查到您的卡号，请手动输入。'
			        });
			        */
				}
			}
		});
	}, 
	getCardName: function(cardType) {
		switch (Number(cardType)) {
			case 1: 
				result = '就诊卡';
				break;
			case 2:
				result = '医保卡';
				break;
			case 3:
				result = '社保卡';
				break;
			case 4:
				result = '住院号';
				break;
		}
	},
	initSelfInfo: function() {
		// 用户姓名
		if ($('#desName').val()) {
			// $('#selfName').siblings('.placeholder-text').hide();
			$('#selfName').parent().children('.placeholder-text').hide();
			$('#selfName').val($('#desName').val());
			$('#rSelfName').val($('#base64Name').val());
		} 
		
		// 手机号码
		if ($('#desMobile').val()) {
			// $('#selfMobile').siblings('.placeholder-text').hide();
			$('#selfMobile').parent().children('.placeholder-text').hide();
			$('#selfMobile').val($('#desMobile').val());
			$('#rSelfMobile').val($('#base64Mobile').val());
		}
		
		
		// 证件类型(只有身份证才做后面的东西)
		var certType = $('#idType').val();
		if (certType == '1') {
			// 身份证
			if ($('#desIdNo').val()) {
				// $('#selfIdNo').siblings('.placeholder-text').hide();
				$('#selfIdNo').parent().children('.placeholder-text').hide();
				$('#selfIdNo').val($('#desIdNo').val());
				$('#rSelfIdNo').val($('#base64IdNo').val());
			}
			
			
			// 年龄
			$('#selfAge').val($('#age').val());
			// 性别
			$('.sex-btn[data-value="' + $('#sex').val() + '"]').trigger('click');
			// 生日
			if ($('#birth').val()) {
				$('#selfBirth').text($('#birth').val());
			}
		}
		
		// 自动带信息后，再自动获取就诊卡
		bindCard.autoGetCardNo();
	},
	initInputData: function() {
		// 清空隐藏域
		$('.user_input').val('');
		// 清理姓名
		$('.patName').val('');
		// 清理证件号码
		$('.patIdNo').val('');
		// 清理手机号码
		$('.patMobile').val('');
		// 清理就诊卡号
		$('.patCardNo').val('');
	}
};

var base64 = new Base64();
var userType = 0;

$(function() {
	/*
	if ($('#isLegalUser').val() == 'false') {
		// 健康易跳转
		loginOut();
	}
	*/
	bindCard.init();
});