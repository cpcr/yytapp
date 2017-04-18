//预约中
var STATE_NORMAL_HAVING = 0;
//已预约
var STATE_NORMAL_HAD = 1;

var PLATFORM_TYPE_EASYHEALTH = "easyHealth";
var PLATFORM_TYPE_ALIPAY = "alipay";
var PLATFORM_TYPE_WECHAT = "wechat";

// 记录绑卡数据
var cards = {};

$(function () {
    loadMedicalCards();
    initBindCardCss();
    
    var activeDom = $('#cardInfos .active');
    if($(activeDom).attr('familyid')) {
    	$("#familyId").val($(activeDom).attr('familyid'));
    	$("#payFamilyId").val($(activeDom).attr('familyid'));
    }
});

function loadMedicalCards() {
    var now = new Date();
    var timeTemp = now.getTime();
    var hospitalId = $("#hospitalId").val();
    var hospitalName = $('#hospitalName').val();
    var branchId = $("#branchHospitalId").val();
    var openId = $("#openId").val();
    var userId = $("#userId").val();
    var hospitalCode = $("#hospitalCode").val();
    var branchCode = $("#branchHospitalCode").val();
    var branchHospitalName = $('#branchHospitalName').val();
    var openId = $("#openId").val();
    var appId = $("#appId").val();
    var appCode = $("#appCode").val();
    var reqUrl = appPath + "mobileApp/common/findAllCards?timeTemp=" + timeTemp;
    var datas = {
        appId: appId,
        appCode: appCode,
        branchId: branchId,
        openId: openId,
        userId: userId,
        hospitalCode: hospitalCode,
        branchCode: branchCode,
        hospitalId: hospitalId,
        hospitalName: hospitalName,
        branchHospitalName: branchHospitalName
    };

    $Y.loading.show('加载就诊人信息,请等待..')
    $.ajax({
        type: 'POST',
        url: reqUrl,
        data: datas,
        dataType: 'json',
        timeout: 120000,
        success: function (data) {
            $Y.loading.hide()
            console.log(data);
            if (data.message) {
                cards = data.message;
                initCards();
            } else {

            }
        },
        error: function (data) {
            $Y.loading.hide()
            var actionURL = appPath + 'mobileApp/register/confirm/registerInfo?timeTemp=' + timeTemp;
            $('#paramsForm').attr('action', actionURL);
            $('#paramsForm').submit();
        }
    });
}

function initCards() {
    $.each(cards, function (i, item) {
        var obj = $('#familyId_' + item.familyId);
        if (obj) {
            console.log('familyId=' + item.familyId + ', cardNo=' + item.cardNo);
            var element = $(obj).find('.label');
            if (element.hasClass('hasButton')) {
                element.removeClass('hasButton');
                element.addClass('hasNoButton');
            }
            $(obj).find('.cardTips').text('');
            $(obj).find('.patCardNo').html(item.cardNo);
            $(obj).find('.btn-bingka').hide();
            var userId = item.cardType + ":" +
                item.ownership + ":" +
                item.cardNo + ":" +
                item.name + ":" +
                item.sex + ":" +
                item.mobile + ":" +
                item.idType + ":" +
                item.idNo;
            $(obj).attr('cardId', userId);
        }
    });
    $('#cardInfos').show();
}

function changePayType(domObj) {
    var obj = $(domObj).find('i').first();
    if (obj.hasClass('icon-switch-right')) {
        obj.removeClass('icon-switch-right');
    } else {
        obj.addClass('icon-switch-right');
    }
}

