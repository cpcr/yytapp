<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<title>添加就诊人</title>
</head>
<body>
<div id="body">
	<div class="familyInfo">
        <div class="box-tips icontips">
            <i class="iconfont"></i>温馨提示：身份证号码作为您在深圳公立医院的统一就诊识别码，全市通用。手机号码用于接收医院就诊通知，请准确填写。
        </div>
        <div class="space15"></div>
        <ul class="yx-list">
            <li class="flex line">
                <div class="">关系</div>
                <div class="flexItem color666 textRight">
                    <label><span class="text">父母</span>
                        <select name="ownership" class="select-screen-box" onchange="selectScreening(this);select_page(this);">
                            <option value="4">父母</option>
                            <option value="6">伴侣</option>
                            <option value="3">儿童</option>
                            <option value="5">兄弟姐妹</option>
                            <option value="2">其他</option>
                        </select>
                        <i class="iconfont">&#xe600;</i>
                    </label>
                </div>
            </li>
        </ul>
        <!--父母 str-->
        <div class="familyBox" style="display: block;">
            <ul class="yx-list">
                <li class="flex">
                    <div class="">姓名</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input patName" placeholder="请输入" id="parentName"></div>
                </li>
                <li class="flex">
                    <div class="">证件类型</div>
                    <div class="flexItem color666 textRight">
                        <label><span class="text">二代身份证</span>
                            <select name="" class="select-screen-box patIdType" onchange="selectScreening(this);changeBirth(this);" id="parentIdType">
                                <option value="1">二代身份证</option>
                                <option value="2">港澳通行证</option>
                            </select>
                            <i class="iconfont">&#xe600;</i>
                        </label>
                    </div>
                </li>
                <li class="flex">
                    <div class="">证件号</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input patIdNo" placeholder="请输入" id="parentIdNo"></div>
                </li>
                <li class="flex birth" style="display: none;">
                    <div class="">出生日期</div>
                    <div class="flexItem color666 textRight"><input  type="text" class="yx-input js-date" placeholder="选择日期" id="parentBirth"></div>
                </li>
                <li class="flex sex_w" style="display: none;">
                    <div class="">性别</div>
                    <div class="flexItem color666 textRight">
                        <label><span class="text">男</span>
                            <select name="" class="select-screen-box" onchange="selectScreening(this)" id="parentSex">
                                <option value="1">男</option>
                                <option value="2">女</option>
                            </select>
                            <i class="iconfont">&#xe600;</i>
                        </label>
                    </div>
                </li>
                <li class="flex">
                    <div class="">手机号</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input patMobile" placeholder="请输入" id="parentMobile" maxLength="11"></div>
                </li>
                <li class="flex">
                    <div class="">验证码</div>
                    <div class="flexItem color666 textRight"><input id="parentCode" type="tel" class="yx-input inputCode" placeholder="请输入" value=""/></div>
                    <div class="codeBtn" id="parentCodeBtn" onclick="sendVerifyCode(this);">点击获取验证码</div>
                </li>
                <li class="flex">
                    <div class="">地址</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input" placeholder="请输入" id="parentAddress"></div>
                </li>
            </ul>
            <div class="btn-w">
	            <div class="btn btn-ok btn-block" id="addParent" onclick="bindParent(this);">添加</div>
	        </div>
        </div>
        <!--父母 end-->
        <!--伴侣 str-->
        <div class="familyBox" style="display: none;">
            <ul class="yx-list">
	            <li class="flex">
	                <div class="">姓名</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patName" placeholder="请输入" id="partnerName"></div>
	            </li>
	            <li class="flex">
	                <div class="">证件类型</div>
	                <div class="flexItem color666 textRight">
	                    <label><span class="text">二代身份证</span>
	                        <select name="" class="select-screen-box patIdType" onchange="selectScreening(this);changeBirth(this);" id="partnerIdType">
	                            <option value="1">二代身份证</option>
	                            <option value="2">港澳通行证</option>
	                        </select>
	                        <i class="iconfont">&#xe600;</i>
	                    </label>
	                </div>
	            </li>
	            <li class="flex">
	                <div class="">证件号</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patIdNo" placeholder="请输入" id="partnerIdNo"></div>
	            </li>
	            <li class="flex birth" style="display: none;">
	                <div class="">出生日期</div>
	                <div class="flexItem color666 textRight"><input  type="text" class="yx-input js-date" placeholder="选择日期" id="partnerBirth"></div>
	            </li>
	            <li class="flex sex_w" style="display: none;">
	                <div class="">性别</div>
	                <div class="flexItem color666 textRight">
	                    <label>
	                    	<span class="text">男</span>
	                        <select name="" class="select-screen-box" onchange="selectScreening(this)" id="partnerSex">
	                            <option value="1">男</option>
	                            <option value="2">女</option>
	                        </select>
	                        <i class="iconfont">&#xe600;</i>
	                    </label>
	                </div>
	            </li>
	            <li class="flex">
	                <div class="">手机号</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patMobile" placeholder="请输入" id="partnerMobile" maxLength="11"></div>
	            </li>
                <li class="flex">
                    <div class="">验证码</div>
                    <div class="flexItem color666 textRight"><input type="tel" id="partnerCode" class="yx-input inputCode" placeholder="请输入" value=""/></div>
                    <div class="codeBtn" id="partnerCodeBtn" onclick="sendVerifyCode(this);">点击获取验证码</div>
                </li>
	            <li class="flex">
	                <div class="">地址</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input" placeholder="请输入" id="partnerAddress"></div>
	            </li>
	        </ul>
        	<div class="btn-w">
	            <div class="btn btn-ok btn-block" id="addPartner" onclick="bindPartner(this);">添加</div>
	        </div>
        </div>
        <!--伴侣 end-->
        <!--子女 str-->
        <div class="familyBox" style="display: none;">
            <ul class="yx-list">
                <li class="flex">
                    <div class="">姓名</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input patName" placeholder="请输入" id="childName"></div>
                </li>
                <li class="flex">
                    <div class="">出生日期</div>
                    <div class="flexItem color666 textRight"><input  type="text" class="yx-input js-date" placeholder="选择日期" id="childBirth"></div>
                </li>
                <li class="flex">
                    <div class="">性别</div>
                    <div class="flexItem color666 textRight">
                        <label><span class="text">男</span>
                            <select name="" class="select-screen-box" onchange="selectScreening(this)" id="childSex">
                                <option value="1">男</option>
                                <option value="2">女</option>
                            </select>
                            <i class="iconfont">&#xe600;</i>
                        </label>
                    </div>
                </li>
                <li class="flex">
                    <div class="">地址</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input" placeholder="请输入" id="childAddress"></div>
                </li>
            </ul>
            <div class="space15"></div>
            <ul class="yx-list">
                <li class="flex">
                    <div class="">监护人姓名</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input patName" placeholder="请输入" id="guardName"></div>
                </li>
                <li class="flex">
                    <div class="">证件类型</div>
                    <div class="flexItem color666 textRight">
                        <label><span class="text">二代身份证</span>
                            <select name="" class="select-screen-box patIdType" onchange="selectScreening(this);" id="guardIdType">
                                <option value="1">二代身份证</option>
                                <option value="2">港澳通行证</option>
                            </select>
                            <i class="iconfont">&#xe600;</i>
                        </label>
                    </div>
                </li>
                <li class="flex">
                    <div class="">监护人证件号</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input patIdNo" placeholder="请输入" id="guardIdNo"></div>
                </li>
                <li class="flex">
                    <div class="">监护人手机</div>
                    <div class="flexItem color666 textRight"><input type="text" class="yx-input patMobile" placeholder="请输入" id="guardMobile"  maxLength="11"></div>
                </li>
                <li class="flex">
                    <div class="">验证码</div>
                    <div class="flexItem color666 textRight"><input type="tel" id="childCode" class="yx-input inputCode" placeholder="请输入" value=""/></div>
                    <div class="codeBtn" id="childCodeBtn" onclick="sendVerifyCode(this);">点击获取验证码</div>
                </li>
            </ul>
            
            <div class="btn-w">
	            <div class="btn btn-ok btn-block" id="addChild" onclick="bindChild(this);">添加</div>
	        </div>
        </div>
        <!--子女 end-->
        <!--兄弟姐妹 str-->
        <div class="familyBox" style="display: none;">
            <ul class="yx-list">
	            <li class="flex">
	                <div class="">姓名</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patName" placeholder="请输入" id="siblingName"></div>
	            </li>
	            <li class="flex">
	                <div class="">证件类型</div>
	                <div class="flexItem color666 textRight">
	                    <label><span class="text">二代身份证</span>
	                        <select name="" class="select-screen-box patIdType" onchange="selectScreening(this);changeBirth(this);" id="siblingIdType">
	                            <option value="1">二代身份证</option>
	                            <option value="2">港澳通行证</option>
	                        </select>
	                        <i class="iconfont">&#xe600;</i>
	                    </label>
	                </div>
	            </li>
	            <li class="flex">
	                <div class="">证件号</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patIdNo" placeholder="请输入" id="siblingIdNo"></div>
	            </li>
	            <li class="flex birth" style="display: none;">
	                <div class="">出生日期</div>
	                <div class="flexItem color666 textRight"><input  type="text" class="yx-input js-date" placeholder="选择日期" id="siblingBirth"></div>
	            </li>
	            <li class="flex sex_w" style="display: none;">
	                <div class="">性别</div>
	                <div class="flexItem color666 textRight">
	                    <label><span class="text">男</span>
	                        <select name="" class="select-screen-box" onchange="selectScreening(this)" id="siblingSex">
	                            <option value="1">男</option>
	                            <option value="2">女</option>
	                        </select>
	                        <i class="iconfont">&#xe600;</i>
	                    </label>
	                </div>
	            </li>
	            <li class="flex">
	                <div class="">手机号</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patMobile" placeholder="请输入" id="siblingMobile"  maxLength="11"></div>
	            </li>
                <li class="flex">
                    <div class="">验证码</div>
                    <div class="flexItem color666 textRight"><input type="tel" id="siblingCode" class="yx-input inputCode" placeholder="请输入" value=""/></div>
                    <div class="codeBtn" id="siblingCodeBtn" onclick="sendVerifyCode(this);">点击获取验证码</div>
                </li>
	            <li class="flex">
	                <div class="">地址</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input" placeholder="请输入" id="siblingAddress"></div>
	            </li>
	        </ul>
        	<div class="btn-w">
	            <div class="btn btn-ok btn-block" id="addSibling" onclick="bindSibling(this);">添加</div>
	        </div>
        </div>
        <!--兄弟姐妹 end-->
        <!--他人 str-->
        <div class="familyBox" style="display: none;">
            <ul class="yx-list">
	            <li class="flex">
	                <div class="">姓名</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patName" placeholder="请输入" id="otherName"></div>
	            </li>
	            <li class="flex">
	                <div class="">证件类型</div>
	                <div class="flexItem color666 textRight">
	                    <label><span class="text">二代身份证</span>
	                        <select name="" class="select-screen-box patIdType" onchange="selectScreening(this);changeBirth(this);" id="otherIdType">
	                            <option value="1">二代身份证</option>
	                            <option value="2">港澳通行证</option>
	                        </select>
	                        <i class="iconfont">&#xe600;</i>
	                    </label>
	                </div>
	            </li>
	            <li class="flex">
	                <div class="">证件号</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patIdNo" placeholder="请输入" id="otherIdNo"></div>
	            </li>
	            <li class="flex birth" style="display: none;">
	                <div class="">出生日期</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input js-date" placeholder="选择日期" id="otherBirth"></div>
	            </li>
	            <li class="flex sex_w" style="display: none;">
	                <div class="">性别</div>
	                <div class="flexItem color666 textRight">
	                    <label><span class="text">男</span>
	                        <select name="" class="select-screen-box" onchange="selectScreening(this)" id="otherSex">
	                            <option value="1">男</option>
	                            <option value="2">女</option>
	                        </select>
	                        <i class="iconfont">&#xe600;</i>
	                    </label>
	                </div>
	            </li>
	            <li class="flex">
	                <div class="">手机号</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input patMobile" placeholder="请输入" id="otherMobile"  maxLength="11"></div>
	            </li>
                <li class="flex">
                    <div class="">验证码</div>
                    <div class="flexItem color666 textRight"><input type="tel" id="otherCode" class="yx-input inputCode" placeholder="请输入" value=""/></div>
                    <div class="codeBtn" id="otherCodeBtn" onclick="sendVerifyCode(this);">点击获取验证码</div>
                </li>
	            <li class="flex">
	                <div class="">地址</div>
	                <div class="flexItem color666 textRight"><input type="text" class="yx-input" placeholder="请输入" id="otherAddress"></div>
	            </li>
	        </ul>
        
	        <div class="btn-w">
	            <div class="btn btn-ok btn-block" id="addOther" onclick="bindOther(this);">添加</div>
	        </div>
        </div>
        <!--他人 end-->
    </div>
    
