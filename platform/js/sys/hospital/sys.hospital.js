/**
 * 医院管理后台js
 */

var $hospital = {};

/**
 * 医院的状态 禁用
 */
$hospital.hospital_invalid_status = 0;

/**
 * 医院的状态 启用
 */
$hospital.hospital_valid_status = 1;

/**
 * 搜索医院
 */
$hospital.search = function() {
  document.forms[0].submit();
}

$hospital.back = function(url) {
	location.href = url;
}

/**
 * 医院管理分页
 */
$hospital.changePage = function(pageNum, pageSize) {
  if (pageNum) {
    var pages = $('form input[name="pages"]').val();
    var pageNumInput = $('form input[name="pageNum"]');

    // 如果输入的页数是非数字，则还是跳到当前页
    if (isNaN(pageNum)) {
      pageNum = pageNumInput.val();
    }

    // 如果页数大于总页数，则跳至最后一页，如页数小于最小页数，则跳至第一页
    pageNum = pageNum > pages ? pages : pageNum;
    pageNum = pageNum < 1 ? 1 : pageNum;

    pageNumInput.val(pageNum);

    // 如果修改了每页显示的数量
    if (pageSize) {
      $('form input[name="pageSize"]').val(pageSize);
    }
    $hospital.search();
  }
}

/**
 * 启用/禁用
 */
$hospital.updateStatus = function(btn, status) {
  var id = $(btn).parent().siblings().eq(1).text();
  // var status = $(btn).parent().siblings().eq(2).text();
  var code = $(btn).parent().siblings().eq(3).text();
  var name = $(btn).parent().siblings().eq(4).text();
  var tips = status == $hospital.hospital_invalid_status ? "禁用" : "启用";
  if (!confirm("确定要" + tips + name + "吗？")) {
    return;
  }
  $.ajax({
    url : 'updateStatus',
    data : {
      id : id,
      status : status,
      code : code
    // 更新缓存用到
    },
    async : true,
    dataType : 'json',
    timeout : 5000,
    type : 'POST',
    error : function(XMLHQ, errorMsg) {
      console.log(errorMsg);
      alert(errorMsg);
    },
    success : function(data) {
      console.dir(data);
      if (data.status == 'OK') {
        $hospital.search();
      } else {
        alert(data.message);
      }

    }
  });
}

/**
 * 添加医院按钮click事件
 */
$hospital.toAdd = function() {
  location.href = 'toAdd';
}

/**
 * 验证电话和手机号码
 * @param value
 * @returns {Boolean}
 */
function checkTel(value){
    var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
    var isMob=/^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|134[0-9]{8})$/;
   // var value=document.getElementById("ss").value.trim();
    if(isMob.test(value) || isPhone.test(value)){
        return true;
    }else{
        return false;
    }
}


/**
 * 新增医院
 */
$hospital.save = function() {
	var name = jQuery.trim($('form input[name="name"]').val());
	var code = jQuery.trim($('form input[name="code"]').val());
	var contactName = jQuery.trim($('form input[name="contactName"]').val());
	var contactTel = jQuery.trim($('form input[name="contactTel"]').val());
	var guideURL = jQuery.trim($('form input[name="guideURL"]').val());
	var cloudURL = jQuery.trim($('form input[name="cloudURL"]').val());
	var trafficURL = jQuery.trim($('form input[name="trafficURL"]').val());
	var logo = jQuery.trim($('form input[name="logo"]').val());
	var areaCode  = jQuery.trim($('form select[name="areaCode"]').find("option:selected").val());
	var reg = /^[\u4E00-\u9FA5A-Za-z0-9_]{1,50}$/;
	var svcType = jQuery.trim($('form select[name="svcType"]').val());
	
	if (!reg.test(name)) {
		console.log(name);
		alert('请填写正确的医院名称');
		return false;
	}
	if(areaCode == ''){
		alert('请选择医院区域');
		return false;
	}
	/*reg = /^[A-Za-z0-9_]{1,50}$/;
	if (!reg.test(code)) {
		console.log(code);
		alert('请填写正确的医院编码');
		return false;
	}*/
  
	if(contactName.length > 20){
	  	console.log(contactName);
	  	alert('联系人过长');
	  	return false;
	}
	if(contactTel != ''){
		if(!checkTel(contactTel)){
			alert('联系人电话格式错误');
			return false;
		}
	} 
	  
    var id = $('form input[name="id"]').val();
    $.ajax({
    	url : 'save',
    	data : {
    		id : id,
    		name : name,
    		code : code,
    		contactName : contactName,
    		contactTel : contactTel,
    		areaCode : areaCode,
    		guideURL:guideURL,
    		cloudURL:cloudURL,
    		trafficURL:trafficURL,
    		logo:logo,
    		svcType:svcType
    	},
    	async : true,
    	dataType : 'json',
    	type : 'POST',
    	error : function(XMLHQ, errorMsg) {
    		console.log(errorMsg);
    		alert(errorMsg);
    	},
    	success : function(data) {
    		console.dir(data);
    		console.log(data.status);
    		if (data.status == 'OK') {
    			location.href = '../branchHospital/toView?hospitalId=' + data.id;
    		} else {
    			alert(data.message);
    		}
    	}
    });
}


