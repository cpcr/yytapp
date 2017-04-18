<!DOCTYPE html>
<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>缴费明细</title>
    <style>
    .i_arrow-1 {
        float: right;
        margin:  5px 5px 0 0;
        display: inline-block;
        border: solid #339FEB;
        border-width: 1px 1px 0 0;
        width: 8px;
        height: 8px;
        transform: rotate(45deg);
    }
    .i_ok {
        float: right;
        display: inline-block;
        width: 18px;
        height: 18px;
        background: url(${basePath}mobileApp/images/icon/i-ok.png) no-repeat;
        background-size: 100%;
        vertical-align: -3px;
    }
    .yx-list2 li {
        line-height: 1.5;
        padding: 0;
        margin: 0;
    }
    .yx-list2 p {
        padding: 0;
        overflow: hidden;
    }
</style>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)">
<div id="body">
    <#if commonParams.barcode?exists && commonParams.hospitalCode!="nsqfybjy"
        && commonParams.hospitalCode!="nsqmxbfzy" && commonParams.hospitalCode!="nsqxlrmyy"
        && commonParams.hospitalCode!="nsqrmyy" && commonParams.hospitalCode!="nsqskrmyy"
        && commonParams.hospitalCode!='szsykyync' && commonParams.hospitalCode!='szsykyy'>
        <div class="box-list" style="padding: .5em;">
            <#--<div>-->
                <#--条形码-->
            <#--</div>-->
            <div class="barCode">
                <div id="barcodeTarget" class="barcodeTarget" style="margin: 0 auto;"></div>
            </div>
        </div>
    </#if>

    <div class="box-list">
        <ul class="yx-list">
			<li>
                <div class="label">就诊人</div>
                <#--<div class="values color666">${commonParams.encryptedPatientName}</div>-->
                <div class="values color666">${commonParams.patientName}</div>
            </li>
            <li>
                <div class="label">卡号</div>
                <div class="values color666">${commonParams.cardNo}</div>
            </li>
            <#-- <li>
                <div class="label">处方号</div>
                <div class="values color666">${commonParams.omitMzFeeId}</div>
            </li> -->
            <#if "1" == commonParams.isInsurance>
                <li>
                    <div class="label">自费金额</div>
                    <div class="values color666"><span class="yellow ">${(commonParams.payFee / 100)?string('0.00')}</span> 元</div>
                </li>
                <li>
                    <div class="label">医保金额</div>
                    <div class="values color666"><span class="yellow ">${((commonParams.totalFee-commonParams.payFee) / 100)?string('0.00')}</span> 元</div>
                </li>
                <li>
                    <div class="label">总金额</div>
                    <div class="values color666"><span class="yellow fontSize140">${(commonParams.totalFee / 100)?string('0.00')}</span> 元</div>
                </li>
			<#else>
			<#-- bug:80 缴费成功界面/缴费明细界面显示缴费金额，自费金额，医保金额 -->
			<#--<li>
                <div class="label">统筹金额</div>
                <div class="values color666"><span class="yellow fontSize140">${(commonParams.medicareFee / 100)?string('0.00')}</span> 元</div>
            </li>-->
                <li>
                    <div class="label">付款金额</div>
                    <div class="values color666"><span class="yellow fontSize140">${(commonParams.totalFee / 100)?string('0.00')}</span> 元</div>
                </li>
	        </#if>
            <#if commonParams.clinicStatus == 30>
	            <li>
	                <div class="label">退费金额</div>
	                <div class="values color666"><span class="yellow fontSize140">${(refundFee / 100)?string('0.00')}</span> 元</div>
	            </li>
            </#if>
            <li>
                <div class="label">付款时间</div>
                <div class="values color666"><span class="yellow fontSize140">${commonParams.payTimeStr}</span></div>
            </li>
        </ul>
    </div>


    <#-- 显示取药信息 -->
    <div class="box-list accordion js-accordion">
        <div class="acc-li">
            <div class="acc-header js-acc-header show">门诊温馨提示</div>
            <div class="acc-content show">
                <div class="p" id="clinicTips" style="word-wrap: break-word;">

                </div>
            </div>
        </div>
    </div>

    <#-- 详情 -->
    <div id="paid-detail"></div>
	<#-- 退费成功提示信息 -->
	<div id="paid-cancel-title" class="section">
	<#-- 退费按钮 -->
	<div id="paid-cancel"></div>
