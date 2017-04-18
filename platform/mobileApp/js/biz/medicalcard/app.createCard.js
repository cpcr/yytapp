var createCard = {
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
    createSelf: function(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行建档');
        
    	/**
		 * 本人建档
		 * 1.姓名
		 * 2.证件号码(证件类型)
		 * 3.性别(不验证,生成)
		 * 4.出生日期(不验证，生成)
		 * 5.手机号码
		 * 6.就诊卡号(卡类型)
		 */
		if (!$('input[name="rSelfName"]').val()) {
			if ($('#selfName').val()) {
				createCard.showIncorrectTip('姓名');
			} else {
				createCard.showIncompleteTip('姓名');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rSelfIdNo"]').val()) {
			if ($('#selfIdNo').val()) {
				createCard.showIncorrectTip('证件号码');
			} else {
				createCard.showIncompleteTip('证件号码');
			}	
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#selfBirth').text() && $('#selfBirth').text() != '请选择') {
			createCard.showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rSelfMobile"]').val()) {
			if ($('#selfMobile').val()) {
				createCard.showIncorrectTip('手机号码');
			} else {
				createCard.showIncompleteTip('手机号码');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#selfAddress').val()) {
			createCard.showIncompleteTip('地址');
			$(obj).attr('disabled', false);
			return false;
		}
		
		var platform = 1;
		var appCode = $('input[name="appCode"]').val();
		if (appCode == 'wechat') {
			platform = 1;
		} else if (appCode == 'alipay') {
			platform = 2;
		} else if (appCode == 'easyHealth') {
			platform = 3;
		}
		
		// 本人异步建档
		console.log('本人异步建档流程...');
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
			name: $('input[name="rSelfName"]').val(),
			mobile: $('input[name="rSelfMobile"]').val(),
			idType: $('#show_selfIdType').attr('data-value'),
			idNo: $('input[name="rSelfIdNo"]').val(),
			birth: $('#selfBirth').text(),
			sex: $('#selfSex').attr('data-value'),
			age: $('#selfAge').val(),
			address: $('#selfAddress').val(),
			ownership: 1,
			bindWay: "1"
		};
		console.log(data);
		createCard.ajaxCreateCard(obj, data);
    }, 
    createOther: function(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行建档');
        
    	/**
		 * 他人建档
		 * 1.姓名
		 * 2.证件号码(证件类型)
		 * 3.性别
		 * 4.出生日期
		 * 5.手机号码
		 * 6.就诊卡号(卡类型)
		 */
		
		if (!$('input[name="rOtherName"]').val()) {
			if ($('#otherName').val()) {
				createCard.showIncorrectTip('姓名');
			} else {
				createCard.showIncompleteTip('姓名');
			}
			
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rOtherIdNo"]').val()) {
			if ($('#otherIdNo').val()) {
				createCard.showIncorrectTip('证件号码');
			} else {
				createCard.showIncompleteTip('证件号码');
			}	
			
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#otherBirth').text() && $('#otherBirth').text() != '请选择') {
			createCard.showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rOtherMobile"]').val()) {
			if ($('#otherMobile').val()) {
				createCard.showIncorrectTip('手机号码');
			} else {
				createCard.showIncompleteTip('手机号码');
			}
			
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#otherAddress').val()) {
			createCard.showIncompleteTip('地址');
			$(obj).attr('disabled', false);
			return false;
		}
		
		var platform = 1;
		var appCode = $('input[name="appCode"]').val();
		if (appCode == 'wechat') {
			platform = 1;
		} else if (appCode == 'alipay') {
			platform = 2;
		} else if (appCode == 'easyHealth') {
			platform = 3;
		}
		
    	// 他人异步建档
		console.log('他人异步建档流程...');
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
			name: $('input[name="rOtherName"]').val(),
			mobile: $('input[name="rOtherMobile"]').val(),
			idType: $('#show_otherIdType').attr('data-value'),
			idNo: $('input[name="rOtherIdNo"]').val(),
			birth: $('#otherBirth').text(),
			sex: $('#otherSex').attr('data-value'),
			age: $('#otherAge').val(),
			address: $('#otherAddress').val(),
			ownership: 2,
			bindWay: "1"
		};
		console.log(data);
		createCard.ajaxCreateCard(obj, data);
    }, 
    createChild: function(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行建档');
        
    	/**
		 * 儿童建档，必要：
		 * 1.姓名
		 * 2.性别(不需要)
		 * 3.出生日期
		 * 4.就诊卡号(卡类型)
		 * 5.监护人姓名
		 * 6.监护人证件(证件类型)
		 * 7.监护人手机号码
		 */
    	if (!$('input[name="rChildName"]').val()) {
    		createCard.showIncompleteTip('姓名');
    		$(obj).attr('disabled', false);
			return false;
		}
    	
		if (!$('#childBirth').text() && $('#childBirth').text() != '请选择') {
			createCard.showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardName"]').val()) {
			createCard.showIncompleteTip('监护人姓名');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardIdNo"]').val()) {
			createCard.showIncompleteTip('监护人证件号码');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardMobile"]').val()) {
			createCard.showIncompleteTip('监护人手机号');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#childAddress').val()) {
			createCard.showIncompleteTip('地址');
			$(obj).attr('disabled', false);
			return false;
		}
		
		var platform = 1;
		var appCode = $('input[name="appCode"]').val();
		if (appCode == 'wechat') {
			platform = 1;
		} else if (appCode == 'alipay') {
			platform = 2;
		} else if (appCode == 'easyHealth') {
			platform = 3;
		}
    	// 儿童异步建档
		console.log('儿童异步建档流程...');
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
			name: $('input[name="rChildName"]').val(),
			idType: '1',
			idNo: $('input[name="rChildIdNo"]').val(),
			birth: $('#childBirth').text(),
			sex: $('#childSex').attr('data-value'),
			age: $('#childAge').val(),
			ownership: 3,
			guardName: $('#rGuardName').val(),
			guardIdType: $('#show_guardIdType').attr('data-value'),
			guardIdNo: $('#rGuardIdNo').val(),
			guardMobile: $('#rGuardMobile').val(),
			address: $('#childAddress').val(),
			bindWay: "1"
		};
		console.log(data);
		createCard.ajaxCreateCard(obj, data);
    },
    ajaxCreateCard: function(obj, data) {
    	// $Y.loading.show('正在为您建档');
		$.ajax({
			type: "POST",
			url: appPath + "mobileApp/medicalcard/create/createCard",
			data: data,
			cache: false, 
			dataType: "json", 
			timeout: 7900,
			error: function(data) {
				$Y.loading.hide();
				new $Y.confirm({
		            ok:{title:'确定'},
		            content:'网络超时，请稍后在个人中心查看建档结果。'
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
							            content: '建档成功',
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
					} else if (code == 'fail') {
						new $Y.confirm({
				            ok:{title:'确定'},
				            content: '建档失败'
				        });
						$(obj).attr('disabled', false);
					} else {
						new $Y.confirm({
				            ok:{title:'确定'},
				            content: data.message.msgInfo ? data.message.msgInfo : '建档失败'
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
    		createCard.switchSex(this);
    	});
    	
    	// 在线建档
    	$('.btn-jianDang').click(function() {
    		createCard.createCard(this);
    	});
    	
    	// 选择框
    	$('.aSelect').change(function() {
    		createCard.select_box(this);
    		$(this).parent('div').children('div').children('.text').attr('data-value', $(this).val());
    		
    		if ($(this).attr('id') == 'branches') {
    			$('#branchHospitalCode').val($(this).val());
    			$('#branchHospitalId').val($(this).find('option:selected').attr('data-id'));
    			$('#branchHospitalName').val($(this).find('option:selected').attr('data-name'));
    		}
    	});
    	
    	// 切换生日
    	$('.aType').change(function() {
    		createCard.select_box(this);
    		createCard.changeBirth(this);
    		$(this).parent('div').children('div').children('.text').attr('data-value', $(this).val());
    		
    		if ($(this).is('.idType')) {
	    		// 需要清空他对应的卡号
	    		var inputBox = $(this).parent().parent().next('li').children('.values').children('.input-placeholder').children('.yx-input');
	    		inputBox.val('');
	    		inputBox.siblings('.placeholder-text').show();
	    		$('#r' + createCard.getFormatName(inputBox)).val('');
    		}
    	});
    	
    	// 切换页面（与本人关系）
    	$('.ownership').change(function() {
    		$(this).parent('div').children('div').children('.text').attr('data-value', $(this).val());
    		$('input[name="userType"]').val($(this).val());
    		userType = $(this).val();
    		createCard.select_box(this);
    		createCard.select_page(this);
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
    		createCard.patNameBlur(this);
    		if (!$(this).val()) {
    			$(this).siblings('.placeholder-text').show();
    		}
    	});
    	
    	// 证件号码脱敏
    	$('.patIdNo').blur(function() {
    		createCard.idNoBlur(this);
    		if (!$(this).val()) {
    			$(this).siblings('.placeholder-text').show();
    		}
    	});
    	
    	// 手机号码脱敏
    	$('.patMobile').blur(function() {
    		createCard.mobileBlur(this);
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
    	
    	// 获取焦点时清空地址
    	$('.patAddress').focus(function() {
    		$(this).siblings('.placeholder-text').hide();
    	});
    	
    },
    patNameBlur: function(obj) {
    	var name = $(obj).val();
		var formatName = createCard.getFormatName(obj);
		var desName = '';
		var rName = '';
		
		if (name) {
			if (createCard.validateName(name)) {
    			desName = desensitize.desName(name);
    			$(obj).val(desName);
    			rName = base64.encode(name);
    			$('#r' + formatName).val(rName);
			} else {
				createCard.showIncorrectTip('姓名');
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
		
    }, 
    mobileBlur: function(obj) {
    	var mobile = $(obj).val();
		var formatName = createCard.getFormatName(obj);
		var desMobile = '';
		var rMobile = '';
		
		if (mobile) {
			if (createCard.validateMobile(mobile)) {
    			desMobile = desensitize.desMobile(mobile);
    			$(obj).val(desMobile);
    			rMobile = base64.encode(mobile);
    			$('#r' + formatName).val(rMobile);
			} else {
				createCard.showIncorrectTip('手机号');
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
		var formatName = createCard.getFormatName(obj);
		var desIdNo = '';
		var rIdNo = '';
		
		if (idNo) {
			if ($(obj).attr('id') == 'childIdNo') {
				// 儿童的身份证（非必填） 不需要带出性别，身份证
				if (createCard.validateIdNo(idNo, 1)) {
    				desIdNo = desensitize.desIdNo(idNo);
	    			$(obj).val(desIdNo);
	    			rIdNo = base64.encode(idNo);
	    			$('#r' + formatName).val(rIdNo);
    			} else {
    				createCard.showIncorrectTip('证件号码');
    				$('#r' + formatName).val('');
    			}
			} else {
				// 本人、他人、监护证件类型（有证件类型选择框的）
    			var type = $(obj).parent().parent().parent('li').prev().children('.values').children('.select_value').children('span').attr('data-value');
    			console.log('idType=' + type);
    			if (createCard.validateIdNo(idNo, Number(type))) {
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
    				createCard.showIncorrectTip('证件号码');
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
    },
    init: function() {
    	createCard.bindEvent();
    	// 建档提示
    	createCard.initOnlineFilingTip();
    	// 温馨提示
    	createCard.initTipWarmContent();
    	// 设定分院 
    	createCard.initBranch();
    	// 设定就诊人
    	createCard.initUserType();
    	// 默认选中本人的分页 
    	createCard.select_page($('#ownership'));
    	// 设定关联的卡类型（二代身份证...）
    	createCard.initCertificatesType();
    	// 设定就诊卡类型  
    	createCard.initCardType();
    	// 清空数据
    	createCard.initInputData();
    	// 初始化从平台中获取的个人用户信息
    	createCard.initSelfInfo();
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
    	createCard.setDefaultType('branches', $('#branchHospitalCode').val());
		$('#branchHospitalCode').val($('select[name="branches"]').val());
		$('#branchHospitalId').val($('select[name="branches"]').find('option:selected').attr('data-id'));
		$('#branchHospitalName').val($('select[name="branches"]').find('option:selected').text());
    },
    // 初始化用户类型
    initUserType: function() {
    	createCard.setDefaultType('ownership');
		userType = $('select[name="ownership"]').val();
    	$('#userType').val(userType);
    },
    // 初始化证件类型
    initCertificatesType: function() {
    	createCard.setDefaultType('selfIdType');
    	createCard.setDefaultType('otherIdType');
    	createCard.setDefaultType('guardIdType');
    },
    // 初始化卡类型
    initCardType: function() {
    	var isShowCardNo = Number($('#isShowCardNo').val());
    	if (isShowCardNo == 1) {
    		createCard.setDefaultType('selfCardType');
    		createCard.setDefaultType('otherCardType');
    		createCard.setDefaultType('childCardType');
    	}
    },
    // 进入建档的提示
    initOnlineFilingTip: function() {
    	new $Y.confirm({
            ok:{title:'知道了'},
            content:'<div style="text-align:left">' + $('#onlineFilingTip').val() + '</div>'
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
    	if (!tip || tip.indexOf('[替换内容]') < 0) {
    		tip = '您输入的[替换内容]不正确';
    	}
    	$Y.tips(tip.replace('[替换内容]', data));
    },
    // 信息不完整提示
    showIncompleteTip: function(data) {
    	$Y.loading.hide();
    	var tip = $('#inputIncorrectTip').val();
    	if (!tip || tip.indexOf('[替换内容]') < 0) {
    		tip = '您输入的[替换内容]不完整';
    	} 
    	$Y.tips(tip.replace('[替换内容]', data));
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
		// 清理地址
		$('.patAddress').val('');
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
	createCard.init();
});