/**
 * 启用/禁用
 */
$hospital.updateBulkStatus = function(status) {
	var tips = status == 0 ? "禁用" : "启用";
	var chk = jQuery("#hospital_tab").find(":checkbox[name=chkHospitals]");
	var hospitalIds = new Array();
	chk.each(function(idx,item){
		if(jQuery(item).parent().hasClass("check")){
			hospitalIds[idx] = jQuery(item).val();
		}
	});
	console.log(hospitalIds);
	if(hospitalIds.length > 0){
		if (confirm("确定要" + tips + "所选医院吗？")) {
			$.ajax({
				url : 'updateBulkStatus',
				 data : {
					 hospitalIds : hospitalIds,
				     status : status
				 },
				 async : true,
				 dataType : 'json',
				 type : 'POST',
				 error : function(XMLHQ, errorMsg) {
					 console.log(errorMsg);
					 alert(errorMsg);
				 },
				 success : function(data) {
					 console.dir(data);
				     if (data.status == 'OK') {
				    	 $hospital.search();
				     } else {
				    	 alert(data.message);
				     }
				 }
			 });
		}
	}else{
		alert("对不起，您未选择医院!");
	}
}

/**
 * 单行编辑医院按钮click事件
 */
$hospital.toEdit = function(btn) {
	var id = $(btn).parent().siblings().eq(1).text();
	location.href = 'toEdit?id=' + id;
}

/**
 * 添加分院选项卡
 */
$hospital.addBranchHospitalItem = function() {
	if (!$hospital.checkValues()) {
		return;
	}

	var liNum = $('#name-Hlist li').size();
	var html = '<li style="cursor: hand;" index="' + liNum + '" onclick="$hospital.setBranchHospitalValues(' + liNum + ');"><i class="caret"></i><span class="text">分院</span><input type="hidden" name="branchHospital_id" value=""></li>';
	$('#name-Hlist').append(html);

	$hospital.setBranchHospitalValues(liNum);
}

/**
 * 切换分院选项卡
 */
$hospital.setBranchHospitalValues = function(index) {
	// 保存原有文本框的值
	var oldIndex = $('.active').attr('index');
	$hospital.saveBranchHospitalValues(oldIndex);

	// 清空所有文本框的值
	var hospitalId = $('form input[name="hospitalId"]').val();
	$('form input').val('');
	$('form input[name="hospitalId"]').val(hospitalId);

	// 移除原有的选中样式
	$('.js_branchHospitalItem').removeClass('js_branchHospitalItem');
	$('.active').removeClass('active');

	// 获得当前点击的分院
	var indexLi = $('#name-Hlist li[index="' + index + '"]');
	// 添加选中样式
	indexLi.addClass('active');
	indexLi.find('span').addClass('js_branchHospitalItem');

	// 设置文本框的值
	var branchHospitalValues = $hospital.branchHospitals[index];
	if (branchHospitalValues) {
		for ( var key in branchHospitalValues) {
			var val = branchHospitalValues[key];
			if (val) {
				$('form input[name="' + key + '"]').val(val);
			}
		}
	}
	console.dir($hospital.branchHospitals);
}

/**
 * 验证分院必填信息
 */
$hospital.checkValues = function() {
	var name = $('form input[name="name"]').val();
	var code = $('form input[name="code"]').val();
	var interfaceId = $('form input[name="interfaceId"]').val();
	var address = $('form input[name="address"]').val();
	var contactTel = $('form input[name="tel"]').val();
	
	var reg = /^[\u4E00-\u9FA5A-Za-z0-9_]{1,50}$/;
	if (!reg.test(name)) {
		console.log(name);
		alert('请填写正确的分院名称');
		return false;
	}
	/*reg = /^[A-Za-z0-9_]{1,50}$/;
	if (!reg.test(code)) {
		alert('请输入正确的分院代码');
		return false;
	}*/
	if (!reg.test(interfaceId)) {
		alert('请输入正确的接口ID');
		return false;
	}
	
	if(address != ''){
		if(address.length > 100){
			alert('分院地址过长');
			return false;
		}
	}
	
	if(contactTel != ''){
		if(!checkTel(contactTel)){
			alert('分院电话格式错误');
			return false;
		}
	} 
	
	return true;
}

/**
 * 临时保存填写的分院信息
 */
$hospital.saveBranchHospitalValues = function(index) {
	var oldValues = $hospital.branchHospitals[index];
	var inputValues = {};
	$('form input').each(function(i, item) {
		if (item.value) {
			eval('inputValues.' + item.name + '="' + item.value + '";');
		}
	});
	if (inputValues.name) {
		if (inputValues) {
			$hospital.branchHospitals[index] = inputValues;
		} else {
			$hospital.branchHospitals.push(inputValues);
		}
	}
}