</div>
<form id="voForm" method="post">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
	<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
	<input type="hidden" id="cardType" name="cardType" value="${commonParams.cardType}" />
	<input type="hidden" id="cardNo" name="cardNo" value="${commonParams.cardNo}" />
	<input type="hidden" id="patientName" name="patientName" value="${commonParams.patientName}" />
	<input type="hidden" id="payIds" name="payIds" value="" />
	<input type="hidden" id="totalFee" name="totalFee" value="${commonParams.totalFee}" />
	<input type="hidden" id="medicareFee" name="medicareFee" value="${commonParams.medicareFee}" />
	<input type="hidden" id="payFee" name="payFee" value="${commonParams.payFee}" />
	<input type="hidden" id="medicareType" name="medicareType" value="${commonParams.medicareType}" />
	<input type="hidden" id="hisOrdNum" name="hisOrdNum" value="${commonParams.hisOrdNum}" />
	<input type="hidden" id="receiptNum" name="receiptNum" value="${commonParams.receiptNum}" />
	<input type="hidden" id="barcode" name="barcode" value="${commonParams.barcode}" />
	<input type="hidden" id="mzFeeId" name="mzFeeId" value="${commonParams.mzFeeId}" />

	<input type="hidden" id="ownership" name="ownership" value="${commonParams.ownership}" />
    <input type="hidden" id="orderNo" name="orderNo" value="${commonParams.orderNo}" />
    <input type="hidden" id="clinicStatus" name="clinicStatus" value="${commonParams.clinicStatus}" />
    <input type="hidden" id="isSupportFried" name="isSupportFried" value="${commonParams.isSupportFried}" />
    <input type="hidden" id="failMsg" name="failMsg" />
    
    <input type="hidden" id="friedExpress" name="friedExpress" value="${friedExpress}" />
</form>

