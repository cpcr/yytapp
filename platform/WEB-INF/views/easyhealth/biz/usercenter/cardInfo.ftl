<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<title>医院就诊卡信息</title>
</head>
<body>
	<div id="body">
	   <#if entity.hospitalCode!="nsqfybjy" 
        && entity.hospitalCode!="nsqmxbfzy" && entity.hospitalCode!="nsqxlrmyy" 
        && entity.hospitalCode!="nsqrmyy" && entity.hospitalCode!="nsqskrmyy">
	   <div class="qrcode">
            <div class="barCode">
                <div id="barcodeTarget" class="barcodeTarget" style="margin: 0 auto;"></div>
            </div>
        </div>
        </#if>
        
	    <div class="space15"></div>
	    <ul class="yx-list">
	        <li class="flex">
	            <div class="flexItem">医院</div>
	            <div class="flexItem color666 textRight">${entity.hospitalName}</div>
	        </li>
	        <li class="flex">
	            <div class="flexItem">姓名</div>
	            <div class="flexItem color666 textRight">${entity.encryptedPatientName}</div>
	        </li>
	        
	        <li class="flex">
	            <div class="flexItem">卡号码</div>
	            <div class="flexItem color666 textRight" id="cardNoDiv">${entity.encryptedCardNoDesc}</div>
	        </li>
	        <#if entity.ownership == 3>
            <li class="flex">
                <div class="flexItem">出生日期</div>
                <div class="flexItem color666 textRight">${entity.birth}</div>
            </li>
            </#if>
	    </ul>
	    <div class="space15"></div>
	    <#if entity.ownership != 3>
	    <ul class="yx-list">
	    	<li class="flex">
	            <div class="flexItem">证件类型</div>
	            <div class="flexItem color666 textRight">
	            	<#switch entity.idType>
	            		<#case 1>二代身份证<#break>
	            		<#case 2>港澳居民身份证<#break>
	            		<#case 3>台湾居民身份证<#break>
	            		<#case 4>护照<#break>
	            		<#default>
	            	</#switch>
	            </div>
	        </li>
	        <li class="flex">
	            <div class="flexItem">证件号码</div>
	            <div class="flexItem color666 textRight">${entity.encryptedIdNo}</div>
	        </li>
	        <li class="flex">
	            <div class="flexItem">手机号码</div>
	            <div class="flexItem color666 textRight">${entity.encryptedMobile}</div>
	        </li>
	    </ul>
	    <#else>
	    <ul class="yx-list">
        	<li class="flex">
                <div class="flexItem">监护人姓名</div>
                <div class="flexItem color666 textRight">${entity.encryptedGuardName}</div>
            </li>
        	<li class="flex">
                <div class="flexItem">监护人证件类型</div>
                <div class="flexItem color666 textRight">
                	<#switch entity.guardIdType>
	            		<#case 1>二代身份证<#break>
	            		<#case 2>港澳居民身份证<#break>
	            		<#case 3>台湾居民身份证<#break>
	            		<#case 4>护照<#break>
	            		<#default>
	            	</#switch>
                </div>
            </li>
            <li class="flex">
                <div class="flexItem">监护人证件号码</div>
                <div class="flexItem color666 textRight">${entity.encryptedGuardIdNo}</div>
            </li>
            <li class="flex">
                <div class="flexItem">监护人手机号码</div>
                <div class="flexItem color666 textRight">${entity.encryptedGuardMobile}</div>
            </li>
        </ul>
	    </#if>
	    
	    <div class="section btn-w">
	    	<div id="unbind" class="btn btn-ok btn-block" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">移除就诊卡</div>
	    </div>
	</div>    
	<form id="voForm" method="post" action="">
	    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
		<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
		<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
		<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
		<input type="hidden" id="hospitalCode" name="hospitalCode" value="${entity.hospitalCode}" />
		<input type="hidden" id="hospitalId" name="hospitalId" value="${entity.hospitalId}" />
		<input type="hidden" id="hospitalName" name="hospitalName" value="${entity.hospitalName}" />
		<input type="hidden" id="syncType" name="syncType" value="${commonParams.syncType}" />
		<input type="hidden" id="familyId" name="familyId" value="${entity.familyId}">
		<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
		<input type="hidden" id="medicalcardId" name="medicalcardId" value="${commonParams.medicalcardId}">
		<input type="hidden" id="forward" name="forward" value="${commonParams.forward}">
	</form>
