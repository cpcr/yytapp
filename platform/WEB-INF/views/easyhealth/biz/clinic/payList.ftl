<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<title>门诊缴费</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
	<div id="">
        <div class="screeningBox">
            <ul class="yx-list">
                <li class="flex">
                    <div class="flexItem">
                        <label><span class="text" id="family" data-id="" data-userId=""></span>
                        <select name="familyFilter" id="familyFilter" class="select-screen-box" onchange="selectScreening(this); changeFamily(this); setOwnership(this)">
                            <#list families as item>
                            <option value="${item.id}" ownership="${item.ownership}" userId="${item.userId}">${item.encryptedName}(<#if item.ownership != 3>${item.encryptedIdNo}<#else>儿童</#if>)</option>
                            </#list>
                        </select>
                            <i class="iconfont"></i>
                        </label>
                    </div>
                    <div class="flexItem">
                        <label><span class="text" id="hospital" data-id=""></span>
                        <select name="hospitalFilter" id="hospitalFilter" class="select-screen-box" onchange="selectScreening(this); changeHospital(this);">
                            <option value="0">全部医院</option>
                            <#list hospitals as item>
                            <option value="${item.hospitalCode}">${item.hospitalName}</option>
                            </#list>
                        </select>
                            <i class="iconfont"></i>
                        </label>
                    </div>
                </li>
            </ul>
        </div>
        <div class="space15"></div>
        
        <ul class="yx-list fourList" style="display: none;" id="paymentList">
               
            </ul>
            
            <div class="noRecord" id="noRecord" style="display: none;">
		        <div id="success">
		            <div class="noticeEmpty"></div>
		            <div class="p color666">已关联的医院中，没有查询到您的任何待缴费项目</div>
		        </div>
		    </div>
        
        <div class="noFamily" id="noFamily" style="display: none;">
	        <div id="success">
	            <div class="noData"></div>
	            <div class="p color666" id="noCardTips"></div>
	        </div>
	        <div class="btn-w">
	            <div class="btn btn-ok btn-block" id="sync" onclick="syncCard();">去绑卡</div>
	        </div>
	    </div>
    </div>
    <#--
    <div class="btn-w">
    	<div class="btn btn-ok btn-block" onclick="doGoBack();">返回</div>
    	<div class="btn btn-ok btn-block" onclick="doRefresh();">刷新</div>
    </div>
    -->
</div>
<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
	<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
	<input type="hidden" id="familyId" name="familyId" value="">
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
	<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
	<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
	<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="" />
	<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="" />
	<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="" />
	<input type="hidden" id="cardType" name="cardType" value="${commonParams.cardType}" />
	<input type="hidden" id="cardNo" name="cardNo" value="${commonParams.cardNo}" />
	<input type="hidden" id="patientName" name="patientName" value="" />
	<input type="hidden" id="mzFeeId" name="mzFeeId" value="" />
	<input type="hidden" id="totalFee" name="totalFee" value="" />
	<input type="hidden" id="payFee" name="payFee" value="" />
	<input type="hidden" id="medicareFee" name="medicareFee" value="" />
	<input type="hidden" id="medicareType" name="medicareType" value="" />
	<input type="hidden" id="deptName" name="deptName" value="" />
	<input type="hidden" id="doctorName" name="doctorName" value="" />
	<input type="hidden" id="patientMobile" name="patientMobile" value="" />
	<input type="hidden" id="visitWay" name="visitWay" value="${commonParams.visitWay}" />
	<input type="hidden" id="accountAmout" name="accountAmout" value="" />
	<input type="hidden" id="insuranceAmout" name="insuranceAmout" value="" />
	
	<#--
	<input type="hidden" id="forwardUrl" name="forwardUrl" value="${basePath}easyhealth/clinic/payIndex" />
	-->
	<input type="hidden" id="ssBillNumber" name="ssBillNumber" value="" />
	<input type="hidden" id="ssFeeNo" name="ssFeeNo" value="" />
	<input type="hidden" id="mzBillId" name="mzBillId" value="" />
	<input type="hidden" id="cancelSerialNo" name="cancelSerialNo" value="" />
	<input type="hidden" id="cancelBillNo" name="cancelBillNo" value="" />

	<input type="hidden" id="deptCode" name="deptCode" value="" />
	<input type="hidden" id="doctorCode" name="doctorCode" value="" />

	<input type="hidden" id="recipeType" name="recipeType" value="" />
	<input type="hidden" id="recipeId" name="recipeId" value="" />
	
	<input type="hidden" id="canUseInsurance" name="canUseInsurance" value="" />
	
	<input type="hidden" id="syncType" name="syncType" value="">
</form>
	<input type="hidden" id="moduleName" name="moduleName" value="门诊待缴费" />
    <input type="hidden" id="cardsList" name="cardsList" value="${cardsList}" />
    <input type="hidden" id="isFromNew" name="isFromNew" value="${isFromNew}" />
    <input type="hidden" id="isClinic" name="isClinic" value="true" />
<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script src="${basePath}easyhealth/js/biz/commonQuery/eh.commonQuery.js?v=1.73" type="text/javascript"></script>
<script>
    var globalMark = '';
    var hasDate = 'false';
    function loadData() {
        globalMark = new Date().getTime();
        hasDate = 'false';
        $Y.loading.show('正在加载数据...');
        for(var i=0;i<selectCards.length;i++) {
           batchLoadData(selectCards[i], globalMark, i);
        }       
    }
    
    function getAllCardsNew() {
    var cardsList = eval('${cardsList}');
    if (cardsList && cardsList.length > 0) {
        cards = cardsList;
        // 过滤数据
        var cardNo = $('#cardNo').val();
        var hospitalCode = $('#hospitalCode').val();
        if (cardNo && cardNo!='' && hospitalCode && hospitalCode!='') {
            filterCardByCardNoAndHospitalCode();
            getAllCardsAfter();
        } else {
            var isFromNew = $('#isFromNew').val();
            if (isFromNew && isFromNew == 'false') {
                loadLastHospital($("#familyFilter").find("option:selected").attr("userId"));
            }
        }
    } else {
        showHasNoCard();
    }
}
    
    function afterLoadData() {
        if(hasDate != 'true') {
           showHasNoData();
        }
    }
    
    function batchLoadData(scards, mark, fornum) {
        var datas = $('#voForm').serializeArray();
        var cards = {};
        cards.name = "cards";
        cards.value = "["+JSON.stringify(scards)+"]";
        datas.push(cards);
        var marks = {};
        marks.name = "mark";
        marks.value = mark;
        datas.push(marks);
        
        $.ajax({
            type: "POST",
            url: "${basePath}easyhealth/clinic/getClinicPayList",
            data: datas,
            cache: false, 
            dataType: "json", 
            timeout: 600000,
            error: function(data) {
                $Y.loading.hide();
                console.log('加载待缴费数据异常');
                if(hasDate!='true') {
                    hasDate = 'false';
                    if((fornum+1) == selectCards.length) {
                        afterLoadData();
                    }
                }
            },
            success: function(data) {
                $Y.loading.hide();
                console.log(data);
                if (data.status == 'OK' && data.message && data.message.entityList && data.message.entityList.length > 0) {
                    //alert(JSON.stringify(data));
                    if(data.message.mark == globalMark) {
                        formatData(data.message.entityList);
                        hasDate = 'true';
                        showHasData();
                    }
                } else {
                    if(hasDate!='true') {
                        hasDate = 'false';
                        if((fornum+1) == selectCards.length) {
                            afterLoadData();
                        }
                    }
                }
            }
        });
    }
    
    function formatData(data) {
        var sHtml = '';
    	$.each(data, function(i, item) {
    		$.each(item.entityList, function(j, detail) {

				//alert(JSON.stringify(detail));
				//alert(detail.sSBillNumber);

//				alert("sSBillNumber:"+detail.sSBillNumber);
//				alert("cancelSerialNo:"+detail.cancelSerialNo);
//				alert("cancelBillNo:"+detail.cancelBillNo);

				var branchCode = '';
				if(item.hospitalCode == 'szsrmyy' || item.hospitalCode == 'szsrmyylhfy'){
                    branchCode = detail.branchCode;
				}else{
                    branchCode = item.branchCode;
				}

				sHtml += '<li' +
    					 ' data-idNo="' + getValue(item.idNo) + '"' +
    					 ' data-hospitalCode="' + getValue(item.hospitalCode) + '"' +
    					 ' data-hospitalName="' + getValue(item.hospitalName) + '"' +
    					 ' data-hospitalId="' + getValue(item.hospitalId) + '"' +
    					 ' data-branchCode="' + getValue(branchCode) + '"' +
    					 ' data-branchName="' + getValue(item.branchName) + '"' +
    					 ' data-branchId="' + getValue(item.branchId) + '"' +
    					 ' data-branchId="' + getValue(item.branchId) + '"' +
    					 ' data-patCardType="' + getValue(item.patCardType) + '"' +
    					 ' data-patCardNo="' + getValue(item.patCardNo) + '"' +
    					 ' data-patCardName="' + getValue(item.patCardName) + '"' +
    					 ' data-patMobile="' + getValue(item.patMobile) + '"' +
    					 ' data-doctor="' + getValue(detail.doctorName) + '"' +
				         ' data-doctorCode="' + getValue(detail.doctorCode) + '"' +
    					 ' data-time="' + getValue(detail.time) + '"' +
    					 ' data-id="' + getValue(detail.mzFeeId) + '"' +
    					 ' data-dept="' + getValue(detail.deptName) + '"' +
						 ' data-deptCode="' + getValue(detail.deptCode) + '"' +
    					 ' data-pay="' + getValue(detail.payAmout) + '"' +
    					 ' data-total="' + getValue(detail.totalAmout) + '"' +
				         ' data-ssbillnumber="' + getValue(detail.sSBillNumber) + '"' +
				         ' data-ssfeeno="' + getValue(detail.sSFeeNo) + '"' +
				         ' data-mzbillid="' + getValue(detail.mzBillId) + '"' +
						 ' data-cancelSerialNo="' + getValue(detail.cancelSerialNo) + '"' +
						 ' data-cancelBillNo="' + getValue(detail.cancelBillNo) + '"' +
						 ' data-recipeType="' + getValue(detail.recipeType) + '"' +
						 ' data-recipeId="' + getValue(detail.recipeId) + '"' +
    					 ' data-medicare="' + getValue(detail.medicareAmout) + '"' +
    					 ' data-accountAmount="' + getValue(detail.accountAmout) + '"' +
    					 ' data-insuranceAmout="' + getValue(detail.insuranceAmout) + '"' +
    					 ' data-canUseInsurance="' + getValue(detail.canUseInsurance) + '"' +
    					 ' data-type="' + getValue(detail.payType) + '">';
                sHtml += '	<div class="boxTable flex arrow-s" onclick="showDetails(this);">';
                sHtml += '		<div class="flexItem">';
                if (detail.deptName && detail.doctorName) {
                	sHtml += '			<div class="name fontSize110">' + detail.deptName + '-' + detail.doctorName + '</div>';
                } else {
                	sHtml += '			<div class="name fontSize110">门诊缴费</div>';
                }
                sHtml += '			<div class="mate">' + item.hospitalName + '</div>';
                sHtml += '			<div class="mate">' + Number(detail.totalAmout / 100).toFixed(2) + '元</div>';
                sHtml += '			<div class="mate color999">' + getValue(detail.time) + '</div>';
                sHtml += '		</div>';
                sHtml += '		<div class="color999 flexItem w120 textRight vertical">&nbsp;</div>';
                sHtml += '	</div>';
                sHtml += '	<div class="space5"></div>';
                sHtml += '	<div class="opt-view" onclick="showDetails(this);">去缴费</div>';
                sHtml += '</li>';
    		});
    	});
    	
    	$('#paymentList').append(sHtml);
    }
    
    
    function showDetails(obj) {
    	obj = $(obj).parent();
     	// 具体的就诊卡信息
    	$("#patientMobile").val($(obj).attr('data-patMobile'));
    	$("#hospitalCode").val($(obj).attr('data-hospitalCode'));
    	$("#hospitalName").val($(obj).attr('data-hospitalName'));
    	$("#hospitalId").val($(obj).attr('data-hospitalId'));
    	$("#branchHospitalCode").val($(obj).attr('data-branchCode'));
    	$("#branchHospitalName").val($(obj).attr('data-branchName'));
    	$("#branchHospitalId").val($(obj).attr('data-branchId'));
    	$("#cardType").val($(obj).attr('data-patCardType'));
    	$("#cardNo").val($(obj).attr('data-patCardNo'));
    	$("#patientName").val($(obj).attr('data-patCardName'));

		$("#ssBillNumber").val($(obj).attr('data-ssbillnumber'));
		$("#ssFeeNo").val($(obj).attr('data-ssfeeno'));
		$("#mzBillId").val($(obj).attr('data-mzbillid'));
		$("#cancelSerialNo").val($(obj).attr('data-cancelSerialNo'));
		$("#cancelBillNo").val($(obj).attr('data-cancelBillNo'));

		$("#deptCode").val($(obj).attr('data-deptCode'));
		$("#doctorCode").val($(obj).attr('data-doctorCode'));

		$("#recipeType").val($(obj).attr('data-recipeType'));
		$("#recipeId").val($(obj).attr('data-recipeId'));

		//alert($(obj).attr('data-ssbillnumber'));

    	// 展示信息
    	$("#doctorName").val($(obj).attr('data-doctor'));
		$("#mzFeeId").val($(obj).attr('data-id'));
		$("#deptName").val($(obj).attr('data-dept'));
		$("#totalFee").val(Number($(obj).attr('data-total')));
		$("#payFee").val(Number($(obj).attr('data-pay')));
		$("#medicareFee").val(Number($(obj).attr('data-medicare')));
		$("#medicareType").val($(obj).attr('data-type'));
		$("#accountAmout").val(Number($(obj).attr('data-accountAmount')));
		//alert("accountAmout"+$("#accountAmout").val());
		$("#insuranceAmout").val(Number($(obj).attr('data-insuranceAmout')));
		$("#canUseInsurance").val(Number($(obj).attr('data-canUseInsurance')));
		//$("#ssBillNumber").val($(obj).attr('data-ssBillNumber'));

		//alert($("#ssBillNumber").val());
		//alert("insuranceAmout"+$("#insuranceAmout").val());
		
		$("#appId").val();
		$("#appCode").val();
		$("#familyId").val($("#familyFilter").find("option:selected").attr("value"));
		
		$("#voForm").attr("action" , '${basePath}mobileApp/clinic/payDetail');
   		$("#voForm").submit();
    }
    
    function showHasNoCard() {
    	$('#noFamily').show();
    	$('#paymentList').hide();
		$('#noRecord').hide();
    }
    
    function showHasNoData() {
    	$('#noFamily').hide();
		$('#paymentList').hide();
		$('#noRecord').show();
    }
    
    function showHasData() {
    	$('#noFamily').hide();
		$('#paymentList').show();
		$('#noRecord').hide();
    }
    
    function loadingData() {
    	$('#noRecord').hide();
    	$('#noFamily').hide();
		$('#paymentList').hide();
		
		$('#paymentList').html('');
    }
    
    // 0 常规访问
	// 1消息推送访问
	var visitWay = 0;
	
	$(function() {
		$("#hospitalFilter option").each(function(){
		   if($(this).val() == '${commonParams.hospitalCode}'){
			  $('#hospital').attr('data-id','${commonParams.hospitalCode}');
			  $('#hospital').text($(this).text());
		   }
		});
		if (!$('#visitWay').val()) {
			var defaultCardNo = '${commonParams.cardNo}';
			if (defaultCardNo) {
				visitWay = 1;
			} 
			
			$('#visitWay').val(visitWay);
		}
	});
	
	// 刷新方法
	function doRefresh() {
		var url = "${basePath}easyhealth/clinic/payIndex";
		if (visitWay == 1) {
			url = "${basePath}easyhealth/clinic/payIndexFromMsg";
		} 
		
		$('#voForm').attr('action', url);
		$('#voForm').submit();
	}
	
	// 返回方法
	function doGoBack() {
		if(IS.isMacOS){
			try {
              window.appCloseView(true);
  			} catch (e) {
            //  alert('IOS的方法出错');
          	}
		}else if(IS.isAndroid){
          	try {
              window.yx129.appCloseView(true);
          	} catch (e) {
           	//   alert('Android的方法出错');
          	}
       	}else{
       		go(appPath + 'easyhealth/userCenterIndex');
        }
	}
	
	function setOwnership(obj) {
	   var ownership = $(obj).find("option:selected").attr("ownership");
	   if(ownership != "1") {
	       $('#syncType').val("2");
	   } else {
	       $('#syncType').val("1");
	   }
	}
</script>
<script type="text/javascript" src="${basePath}easyhealth/js/common/nav-list.js"></script>