/**
 * 保存分院
 */
$hospital.saveBranchHospitals = function() {
	if (!$hospital.checkValues()) {
		return;
	}

	// 设置最后添加的分院的值
	var index = $('.active').attr('index');
	$hospital.saveBranchHospitalValues(index);
	console.dir($hospital.branchHospitals);
	console.dir($json.toJSONString($hospital.branchHospitals));
	$.ajax({
		url : 'save',
		data : {
			hospitalId : $hospital.id,
			branchHospitals : $json.toJSONString($hospital.branchHospitals)
		},
		async : true,
		dataType : 'json',
		type : 'POST',
		error : function(XMLHQ, errorMsg) {
			console.log(errorMsg);
		},
		success : function(data) {
			console.dir(data);
			if (data.status == 'OK') {
				location.href = '../platformSettings/toView?hospitalId=' + $hospital.id;
			} else {
				alert(data.message);
			}
		}
	});
}

/*删除分院*/
$hospital.deleteBranchHospitals = function(){
	var li = jQuery("#name-Hlist").find("li");
	if(li.length > 1){
		var branchHospitalId = $('.active').find(":hidden[name=branchHospital_id]").val();
		console.log(li.length);
		console.log(branchHospitalId);
		if(branchHospitalId != ''){
			$.ajax({
			    url : 'delete',
			    data : {
			    	branchHospitalId : branchHospitalId
			    },
			    async : true,
			    dataType : 'json',
			    type : 'POST',
			    error : function(XMLHQ, errorMsg) {
			      console.log(errorMsg);
			    },
			    success : function(data) {
			      console.dir(data);
			      if (data.status == 'OK') {
			    	  //$('.active').remove();
			    	  //$hospital.setBranchHospitalValues(li.length - 2)
			    	  window.location.reload(true);
			      } else {
			    	  alert(data.message);
			      }

			    }
			  });
		}else{
			$('.active').remove();
			$hospital.setBranchHospitalValues(li.length - 2)
		}
	}else{
		alert("请至少保留一个分院!");
	}
}

$hospital.platform = {};

/**
 * 切换接入平台选项卡是动态显示/影藏对应的Input
 */
$hospital.platform.switchTab = function(tab) {
	var code = $(tab).attr('code');
	var ehFlag = $(tab).attr('easyHealth');
	if ($(tab).is('.active')) {
		$(tab).removeClass('active');
		$('#' + code + '_input').hide();
		$('#' + code + '_wxts').hide();
		if(ehFlag == 'true'){
			$("#" + code + "_input").find(":text[field=appId]").val("");
		}
	} else {
		
		if(ehFlag == 'true'){
			$.ajax({
		    	url : 'getGenerat',
		    	data:{hospitalId:$hospital.id},
		    	success : function(data) {
		    		if (data.status == 'OK') {
		    			$("#" + code + "_input").find(":text[field=appId]").val(data.message);
		    			$(tab).addClass('active');
		    			$('#' + code + '_input').show();
		    			$('#' + code + '_wxts').show();
		    		}
		    	}
		    });
		}else{
			$(tab).addClass('active');
			$('#' + code + '_input').show();
			$('#' + code + '_wxts').show();
		}
	}
}

/**
 * 保存接入平台配置信息
 */
$hospital.platform.savePlatformSettings = function() {
	if (!$hospital.platform.check()) {
		return;
	}
	var params = {};
	// 获取填写的信息
	// var checkPlatforms = $('.name-list li.active');
	var checkPlatforms = $('.name-list li');
	checkPlatforms.each(function(i, item) {
	    var code = $(item).attr('code');
	    var platformId = $(item).attr('value');
	    eval('params.' + code + '={};');
	    $('#' + code + '_input input').each(function(ii, inputItem) {
	    	if (inputItem.value) {
	    		if($(item).hasClass("active")){
	    			eval('params.' + code + '.' + $(inputItem).attr('field') + ' = "' + inputItem.value + '";');
	    		}else{
	    			if($(inputItem).attr('field') == "id"){
	    				eval('params.' + code + '.' + $(inputItem).attr('field') + ' = "' + inputItem.value + '";');
	    			}else{
	    				eval('params.' + code + '.' + $(inputItem).attr('field') + ' = "";');
	    			}
	    		}
	    		//eval('params.' + code + '.' + $(inputItem).attr('field') + ' = "' + inputItem.value + '";');
	    		// 是否需要更新状态
	    		if ($(item).is('.active')) {
	    			eval('params.' + code + '.status = 1;');
	    		} else {
	    			eval('params.' + code + '.status = 0;');
	    		}
	    		eval('params.' + code + '.platformId = "' + platformId + '";');
	    	}
	    });
	});
	console.log($json.toJSONString(params));

	var alipayOldAppId = $('#alipayOldAppId').val();
	var wechatOldAppId = $('#wechatOldAppId').val();

	// 提交后台处理
	$.ajax({
		url : 'save',
		data : {
			wechatOldAppId : wechatOldAppId,
			alipayOldAppId : alipayOldAppId,
			hospitalId : $hospital.id,
			params : $json.toJSONString(params)
		},
		async : true,
		dataType : 'json',
		type : 'POST',
		error : function(XMLHQ, errorMsg) {
			console.log(errorMsg);
		},
		success : function(data) {
			console.dir(data);
			if (data.status == 'OK') {
				// alert('save complete');
				location.href = '../paySettings/toView?hospitalId=' + $hospital.id;
			} else {
				alert(data.message);
			}
		}
	});
}