<#include "/easyhealth/common/footer.ftl">
</body>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/idCardUtils.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery-barcode.min.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/base64.js"></script>
<script type="text/javascript">
	$(function() {		
	   generateBarcode('${entity.cardNo}');
	   
		$('#unbind').click(function(event) {
			event.stopPropagation();
	        event.preventDefault();
			unbindCard();
		});
		if(IS.isMacOS){
	        try{
	        	setTimeout("appHideNavRefresh();",1000);
		        } 
		        catch (e) {}
		}
		else if(IS.isAndroid){
		        try
		        {
		        	window.yx129.appHideNavRefresh();
		        } catch (e) {}
		    }
	});
	
	function generateBarcode(cardNo) {
		// 内容
		var value = cardNo;
        if('${entity.encryptedCardNoDesc}'=='') {
          $("#cardNoDiv").html(cardNo);
        } else {
          var base64 = new Base64();
          value = base64.decode(cardNo);
        }
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
          addQuietZone: false,
          showHRI: false
        };
        
        $("#barcodeTarget").html("").show().barcode(value, btype, settings);
	};
	
	function unbindCard() {
		$Y.loading.show('正在为您解绑就诊卡...');
		$.ajax({
			type: "POST",
			url: appPath + "easyhealth/usercenter/cardInfo/unbindCard",
			data: {
				id: '${entity.id}',
				appId: '${entity.appId}',
				openId: '${entity.openId}'
			},
			cache: false, 
			dataType: "json", 
			timeout: 600000,
			error: function(data) {
				$Y.loading.hide();
				showMessageBox('解绑失败，请稍后重试。');
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				if (data.status == 'OK') {
					if (data.message.isSuccess == 'success') {
						//$('#voForm').attr('action', '${basePath}easyhealth/usercenter/familyInfo/index');
						//$('#voForm').submit();
						var syncType = '${commonParams.syncType}';
						if (syncType) {
							// 回到就诊卡列表页面
							$('#voForm').attr('action', '${basePath}easyhealth/usercenter/familyInfo/index');
							$('#voForm').submit();
						} else {
							// 没有这个东西，就认为他是从消息里面过来的，直接关闭即可。
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
					} else {
						showMessageBox('解绑失败，请稍后重试。');
					}
				} else {
					showMessageBox('解绑失败，请稍后重试。');
				}
			}
		})
	};
	
	function showMessageBox(data) {
		new $Y.confirm({
	        ok:{title:'确定'},
	        content: data
	    });
	};
	
	// 刷新方法
	function doRefresh() {
		$('#voForm').attr('action', "${basePath}easyhealth/usercenter/cardInfo/toView");
		$('#voForm').submit();
	}
	
	// 返回方法
	function doGoBack() {
		var syncType = '${commonParams.syncType}';
		var forward = '${commonParams.forward}';
		if (forward) {
			// 回到就诊卡列表页面
				$('#voForm').attr('action', '${basePath}easyhealth/usercenter/familyInfo/index');
				$('#voForm').submit();
		} else {
			if (syncType) {
				// 回到就诊卡列表页面
				$('#voForm').attr('action', '${basePath}easyhealth/usercenter/familyInfo/index');
				$('#voForm').submit();
			} else {
				// 没有这个东西，就认为他是从消息里面过来的，直接关闭即可。
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
		}
	}	
</script>
</html>