/*
 function autoBindCard() {
 var now = new Date();
 var timeTemp = now.getTime();
 var hospitalId = $("#hospitalId").val();
 var hospitalName = $('#hospitalName').val();
 var branchId = $("#branchHospitalId").val();
 var openId = $("#openId").val();
 var hospitalCode = $("#hospitalCode").val();
 var branchCode = $("#branchHospitalCode").val();
 var branchHospitalName = $('#branchHospitalName').val();
 var openId = $("#openId").val();
 var appId = $("#appId").val();
 var appCode = $("#appCode").val();

 var reqUrl = appPath + "mobileApp/common/autoBindCard?timeTemp=" + timeTemp;
 var datas = {
 appId:appId,
 appCode:appCode,
 branchId:branchId,
 openId:openId,
 hospitalCode:hospitalCode,
 branchCode:branchCode,
 hospitalId:hospitalId,
 hospitalName: hospitalName,
 branchHospitalName: branchHospitalName
 };

 $Y.loading.show('正在进行绑卡操作，请稍后...')
 $.ajax({  
 type : 'POST',  
 url  : reqUrl,  
 data : datas,  
 dataType : 'json',  
 timeout  : 120000,
 success  : function(data) { 
 $Y.loading.hide();
 console.log(data);
 if (data.status == 'OK' && data.message.isSuccess == '0') {
 // 重新加载就诊人信息
 loadMedicalCards();
 } else {
 $Y.loading.hide();
 new $Y.confirm({
 ok: {title:'确定'},
 content: '一键绑卡失败，请稍后重试，或者手动添加就诊人。'
 });
 }
 },
 error : function(data) {  
 $Y.loading.hide();
 new $Y.confirm({
 ok: {title:'确定'},
 content: '一键绑卡失败，请稍后重试，或者手动添加就诊人。'
 });
 }
 });
 }
 */

function changeActive(domObj) {
    var activeDom = $('#cardInfos .active');
    if (activeDom) {
        activeDom.removeClass('active');
        $(domObj).addClass('active');
        // var idVal = domObj.id.split(":");
        if($(domObj).attr('familyid')) {
        	$("#familyId").val($(domObj).attr('familyid'));
        	$("#payFamilyId").val($(domObj).attr('familyid'));
        }
        if ($(domObj).attr('cardId')) {
            var idVal = $(domObj).attr('cardId').split(":");
            $("#cardType").val(idVal[0]);
            $("#regPersonType").val(idVal[1]);
            $("#cardNo").val(idVal[2]);
            $("#patientName").val(idVal[3]);
            $("#patientSex").val(idVal[4]);
            $("#patientMobile").val(idVal[5]);
            $("#idType").val(idVal[6]);
            $("#idNo").val(idVal[7]);
        }

        /**
         * bug:39 挂号他人不允许选择医保结算
         */
        if ($(domObj).attr('ownership')) {
            var ownershipVal = $(domObj).attr('ownership');
            if (ownershipVal != "1") {
                $("#ybDiv").hide();
            } else {
                $("#ybDiv").show();
            }
        }
    }
}
//根据选择进行医保卡支付，或者生成订单分流
function chooceYb(domObj) {

    var obj = $(domObj).find('i').first();
    if (obj.hasClass('icon-switch-right')) {
        obj.removeClass('icon-switch-right');

        /**
         * bug:48 确认挂号页面选择使用医保卡支付后，需要禁用“确认挂号”按钮
         */
        $("#registerDiv").show();

        $("#addCardLi").show();
        
        var query = appPath + "/mobileApp/register/confirm//registerInfo"//tradeMode=5&appCode="+$("#appCode").val()+"&tradeUrl="+$("tradeUrl").val();

        window.location.href = query;
    } else {
        obj.addClass('icon-switch-right');
        
        /**
         * bug:48 确认挂号页面选择使用医保卡支付后，需要禁用“确认挂号”按钮
         */
        $("#registerDiv").hide();
        
        $("#addCardLi").hide();
        
        var query = appPath + "mobileApp/medicalcard/bind/queryauthrize?appId=" + $("#appId").val()+"&hospitalAppId="+$("#hospitalAppId").val();//tradeMode=5&appCode="+$("#appCode").val()+"&tradeUrl="+$("tradeUrl").val();

        window.location.href = query;
    }
//	if(flag=="1"){
//		confirmRegisterMedicare(domObj);
//	}else{
//		confirmRegister(domObj);
//	}
}
//医保卡效验
function confirmRegisterMedicare(domObj) {
    //进入医保卡效验环节\
    $("#diseaseDesc").val($("#diseaseDesc_input").val());
    var query = appPath + "mobileApp/medicalcard/bind/queryauthrize?tradeMode=5&datas=" + $("#paramsForm").serializeArray() + "&appCode=" + $("#appCode").val() + "&tradeUrl=" + $("tradeUrl").val() + "&appId=" + $("#appId").val()+"&hospitalAppId="+$("#hospitalAppId").val();
    /* $.ajax({
     type : 'POST',
     url  : query,
     dataType : 'json',
     timeout  : 120000,
     success  : function(data){
     if(data.status == 'OK'){
     confirmRegister(domObj);
     }else{
     //如果没有绑定，那么提示是否绑定
     if(confirm('是否绑定医保卡')){
     window.location=appPath + "mobileApp/medicalcard/bind/medicarePayBind";   
     }
     }
     }
     });*/
    window.location = query;
}