$hospital.platform.check = function() {
	var result = true;
	var checkPlatforms = $('.name-list li.active');
	// alert(checkPlatforms.size());
	if (checkPlatforms.size() == 0) {
		alert('请选择接入平台');
		return false;
	}

	// 验证勾选的接入平台信息是否填写完整
	checkPlatforms.each(function(i, item) {
		var code = $(item).attr('code');
		$('#' + code + '_input input[class="span11"]').each(function(ii, inputItem) {
			if(code != 'easyHealth'){
				if (!$(inputItem).attr('field').match('id|platformId|hospitalPlatformSettingsId')) {
					if (result && !$(inputItem).val()) {
						alert("请输入" + $(inputItem).parent().parent().find(".control-label").text());
						result = false;
						return false;
					}
				}
			}else{
				var jkyAppId = $.trim($('#' + code + '_input').find(":text[field=appId]").val());
				if(jkyAppId == ''){
					result = false;
					return false;
				}
			}
		});
	});
  return result;
}



/**
 * 切换支付方式选项卡是动态显示/影藏对应的Input
 */
$hospital.platform.switchPayType = function(tab) {
	var code = $(tab).attr('code');
	if ($(tab).is('.active')) {
		$(tab).removeClass('active');
		$('#' + code + '_input').hide();
	} else {
		$(tab).addClass('active');
		$('#' + code + '_input').show();
	}
}




$hospital.pay = {};
$hospital.pay.savePaySettings = function() {
	if(!$hospital.pay.check()){
		return;
	}
	
	var params = {};
	// 获取填写的信息
	// var checkPlatforms = $('.name-list li.active');
	var checkPlatforms = $('.name-list li');
	checkPlatforms.each(function(i, item) {
		var code = $(item).attr('code');
		var platformId = $(item).attr('platformId');
	    eval('params.' + code + '={};');
	    $('#' + code + '_input input').each(function(ii, inputItem) {
	    	console.log($(inputItem).attr('field') + "//" + $(inputItem).attr("value"));
	    	if (inputItem.value) {
	    		if($(item).hasClass("active")){
	    			eval('params.' + code + '.' + $(inputItem).attr('field') + ' = "' + inputItem.value + '";');
	    		}else{
	    			if($(inputItem).attr('field') == "id" || $(inputItem).attr('field') == "payModeId"|| $(inputItem).attr('field') == "flag"){
	    				eval('params.' + code + '.' + $(inputItem).attr('field') + ' = "' + inputItem.value + '";');
	    			}else{
	    				eval('params.' + code + '.' + $(inputItem).attr('field') + ' = "";');
	    			}
	    		}
	    		// 是否需要更新状态
		        if ($(item).is('.active')) {
		          eval('params.' + code + '.status = 1;');
		        } else {
		          eval('params.' + code + '.status = 0;');
		        }
		        eval('params.' + code + '.platformId = "' + platformId + '";');
	    	}
	    });
	  });
	 console.log($json.toJSONString(params));
	 $.ajax({
		 url : 'save',
		 data : {
			 hospitalId : $hospital.id,
			 params : $json.toJSONString(params)
		 },
		 async : true,
		 dataType : 'json',
		 type : 'POST',
		 error : function(XMLHQ, errorMsg) {
			 console.log(errorMsg);
		 },
		 success : function(data) {
			 console.dir(data);
			 if (data.status == 'OK') {
				 // alert('save complete');
				 location.href = '../optional/toView?hospitalId=' + $hospital.id;
			 } else {
				 alert(data.message);
			 }
		 }
	 });
}

