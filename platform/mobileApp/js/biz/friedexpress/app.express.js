
$(function(){
	var openIdObj = $("input[name='openId']");
	var hospitalIdObj = $("input[name='hospitalId']");
	//---------------用户地址管理-----------------------
	var toAddrFriedExpressUrl = appPath+"easyhealth/clinic/toAddFriedExpress?openId="+openIdObj.val()+"&hospitalId="+hospitalIdObj.val();
	//添加地址事件
	$(".add-btn").on("click",function(){
		window.location.href = toAddrFriedExpressUrl;
	});

	$('.address-detail').on("click",function(){
		$(this).parents("li").find("input").prop('checked', true);
	});
	
	//编辑地址事件
	$(".address-edit").on("click",function(){
		var id = $(this).parents("li").find("input[name='checkAddr']").val();
		toAddrFriedExpressUrl = toAddrFriedExpressUrl+"&id="+id;
		
		window.location.href = toAddrFriedExpressUrl;
	});
	
	$("#btnSave").on("click",function(){
		var checkedAddrObj = $("input[name='checkAddr']:checked");
		if(checkedAddrObj.length == 0){
			if($(".tip")){
				showMsg("请先添加送货地址");
				return;
			}else{
				showMsg("请选择送货地址。");
				return;
			}
		}
		addrFriedExpressId = checkedAddrObj.val();
		window.location.href = appPath + "mobileApp/clinic/payDetail?openId=" + openIdObj.val()+"&hospitalId="+hospitalIdObj.val()+"&friedExpressId="+addrFriedExpressId;
	});
	
	function showMsg(msg){
		new $Y.confirm({
            ok:{title:'确定' },
            content:msg
        });
	}

	// 绑定全局 是否按钮
	$(document).on('click', '.icon-switch', function () {
		if ($(this).hasClass('icon-switch-right')) {
			$(this).removeClass('icon-switch-right')
		} else {
			$(this).addClass('icon-switch-right')
		}
	})
});