function reserveMedicalPay(domObj, orderNo) {
    $Y.loading.show('订单确认中，请等待...')
    var reqUrl = appPath + "mobileApp/register/confirm/reserveMedicalConfirm";
    var datas = $("#paramsForm").serializeArray();
    var obj = new Object();
    obj.name = "orderNo";
    obj.value = orderNo;
    datas.push(obj);
    $.ajax({
        type: 'POST',
        url: reqUrl,
        data: datas,
        dataType: 'json',
        timeout: 120000,
        success: function (data) {
            $Y.loading.hide()
            if (data.message.isSuccess) {
                $("#payForm").formEdit(data.message.pay);
                $("#payForm").submit();
            } else {
                $Y.mask.remove();
                msgBox = new $Y.confirm({
                    content: '<div>' + data.message.msgInfo + '</div>',
                    ok: {title: '确定'}
                })
                $(domObj).attr("disabled", false);
            }
        },
        error: function (data) {
            $Y.loading.hide()
            $Y.mask.remove();
            errorBox = new $Y.confirm({
                content: '<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                ok: {title: '确定'}
            })
            $(domObj).attr("disabled", false);
        }
    });
}

//生成订单进入订单详情，并且支付
function confirmRegister(domObj) {
    //病区号源
    if($('#isBqReg').val() == 'true'){
        if(!checkCaptcha($('#captcha_input').val())){
            $('#captcha_title').css("color","red");
            $('#captcha_title').html("验证码错误");
            return;
        }

        $('#bqyzm').val($('#captcha_input').val());
    }

    $(domObj).attr("disabled", true);
    $Y.loading.show('号源确认中，请等待..')
    $Y.mask.show();


    var activeDom = $('#cardInfos .active');
    var appCode = $("#appCode").val();
    if (activeDom && activeDom[0] != undefined) {
        // var idVal = activeDom[0].id.split(":");
        if ($(activeDom[0]).attr('cardId')) {
            var idVal = $(activeDom[0]).attr('cardId').split(":");
            $("#cardType").val(idVal[0]);
            $("#regPersonType").val(idVal[1]);
            $("#cardNo").val(idVal[2]);
            $("#patientName").val(idVal[3]);
            $("#patientSex").val(idVal[4]);
            $("#patientMobile").val(idVal[5]);
            $("#idType").val(idVal[6]);
            $("#idNo").val(idVal[7]);
        } else {
            $Y.loading.hide();
            $Y.mask.remove();
            var noaddpatient = new $Y.confirm({
                content: '<div>该用户并没有关联就诊卡，请先关联就诊卡。</div>',
                ok: {title: '确定'}
            })
            $(domObj).attr("disabled", false);
            return;
        }
    } else {
        $Y.loading.hide();
        $Y.mask.remove();
        var noaddpatient = new $Y.confirm({
            content: '<div>请添加就诊人.</div>',
            ok: {title: '确定'}
        })
        $(domObj).attr("disabled", false);
        return;
    }

    var isPayDom = $("#isPayFlag");
    if (isPayDom) {
        if (isPayDom.hasClass('icon-switch-right')) {
            $("#isPay").val(1);
        } else {
            $("#isPay").val(0);
        }
    }

    /**
     * bug:47 挂号付款提交会显示两个00
     */
    //$Y.loading.show("00");
    $("#diseaseDesc").val($("#diseaseDesc_input").val());
    var reqUrl = appPath + "mobileApp/register/confirm/generateOrder";
    var appCode = $("#appCode").val();
    var tradeMode;
    if (appCode == PLATFORM_TYPE_EASYHEALTH) {
        $("#appPay li").each(function () {
            if ($(this).hasClass("active")) {
                tradeMode = $(this).attr("val");
            }
        });
        if (tradeMode == "" || tradeMode == undefined) {
            $Y.loading.hide();
            $Y.mask.remove();
            var noaddtradeMode = new $Y.confirm({
                content: '<div>抱歉，该医院未开通在线支付，请到医院窗口挂号。</div>',
                ok: {title: '确定'}
            })
            $(domObj).attr("disabled", false);
            return;
        }
    } else if (appCode == PLATFORM_TYPE_ALIPAY) {
        tradeMode = 4;
    } else if (appCode == PLATFORM_TYPE_WECHAT) {
        tradeMode = 3;
    }
    var obj = $("#isybFlag").find('i').first();

    //alert(obj.hasClass('icon-switch-right')+"1");
    if (obj.hasClass('icon-switch-right')) {
        ;
        $("#tradeMode").val(tradeMode);
        //obj.removeClass('icon-switch-right');
    } else {

        tradeMode = 5;
        $("#tradeMode").val(tradeMode);
    }


    var datas = $("#paramsForm").serializeArray();
    $.ajax({
        type: 'POST',
        url: reqUrl,
        data: datas,
        dataType: 'json',
        timeout: 120000,
        success: function (data) {
            $Y.loading.hide()
            if (data.message.isSuccess) {
                // 是否是预约医保单
                if (data.message.isReserveRegisterMedical && data.message.isReserveRegisterMedical == "bingo") {
                    // window.location = appPath + "mobileApp/register/confirm/reserve/medical/result?reserveOrderNo=" + data.message.reserveOrderNo + "&openId=" + data.message.openId;
                    window.location = appPath + "mobileApp/register/infos/showOrderInfo?orderNo=" + data.message.orderNo
                        + "&userId=" + data.message.userId + "&openId=" + data.message.openId + "&timeTemp=" + Date.parse(new Date());
                } else {
                    if (data.message.currentRegStatus == STATE_NORMAL_HAD) {
                        if (data.message.currentIsPay == 0 || data.message.currentIsPay === undefined) {
                            var currentRegOrderNo = data.message.currentRegOrderNo;
                            var currentOpenId = data.message.currentOpenId;
                            window.location = appPath + "mobileApp/register/infos/showOrderInfo?reqSource=confirmReg&orderNo=" + currentRegOrderNo + "&openId=" + currentOpenId + "&isInsurance=" + isInsurance;
                        } else {
                            $("#payForm").formEdit(data.message.pay);
                            if (data.message.tradeUrl != "" && appCode == "easyHealth") {
                                $("#payForm").attr("action", data.message.tradeUrl);
                            }
                            $("#payForm").submit();
                        }
                    } else {
                        // $("#isInsurance").val(isInsurance);
                        //$("#medicalCardNo").val(medicalCardNo);
                        //$("#medicareCardNo").val(medicareCardNo);
                        //$("#org_no").val(org_no);
                        //$("#org_name").val(org_name);
                        $("#payForm").formEdit(data.message.pay);
                        if (data.message.tradeUrl != "" && appCode == "easyHealth") {
                            $("#payForm").attr("action", data.message.tradeUrl);
                        }
                        $("#payForm").submit();
                    }
                }
            } else {
                $Y.mask.remove();
                msgBox = new $Y.confirm({
                    content: '<div>' + data.message.msgInfo + '</div>',
                    ok: {title: '确定'}
                })
                $(domObj).attr("disabled", false);
            }
        },
        error: function (data) {
            $Y.loading.hide()
            $Y.mask.remove();
            errorBox = new $Y.confirm({
                content: '<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                ok: {title: '确定'}
            })
            $(domObj).attr("disabled", false);
        }
    });
}