//是否子商户切换
$hospital.pay.isSubPay = function(obj, code){
	var code = jQuery("#" + code + "_input");
	if(jQuery(obj).val() == 0){//选中
		jQuery(obj).val(1);
		jQuery(code).find("div[name=div_subMchId]").show();
		jQuery(code).find("div[name=div_parentAppId]").show();
		jQuery(code).find("div[name=div_parentSecret]").show();
		jQuery(code).find("div[name=label_mchId]").text("微信支付父商户号");
		jQuery(code).find("div[name=label_payKey]").text("微信支付父商户密匙");
		jQuery(code).find("div[name=label_certificatePath]").text("微信父商户退费证书");
	}else{
		jQuery(code).find("div[name=subMchId]").val("");
		jQuery(obj).val(0);
		jQuery(code).find("div[name=div_subMchId]").hide();
		jQuery(code).find("div[name=div_parentAppId]").hide();
		jQuery(code).find("div[name=div_parentSecret]").hide();
		jQuery(code).find("div[name=label_mchId]").text("微信支付商户号");
		jQuery(code).find("div[name=label_payKey]").text("微信支付密匙");
		jQuery(code).find("div[name=label_certificatePath]").text("微信退费证书");
	}
}

$hospital.pay.getFile = function(e){
	var src=e.target || window.event.srcElement; //获取事件源，兼容chrome/IE
    var filename = src.value.substring(src.value.lastIndexOf('\\')+1);
    jQuery("#fileNameDiv").text(filename);
}

$hospital.pay.check = function() {
	  var result = true;
	  var checkPayMode = $('.name-list li.active');
	  console.dir(checkPayMode.size());
	  if (checkPayMode.size() == 0) {
		  alert('请选择支付方式');
		  return false;
	  }
	  
	  var isSubPay = 
	  // 验证勾选的接入平台信息是否填写完整
	  checkPayMode.each(function(i, item) {
		  var code = $(item).attr('code');
		  var inputItem = $('#' + code + '_input');
		  var easyHealth = "";
		  if(code == "easyHealthWechat" || code == "easyHealthAlipay"){
			  easyHealth = "健康易";
		  }
		  if(code == "wechat" || code == "easyHealthWechat"){
			  var isSubPay = jQuery("#" + code + "_input").find(":checkbox[name=isSubPay]").val();
			  console.dir(jQuery("#" + code + "_input").find(":checkbox[name=isSubPay]").val());
			  if(isSubPay == 1){
				  if(jQuery.trim(jQuery(inputItem).find('[field=subMchId]').val()) == ""){
					  alert("请输入" + easyHealth + "微信支付子商户号");
					  result = false;
					  return false;
				  }
				  if(jQuery.trim(jQuery(inputItem).find('[field=parentAppId]').val()) == ""){
					  alert("请输入" + easyHealth + "微信支付父商户appId");
					  result = false;
					  return false;
				  }
				  if(jQuery.trim(jQuery(inputItem).find('[field=parentSecret]').val()) == ""){
					  alert("请输入" + easyHealth + "微信支付父商户Secret");
					  result = false;
					  return false;
				  }
			  }
	    	
			  if(jQuery.trim(jQuery(inputItem).find('[field=mchId]').val()) == ""){
				  if(jQuery("#isSubPay").is(":checked")){
					  alert("请输入" + easyHealth + "微信支付父商户号");
				  }else{
					  alert("请输入" + easyHealth + "微信支付商户号");
				  }
				  result = false;
				  return false;
			  }
			  if(jQuery.trim(jQuery(inputItem).find('[field=payKey]').val()) == ""){
				  alert("请输入" + easyHealth + "微信支付密匙");
				  result = false;
				  return false;
			  }
			  console.dir(jQuery(inputItem).find('[field=certificatePath]').val());
			  if(jQuery.trim(jQuery("#fileNameDiv").text()) == ""){
				  if(jQuery("#isSubPay").is(":checked")){
					  alert("请上传" + easyHealth + "微信父商户退费证书");
				  }else{
					  alert("请上传" + easyHealth + "微信退费证书");
				  }
				  result = false;
				  return false;
			  }
		  }else if(code == "alipay" || code == "easyHealthAlipay"){
			  if(jQuery.trim(jQuery(inputItem).find('[field=mchId]').val()) == ""){
				  alert("请输入" + easyHealth + "支付宝合作者ID");
				  result = false;
				  return false;
			  }
			  if(jQuery.trim(jQuery(inputItem).find('[field=mchAccount]').val()) == ""){
				  alert("请输入" + easyHealth + "支付宝商家帐号");
				  result = false;
				  return false;
			  }
			  if(jQuery.trim(jQuery(inputItem).find('[field=payKey]').val()) == ""){
				  alert("请输入" + easyHealth + "支付宝支付秘钥");
				  result = false;
				  return false;
			  }
			  if(jQuery.trim(jQuery(inputItem).find('[field=payPrivateKey]').val()) == ""){
				  alert("请输入" + easyHealth + "支付宝支付私钥");
				  result = false;
				  return false;
			  }
			  if(jQuery.trim(jQuery(inputItem).find('[field=payPublicKey]').val()) == ""){
				  alert("请输入" + easyHealth + "支付宝支付公钥");
				  result = false;
				  return false;
			  }
		  }
	    /*console.dir(code)
	    $('#' + code + '_input input').each(function(ii, inputItem) {
	    	console.dir($(inputItem).attr('field'));
	      if (!$(inputItem).attr('field').match('id|mchId|payKey|certificatePath')) {
	    	  console.dir($(inputItem).val());
	    	  if (result && !$(inputItem).val()) {
	    		  if($(inputItem).attr('field') == 'subMchId'){
	    			  if(jQuery("#isSubPay").is(":checked")){
	    				  alert("请输入" + $(inputItem).parent().siblings(0).text());
			    		  result = false;
			    		  return false;
	    			  }
		    	  }else{
		    		  alert("请输入" + $(inputItem).parent().siblings(0).text());
		    		  result = false;
		    		  return false;
		    	  }
	    	  }
	      }
	    });*/
	  	});
	  	console.dir(result)
	  	return result;
	}

