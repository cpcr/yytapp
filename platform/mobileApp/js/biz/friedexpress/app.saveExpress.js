$(function(){
	var idObj = $("input[name='id']");
	var hospitalIdObj = $("input[name='hospitalId']");
	var platformObj = $("input[name='platform']");
	var openIdObj = $("input[name='openId']");
	var nameObj = $("input[name='name']");
	
	var provinceObj = $("input[name=province]");
	var cityObj = $("input[name=city]");
	var areaObj = $("input[name=area]");
	
	var detailAddrObj = $("input[name='detailAddr']");
	var mobileObj = $("input[name='mobile']");
	var zipCodeObj = $("input[name='zipCode']");
	
	$('.city-select').citySelect();
	var id = idObj.val();

	if(id && id!='') {
		$('.J_city_f').val(provinceObj.val()).trigger('change');
        $('.J_city_s').val(cityObj.val()).trigger('change');
        $('.J_city_t').val(areaObj.val());
	}
	var $AddrFriedExpress = {};
	
	var idxUrl = appPath+"mobileApp/friedExpress/index?openId="+openIdObj.val();
	
	$AddrFriedExpress.init=function(){
		//请输入 提示显示与隐藏
		$("input.yx-input").on("focus",function(){
			$(this).prev().hide();
		});
		$("input.yx-input").on("blur",function(){
			var val = $(this).val();
			if($.trim(val)==""){
				$(this).prev().show();
			}
		});
		
		//地址管理删除或保存事件
		var saveBtn = $("#saveBtn");
		if(saveBtn){
			saveBtn.on("click",function(){
				saveAddr();
			});
		}
		var delBtn = $("#delBtn");
		if(delBtn){
			delBtn.on("click",function(){
				delAddr();
			});
		}
	};
	
	$AddrFriedExpress.loadAddr=function(parentId,level,selectName,fn){
		var url = appPath + "mobileApp/friedExpress/addrDictionary/loadAddr?openId="+openIdObj.val();
		var nextLevel = parseInt(level)+1;
		$.ajax({
			type: 'POST',
			url: url,
			data: {parentId: parentId, level: nextLevel},
			async : false,
			success: function (data) {
				var levlSelectObj = $("select[level='" + nextLevel + "']");
				var optionsStr = '<option value="">请选择</option>';

				var addrs = data.message;
				// var checkFlag = false;
			}
		});
	};
	
	function saveAddr(){
		var id = idObj.val();
		var hospitalId = hospitalIdObj.val();
		var platform = platformObj.val();
		var openId = openIdObj.val();
		var name = nameObj.val();
		
		var province = $('.J_city_f').val();//provinceObj.val();
		var city = $('.J_city_s').val();  //cityObj.val();
		var area = $('.J_city_t').val(); //areaObj.val();
		
		var detailAddr = detailAddrObj.val();
		var mobile = mobileObj.val();
		
		var addrFriedExpressObj = {};
		addrFriedExpressObj.id=id;
		addrFriedExpressObj.hospitalId = hospitalId;
		addrFriedExpressObj.platform = platform;
		addrFriedExpressObj.openId = openId;
		addrFriedExpressObj.name = name;
		addrFriedExpressObj.province = province;
		addrFriedExpressObj.city = city;
		addrFriedExpressObj.area = area;
		addrFriedExpressObj.detailAddr = detailAddr;
		addrFriedExpressObj.mobile = mobile;
		
		//未通过校验,直接返回.
		if(!vaid(addrFriedExpressObj)){
			return;
		}
		
		var saveUrl = appPath + "easyhealth/clinic/saveFriedExpress";
		$.post(saveUrl,addrFriedExpressObj,function(data){
			// showMsg(data.message);
			if(data.status=="OK"){
				window.location.href = appPath + "easyhealth/clinic/toExpress?openId=" + openId+"&hospitalId="+hospitalId;
			}
		},"JSON");
	}
	
	function delAddr(){
		var idObj = $("input[name='id']");
		var delUrl = appPath+"easyhealth/clinic/delFriedExpress?openId="+openIdObj.val();
		new $Y.confirm({
            content:'是否确认删除？',
            ok:{
                title: '确定',
                click:function(){
                	$.post(delUrl,{id:idObj.val()},function(data){
            			if(data.status=="OK"){
            				window.location.href = appPath + "easyhealth/clinic/toExpress?openId=" + openIdObj.val()+"&hospitalId="+hospitalIdObj.val();
            			}
            		},"JSON");
                }
            }
        });
	}
	
	function vaid(addrFriedExpressObj){
		if(isEmpty(addrFriedExpressObj.province)){
			showMsg("请选择省份");
			return false;
		}
		if(isEmpty(addrFriedExpressObj.city)){
			showMsg("请选择城市");
			return false;
		}
		if(isEmpty(addrFriedExpressObj.area)){
			showMsg("请选择县区");
			return false;
		}
		if(isEmpty(addrFriedExpressObj.detailAddr)){
			showMsg("请输入详细地址");
			return false;
		}
		if(!isEmpty(addrFriedExpressObj.zipCode)){
			var reg = /^[1-9][0-9]{5}$/;
			if(!reg.test(addrFriedExpressObj.zipCode)){
				showMsg("请输入正确的邮编");
				return false;
			}
		}
		if(isEmpty(addrFriedExpressObj.name)){
			showMsg("收货人姓名不能为空");
			return false;
		}
		if(isEmpty(addrFriedExpressObj.mobile)){
			showMsg("请输入手机号");
			return false;
		}
		
		var reg = /^1[3|4|5|7|8][0-9]{9}$/;
		if(!reg.test(addrFriedExpressObj.mobile)){
			showMsg("请输入正确的手机号");
			return false;
		}
		
		return true;
	}
	
	function showMsg(msg){
		new $Y.confirm({
			ok:{title:'确定' },
			content:msg
		});
	}
	
	function isEmpty(str){
		if(!str||$.trim(str)==""){
			return true;
		}
		return false;
	}
	
	window.$AddrFriedExpress=$AddrFriedExpress;
	$AddrFriedExpress.init();
});