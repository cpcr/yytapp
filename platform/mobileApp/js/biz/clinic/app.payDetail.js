
var payDetail = {
    loadData: function () {
        var now = new Date();
        var timeTemp = now.getTime();
        var url = appPath + "mobileApp/clinic/getPayDetail?timeTemp=" + timeTemp;
        var datas = $("#voForm").serializeArray();
        $Y.loading.show('正在为您加载数据');
        $.ajax({
            type: 'POST',
            url: url,
            data: datas,
            dataType: 'json',
            timeout: 120000,
            error: function (data) {
                $Y.loading.hide();
                //payDetail.showNoData();
                $('#voForm').attr('action', appPath + 'mobileApp/clinic/payDetail?timeTemp=' + timeTemp);
                $('#voForm').submit();
            },
            success: function (data) {
                $Y.loading.hide();
                if (data.status == 'OK' && data.message) {
                	$('#payFamilyId').val(data.message.familyId);
                	
                	var isSupportFried = $('#isSupportFried').val();
                	if (isSupportFried != '1') {
                		payDetail.formatData(data.message);
                	} else {
                		payDetail.formatDataFriedExpress(data.message);
                	}
                	
                	var sHtml = '';
                	// 添加医保结算
                    var supportMedicare = $('#supportMedicare').val();
                    if (supportMedicare && supportMedicare == '1') {
                        sHtml += '<div class="box-list switch">';
                        sHtml += '	<ul class="yx-list">';
                        sHtml += '	  <li>';
                        sHtml += '	    <div class="label">是否进行医保结算</div>';
                        sHtml += '      <div class="values"><i class="icon-switch" onclick="payDetail.calcMedicareFee(this);"></i></div>';
                        sHtml += '    </li>';
                        sHtml += '	</ul>';
                        sHtml += '</div>';
                    }

                    var appCode = $('#appCode').val();
                    if (isShowTradeMode == 1 && appCode == 'easyHealth') {
                        sHtml += '<div class="easyHealthTradeMode">';
                        sHtml += '	<div class="page-title" style="margin-left: 1em;">支付方式</div>';
                        sHtml += '	<div class="box-list radio-list" id = "easyHealthPay">';
                        sHtml += '		<ul class="yx-list">';

                        // 支付信息
                        if ($('#isViewHealthCard').val() == '1') {
                            sHtml += '			<li ' + ($('#isUseHealthCardTrade').val() == '0' ? 'class="disable"' : '') + ' data-value="7" id="trade_7">';
                            sHtml += '				<div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>健康卡</div>';
                            sHtml += '			</li>';
                        }

                        if ($('#isViewAlipay').val() == '1') {
                            sHtml += '			<li ' + ($('#isUseAlipayTrade').val() == '0' ? 'class="disable"' : '') + ' data-value="4" id="trade_4">';
                            sHtml += '				<div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>支付宝</div>';
                            sHtml += '			</li>';
                        }

                        if ($('#isViewWeiXin').val() == '1') {
                            sHtml += '			<li ' + ($('#isUseWeiXinTrade').val() == '0' ? 'class="disable"' : '') + ' data-value="3" id="trade_3">';
                            sHtml += '				<div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>微信</div>';
                            sHtml += '			</li>';
                        }

                        
                        if ($('#isViewInsuranceHealthCard').val() == '1') {
                            sHtml += '			<li ' + ($('#isUseInsuranceHealthCardTrade').val() == '0' ? 'class="disable"' : '') + ' data-value="8" id="trade_8">';
                            sHtml += '				<div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>医保卡</div>';
                            sHtml += '			</li>';
                        }

                        if ($('#isViewUnionpay').val() == '1') {
                            sHtml += '			<li ' + ($('#isUseUnionpayTrade').val() == '0' ? 'class="disable"' : '') + ' data-value="5" id="trade_5">';
                            sHtml += '				<div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>银联卡</div>';
                            sHtml += '			</li>';
                        }

                        if ($('#isViewCITICBank').val() == '1') {
                            sHtml += '			<li ' + ($('#isUseCITICBankTrade').val() == '0' ? 'class="disable"' : '') + ' data-value="9" id="trade_9">';
                            sHtml += '				<div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>中信银行卡</div>';
                            sHtml += '			</li>';
                        }

                        sHtml += '		</ul>';
                        sHtml += '	</div>';
                        sHtml += '</div>';

                        data - pay
                    }

                    // 添加支付按钮
                    if ($("#voForm").find("#ownership").val() != "1") {
                    	sHtml += '<div class="section btn-w">';
                        sHtml += '	<div class="btn btn-ok btn-block" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)" onclick="payDetail.pay();">去支付</div>';
                        sHtml += '</div>';
                    } else {
	                    var canUseInsuranceVal = $("#canUseInsurance").val();
	                    if (canUseInsuranceVal && canUseInsuranceVal == "0") {// 自费单，不能医保支付
	                        sHtml += '<div class="section btn-w">';
	                        sHtml += '	<div class="btn btn-ok btn-block" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)" onclick="payDetail.pay();">去支付</div>';
	                        sHtml += '</div>';
	                    } else {// 可医保支付
	                        sHtml += '<div class="section btn-w" style="text-align: center">';
	
	                        var onlyUseInsurance = $("#onlyUseInsurance").val();
	                        if(onlyUseInsurance && onlyUseInsurance == "1"){
	                            sHtml += '	<div class="btn btn-ok btn-block" style="width: 59%; display: inline-block;" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)" onclick="payDetail.toMedicarePay();">医保支付</div>';
	                            sHtml += '</div>';
	                        }else if(onlyUseInsurance && onlyUseInsurance == "2"){
	                            sHtml += '	<div class="btn btn-ok btn-block" style="background-color: #ff9400;width: 35%;border-color: #ff9400;display: inline-block;margin-right: 10px;" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)" onclick="payDetail.pay();">全额自费</div>';
	                            sHtml += '</div>';
	                        }else{
	                            sHtml += '	<div class="btn btn-ok btn-block" style="background-color: #ff9400;width: 35%;border-color: #ff9400;display: inline-block;margin-right: 10px;" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)" onclick="payDetail.pay();">全额自费</div>';
	                            sHtml += '	<div class="btn btn-ok btn-block" style="width: 59%; display: inline-block;" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)" onclick="payDetail.toMedicarePay();">医保支付</div>';
	                            sHtml += '</div>';
	                        }
	                    }
                    }

                    $('#pay-detail').append(sHtml);

                    // 设置默认的支付方式
                    var defaultTradeMode = $('#defaultTradeType').val();
                    if (defaultTradeMode) {
                        if (!$('#trade_' + defaultTradeMode).hasClass('disable')) {
                            $('#trade_' + defaultTradeMode).addClass('active');
                        }
                    }
                	
                    //假如是从挂号成功后跳转过来，则显示提示时间范围内必须支付
                    if(data.message.isRegPayFrom != null && data.message.isRegPayFrom == '1'){
                        $('#pay-detail-title').html('<div class="box-tips"> <i class="icon-warn"></i>请在' + data.message.outTimeSecond + '分钟内完成支付，否则该挂号被取消.</div>');
                    }
                } else {
                    payDetail.showNoData();
                }
            }
        });
    },
    formatData: function (data) {
        if (data.list.length > 0) {
            var sHtml = '';
            // bug:78 本人可以看到缴费明细，他人不允许查看
            // if ($("#voForm").find("#ownership").val() == "1") {
            if($("#voForm").find("#ownership").val()=="1" || $("#voForm").find("#hospitalCode").val()=="szsykyy"
                || $("#voForm").find("#hospitalCode").val()=="szsykyync" || $("#voForm").find("#hospitalCode").val().indexOf("stdxyxy") >= 0) {

                $.each(data.detailMap, function (recipeId, perDetailMap) {
                    sHtml += '<div class="box-list accordion js-accordion">';
                    if(recipeId&&recipeId!=''&&recipeId!=null&&recipeId!='null'&&recipeId!='----'){
                        sHtml += '<ul class="content3" style="text-align: left;padding:10px;background: white">' +
                            '<li class="item"><span>处方号:'+ recipeId +'</span></li>' +
                            '</ul>';
                    }
                    sHtml += '<ul class="content3" style="display: -webkit-box;display: -webkit-flex;display: flex;text-align: center;padding:10px 0;background: #ccc">' +
                        '<li class="item" style="width:40%">项目</li>' +
                        '<li class="item" style="width:20%; ">数量</li>' +
                        '<li class="item" style="width:20%; ">单价(元)</li>' +
                        '<li class="item" style="width:20%; ">金额(元)</li>' +
                        '</ul>';
                    $.each(perDetailMap, function (key, values) {

                        sHtml += '<div class="acc-li" data-id="' + key + '">';
                        sHtml += '	<div class="acc-header js-acc-header">' + key

                        var perKeyTotalFee = Number(0);
                        $(values).each(function () {
                            perKeyTotalFee = perKeyTotalFee + Number(this.itemTotalFee / 100);
                        });
                        sHtml += '		(<span class="yellow">' + perKeyTotalFee.toFixed(2) + '</span>元)';
                        sHtml += '	</div>';
                        if ($("#voForm").find("#ownership").val() == "1" || $("#voForm").find("#hospitalCode").val()=="stdxyxyfsdyyy") {
                            sHtml += '	<ul class="acc-content" >';

                            $(values).each(function () {
                                sHtml += '		<li class="item">';
                                sHtml += '<div class="acc-li" data-id="' + this.itemId + '">';
                                sHtml += '	<ul style="display: -webkit-box;display: -webkit-flex;display: flex; padding: 10px 5px;">';
                                sHtml += '		<li style=" text-align: left; width:40%">';
                                sHtml += this.itemName;
                                sHtml += '		</li>';
                                sHtml += '		<li style="width:20%; text-align: center;">';
                                sHtml += (this.itemNumber ? this.itemNumber : '---');
                                sHtml += '		</li>';
                                sHtml += '		<li style="width:20%; text-align: right;"> ';
                                sHtml += (this.itemPrice ? (Number(this.itemPrice / 100).toFixed(2) ) : '---');
                                sHtml += '		</li>';
                                sHtml += '		<li style="width:20%; text-align: right;">';
                                sHtml += '<span class="yellow">' + Number(this.itemTotalFee / 100).toFixed(2) + '</span>';
                                sHtml += '		</li>';
                                sHtml += '	</ul>';
                                sHtml += '</div>';
                                sHtml += '		</li>';
                            });

                            sHtml += '	</ul>';
                        }
                        sHtml += '</div>';
                    });
                    sHtml += '</div>';
                });
            } else {
                sHtml += '<div class="box-list accordion js-accordion">';
                sHtml += '<ul id="clinic-list" class="yx-list">';
                sHtml += '  <li class="noData">';
                sHtml += '      <p class="color666" style="text-align: center">为了保护患者数据，暂时不支持查看他人处方明细</p>';
                sHtml += '  </li>';
                sHtml += '</ul>';
                sHtml += '</div>';
            }
            
            $('#pay-detail').html('');
            $('#pay-detail').append(sHtml);
        } else {
            payDetail.showNoData();
        }
    },
    formatDataFriedExpress: function(data) {
    	if (data.resultData.recipes.length > 0) {
    		$("#voForm").find("#recipeId").val(data.friedRecipeId);
    		$("#payForm").find("#recipeId").val(data.friedRecipeId);
    		
			// 代煎配送--------------------------------------
			var canFried = data.resultData.canFried;
			var canDeliver = data.resultData.canDeliver;
			// ----------------------------------------------

			var sHtml = '';
			
			if(canFried == '1' && canDeliver == '1') {
				sHtml += '<div class="box-list accordion js-accordion">';
	            sHtml += '<ul id="clinic-list" class="yx-list yx-list2">';
	            sHtml += '  <li class="canFried">';
	            sHtml += '      <p>是否代煎<i class="i_ok"></i></p>';
	            sHtml += '  </li>';
	            sHtml += '  <li class="canDeliver">';
	            sHtml += '      <p>是否配送<i class="i_ok"></i></p>';
	            sHtml += '  </li>';
	            sHtml += '  <li class="chooseAddress">';
	            
	            var friedExpress = $("#friedExpress").val();
	            	if(friedExpress && friedExpress!='') {
	            		sHtml += '      <p style="text-align: center; color: #339FEB" onclick="payDetail.toFriedExpress();">'+friedExpress+' <i class="i_arrow-1"></i></p>';
	            	} else {
	            		sHtml += '      <p style="color: #339FEB" onclick="payDetail.toFriedExpress();">请选择配送地址 <i class="i_arrow-1"></i></p>';
	            	}
	            	
	            sHtml += '  </li>';
	            sHtml += '</ul>';
	            sHtml += '</div>';
			}
			
            // bug:78 本人可以看到缴费明细，他人不允许查看
            // if ($("#voForm").find("#ownership").val() == "1") {
            if($("#voForm").find("#ownership").val()=="1" || $("#voForm").find("#hospitalCode").val()=="szsykyy"
                || $("#voForm").find("#hospitalCode").val()=="szsykyync" || $("#voForm").find("#hospitalCode").val()=="stdxyxyfsdyyy") {

                $.each(data.resultData.recipes, function (i, item) {
                    sHtml += '<div class="box-list accordion js-accordion">';
                    if(item.recipeId&&item.recipeId!=''&&item.recipeId!=null&&item.recipeId!='null'&&item.recipeId!='----'){
                        sHtml += '<ul class="content3" style="text-align: left;padding:10px;background: white">' +
                            '<li class="item"><span>处方号:'+ item.recipeId +'</span></li>' +
                            '</ul>';
                    }
                    sHtml += '<ul class="content3" style="display: -webkit-box;display: -webkit-flex;display: flex;text-align: center;padding:10px 0;background: #ccc">' +
                        '<li class="item" style="width:40%">项目</li>' +
                        '<li class="item" style="width:20%; ">数量</li>' +
                        '<li class="item" style="width:20%; ">单价(元)</li>' +
                        '<li class="item" style="width:20%; ">金额(元)</li>' +
                        '</ul>';
//		                    $.each(perDetailMap, function (key, values) {
                    $.each(item.recipeDetails, function(key, values) {
                        sHtml += '<div class="acc-li" data-id="' + this.itemId + '">';
                        sHtml += '	<div class="acc-header js-acc-header">' + this.itemName

                        var perKeyTotalFee = Number(0);
                        $(values).each(function () {
                            perKeyTotalFee = perKeyTotalFee + Number(this.itemTotalFee / 100);
                        });
                        sHtml += '		(<span class="yellow">' + perKeyTotalFee.toFixed(2) + '</span>元)';
                        sHtml += '	</div>';
                            sHtml += '	<ul class="acc-content" >';

                            $(values).each(function () {
                                sHtml += '		<li class="item">';
                                sHtml += '<div class="acc-li" data-id="' + this.itemId + '">';
                                sHtml += '	<ul style="display: -webkit-box;display: -webkit-flex;display: flex; padding: 10px 5px;">';
                                sHtml += '		<li style=" text-align: left; width:40%">';
                                sHtml += this.itemName;
                                sHtml += '		</li>';
                                sHtml += '		<li style="width:20%; text-align: center;">';
                                sHtml += (this.itemNumber ? this.itemNumber : '---');
                                sHtml += '		</li>';
                                sHtml += '		<li style="width:20%; text-align: right;"> ';
                                sHtml += (this.itemPrice ? (Number(this.itemPrice / 100).toFixed(2) ) : '---');
                                sHtml += '		</li>';
                                sHtml += '		<li style="width:20%; text-align: right;">';
                                sHtml += '<span class="yellow">' + Number(this.itemTotalFee / 100).toFixed(2) + '</span>';
                                sHtml += '		</li>';
                                sHtml += '	</ul>';
                                sHtml += '</div>';
                                sHtml += '		</li>';
                            });

                            sHtml += '	</ul>';
                        sHtml += '</div>';
                    });
                    sHtml += '</div>';
                });
            } else {
                sHtml += '<div class="box-list accordion js-accordion">';
                sHtml += '<ul id="clinic-list" class="yx-list">';
                sHtml += '  <li class="noData">';
                sHtml += '      <p class="color666" style="text-align: center">为了保护患者数据，暂时不支持查看他人处方明细</p>';
                sHtml += '  </li>';
                sHtml += '</ul>';
                sHtml += '</div>';
            }

            $('#pay-detail').html('');
            $('#pay-detail').append(sHtml);
        } else {
            payDetail.showNoData();
        }
    },
    calcMedicareFee: function (obj) {
        if ($(obj).hasClass('icon-switch-right')) {
            $(obj).removeClass('icon-switch-right');
        } else {
            $(obj).addClass('icon-switch-right');
        }
    },
    pay: function () {
    	var friedExpress = $("#friedExpress").val();
    	var recipeId = $("#voForm").find("#recipeId").val();
    	if(recipeId && recipeId!='' && (!friedExpress || friedExpress=='')) {
    		new $Y.confirm({
    			ok:{title:'确定' },
    			content:"请选择配送地址"
    		});
    		return;
    	}
        // 健康易需要选择tradeMode
        if (isShowTradeMode == 1) {
            var easyHealthPay = $("#easyHealthPay");
            if (easyHealthPay) {
                var tradeMode = -1;
                $("#easyHealthPay li").each(function () {
                    if ($(this).hasClass("active")) {
                        tradeMode = $(this).attr("data-value");
                    }
                });

                if (tradeMode == -1) {
                    new $Y.confirm({
                        ok: {title: '确定'},
                        content: '该医院暂未开通手机支付，请到医院窗口进行缴费。'
                    });
                    return;
                }

                $("#tradeMode").val(tradeMode);
            }
        }
        var appCode = $('#appCode').val();
        $Y.loading.show('正在生成订单，请稍后...');
        var url = appPath + 'mobileApp/clinic/generateOrder';
        var datas = $('#voForm').serializeArray();
        $.ajax({
            type: 'POST',
            url: url,
            data: datas,
            dataType: 'json',
            timeout: 120000,
            error: function (data) {
                $Y.loading.hide();
                payDetail.showNoData();
            },
            success: function (data) {
                $Y.loading.hide();
                if (data.status == 'OK' && data.message) {
                    // 下面是本机测试使用
                    if (data.message.tradeUrl && appCode == "easyHealth") {
                        $("#payForm").attr('action', data.message.tradeUrl);
                    }
                    $("#payForm").initFormData(data.message.pay);
                    // 测试异常使用
                    // $("#notifyMethodName").val("pangziInvoke");
                    $("#payForm").submit();
                } else {
                    new $Y.confirm({
                        ok: {title: '确定'},
                        content: '网络异常，订单生成失败，请稍后重试。'
                    });
                }
            }
        });
    },

    toMedicarePay:  function () {
    	var friedExpress = $("#friedExpress").val();
    	var recipeId = $("#voForm").find("#recipeId").val();
    	if(recipeId && recipeId!='' && (!friedExpress || friedExpress=='')) {
    		new $Y.confirm({
    			ok:{title:'确定' },
    			content:"请选择配送地址"
    		});
    		return;
    	}
    	
        var appId = $("#voForm input[name='appId']").val();
        var hospitalAppId = $("#hospitalAppId").val();
        var query = appPath + "mobileApp/medicalcard/bind/queryauthrize?createandpay_source_flag=1&appId=" + appId + "&hospitalAppId=" + hospitalAppId;
        window.location.href = query;
    },

    medicarePay: function () {
        // 健康易需要选择tradeMode
        if (isShowTradeMode == 1) {
            var easyHealthPay = $("#easyHealthPay");
            if (easyHealthPay) {
                var tradeMode = -1;
                $("#easyHealthPay li").each(function () {
                    if ($(this).hasClass("active")) {
                        tradeMode = $(this).attr("data-value");
                    }
                });
                if (tradeMode == -1) {
                    new $Y.confirm({
                        ok: {title: '确定'},
                        content: '该医院暂未开通手机支付，请到医院窗口进行缴费。'
                    });
                    return;
                }
                $("#tradeMode").val(tradeMode);
            }
        }
        var appCode = $('#appCode').val();
        $Y.loading.show('正在生成订单，请稍后...');
        var url = appPath + 'mobileApp/clinic/generateOrder';
        var datas = $('#voForm').serializeArray();
        $.ajax({
            type: 'POST',
            url: url,
            data: datas,
            dataType: 'json',
            timeout: 120000,
            error: function (data) {
                $Y.loading.hide();
                payDetail.showNoData();
            },
            success: function (data) {
                $Y.loading.hide();
                if (data.status == 'OK' && data.message) {
                    $("#payForm").attr('action', $("#medicarePayUrl").val());
                    $("#payForm").initFormData(data.message.pay);
                    $("#cancelBillNoVOO").val(data.message.cancelBillNo);
                    $("#cancelSerialNoVOO").val(data.message.cancelSerialNo);
                    $("#sSBillNoVOO").val(data.message.sSBillNo);
                    $("#sSFeeNoVOO").val(data.message.sSFeeNo);
                    $("#mzFeeIdVOO").val(data.message.mzFeeId);
                    $("#mzBillIdVOO").val(data.message.mzBillId);
                    $("#payForm").submit();
                } else {
                    new $Y.confirm({
                        ok: {title: '确定'},
                        content: "医院预结算失败，请到线下窗口缴费"
                    });
                }
            }
        });
    },

    showNoData: function () {
        var sHtml = '';

        sHtml += '<ul id="clinic-list" class="yx-list">';
        sHtml += '	<li class="noData">';
        sHtml += '  	<p class="color666" style="text-align: center">没有查到您的缴费明细信息</p>';
        sHtml += '	</li>';
        sHtml += '</ul>';

        // 添加支付按钮
        sHtml += '<div class="section btn-w">';
        sHtml += '	<div class="btn btn-ok btn-block" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)" onclick="payDetail.pay();">确认缴费</div>';
        sHtml += '</div>';

        $('#pay-detail').html('');
        $('#pay-detail').append(sHtml);
        $('#pay-detail').addClass('boxLi');
    },
    initEasyHealthTradeMode: function () {
        // 显示了，就是健康易
        if (isShowTradeMode == 1) {
            // 默认选中4，健康易支付宝
            $("#voForm").find("#tradeMode").val($('#defaultTradeType').val());
        }
    },
    toFriedExpress:  function () {
        var openId = $("#openId").val();
        var hospitalId = $("#hospitalId").val();
        var query = appPath + "easyhealth/clinic/toExpress?openId=" + openId+"&hospitalId="+hospitalId+"&orderNo="+orderNo;
        window.location.href = query;
    },
};

$.fn.initFormData = function (data) {
    return this.each(function () {
        if (!data || data == 'null') {
            // 将值重置为默认值
            this.reset();
            return;
        }

        $.each($(this).children(), function (i, item) {
            if (data[item.name] && data[item.name] != 'null') {
                $(item).val(data[item.name]);
            }
        });
    });
};

var isShowTradeMode = $('#isShowTradeMode').val();

$(function () {
    payDetail.initEasyHealthTradeMode();
    payDetail.loadData();

    /**
     * bug:38 自费单不允许选择医保支付
     */
    // if ($("#voForm").find("#canUseInsurance").val() == "0") {
    //     $("#ybDiv").hide();
    // }
    // if ($("#voForm").find("#ownership").val() != "1") {
    //     $("#ybDiv").hide();
    // }
});