</div>

<!-- 伴侣的信息 -->
<input type="hidden" name="rPartnerName" id="rPartnerName" value="" class="user_input"/>
<input type="hidden" name="rPartnerIdNo" id="rPartnerIdNo" value="" class="user_input"/>
<input type="hidden" name="rPartnerMobile" id="rPartnerMobile" value="" class="user_input"/>
<!-- end 伴侣的信息 -->

<!-- 他人的信息 -->
<input type="hidden" name="rOtherName" id="rOtherName" value="" class="user_input"/>
<input type="hidden" name="rOtherIdNo" id="rOtherIdNo" value="" class="user_input"/>
<input type="hidden" name="rOtherMobile" id="rOtherMobile" value="" class="user_input"/>
<!-- end 他人的信息 -->

<!-- 父母的信息 -->
<input type="hidden" name="rParentName" id="rParentName" value="" class="user_input"/>
<input type="hidden" name="rParentIdNo" id="rParentIdNo" value="" class="user_input"/>
<input type="hidden" name="rParentMobile" id="rParentMobile" value="" class="user_input"/>
<!-- end 父母的信息 -->

<!-- 兄弟姐妹的信息 -->
<input type="hidden" name="rSiblingName" id="rSiblingName" value="" class="user_input"/>
<input type="hidden" name="rSiblingIdNo" id="rSiblingIdNo" value="" class="user_input"/>
<input type="hidden" name="rSiblingMobile" id="rSiblingMobile" value="" class="user_input"/>
<!-- end 兄弟姐妹的信息 -->