$hospital.platform.changeUrl = function(obj,name){
	jQuery("#" + name).text(jQuery(obj).val());
}


$hospital.optional = {};

/**
 * 添加已选功能
 */
$hospital.optional.addItem = function(tab) {
	if ($(tab).attr('sel') != 'true') {
		var id = $(tab).attr('data-id');
		var text = $(tab).find('span.text').text();
		var controller = $(tab).attr('data-controller');
		controller = controller ? controller : '';
		var html = [];
		html.push('<li>');
		html.push('<span class="text">' + text + '</span>');
		html.push('<a class="green pull-right" href="javascript:void(0);" data-id="' + id + '" data-controller="' + controller + '" onclick="$hospital.optional.delItem(this);">取消</a>');
		html.push('</li>');
		$('.optionsS-list').append(html.join(''));

		$(tab).attr('sel', 'true');
		$(tab).parent().hide();
	}
}

/**
 * 删除已选功能
 */
$hospital.optional.delItem = function(tab) {
	$(tab).parents('li').remove();
	$('.module-list li a[data-id="' + $(tab).attr('data-id') + '"]').removeAttr('sel').parent().show();
}

/**
 * 保存已选功能
 */
$hospital.optional.save = function() {
	var lis = $('.optionsS-list li');
	if (lis.size() == 0) {
		alert('请添加可选功能');
		return;
	} else {
		var selOptionals = [];
		// 循环获取已选择的功能
		lis.each(function(i, item) {
			var optional = {};
			var aItem = $(item).find('a');
			optional.id = aItem.attr('data-id');
			optional.name = $(item).find('span.text').text();
			optional.controllerPath = aItem.attr('data-controller');
			console.dir(optional);
			selOptionals.push(optional);
		});

	    // 提交后台处理
	    $.ajax({
	    	url : 'save',
	    	data : {
	    		hospitalId : $hospital.id,
	    		selOptionals : $json.toJSONString(selOptionals)
	    	},
	    	async : true,
	    	dataType : 'json',
	    	type : 'POST',
	    	error : function(XMLHQ, errorMsg) {
	    		console.log(errorMsg);
	    	},
	    	success : function(data) {
	    		console.dir(data);
	    		if (data.status == 'OK') {
	         	// alert('save complete');
	    			location.href = '../customerMenu/toView?hospitalId=' + $hospital.id;
	    		} else {
	    			alert(data.message);
	    		}
	    	}
	    });
	}
}








/*------------------------菜单配置页面  start-------------------------------*/
$hospital.menu = {};
//切换接入平台 
function getMeun(obj){
	var platformsId = jQuery("#platforms").find("option:selected").attr("value");
	var hospitalId = jQuery("#hospitalId").attr("value");
	location.href = '../customerMenu/toView?hospitalId=' + hospitalId + '&platformsId=' + platformsId;
}




/**
 * 保存配置菜单
 */
