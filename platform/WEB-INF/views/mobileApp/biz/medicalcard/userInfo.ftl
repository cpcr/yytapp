<!DOCTYPE html>
<html>
<head>
<#include "/mobileApp/common/common.ftl">
<title>${(card.ownership==1)?string("个人资料", "就诊人信息")}</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)">
	<div id="body">
	    <div id="myCenter">
	        <div class="box-list">
	            <ul class="yx-list">
	                <li class="user_pic">
	                    <div class="label">头像</div>
	                    <div class="values">
	                        <img src="${basePath}mobileApp/images/${(card.sex==1)?string("man-def.png", "girl-def.png")}" width="40" height="40">
	                        <i class="icon-arrow"></i>
	                    </div>
	                </li>
	                <li>
	                    <div class="label">姓名</div>
	                    <div class="values color666">${card.encryptedPatientName}</div>
	                </li>
	                <li>
	                    <div class="label">性别</div>
	                    <div class="values color666">${card.patientSexLable}</div>
	                </li>
	            </ul>
	        </div>
	        <div class="box-list">
	            <ul class="yx-list">
	            	<#list rule.userInfoContent?split(",") as item>
	            		<#switch item>
		            		<#case 1>
		            		    <#if card.hospitalCode!="nsqfybjy" 
                                    && card.hospitalCode!="nsqmxbfzy" && card.hospitalCode!="nsqxlrmyy" 
                                    && card.hospitalCode!="nsqrmyy" && card.hospitalCode!="nsqskrmyy">
				                <li>
                                    <div>条型码</div>
                                    <div class="barCode">
                                        <div id="barcodeTarget" class="barcodeTarget" style="margin: 0 auto;"></div>
                                    </div>
                                </li>
                                </#if>
				            <#break>
				            <#case 2>
				                <li>
				                    <div class="label">
				                    	<#switch card.idType>
				                    		<#case 1>二代身份证<#break>
				                    		<#case 2>港澳居民身份证<#break>
				                    		<#case 3>台湾居民身份证<#break>
				                    		<#case 4>护照<#break>
				                    		<#default>
				                    	</#switch>
				                    </div>
				                    <div class="values color666">${card.encryptedIdNo}</div>
				                </li>
				            <#break>
				            <#case 3>
				                <li>
				                    <div class="label">手机号</div>
				                    <div class="values color666">
				                    	${card.encryptedMobile}
				                    </div>
				                </li>
				            <#break>
				            <#case 4>
				                <li>
				                	<div class="label">
				                    	<#switch card.cardType>
		                            		<#case 1>就诊卡号<#break>
		                            		<#case 2>社保卡号<#break>
		                            		<#case 3>医保卡号<#break>
		                            		<#case 4>健康卡号<#break>
		                            		<#case 5>身份证号<#break>
		                            		<#case 6>市民卡号<#break>
		                            		<#case 7>患者唯一标识<#break>
		                            		<#case 8>临时诊疗卡号<#break>
		                            		<#default>
		                            	</#switch>
				                    </div>
				                    <div class="values color666">${card.cardNo}</div>
				                </li>
				            <#break>
				           	<#case 5>
				                <li>
				                    <div class="label">住院号</div>
				                    <div class="values color666">&nbsp;</div>
				                </li>
				           	<#break>
				           	<#case 6>
				                <li>
				                    <div class="label">医保号</div>
				                    <div class="values color666">&nbsp;</div>
				                </li>
				           	<#break>
				    	</#switch>
		        	</#list>
	            </ul>
	        </div>
	    </div>
	    
	    <div class="section btn-w">
	    	<div id="unbind" class="btn btn-ok btn-block" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">删除就诊人</div>
	    </div>
	    <#--
	    <#if (card.appCode != 'easyHealth') || (card.appCode == 'easyHealth' && card.idNo != sessionUser.cardNo)>
	    <div class="section btn-w">
	    	<div id="unbind" class="btn btn-ok btn-block" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">删除就诊人</div>
	    </div>
	   	</#if>
	   	-->
	</div>
	
	<form id="voForm" method="post" action="">
		<input type="hidden" id="openId" name="openId" value="${card.openId}" />
		<input type="hidden" id="appCode" name="appCode" value="${card.appCode}" />
		<input type="hidden" id="appId" name="appId" value="${card.appId}" />
		<input type="hidden" id="hospitalCode" name="hospitalCode" value="${card.hospitalCode}" />
		<input type="hidden" id="hospitalId" name="hospitalId" value="${card.hospitalId}" />
		<input type="hidden" id="hospitalName" name="hospitalName" value="${card.hospitalName}" />
	</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/idCardUtils.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery-barcode.min.js"></script>
<script type="text/javascript">
	$(function() {		
	   generateBarcode('${card.cardNo}');
	
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
			url: appPath + "mobileApp/medicalcard/userinfo/unbind",
			data: {
				id: '${card.id}',
				appId: '${appId}',
				openId: '${card.openId}'
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
						if ($('#appCode').val() == 'easyHealth') {
							$('#voForm').attr('action', '${basePath}mobileApp/medicalcard/family/toView');
						} else {
							$('#voForm').attr('action', '${basePath}mobileApp/medicalcard/usercenter/toView');
						}
						$('#voForm').submit();
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
	
	
</script>
</html>