function addFamily() {
    var familyNumbers = Number($('#familyNumbers').val());
    var curFamilySize = $('#cardInfos ._family').length;
    console.log('最多: ' + familyNumbers + ", 当前：" + curFamilySize);

    if (curFamilySize >= familyNumbers + 1) {
        // 最多只能绑定那么多个
        new $Y.confirm({
            content: '<div>每个用户最多可以绑定' + familyNumbers + '个就诊人。</div>',
            ok: {title: '确定'}
        });
    } else {
        console.log('可以绑就诊人');
        // 跳转绑定就诊人的界面。
        $('#forward').val(appPath + 'mobileApp/register/confirm/registerInfo');
        $('#paramsForm').attr('action', appPath + 'easyhealth/usercenter/myFamily/addMyFamily');
        $('#paramsForm').submit();
    }
}

//edit by dengsw at 20160621
function syncCard(obj) {
	$('.addCard').removeClass('none');
	var parentObj = $(obj).parent();
	$('#familyId').val($(parentObj).attr('familyId'));
    $('#syncType').val($(parentObj).attr('ownership'));
	selectOnHospital(fromHospitalName);
}


function bindCard(obj) {
    var parentObj = $(obj).parent();
    $('#familyId').val($(parentObj).attr('familyId'));
    /*
     // 使用goUrl的方式过去，绑定后，跳回这个页面，并自动刷新。
     var url = '${basePath}easyhealth/usercenter/medicalcard/index' + 
     '?appId=' + $('#appId').val() + 
     '&appCode=' + $('#appCode').val() + 
     '&openId=' + $('#openId').val() +  
     '&areaCode=' + $('#areaCode').val() + 
     '&familyId=' + $('#familyId').val() + 
     '&hospitalId=' + $('#hospitalId').val() + 
     '&hospitalCode=' + $('#hospitalCode').val();
     console.log(url);
     go(url);
     */
    $('#forward').val(appPath + 'mobileApp/register/confirm/registerInfo');
    $('#paramsForm').attr('action', appPath + 'easyhealth/usercenter/medicalcard/index');
    $('#paramsForm').submit();
}