$hospital.menu.save = function() {
	var menuItem = [];
	var childItem = []
	var actionRow  = $("#menu_box").find(".availability");
	var checkFlag = true;
	if(actionRow.length > 0){
		actionRow.each(function(idx,item){//循环一级菜单
			var menu = {};
			var id = jQuery(item).find(":hidden[name=id]").val();
			//菜单名称
			var name = jQuery(item).find(":text[name=name]").val();		
			//菜单功能
			var menuOptionalSelect = jQuery(item).find("select[name=menuOptionalSelect] option:selected").attr("value");
			var bizCode = jQuery(item).find("select[name=menuOptionalSelect] option:selected").attr("bizCode");
			var mark = idx;
			var meunType = 0;
			if(menuOptionalSelect == ''){
				meunType = jQuery(item).find("select[name=menuOptionalSelect] option:selected").attr("menutype");
				if(meunType == '' || typeof(meunType) == 'undefined'){
					checkFlag = false;
					return false;
				}
			}
			
			console.log("meunType:" + meunType);
			//外部链接
			var content = jQuery(item).find(":text[name=content]").val();
			console.log("content:" + content);
			//图文ID
			var grapicsId = jQuery(item).find(":hidden[name=grapicsId]").attr("value");
			console.log((typeof(content) == 'undefined'));
			content = typeof(content) == 'undefined' ? '':content;
			grapicsId = typeof(grapicsId) == 'undefined' ? '':grapicsId;
			console.log((typeof(grapicsId) == 'undefined'));
			eval('menu.id="' + id + '";');
			eval('menu.mark="' + mark + '";');
			eval('menu.name="' + name + '";');
			//eval('menu.grapicsId=1;');
			eval('menu.optionalId="' + menuOptionalSelect + '";');
			eval('menu.bizCode="' + bizCode + '";');
			eval('menu.meunType="' + meunType + '";');
			eval('menu.content="' + content + '";');
			eval('menu.grapicsId="' + grapicsId + '";');
			eval('menu.sort="' + (idx + 1) + '";');//排序从1开始
			var menuTwo = jQuery(item).find(".action-second-outer");
			if(menuTwo.length > 0){
				menuTwo.each(function(idxChild,cItem){//循环二级菜单 
					var child = {};
					id = jQuery(cItem).find(":hidden[name=id]").val();
					name = jQuery(cItem).find(":text[name=name]").val();		
					//菜单功能
					menuOptionalSelect = jQuery(cItem).find("select[name=menuOptionalSelect] option:selected").attr("value");
					bizCode = jQuery(cItem).find("select[name=menuOptionalSelect] option:selected").attr("bizCode");
					var meunType = 0;
					if(menuOptionalSelect == ''){
						meunType = jQuery(cItem).find("select[name=menuOptionalSelect] option:selected").attr("menutype");
						if(meunType == '' || typeof(meunType) == 'undefined'){
							checkFlag = false;
							return false;
						}
					}
					console.log("child.meunType:" + meunType);
					
					//外部链接
					var content = jQuery(cItem).find(":text[name=content]").val();
					console.log("content:" + content);
					//图文ID
					var grapicsId = jQuery(cItem).find(":hidden[name=grapicsId]").attr("value");
					console.log((typeof(content) == 'undefined'));
					content = typeof(content) == 'undefined' ? '':content;
					grapicsId = typeof(grapicsId) == 'undefined' ? '':grapicsId;
					console.log((typeof(grapicsId) == 'undefined'));
					eval('child.id="' + id + '";');
					eval('child.mark="' + mark + '";');
					eval('child.name="' + name + '";');
					//eval('child.level=2;');
					eval('child.optionalId="' + menuOptionalSelect + '";');
					eval('child.bizCode="' + bizCode + '";');
					eval('child.meunType="' + meunType + '";');
					eval('child.content="' + content + '";');
					eval('child.grapicsId="' + grapicsId + '";');
					eval('child.sort="' + (idxChild + 1) + '";');//排序从1开始
					childItem.push(child);
				});
			}
			menuItem.push(menu);
		});
		console.log("json:" + JSON.stringify(menuItem));
		console.log("childjson:" + JSON.stringify(childItem));
	}
	var platformsCode = jQuery("#platforms").find("option:selected").attr("code");
	if(platformsCode != "easyHealth"){
		if(menuItem.length <= 0){
			alert("请配置菜单!");
			return;
		}
	}else{
		if(menuItem.length > 0){
			var flag = false;
			var hash = {};
			$("#menu_box").find("select[name=menuOptionalSelect] option:selected").each(function(){
				var key = jQuery(this).attr("bizCode");
				if(hash[key]){
					flag = true;return; 
				}
				hash[key] = key;
			});
			if(flag){
				alert("您有功能重复选择，请检查功能项!");
				return;
			}
		}
		
	}
	
	if(checkFlag == false){
		alert("您有菜单未选择功能，请检查菜单功能项!");
	}else{
		//平台ID
		var platformsId = jQuery("#platforms").find("option:selected").attr("value");
		$hospital.id = jQuery("#hospitalId").attr("value");
		console.log("$hospital.id:" + $hospital.id);
	    // 提交后台处理
	    $.ajax({
	    	url : 'save',
	    	data : {
	    		hospitalId : $hospital.id,
	    		platformsId : platformsId,
	    		platformsCode: platformsCode,
	    		menuItem : $json.toJSONString(menuItem),
	    		childItem : $json.toJSONString(childItem)
	    	},
	    	async : true,
	     	dataType : 'json',
	     	type : 'POST',
	     	error : function(XMLHQ, errorMsg) {
	     		console.log(errorMsg);
	     	},
	     	success : function(data) {
	     		console.dir(data);
	     		if (data.status == 'OK') {
	     			alert('保存成功');
	     			//location.href = '../customerMenu/toView?hospitalId=' + $hospital.id;
	     		} else {
	     			alert(data.message);
	     		}
	     	}
	    });
	}
}