<#include "/mobileApp/common/yxw_footer.ftl">
<script type="text/javascript" src="${basePath}mobileApp/js/common/nav-list.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery-barcode.min.js"></script>
<script>
	$(function() {
		var hisMessage = decodeURIComponent('${commonParams.hisMessage}');
		var receiptNum = '${commonParams.receiptNum}' ? '收据号：${commonParams.receiptNum}' : '';
		$('#clinicTips').html(hisMessage + '<br />' +  receiptNum);

		loadPaidDetail();

        generateBarcode('${commonParams.barcode}');
	});

	function loadPaidDetail() {
		var datas = $('#voForm').serializeArray();
		var now = new Date();
		var timeTemp = now.getTime();
		var url = '${basePath}mobileApp/clinic/getPaidDetail?timeTemp=' + timeTemp;

		$Y.loading.show('正在为您加载数据');
		$.ajax({
           	type: 'POST',
           	url: url,
           	data: datas,
           	dataType: 'json',
           	timeout: 120000,
           	error: function(data) {
           		$Y.loading.hide();
           		showNoData();
           	},
           	success : function(data) {
           		console.log(data);
           		$Y.loading.hide();
           		if (data.status == 'OK' && data.message) {
           			formatPaidData(data.message);
           		} else {
           			showNoData();
           		}
           	}
    	})
	}

	function formatPaidData(data) {
		if (data.list.length > 0) {
			var sHtml = '';
			
			if(data.friedExpress && data.friedExpress!='') {
			     sHtml += '<div class="box-list accordion js-accordion">';
                sHtml += '<ul id="clinic-list" class="yx-list yx-list2">';
                sHtml += '  <li class="canFried">';
                sHtml += '      <p>是否代煎<i class="i_ok"></p></i>';
                sHtml += '  </li>';
                sHtml += '  <li class="canDeliver">';
                sHtml += '      <p>是否配送<i class="i_ok"></p></i>';
                sHtml += '  </li>';
                sHtml += '  <li class="chooseAddress">';
                sHtml += '      <p style="text-align: center" >'+data.friedExpress+'</p>';
                sHtml += '  </li>';
                sHtml += '</ul>';
                sHtml += '</div>';
			}
			

			// bug:78 本人可以看到缴费明细，他人不允许查看
			if($("#voForm").find("#ownership").val()=="1" || $("#voForm").find("#hospitalCode").val()=="szsykyy"
                || $("#voForm").find("#hospitalCode").val()=="szsykyync" || $("#voForm").find("#hospitalCode").val().indexOf("stdxyxy") >= 0) {

                $.each(data.detailMap, function (recipeId, perDetailMap) {
                    sHtml += '<div class="box-list accordion js-accordion">';
                    if(recipeId&&recipeId!=''&&recipeId!=null&&recipeId!='null'&&recipeId!='----'){
                        sHtml += '<ul class="content3" style="display: -webkit-box;display: -webkit-flex;display: flex;text-align: center;padding:10px 0;background: white">' +
                                '<li class="item" style="-webkit-box-flex: 2;-webkit-flex: 2;flex: 2;">处方号:'+ recipeId +'</li>' +
                                '<li class="item" style="-webkit-box-flex: 1;-webkit-flex: 1;flex: 1;"></li>' +
                                '<li class="item" style="-webkit-box-flex: 1;-webkit-flex: 1;flex: 1;"></li>' +
                                '<li class="item" style="-webkit-box-flex: 1;-webkit-flex: 1;flex: 1;"></li>' +
                                '</ul>';
                    }
                    sHtml += '<ul class="content3" style="display: -webkit-box;display: -webkit-flex;display: flex;text-align: center;padding:10px 0;background: #ccc">' +
                            '<li class="item" style="width:40%">项目</li>' +
                            '<li class="item" style="width:20%; ">数量</li>' +
                            '<li class="item" style="width:20%; ">单价(元)</li>' +
                            '<li class="item" style="width:20%; ">金额(元)</li>' +
                            '</ul>';
                    console.dir(perDetailMap);
                    $.each(perDetailMap, function (key, values) {
                        sHtml += '<div class="acc-li" data-id="' + key + '">';
                        sHtml += '	<div class="acc-header js-acc-header">' + key;

                        var perKeyTotalFee = Number(0);
                        $(values).each(function () {
                            perKeyTotalFee = perKeyTotalFee + Number(this.itemTotalFee / 100);
                        });
                        sHtml += '		(<span class="yellow">' + perKeyTotalFee.toFixed(2) + '</span>元)';

                        sHtml += '	</div>';

                        if ($("#voForm").find("#ownership").val() == "1" || $("#voForm").find("#hospitalCode").val()=="stdxyxyfsdyyy") {
                            sHtml += '	<ul class="acc-content">';

                            $(values).each(function () {
                                sHtml += '		<li class="item">';
                                sHtml += '<div class="acc-li" data-id="' + this.itemId + '">';
                                sHtml += '	<ul style="display: -webkit-box;display: -webkit-flex;display: flex; padding: 10px 5px;">';
                                sHtml += '		<li style="text-align: left; width:40%">';
                                sHtml += this.itemName;
                                sHtml += '		</li>';
                                sHtml += '		<li style="width:20%; text-align: center;">';
                                sHtml += (this.itemNumber ? this.itemNumber : '---');
                                sHtml += '		</li>';
                                sHtml += '		<li style="width:20%; text-align: right;">';
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

			$('#paid-detail').html('');
			$('#paid-detail').append(sHtml);
		} else {
			showNoData();
		}

        if(data.isRefundSuccess == '1'){
            $('#paid-cancel-title').html('<div class="box-tips"> <i class="icon-warn"></i>费用已被退回,请注意查收.</div>');
        }

		if(data.isShowCancelClinic == '1' && data.isRefundSuccess == '0'){
            $('#paid-cancel').html('<button type="button" class="btn btn-ok btn-block" id="refundBtn" onclick="refundConfirm(this)">退费</button>');
		}
	}

    function refundConfirm(domObj){
        var myBox = new $Y.confirm({
            content:'<div>您是否真的要退费？</div>',
            ok:{
                title:"确定",
                click:function(){ //参数可为空，没有默认方法,不会自动关闭窗体，可用  myBox.close()来关闭
                    myBox.close();
                    refundClinicConfirm(domObj);
//                    alert('退费成功');
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

    function refundClinicConfirm(domObj){
        $(domObj).attr("disabled",true);
        $Y.loading.show("退费中,请等待..");
        $Y.mask.show();
        var datas = $("#voForm").serializeArray();
        var url = appPath + "mobileApp/clinic/refundClinicConfirm"
        $.ajax({
            type : 'POST',
            url : url,
            data : datas,
            dataType : 'json',
            timeout:120000,
            success : function(data) {
                $Y.loading.hide();

                if (data.message.refundIsSuccess) {
                    //第3方退费成功
//                    $("#voForm").attr("action" , appPath + "mobileApp/clinic/paidDetail");
//                    $("#voForm").submit();
                    $('#paid-cancel-title').html('<div class="box-tips"> <i class="icon-warn"></i>费用已被退回,请注意查收.</div>');
                    $('#paid-cancel').html('');
                } else {
                    //第3方退费失败
                    $Y.loading.hide();
                    $Y.mask.remove();
                    var refundErrorMsg = new $Y.confirm({
                        content:'<div>' + data.message.msgInfo + '</div>',
                        ok:{title: '确定'}
                    });
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

	function showNoData() {
		var sHtml = '';

		sHtml += '<ul id="clinic-list" class="yx-list">';
		sHtml += '	<li class="noData">';
	    sHtml += '  	<p class="color666" style="text-align: center">没有查到您的已缴费明细信息。</p>';
	    sHtml += '	</li>';
	    sHtml += '</ul>';

		$('#paid-detail').html('');
		$('#paid-detail').append(sHtml);
		$('#paid-detail').addClass('boxLi');
	}

	function generateBarcode(cardNo) {
		// 内容
		var value = cardNo;
		// 码制（看医院）
		var codeStyle = '${rule.barcodeStyle}';
		var btype = '';
		switch (codeStyle) {
			case '1':
				btype = 'ean8';
				break;
			case '2':
				btype = 'upc';
				break;
			case '3':
				btype = 'code39';
				break;
			case '4':
				btype = 'code128';
				break;
			case '5':
				btype = 'codabar';
				break;
			default:
				btype = 'code128';
		}

        // 类型（固定）
        var renderer = 'css';

        var settings = {
          output:renderer,
          bgColor: '#FFFFFF',
          color: '#000000',
          barWidth: 2,
          barHeight: 50,
          moduleSize: 5,
          posX: 10,
          posY: 20,
          addQuietZone: false
        };
        
        $("#barcodeTarget").html("").show().barcode(value, btype, settings);
	};
	
	function doRefresh()
	{
		loadPaidDetail();
		/*var freshForm=$("<form></form>");
		freshForm.append($('<input type="hidden" name="hospitalId" value="${commonParams.hospitalId}"/>'));
		freshForm.append($('<input type="hidden" name="hospitalCode" value="${commonParams.hospitalCode}"/>'));
		freshForm.append($('<input type="hidden" name="hospitalName" value="${commonParams.hospitalName}"/>'));
		freshForm.append($('<input type="hidden"  name="cardNo" value="${commonParams.cardNo}">'));
		freshForm.append($('<input type="hidden"  name="cardType" value="${commonParams.cardType}">'));
		freshForm.append($('<input type="hidden"  name="patientName" value="${commonParams.patientName}">'));
		freshForm.append($('<input type="hidden" name="mzFeeId" value="${commonParams.mzFeeId}"/>'));
		freshForm.append($('<input type="hidden" name="payFee" value="${commonParams.payFee}"/>'));
		freshForm.append($('<input type="hidden" name="totalFee" value="${commonParams.totalFee}"/>'));
		freshForm.append($('<input type="hidden" name="medicareFee" value="${commonParams.medicareFee}"/>'));
		freshForm.append($('<input type="hidden" name="medicareType" value="${commonParams.medicareType}"/>'));
		freshForm.append($('<input type="hidden" name="hisOrdNum" value="${commonParams.hisOrdNum}"/>'));
		freshForm.append($('<input type="hidden" name="orderNo" value="${commonParams.orderNo}"/>'));
		freshForm.append($('<input type="hidden" name="clinicStatus" value="${commonParams.clinicStatus}"/>'));
		freshForm.append($('<input type="hidden" name="receiptNum" value="${commonParams.receiptNum}"/>'));
		freshForm.append($('<input type="hidden" name="hisMessage" value="${commonParams.hisMessage}"/>'));
		freshForm.append($('<input type="hidden" name="barcode" value="${commonParams.barcode}"/>'));
		freshForm.append($('<input type="hidden" name="branchHospitalCode" value="${commonParams.branchHospitalCode}"/>'));
		freshForm.appendTo("body");
		freshForm.css('display','none');
		freshForm.attr("method","post");
		freshForm.attr("action","${basePath}mobileApp/clinic/paidDetail");
		freshForm.submit();*/
	}
	
/*	function doGoBack()
	{
		var freshForm=$("<form></form>");
		freshForm.append($('<input type="hidden" name="openId" value="${commonParams.openId}"/>'));
		freshForm.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}"/>'));
		freshForm.appendTo("body");
		freshForm.css('display','none');
		freshForm.attr("method","post");
		freshForm.attr("action","${basePath}mobileApp/clinic/paidIndex");
		freshForm.submit();
	}*/
</script>
</body>
</html>