/*
 function addMedicalCard(){
 $Y.loading.show('正在进行绑卡检测');

 var url = appPath + "mobileApp/common/whetherCanBindCard";
 var datas = $("#paramsForm").serializeArray();
 $.ajax({
 type : 'POST',  
 url : url,  
 data : datas,  
 dataType : 'json',  
 timeout:120000,
 error: function(data) {
 $Y.loading.hide();
 new $Y.confirm({
 ok: {title:'确定'},
 content: '网络异常，无法进行绑卡操作'
 });
 },
 success : function(data) {
 console.log(data);
 $Y.loading.hide();
 if (data.status == 'OK') {
 if (data.message.canBindCard == '1') {
 $("#paramsForm").attr("action" ,appPath + "mobileApp/medicalcard/bind/toView");
 $("#diseaseDesc").val($("#diseaseDesc_input").val());
 var openId = $("#openId").val();
 $("#forward").val(appPath + "mobileApp/register/confirm/addCardSuccess?openId=" + openId);
 $("#bindCardType").val(data.message.bindCardType ? data.message.bindCardType : '0');
 $("#paramsForm").submit();
 } else {
 new $Y.confirm({
 ok: {title:'确定'},
 content: '每个账号只可以添加' + data.message.maxCardCount + '张就诊人就诊卡。'
 });
 }
 } else {
 new $Y.confirm({
 ok: {title:'确定'},
 content: '网络异常，无法进行绑卡操作'
 });
 }
 }
 });
 }
 */

function addTradeMode(tradeMode) {
    $("#paramsForm").find("#tradeMode").val(tradeMode);
}

$.fn.formEdit = function (data) {
    return this.each(function () {
        var elementDom;
        var elementDomName;
        if (data == null) {
            this.reset();
            return;
        }
        for (var i = 0; i < this.length; i++) {
            elementDom = this.elements[i];
            elementDomName = elementDom.name;
            if (data[elementDomName] == undefined) {
                continue;
            }
            elementDom.value = data[elementDomName];
        }
    });
};

function doRefresh() {
    $Y.loading.show('订单重载中...');
    setTimeout("$Y.loading.hide()", 500);
}


function initBindCardCss(){
	var nowSelect,
	$addCard = $('.addCard'),
	$blackWrapper = $('.blackWrapper');

	
	//下拉框触发
	$('.contanier').on('click', '.isSelect', function() {
		var list = $(this).data('list').split('|'),
			_html = '';
		list.forEach(function(item) {
			ary = item.split(':'),
			_html += '<li key="' + ary[0] + '">' + ary[1] + '</li>';
		});
		$blackWrapper.removeClass('none').find('.selectList').html(_html);
		nowSelect = $(this);
	});
	//下拉框弹出
	$blackWrapper.on('click', '.selectCancle', function() {
		$blackWrapper.addClass('none');
	}).on('click', 'li', function() {
		nowSelect[nowSelect.is('input') ? 'val' : 'text']($(this).text());
		nowSelect.attr('key',$(this).attr('key'));
		($('#isCard').val() == '有' ? $('#idNum') : $('#city')).parents('li').removeClass('none')[$('#isCard').val() == '有' ? 'next' : 'prev']().addClass('none');
		$blackWrapper.addClass('none');
		changeCardNoBySelectH($(this).attr('key'));
	});
}