//发布菜单
$hospital.optional.publish = function() {
	var platformsId = jQuery("#platforms").find("option:selected").attr("value");
	$hospital.id = jQuery("#hospitalId").attr("value");
	$.ajax({
	      url : basePath + 'sys/customerMenu/publish',
	      data : {
	        hospitalId : $hospital.id,
	        platformsId : platformsId
	      },
	      async : true,
	      dataType : 'json',
	      type : 'POST',
	      error : function(XMLHQ, errorMsg) {
	        console.log(errorMsg);
	      },
	      success : function(data) {
	        console.dir(data);
	        if(data.status == true){
	        	alert("菜单创建成功!");
	        }else{
	        	alert(data.message);
	        }
	        
	       /* if (data.jsonMenu != '') {
	        	console.dir(JSON.stringify(data.jsonMenu));
	        	$.ajax({
		      	      url : basePath + 'sdk/wechat/menu/createStr',
		      	      data : {
		      	    	jsonMenu : JSON.stringify(data.jsonMenu),
		      	    	appId : data.platformSettings.appId,
		      	    	appSecret : data.platformSettings.privateKey
		      	      },
		      	      async : true,
		      	      dataType : 'json',
		      	      type : 'POST',
		      	      error : function(XMLHQ, errorMsg) {
		      	    	console.log(XMLHQ);
		      	        console.log(errorMsg);
		      	        alert(errorMsg);
		      	      },
		      	      success : function(data) {
		      	        console.dir(data);
		      	        if (data.status == 'OK') {
		      	        	alert("成功");
		      	        } else {
		      	          alert(data.message);
		      	        }

		      	      }
		      	    });
	        	
	        } else {
	        	alert(data.message);
	        }*/

	      }
	    });
}



/*
//添加一级菜单
$hospital.menu.addfirstMenu = function(){
	var action_box = jQuery("#menu_box");//一级菜单盒子
	var len = jQuery(action_box).find(".action-row").length;
	var menu_one_id = "menu_one_" + len;
	var menu_one = jQuery("#menu_one").clone().attr("id","menu_one_" + len).addClass("availability").show();//克隆一级菜单
	jQuery(menu_one).find("button[name=addBut]").attr("onclick","addSecondMenu(this,'" + menu_one_id + "')")
	jQuery(menu_one).find("button[name=delBut]").attr("onclick","delSecondMenu(this,'" + menu_one_id + "')")
	jQuery("#menu_box").append(menu_one);
	setorder();
}

delSecondMenu = function(obj,menu_one_id){
	if(confirm("删除一级菜单会级联删除二级菜单，确定删除?")){
		jQuery("#" + menu_one_id).remove();
		jQuery("div[menuOne='" + menu_one_id + "']").remove();
		setorder();
	}
}


//添加二级菜单
addSecondMenu = function(obj,menu_one_id){
	var item_two = jQuery("div[menuone=" + menu_one_id + "]");
	var len = item_two.length;
	var aterHtml = jQuery("#" + menu_one_id);
	if(len > 0){
		aterHtml = jQuery(item_two).last();
	}
	var id = menu_one_id  + "_menu_two_" + len;
	var menu_two = jQuery("#menu_two").clone().attr("id",id).attr("menuOne",menu_one_id).addClass("availability-second").show();//克隆二级菜单
	jQuery(menu_two).find("button[name=delTwoBut]").attr("onclick","delSecondTwoMenu(this,'" + id + "')")
	jQuery(aterHtml).after(menu_two);
	
}

//删除二级菜单
delSecondTwoMenu = function(obj, menu_two_id){
	if(confirm("确定删除?")){
		jQuery("#" + menu_two_id).remove();
	}
}

//一级菜单排序
setorder = function(){
	var menuLen = jQuery("#menu_box").find(".availability");
	if(menuLen.length > 0){
		menuLen.each(function(idx,item){
			jQuery(item).find(".label_id").text(idx + 1);
			
		});
	}
}
*/

/*------------------------菜单配置页面 end-------------------------------*/

function goWhiteListConfig(hospitalId , hospitalCode){
	var url  = path + "/sys/whiteListSetings/index?hospitalId=" + hospitalId + "&appCode=wechat&hospitalCode=" + hospitalCode;
	window.location = url;
}

function goExtension(hospitalId , hospitalCode){
	var url  = path + "/sys/extension/index?hospitalId=" + hospitalId + "&appCode=wechat";
	window.location = url;
}

//上传医院logo
$hospital.uploadImg = function()
{
	var src=$('#uploadFile').val();
	if(src!='')
	{
		//异步上传到服务器
		$.ajaxFileUpload(  
		{
			  secureuri:false,  
              fileElementId:'uploadFile',  			
              dataType: 'json',	  
              type:'POST',
			  url: $("#basePath").val() +"/uploading?method=uploadLogo",
			  success:function(resp)
			  {
					if(resp.status=='OK')
					{
						$('#showImg').attr('src', resp.message);
						$('#logo').val(resp.message);
					}
					else if(resp.status=='ERROR')
					{
						window.wxc.xcConfirm(resp.message, window.wxc.xcConfirm.typeEnum.error);
					}
			  }                                                                                                              
		});
	}
}
 
