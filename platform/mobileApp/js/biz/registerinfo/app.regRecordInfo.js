function cancelRegister(domObj){
	$(domObj).attr("disabled",true);
    $Y.loading.show();
    $Y.mask.show();
    var datas = $("#paramsForm").serializeArray(); 
	var url = appPath + "mobileApp/register/infos/checkCanCancelReg";
	$.ajax({  
		type : 'POST',  
	    url : url,  
	    data : datas,  
	    dataType : 'json',  
	    timeout:120000,
	    success : function(data) { 
	    	$Y.loading.hide();
	    	if(data.message.isSuccess){
	    		$("#paramsForm").attr("action" , appPath + "mobileApp/register/infos/cancelRegister");
	    	    $("#paramsForm").submit();
	    	}else{
	    		$Y.mask.remove();
	    		var refundWarnMsg = new $Y.confirm({
	                content:'<div>' + data.message.msgInfo + '</div>',
	                ok:{title: '确定'}
	            }); 
	    		$(domObj).attr("disabled",false);
	    	}
	    },  
	    error : function(data) {  
	    	$Y.loading.hide();
	    	$Y.mask.remove();
	    	var refundErrorMsg = new $Y.confirm({
                content:'<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                ok:{title: '确定'}
            })
	    	$(domObj).attr("disabled",false);
	    }  
	 }); 
}

function goRegInfoList(){
	var appCode = jQuery("#appCode").val();
	if(appCode == "easyHealth"){
		if(IS.isMacOS){
			appCloseView();
		}else if(IS.isAndroid){
			yyc.appCloseView();
		}
	}else{
		try{
			WeixinJSBridge.invoke('closeWindow',{},function(res){});
		}catch(e){
			AlipayJSBridge.call('closeWebview');
		}
	}
}

function payMentReg(domObj){
	$(domObj).attr("disabled",true);
	$Y.loading.show("请求提交中");
	if(isCanPayMent == 'false' || $('#leftSecondSpan').text() == "00:00"){
		$Y.loading.hide();
		var tipMsg = new $Y.confirm({
            content:'<div>支付时间已过,该订单已过期.</div>',
            ok:{title: '确定'}
        })
		$(domObj).attr("disabled",false);
		return;
	}
	var url = appPath + "mobileApp/register/infos/checkCanPayMent";
	var datas = $("#paramsForm").serializeArray();
	$.ajax({  
		type : 'POST',  
	    url : url,  
	    data : datas,  
	    dataType : 'json',  
	    timeout:120000,
	    success : function(data) { 
	    	$Y.loading.hide();
	    	if(data.message.isSuccess){
	    		$("#payForm").submit();
	    	}else{
	    		var payMentWarnMsg = new $Y.confirm({
	                content:'<div>' + data.message.msgInfo + '</div>',
	                ok:{title: '确定'}
	            }); 
	    		$(domObj).attr("disabled",false);
	    	}
	    },  
	    error : function(data) {  
	    	$Y.loading.hide();
	    	var refundErrorMsg = new $Y.confirm({
                content:'<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                ok:{title: '确定'}
            })
	    	$(domObj).attr("disabled",false);
	    }  
	}); 
}

function payMentRegMedical(domObj, orderNo) {
	$(domObj).attr("disabled", true);
	$Y.loading.show("请求提交中");
	var url = appPath + "mobileApp/register/infos/checkCanPayMentMedical";
	var datas = $("#paramsForm").serializeArray();
	$.ajax({
		type: 'POST',
		url: url,
		data: datas,
		dataType: 'json',
		timeout: 120000,
		success: function (data) {
			$Y.loading.hide();
			if (data.message.isSuccess) {
				// $("#payForm").submit();
				var query = appPath + "mobileApp/medicalcard/bind/queryauthrize?appId=" + $("#appId").val() + "&hospitalAppId=" + $("#hospitalAppId").val() + "&isReserveMedical=true&orderNo=" + orderNo;
				window.location.href = query;
				// $("#paramsForm").attr("action", appPath + "mobileApp/register/confirm/registerInfo");
				// $("#paramsForm").submit();
			} else {
				new $Y.confirm({
					content: '<div>' + data.message.msgInfo + '</div>',
					ok: {title: '确定'}
				});
				$(domObj).attr("disabled", false);
			}
		},
		error: function (data) {
			$Y.loading.hide();
			new $Y.confirm({
				content: '<div>网络异常，请保持您的网络通畅，稍后再试</div>',
				ok: {title: '确定'}
			})
			$(domObj).attr("disabled", false);
		}
	});
}

function refundConfirm(domObj){
     var myBox = new $Y.confirm({
    	content:'<div>您是否真的要取消预约？</div>',
		ok:{
			title:"确定",
			click:function(){ //参数可为空，没有默认方法,不会自动关闭窗体，可用  myBox.close()来关闭  
				myBox.close();
				refundRegConfirm(domObj);
			}
		},
		cancel:{                   
			title:"取消",
			click:function(){       //参数可为空, 当为空时默认方法关闭窗体
				myBox.close();
			}
		},
		callback:function(){ 
		//窗体显示后的回调
		}
     })
}
     