function changeCardNoBySelectH(data){
	$('#idNum').val('');
	var dataArr=data.split(',');
	if(dataArr[0]&&dataArr[0]!=''){
		$('#appId').val(dataArr[0]);
	}
	if(dataArr[1]&&dataArr[1]!=''){
		$('#appCode').val(dataArr[1]);
	}
	if(dataArr[2]&&dataArr[2]!=''){
		$('#hospitalName').val(dataArr[2]);
	}
	if(dataArr[3]&&dataArr[3]!=''){
		$('#hospitalId').val(dataArr[3]);
	}
	if(dataArr[4]&&dataArr[4]!=''){
		$('#hospitalCode').val(dataArr[4]);
	}

    //是否有就诊卡选择标示
    var hasCard=$('#isCard').attr('key');
    if(!isCard||isCard==''){
        $Y.tips('请选择是否有就诊卡');
        return;
    }
    $('#hasCard').val(hasCard);
	
	var datas=$('#paramsForm').serializeArray();
	$.ajax({
        type: "POST",
        url: appPath+"easyhealth/usercenter/syncCard/syncMedicalcardNewest?isQueryCardNo=Y",
        data: datas,
        cache: false,
        dataType: "json",
        timeout: 30000,
        error: function (data) {
            
        },
        success: function (data) {
            if (data.status == 'OK') {
                if(data.message.filingState){
                    $("#isCard").removeClass("isSelect");
                }else{
                    $("#isCard").addClass("isSelect");
                }

                if(data.message.isCardNo=='Y' && data.message.cardNo && data.message.cardNo!='null'){
                	$('#idNum').val(data.message.cardNo);
                }
            }
        }
    });
}
    	
    
function addSyncCard(){
	var dataStr=$('#hospitalLists').attr('key');
	if(!dataStr||dataStr==''){
		$Y.tips('请选择医院');
		return;
	}
	var dataArr=dataStr.split(',');
	if(dataArr[0]&&dataArr[0]!=''){
		$('#appId').val(dataArr[0]);
	}
	if(dataArr[1]&&dataArr[1]!=''){
		$('#appCode').val(dataArr[1]);
	}
	if(dataArr[2]&&dataArr[2]!=''){
		$('#hospitalName').val(dataArr[2]);
	}
	if(dataArr[3]&&dataArr[3]!=''){
		$('#hospitalId').val(dataArr[3]);
	}
	if(dataArr[4]&&dataArr[4]!=''){
		$('#hospitalCode').val(dataArr[4]);
	}
	
	var hasCard=$('#isCard').attr('key');
	if(!isCard||isCard==''){
		$Y.tips('请选择是否有就诊卡');
		return;
	}
	$('#hasCard').val(hasCard);
	if(hasCard==0){//没有就诊卡
		var address=$('#city').val();
		if(!address||address==''){
			$Y.tips('请输入城市');
			return;
		}else{
			$('#address').val(address);
		}
	}else{
		var medicalcardId=$('#idNum').val();
		if(!medicalcardId||medicalcardId==''){
			$Y.tips('请输入就诊卡号');
			return;
		}else{
			$('#medicalcardId').val(medicalcardId);
		}
	}
	var datas=$('#paramsForm').serializeArray();
	$.ajax({
        type: "POST",
        url: appPath+"easyhealth/usercenter/syncCard/syncMedicalcardNewest",
        data: datas,
        cache: false,
        dataType: "json",
        timeout: 30000,
        error: function (data) {
            enableShellButtonEvent = true;
            new $Y.confirm({
                ok: {title: '确定'},
                content: '网络超时，请稍后在我的就诊人查看绑定结果。'
            });
            $(obj).attr('disabled', false);

            tipsElement.removeClass('color999');
            tipsElement.addClass('red');
            tipsElement.text('关联失败');
            $(obj).hide();
            $(obj).siblings('.btn-async').show();
        },
        success: function (data) {
            console.log(data);
            enableShellButtonEvent = true;
            if (data.status == 'OK') {
                var isSuccess = data.message.isSuccess;
                if (isSuccess == 0) {
                	$Y.tips('添加成功！');
                	$('.addCard').addClass('none');
                	location.reload();
                } else {
                	$Y.tips('添加失败！');
                }
            } else if(data.status == 'PROMPT'){
            	$Y.tips(data.message);
            } else {
            	$Y.tips('添加失败！');
            }
        }
    });
}


function selectOnHospital(hospitalname){
	$('#hospitalLists').click();
    $('.selectList li').each(function(i,e){
      $e = $(e);
      if($e.text() == hospitalname){ 
        $e.click();
        return;
      }
    });
}

//校验验证码
function checkCaptcha() {
    return true;
}