<!-- 儿童的信息 -->
<input type="hidden" name="rChildName" id="rChildName" value="" class="user_input"/>
<input type="hidden" name="rChildIdNo" id="rChildIdNo" value="" class="user_input"/>
<input type="hidden" name="rGuardName" id="rGuardName" value="" class="user_input"/>
<input type="hidden" name="rGuardIdNo" id="rGuardIdNo" value="" class="user_input"/>
<input type="hidden" name="rGuardMobile" id="rGuardMobile" value="" class="user_input"/>

<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}">
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
	<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
	<input type="hidden" id="forward" name="forward" value="${commonParams.forward}">
	<input type="hidden" id="syncType" name="syncType" value="${commonParams.syncType}">
</form>

<#include "/easyhealth/common/footer.ftl">
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/idCardUtils.js"></script>
<#--
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/desensitize.js"></script>
-->
</body>
</html>

<script type="text/javascript" src="${basePath}easyhealth/js/common/yxCalendar.js?v=7"></script>
<script>
	var codeType = "addFamily";

	new yxCalendar({
		dom:'.js-date',
		// bug:43 支付宝服务窗添加就诊人为儿童，选择出生日期当天之后的，不合理。
		maxDate:yxCalendar.getTime()
	})

	 function selectScreening(obj){
        var option = obj.children[obj.selectedIndex];
        var html = option.innerHTML;
        obj.previousElementSibling.innerHTML = html
        $('.yx-input.patIdNo').val('');
        $('.yx-input.js-date').val('');
        
    }
    //切换 本人 他人 儿童
    function select_page(obj){
        var index = $(obj)[0].selectedIndex||0;
        $('.familyBox').hide().eq(index).show();
    }
    select_page($('.select-screen-box').eq(0))

    //改变证件类型，出生日选项
    function changeBirth(obj){
        var index = $(obj)[0].selectedIndex;
        if(index == 0){
        	console.log(index);
            $(obj).closest('ul').eq(0).find('li.birth').hide();
            $(obj).closest('ul').eq(0).find('li.sex_w').hide();
        }else{
            $(obj).closest('ul').eq(0).find('li.birth').show();
            $(obj).closest('ul').eq(0).find('li.sex_w').show();
        }
    }
	
	$(function() {
		 init();
	})
	
	function init() {
		// 姓名脱敏
    	$('.patName').blur(function() {
    		patNameBlur(this);
    	});
    	
    	// 证件号码脱敏
    	$('.patIdNo').blur(function() {
    		idNoBlur(this);
    	});
    	
    	// 手机号码脱敏
    	$('.patMobile').blur(function() {
    		mobileBlur(this);
    	});
    	
    	// 获取焦点时清空姓名
    	$('.patName').focus(function() {
    		$(this).val('');
    	});
    	
    	// 获取焦点时清空证件号码
    	$('.patIdNo').focus(function() {
    		$(this).val('');
    	});
    	
    	// 获取焦点时清空手机号码
    	$('.patMobile').focus(function() {
    		$(this).val('');
    	});
	}
	
	function patNameBlur(obj) {
    	var name = $(obj).val();
		var formatName = getFormatName(obj);
		//var desName = '';
		
		if (name) {
			if (validateName(name)) {
    			//desName = desensitize.desName(name);
    			//$(obj).val(desName);
    			$('#r' + formatName).val(name);
			} else {
				showIncorrectTip('姓名');
				$('#r' + formatName).val('');
			}
		} else {
			/*
			name = $('#r' + formatName).val();
			if (name) {
				desName = desensitize.desName(name);
				$(obj).val(desName);
			}
			*/
		}
    }
    
    function mobileBlur(obj) {
    	var mobile = $(obj).val();
		var formatName = getFormatName(obj);
		//var desMobile = '';
		
		if (mobile) {
			if (validateMobile(mobile)) {
    			//desMobile = desensitize.desMobile(mobile);
    			//$(obj).val(desMobile);
    			$('#r' + formatName).val(mobile);
			} else {
				showIncorrectTip('手机号');
				$('#r' + formatName).val('');
			}
		} else {
			/*
			mobile = $('#r' + formatName).val();
			if (mobile) {
				desMobile = desensitize.desMobile(mobile);
				$(obj).val(desMobile);
			}
			*/
		}
    }
    
    function idNoBlur(obj) {
    	var idNo = $(obj).val();
		var formatName = getFormatName(obj);
		//var desIdNo = '';
		
		if (idNo) {
			if ($(obj).attr('id') == 'childIdNo') {
				// 儿童的身份证（非必填） 不需要带出性别，身份证 
				if (validateIdNo(idNo, 1)) {
    				//desIdNo = desensitize.desIdNo(idNo);
	    			//$(obj).val(desIdNo);
	    			$('#r' + formatName).val(idNo);
    			} else {
    				showIncorrectTip('证件号码');
    				$('#r' + formatName).val('');
    			}
			} else {
				// 本人、他人、监护证件类型（有证件类型选择框的）
    			var type = $(obj).parent().parent().parent().find('.patIdType').val();
    			console.log('idType=' + type);
    			if (validateIdNo(idNo, Number(type))) {
    				//desIdNo = desensitize.desIdNo(idNo);
	    			//$(obj).val(desIdNo);
	    			$('#r' + formatName).val(idNo);
	    			
	    			// 本人和他人的时候，并且证件类型时1的时候
	    			if (Number(type) == 1 && $(obj).attr('id') != 'guardIdNo') {
	    				var sex = Number(idCardUtils.getGender(idNo));
	    				console.log('性别：' + sex);
	    				var birth = idCardUtils.getBirth(idNo);
	    				console.log('生日：' + birth);
	    				var age = idCardUtils.getAge(birth);
	    				console.log('年龄：' + age);
	    				
	    				var userType = $('select[name="ownership"]').val();
	    				if (userType == '4') {
	    					// 父母 parent
	    					$('#parentBirth').val(birth);
	    					var opt = $('#parentSex option[value="' + sex +'"]');
	    					opt.attr('selected', 'true');
	    					$('#parentSex').parent().find('.text').text(opt.text());
	    				} else if (userType == '6') {
	    					// 伴侣 partner
	    					$('#partnerBirth').val(birth);
	    					var opt = $('#partnerSex option[value="' + sex + '"]');
	    					opt.attr('selected', 'true');
	    					$('#partnerSex').parent().find('.text').text(opt.text());
	    				}  else if (userType == '5') {
	    					// 兄弟姐妹 sibling
	    					$('#siblingBirth').val(birth);
	    					var opt = $('#siblingSex option[value="' + sex + '"]');
	    					opt.attr('selected', 'true');
	    					$('#siblingSex').parent().find('.text').text(opt.text());
	    				} else if (userType == '2') {
	    					// 其他 other
	    					$('#otherBirth').val(birth);
	    					var opt = $('#otherSex option[value="' + sex + '"]');
	    					opt.attr('selected', 'true');
	    					$('#otherSex').parent().find('.text').text(opt.text());
	    				}
	    			}
    			} else {
    				showIncorrectTip('证件号码');
    				$('#r' + formatName).val('');
    			}
			}
		} else {
			/*
			idNo = $('#r' + formatName).val();
			if (idNo) {
				desIdNo = desensitize.desIdNo(idNo);
				$(obj).val(desIdNo);
			}
			*/
		}
    }
    
    // 转换函数，将对象Id的首字母变成大写
    function getFormatName(obj, i) {
    	var id = $(obj).attr('id');
    	return id.substring(0, 1).toUpperCase() + id.substring(1, id.length);
    }
    
    // 验证姓名
    function validateName(data) {
    	var reg = /^[a-zA-Z0-9\u4e00-\u9fa5]{1,30}$/;		// 30位大写，小写，数字，中文
    	return reg.exec(data);
    }
    
    // 验证身份证
    function validateIdNo(data, type) {
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
    }
    
    // 验证手机号码
    function validateMobile(data) {
    	var reg = /^1\d{10}$/;								// 1开头的号码
    	return reg.exec(data);
    }
    
    // 验证就诊卡号
    function validateCardNo(data) {
    	var reg = /^[a-zA-Z0-9]{1,30}/;						// 30位大写、小写、数字。
    	return reg.exec(data);
    }
    
    // 信息不正确提示
    function showIncorrectTip(data) {
    	$Y.loading.hide();
    	var tip = $('#inputIncorrectTip').val();
    	if (!tip || tip.indexOf('%replace%') < 0) {
    		tip = '您输入的%replace%不正确';
    	}
    	$Y.tips(tip.replace('%replace%', data));
    }
    
    // 信息不完整提示
    function showIncompleteTip(data) {
    	$Y.loading.hide();
    	var tip = $('#inputIncorrectTip').val();
    	if (!tip || tip.indexOf('%replace%') < 0) {
    		tip = '%replace%不能为空';
    	} 
    	$Y.tips(tip.replace('%replace%', data));
    }
    
    function bindParent(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行绑定就诊人信息');
    	
		if (!$('input[name="rParentName"]').val()) {
			if ($('#parentName').val()) {
				showIncorrectTip('姓名');
			} else {
				showIncompleteTip('姓名');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rParentIdNo"]').val()) {
			if ($('#parentIdNo').val()) {
				showIncorrectTip('证件号码');
			} else {
				showIncompleteTip('证件号码');
			}	
			$(obj).attr('disabled', false);	
			return false;
		}
		
		if (!$('#parentBirth').val()) {
			showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rParentMobile"]').val()) {
			if ($('#parentMobile').val()) {
				showIncorrectTip('手机号码');
			} else {
				showIncompleteTip('手机号码');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#parentAddress').val()) {
			showIncompleteTip('地址');
			$(obj).attr('disabled', false);
			return false;
		}
		
		// 验证码
		var inputCode = $('#parentCode').val();
		if (!inputCode) {
			showIncompleteTip('验证码');
            return false;
		}
		
		console.log('父母异步绑卡流程...');
		
		var data = {
			appCode: $('input[name="appCode"]').val(),
			areaCode: $('input[name="areaCode"]').val(),
			openId: $('input[name="openId"]').val(),
			userId:$('input[name="userId"]').val(),
			name: $('input[name="rParentName"]').val(),
			mobile: $('input[name="rParentMobile"]').val(),
			idType: $('#parentIdType').val(),
			idNo: $('input[name="rParentIdNo"]').val(),
			birth: $('#parentBirth').val(),
			sex: $('#parentSex').val(),
			address: $('#parentAddress').val(),
			ownership: 4,
			verifyCode: $('#parentCode').val(),
			codeType: codeType
		};
		console.log(data);
		ajaxBindFamily(obj, data);
    }
    
    function bindPartner(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行绑定就诊人信息');
    	
		if (!$('input[name="rPartnerName"]').val()) {
			if ($('#partnerName').val()) {
				showIncorrectTip('姓名');
			} else {
				showIncompleteTip('姓名');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rPartnerIdNo"]').val()) {
			if ($('#partnerIdNo').val()) {
				showIncorrectTip('证件号码');
			} else {
				showIncompleteTip('证件号码');
			}	
			$(obj).attr('disabled', false);	
			return false;
		}
		
		if (!$('#partnerBirth').val()) {
			showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rPartnerMobile"]').val()) {
			if ($('#partnerMobile').val()) {
				showIncorrectTip('手机号码');
			} else {
				showIncompleteTip('手机号码');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#partnerAddress').val()) {
			showIncompleteTip('地址');
			$(obj).attr('disabled', false);
			return false;
		}
		
		// 验证码
		var inputCode = $('#partnerCode').val();
		if (!inputCode) {
			showIncompleteTip('验证码');
            return false;
		}
		
		console.log('伴侣异步绑卡流程...');
		
		var data = {
			appCode: $('input[name="appCode"]').val(),
			areaCode: $('input[name="areaCode"]').val(),
			openId: $('input[name="openId"]').val(),
			name: $('input[name="rPartnerName"]').val(),
			mobile: $('input[name="rPartnerMobile"]').val(),
			idType: $('#partnerIdType').val(),
			idNo: $('input[name="rPartnerIdNo"]').val(),
			birth: $('#partnerBirth').val(),
			sex: $('#partnerSex').val(),
			address: $('#partnerAddress').val(),
			ownership: 6,
			verifyCode: $('#partnerCode').val(),
			codeType: codeType
		};
		console.log(data);
		ajaxBindFamily(obj, data);
    }
    
    function bindOther(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行绑定就诊人信息');
    	
		if (!$('input[name="rOtherName"]').val()) {
			if ($('#otherName').val()) {
				showIncorrectTip('姓名');
			} else {
				showIncompleteTip('姓名');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rOtherIdNo"]').val()) {
			if ($('#otherIdNo').val()) {
				showIncorrectTip('证件号码');
			} else {
				showIncompleteTip('证件号码');
			}	
			$(obj).attr('disabled', false);	
			return false;
		}
		
		if (!$('#otherBirth').val()) {
			showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rOtherMobile"]').val()) {
			if ($('#otherMobile').val()) {
				showIncorrectTip('手机号码');
			} else {
				showIncompleteTip('手机号码');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#otherAddress').val()) {
			showIncompleteTip('地址');
			$(obj).attr('disabled', false);
			return false;
		}
		
		// 验证码
		var inputCode = $('#otherCode').val();
		if (!inputCode) {
			showIncompleteTip('验证码');
            return false;
		}
		
		console.log('他人异步绑卡流程...');
		
		var data = {
			appCode: $('input[name="appCode"]').val(),
			areaCode: $('input[name="areaCode"]').val(),
			openId: $('input[name="openId"]').val(),
			name: $('input[name="rOtherName"]').val(),
			mobile: $('input[name="rOtherMobile"]').val(),
			idType: $('#otherIdType').val(),
			idNo: $('input[name="rOtherIdNo"]').val(),
			birth: $('#otherBirth').val(),
			sex: $('#otherSex').val(),
			address: $('#otherAddress').val(),
			ownership: 2,
			verifyCode: $('#otherCode').val(),
			codeType: codeType
		};
		console.log(data);
		ajaxBindFamily(obj, data);
    }
    
    function bindSibling(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行绑定就诊人信息');
    	
		if (!$('input[name="rSiblingName"]').val()) {
			if ($('#siblingName').val()) {
				showIncorrectTip('姓名');
			} else {
				showIncompleteTip('姓名');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rSiblingIdNo"]').val()) {
			if ($('#siblingIdNo').val()) {
				showIncorrectTip('证件号码');
			} else {
				showIncompleteTip('证件号码');
			}	
			$(obj).attr('disabled', false);	
			return false;
		}
		
		if (!$('#siblingBirth').val()) {
			showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rSiblingMobile"]').val()) {
			if ($('#siblingMobile').val()) {
				showIncorrectTip('手机号码');
			} else {
				showIncompleteTip('手机号码');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#siblingAddress').val()) {
			showIncompleteTip('地址');
			$(obj).attr('disabled', false);
			return false;
		}
		
		// 验证码
		var inputCode = $('#siblingCode').val();
		if (!inputCode) {
			showIncompleteTip('验证码');
            return false;
		}
		
		console.log('兄弟姐妹异步绑卡流程...');
		
		var data = {
			appCode: $('input[name="appCode"]').val(),
			areaCode: $('input[name="areaCode"]').val(),
			openId: $('input[name="openId"]').val(),
			name: $('input[name="rSiblingName"]').val(),
			mobile: $('input[name="rSiblingMobile"]').val(),
			idType: $('#siblingIdType').val(),
			idNo: $('input[name="rSiblingIdNo"]').val(),
			birth: $('#siblingBirth').val(),
			sex: $('#siblingSex').val(),
			address: $('#siblingAddress').val(),
			ownership: 5,
			verifyCode: $('#siblingCode').val(),
			codeType: codeType
		};
		console.log(data);
		ajaxBindFamily(obj, data);
    }
    
    function bindChild(obj) {
    	$(obj).attr('disabled', true);
    	$Y.loading.show('正在为您进行绑定就诊人信息');
    	
    	if (!$('input[name="rChildName"]').val()) {
    		if ($('#childName').val()) {
				showIncorrectTip('姓名');
			} else {
				showIncompleteTip('姓名');
			}
    		$(obj).attr('disabled', false);
			return false;
		}
    	
		if (!$('#childBirth').val()) {
			showIncompleteTip('出生日期');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('#childAddress').val()) {
			showIncompleteTip('地址');
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardName"]').val()) {
			if ($('#guardName').val()) {
				showIncorrectTip('监护人姓名');
			} else {
				showIncompleteTip('监护人姓名');
			}	
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardIdNo"]').val()) {
			if ($('#guardIdNo').val()) {
				showIncorrectTip('监护人证件号码');
			} else {
				showIncompleteTip('监护人证件证件号码');
			}	
			$(obj).attr('disabled', false);
			return false;
		}
		
		if (!$('input[name="rGuardMobile"]').val()) {
			if ($('#guardMobile').val()) {
				showIncorrectTip('监护人手机号码');
			} else {
				showIncompleteTip('监护人手机号码');
			}
			$(obj).attr('disabled', false);
			return false;
		}
		
		// 验证码
		var inputCode = $('#childCode').val();
		if (!inputCode) {
			showIncompleteTip('验证码');
            return false;
		}
		
    	// 儿童异步绑卡
		console.log('儿童异步绑卡流程...');

		var data = {
			appId: $('input[name="appId"]').val(),
			appCode: $('input[name="appCode"]').val(),
			areaCode: $('input[name="areaCode"]').val(),
			openId: $('input[name="openId"]').val(),
			name: $('input[name="rChildName"]').val(),
			idType: '1',
			idNo: '',
			birth: $('#childBirth').val(),
			sex: $('#childSex').val(),
			address: $('#childAddress').val(),
			ownership: 3,
			guardName: $('#rGuardName').val(),
			guardIdType: $('#guardIdType').val(),
			guardIdNo: $('#rGuardIdNo').val(),
			guardMobile: $('#rGuardMobile').val(),
			verifyCode: $('#childCode').val(),
			codeType: codeType
		};
		console.log(data);
		ajaxBindFamily(obj, data);
    }
    
    function ajaxBindFamily(obj, data) {
		return $.ajax({
			type: "POST",
			url: "${basePath}easyhealth/usercenter/myFamily/add",
			data: data,
			cache: false, 
			dataType: "json", 
			timeout: 120000,
			error: function(data) {
				$Y.loading.hide();
				new $Y.confirm({
		            ok:{title:'确定'},
		            content:'网络超时，请稍后在我的就诊人查看绑定结果。'
		        });
				$(obj).attr('disabled', false);
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				if (data.status == 'OK') {
					var code = data.message.isSuccess;
					if (code == 0) {
						// 挂号过来的话，跳回挂号页面
						var forward = $('#forward').val();
						if (forward) {
							$('#voForm').attr('action', forward);
						} else {
							$('#voForm').attr('action', '${basePath}easyhealth/usercenter/myFamily/index');
						}
                        myBox = new $Y.confirm({
                            title: "",
                            content: "<div style='text-align: center;'>添加成功</div>",
                            ok: {
                                title: "确定",
                                click: function() {
                                    myBox.close();
                                    $('#voForm').submit();
                                }
                            }
                        });
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
    }
    
    // 刷新方法
	function doRefresh() {
		$('#voForm').attr('action', '${basePath}easyhealth/usercenter/myFamily/addMyFamily');
		$('#voForm').submit();
	}
	
	// 返回方法
	function doGoBack() {
		var url = "${basePath}easyhealth/usercenter/myFamily/index";
		var forward = $('#forward').val();
		if (forward) {
			url = forward;
		}
		
		$('#voForm').attr('action', url);
		$('#voForm').submit();
	}
	
	var verifyCodeSended = false;
	/**
	 * 发送验证吗
	 */
	function sendVerifyCode(obj){
	    if (verifyCodeSended) {
	      return false;
	    }
		var reqUrl = "${basePath}easyhealth/usercenter/myFamily/sendCode";
		var mobile = $(obj).parent().parent().find('.patMobile').val();
		if (!mobile) {
			showIncompleteTip('请输入手机号码');
			return false;
		} else {
			var mobileReg = /^1\d{10}$/;
			if(!mobileReg.test(mobile)){
		      	showIncorrectTip('请输入手机号码');
		      	return false;
	  		}
		}

		verifyCodeSended = true;
	    var btn = $(obj), time = 60, timer = null;
		
		clearInterval(timer);
	    btn.html('发送中...');
	    btn.addClass('doing');
	    btn.unbind('click');
	
	    _toggleBtn = function() {
	        timer = setInterval(function () {
	            if (time >= 1) {
	                btn.html(time + '秒后重试');
	                time--;
	            } else {
	                clearInterval(timer);
	                btn.html('点击获取验证码');
	                btn.removeClass('doing');
	                time = 60;
	                btn.bind('click');
	                verifyCodeSended = false;
	            }
	        }, 1000)
	    }
		
		var datas = {
            mobile: mobile,
            codeType: codeType
        };
		_toggleBtn();
		$.ajax({  
	        type: 'POST',  
	        url: reqUrl,  
	        data: datas,  
	        dataType: 'json',  
	        timeout: 120000,
	        error: function(XMLHQ, errorMsg) {
	            
	        },
	        success: function(result) {
	            //$Y.loading.hide();
	        	if (result.status == 'OK') {
	
	        	} else {
	        	    clearInterval(timer);
	        	    btn.html('点击获取验证码');
	        	    btn.removeClass('doing');
	        	    verifyCodeSended = false;
	        		myBox = new $Y.confirm({
	        			title:"",
	        			content:"<div style='text-align: center;'>" + result.message + "</div>",
	        			ok:{title:"确定",
	        				click:function(){
	        					myBox.close();
	        				}
	        			}
	        		});
	        	}
	        }
		 });
	}
</script>