function refundRegConfirm(domObj){
	$(domObj).attr("disabled",true);
	$Y.loading.show("取消预约中,请等待..");
	$Y.mask.show();
	var datas = $("#paramsForm").serializeArray(); 
	var url = appPath + "mobileApp/register/infos/refundRegConfirm"
	$.ajax({  
		type : 'POST',  
	    url : url,  
	    data : datas,  
	    dataType : 'json',  
	    timeout:120000,
	    success : function(data) { 
	    	$Y.loading.hide();
	    	//退费确认是否成功
	    	if(data.message.isSuccess){
	    		//$("#refundForm").formEdit(data.message.refund);
                //$("#refundForm").submit();
	    		
	    		if(data.message.isSuccess){
	    			//第3方退费成功
	    			url = appPath + "mobileApp/register/infos/refundSuccess";
	    			$("#paramsForm").attr("action" , url);
	    			$("#paramsForm").submit();
	    		}else{
	    			//第3方退费失败
	    			url = appPath + "mobileApp/register/infos/refundException";
	    			$("#paramsForm").attr("action" , url);
	    			$("#failMsg").val(data.message.failMsg);
	    			$("#paramsForm").submit();
	    		}
	    	}else{
	    		$Y.mask.remove();
	    		var refundWarnMsg = new $Y.confirm({
	                content:'<div>' + data.message.msgInfo + '</div>',
	                ok:{title: '确定'}
	            }); 
	    		$(domObj).attr("disabled",false);
	    	}
	    },  
	    error : function(data) {  
	    	$Y.loading.hide();
	    	$Y.mask.remove();
	    	var refundErrorMsg = new $Y.confirm({
                content:'<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                ok:{title: '确定'}
            })
	    	$(domObj).attr("disabled",false);
	    }  
	 }); 
}

$.fn.formEdit = function(data){
    return this.each(function(){
        var elementDom;
        var elementDomName;
        if(data == null){
        	this.reset(); 
        	return; 
        }
        for(var i = 0; i < this.length; i++){  
        	elementDom = this.elements[i];
        	elementDomName = elementDom.name;
            if(data[elementDomName] == undefined){ 
            	continue;
            }
            elementDom.value = data[elementDomName];
        }
    });
};

jQuery(function(){
	var leftSecondDom = $('#leftSecond');
    if(leftSecondDom){
    	var leftSecond = leftSecondDom.val();
        if(leftSecond <= 0){
            $('#leftSecond').val(0);
            $('#leftSecondSpan').text("00:00");
            $('#payBtn').unbind("click");//禁用
        }else{
            $('#leftSecondSpan').text(secondToMin(leftSecond));
            setTimeout(djs, 1000);
        }
    }
});

//倒计时
function djs() {
    var leftSecond = $('#leftSecond').val() - 1;
    if (leftSecond > 0) {
        $('#leftSecond').val(leftSecond);
        $('#leftSecondSpan').text(secondToMin(leftSecond));
        setTimeout(djs, 1000);
    } else {
        $('#leftSecond').val(0);
        $('#leftSecondSpan').text("00:00");
        $('#payBtn').unbind("click");//禁用
    }
}

function secondToMin(leftSecond){
    var min = 0;
    var second = 0;
    if(leftSecond > 60){
        var min = parseInt(leftSecond/60);
        var second = parseInt(leftSecond%60);
        if(min < 10){
            min = "0" + min;
        }
        if(second < 10){
            second = "0" + second;
        }
    }else{
        var second = leftSecond%60;
        if(second < 10){
            second = "0" + second;
        }
        min = "00";
    }
    return min + ":" + second;
}

function goDidipasnger(){
	if(IS.isMacOS){ 
		appCallOtherApp("didipasnger");
	}else if(IS.isAndroid){
		window.yx129.appCallOtherApp("com.sdu.didi.psnger");
	}
}

/**
 * 预约挂号取消预约
 * @param obj
 */
function cancelReserveRegister() {
	var myBox = new $Y.confirm({
		content: '<div>您是否真的要取消预约？</div>',
		ok: {
			title: "确定",
			click: function () {
				myBox.close();
				doCancelReserveRegister();
			}
		},
		cancel: {
			title: "取消",
			click: function () {       //参数可为空, 当为空时默认方法关闭窗体
				myBox.close();
			}
		}
	});
}

/**
 * 执行预约挂号取消预约
 * @param obj
 */
function doCancelReserveRegister() {
	$Y.loading.show("取消预约中，请等待...");
	var datas = $("#paramsForm").serializeArray();
	var url = appPath + "mobileApp/register/infos/doCancelReserveRegister"
	$.ajax({
		type: 'POST',
		url: url,
		data: datas,
		dataType: 'json',
		timeout: 120000,
		success: function (data) {
			$Y.loading.hide();
			var thisBox = new $Y.confirm({
				content: '<div>' + data.message.msgInfo + '</div>',
				ok: {
					title: '确定',
					click: function () {
						if (data.message.isSuccess) {
							$("#paramsForm").attr("action" , appPath + "mobileApp/register/infos/showOrderInfo");
							$("#paramsForm").submit();
						} else {
							thisBox.close();
						}
					}
				}
			});
			// if (data.message.isSuccess) {
			// 	window.location.reload(true);
			// 	if (data.message.isSuccess) {
			// 		//第3方退费成功
			// 		url = appPath + "mobileApp/register/infos/refundSuccess";
			// 		$("#paramsForm").attr("action", url);
			// 		$("#paramsForm").submit();
			// 	} else {
			// 		//第3方退费失败
			// 		url = appPath + "mobileApp/register/infos/refundException";
			// 		$("#paramsForm").attr("action", url);
			// 		$("#failMsg").val(data.message.failMsg);
			// 		$("#paramsForm").submit();
			// 	}
			// }
		},
		error: function (data) {
			$Y.loading.hide();
			new $Y.confirm({
				content: '<div>网络异常，请保持您的网络通畅，稍后再试</div>',
				ok: {title: '确定'}
			})
		}
	});
}
