<html>
<head>
    <#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/json_utils.js"></script>
    <script type="text/javascript" src="${basePath}js/sys/hospital/sys.hospital.js"></script>
    <script type="text/javascript" src="${basePath}js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="${basePath}js/attach/sys.attach.js"></script>
    <title>支付方式</title>
</head>
<body>
	<#include "./sys/common/hospital_setting.ftl">
    <div id="content-header">
        <div class="widget-title"><h3 class="title">支付方式</h3></div>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="row-fluid">
                <div class="space10"></div>
                <div class="myStep s4">
                    <div class="myStepClick">
                        <a class="aStepClick a-s1" href="${basePath}sys/hospital/toEdit?id=${hospitalId}"></a>
                        <a class="aStepClick a-s2" href="${basePath}sys/branchHospital/toView?hospitalId=${hospitalId}"></a>
                        <a class="aStepClick a-s3" href="${basePath}sys/platformSettings/toView?hospitalId=${hospitalId}"></a>
                        <a class="aStepClick a-s4" href="${basePath}sys/paySettings/toView?hospitalId=${hospitalId}"></a>
                        <a class="aStepClick a-s5" href="${basePath}sys/optional/toView?hospitalId=${hospitalId}"></a>
                        <a class="aStepClick a-s6" href="${basePath}sys/customerMenu/toView?hospitalId=${hospitalId}"></a>
                    </div>
                </div>
            </div>
            <div class="widget-box">
                <div class="h22"></div>
                <div class="widget-content">
                    <div class="row-fluid">
                        <!--内容-->
                        <div class="h-Info">
                            <div class="h-name">
                                <ul class="name-list textleft">
                                    <li <#if paySettingsMap['wechat'].id?exists >class="active"</#if> value="${paySettingsMap['wechat'].pfId}" code="wechat" onclick="$hospital.platform.switchTab(this);"><a href="javascript:void(0);"><label ><i class="checkbox-opt"></i><span class="text">微信</span></label></a></li>
                                	<li <#if paySettingsMap['alipay'].id?exists>class="active"</#if> value="${paySettingsMap['alipay'].pfId}" code="alipay" onclick="$hospital.platform.switchTab(this);"><a href="javascript:void(0);"><label ><i class="checkbox-opt"></i><span class="text">支付宝</span></label></a></li>
                                	<li <#if paySettingsMap['easyHealthWechat'].id?exists >class="active"</#if> value="${paySettingsMap['easyHealthWechat'].pfId}" code="easyHealthWechat" onclick="$hospital.platform.switchTab(this);"><a href="javascript:void(0);"><label ><i class="checkbox-opt"></i><span class="text">健康易微信</span></label></a></li>
                                	<li <#if paySettingsMap['easyHealthAlipay'].id?exists >class="active"</#if> value="${paySettingsMap['easyHealthAlipay'].pfId}" code="easyHealthAlipay" onclick="$hospital.platform.switchTab(this);"><a href="javascript:void(0);"><label ><i class="checkbox-opt"></i><span class="text">健康易支付宝</span></label></a></li>
                                </ul>
                            </div>
                            <div class="h-content">
                                <form class="form-horizontal">
                                    <div class="space30"></div>
									<div id="wechat_input">
                                    	<input id="attachId" type="hidden" field="id" value="${paySettingsMap['wechat'].id}" />
                                    	<input type="hidden" field="flag" value="<#if paySettingsMap['wechat'].id??>1<#else>0</#if>" />
	                                    <input type="hidden" field="payModeId" value="${paySettingsMap['wechat'].payModeId}" />
	                                    <input type="hidden" field="hospitalPaySettingsId" value="${paySettingsMap['wechat'].hpsId}" />
	                                    <#if paySettingsMap['wechat'].isSubPay == 1>
	                                   	 	<div name="div_subMchId" class="control-group"><label class="control-label">微信支付子商户号</label><div class="controls"><input type="text" id="subMchId" field="subMchId" value="${paySettingsMap['wechat'].subMchId}" class="span11"></div></div>
	                                    </#if>
                            			<#if paySettingsMap['wechat'].isSubPay == 0>
                            				<div name="div_subMchId" class="control-group" style="display: none;"><label class="control-label">微信支付子商户号</label><div class="controls"><input type="text" id="subMchId" field="subMchId" value="${paySettingsMap['wechat'].subMchId}" class="span11"></div></div>
                            			</#if>
	                                    <div class="control-group">
	                                    	<label class="control-label">是否子商户</label>
	                                    	<div class="controls" style="margin-top:10px;">
	                                    		<#if paySettingsMap['wechat'].isSubPay == 1>
	                                    			<label class="checkboxTwo inline check">
	                                    				<input type="checkbox" name="isSubPay" field="isSubPay" value="1"  onclick="$hospital.pay.isSubPay(this,'wechat');">
	                                    			</label>
                                    			</#if>
                                    			<#if paySettingsMap['wechat'].isSubPay == 0>
	                                    			<label class="checkboxTwo inline">
	                                    				<input type="checkbox" name="isSubPay" field="isSubPay" value="0" onclick="$hospital.pay.isSubPay(this,'wechat');">
	                                    			</label>
                                    			</#if>
	                                    	</div>
	                                    </div>
	                                    <div class="control-group" name="div_parentAppId" style="display: <#if paySettingsMap['wechat'].isSubPay == 0>none<#else>black</#if>;">
	                                    	<label id="label_parentAppId" class="control-label">父商户appId</label>
	                                    	<div class="controls"><input type="text" field="parentAppId" value="${paySettingsMap['wechat'].parentAppId}" class="span11"></div>
	                                    </div>
	                                    <div class="control-group" name="div_parentSecret" style="display: <#if paySettingsMap['wechat'].isSubPay == 0>none<#else>black</#if>;">
	                                    	<label id="label_parentSecret" class="control-label">父商户Secret</label>
	                                    	<div class="controls"><input type="text" field="parentSecret" value="${paySettingsMap['wechat'].parentSecret}" class="span11"></div>
	                                    </div>
	                                    
	                                    <div class="control-group">
	                                    	<label name="label_mchId" class="control-label">
	                                    		<#if paySettingsMap['wechat'].isSubPay == 0>微信支付商户号</#if><#if paySettingsMap['wechat'].isSubPay == 1>微信支付父商户号</#if>
	                                    	</label>
	                                    	<div class="controls"><input type="text" field="mchId" value="${paySettingsMap['wechat'].mchId}" class="span11"></div>
	                                    </div>
	                                    <div class="control-group">
	                                    	<label name="label_payKey" class="control-label">
	                                    		<#if paySettingsMap['wechat'].isSubPay == 0>微信支付密匙</#if><#if paySettingsMap['wechat'].isSubPay == 1>微信支付父商户密匙</#if>
	                                    	</label>
	                                    	<div class="controls"><input type="text" field="payKey" value="${paySettingsMap['wechat'].payKey}" class="span11"></div>
	                                    </div>
	                                    <div class="control-group">
	                                    	<label name="label_certificatePath" class="control-label">
	                                    		<#if paySettingsMap['wechat'].isSubPay == 0>微信退费证书</#if><#if paySettingsMap['wechat'].isSubPay == 1>微信父商户退费证书</#if>
	                                    	</label>
	                                    	<div class="controls">
	                                        	<span class="btn-save btn-upload" style="float:left;">
													选择证书<input class="fileupload" field="certificatePath" type="file" id="uploadFile1" name="uploadFile" onchange="$attach.uploadFile(this,'fileNameDiv','attachId','2');" value="${paySettingsMap['wechat'].certificatePath }">
	                                        	</span>
	                                        	<div id="fileNameDiv" class="span5" style="border:#ccc 1px solid; height:40px; line-height:40px; display:inline-block; padding:0 5px;">${paySettingsMap['wechat'].certificatePath }</div>
	                                    	</div>
	                                    </div>
                                    </div>
                                	<div id="alipay_input" style="display: none;">
                                    	<input type="hidden" field="id" value="${paySettingsMap['alipay'].id}" />
	                                    <input type="hidden" field="flag" value="<#if paySettingsMap['alipay'].id??>1<#else>0</#if>" />
	                                    <input type="hidden" field="payModeId" value="${paySettingsMap['alipay'].payModeId}" />
	                                    <input type="hidden" field="hospitalPaySettingsId" value="${paySettingsMap['alipay'].hpsId}" />
	                                    <div class="control-group"><label class="control-label">支付宝合作者ID</label><div class="controls"><input type="text" field="mchId" value="${paySettingsMap['alipay'].mchId}" class="span11"></div></div>
	                                    <div class="control-group"><label class="control-label">支付宝商家帐号</label><div class="controls"><input type="text" field="mchAccount" value="${paySettingsMap['alipay'].mchAccount}" class="span11"></div></div>
	                                    <div class="control-group"><label class="control-label">支付宝支付密匙</label><div class="controls"><input type="text" field="payKey" value="${paySettingsMap['alipay'].payKey}" class="span11"></div></div>
	                                    <div class="control-group"><label class="control-label">支付宝支付私钥</label><div class="controls"><input type="text" field="payPrivateKey" value="${paySettingsMap['alipay'].payPrivateKey}" class="span11"></div></div>
	                                    <div class="control-group"><label class="control-label">支付宝支付公钥</label><div class="controls"><input type="text" field="payPublicKey" value="${paySettingsMap['alipay'].payPublicKey}" class="span11"></div></div>
									</div>
									<div id="easyHealthWechat_input" style="display: none;">
                                    	<input id="easyHealthWechatAttachId" type="hidden" field="id" value="${paySettingsMap['easyHealthWechat'].id}" />
                                    	<input type="hidden" field="flag" value="<#if paySettingsMap['easyHealthWechat'].id??>1<#else>0</#if>" />
	                                    <input type="hidden" field="payModeId" value="${paySettingsMap['easyHealthWechat'].payModeId}" />
	                                    <input type="hidden" field="hospitalPaySettingsId" value="${paySettingsMap['easyHealthWechat'].hpsId}" />
	                                    <#if paySettingsMap['easyHealthWechat'].isSubPay == 1>
	                                   	 	<div name="div_subMchId" class="control-group"><label class="control-label">健康易微信支付子商户号</label><div class="controls"><input type="text" id="subMchId" field="subMchId" value="${paySettingsMap['easyHealthWechat'].subMchId}" class="span11"></div></div>
	                                    </#if>
                            			<#if paySettingsMap['easyHealthWechat'].isSubPay == 0>
                            				<div name="div_subMchId" class="control-group" style="display: none;"><label class="control-label">健康易微信支付子商户号</label><div class="controls"><input type="text" id="subMchId" field="subMchId" value="${paySettingsMap['easyHealthWechat'].subMchId}" class="span11"></div></div>
                            			</#if>
	                                    <div class="control-group">
	                                    	<label class="control-label">健康易是否子商户</label>
	                                    	<div class="controls" style="margin-top:10px;">
	                                    		<#if paySettingsMap['easyHealthWechat'].isSubPay == 1>
	                                    			<label class="checkboxTwo inline check">
	                                    				<input type="checkbox" name="isSubPay" field="isSubPay" value="1"  onclick="$hospital.pay.isSubPay(this,'easyHealthWechat');">
	                                    			</label>
                                    			</#if>
                                    			<#if paySettingsMap['easyHealthWechat'].isSubPay == 0>
	                                    			<label class="checkboxTwo inline">
	                                    				<input type="checkbox" name="isSubPay" field="isSubPay" value="0" onclick="$hospital.pay.isSubPay(this,'easyHealthWechat');">
	                                    			</label>
                                    			</#if>
	                                    	</div>
	                                    </div>
	                                    <div class="control-group" name="div_parentAppId" style="display: <#if paySettingsMap['easyHealthWechat'].isSubPay == 0>none<#else>black</#if>;">
	                                    	<label id="label_parentAppId" class="control-label">健康易父商户appId</label>
	                                    	<div class="controls"><input type="text" field="parentAppId" value="${paySettingsMap['easyHealthWechat'].parentAppId}" class="span11"></div>
	                                    </div>
	                                    <div class="control-group" name="div_parentSecret" style="display: <#if paySettingsMap['easyHealthWechat'].isSubPay == 0>none<#else>black</#if>;">
	                                    	<label id="label_parentSecret" class="control-label">健康易父商户Secret</label>
	                                    	<div class="controls"><input type="text" field="parentSecret" value="${paySettingsMap['easyHealthWechat'].parentSecret}" class="span11"></div>
	                                    </div>
	                                    
	                                    <div class="control-group">
	                                    	<label name="label_mchId" class="control-label">
	                                    		<#if paySettingsMap['easyHealthWechat'].isSubPay == 0>健康易微信支付商户号</#if><#if paySettingsMap['easyHealthWechat'].isSubPay == 1>健康易微信支付父商户号</#if>
	                                    	</label>
	                                    	<div class="controls"><input type="text" field="mchId" value="${paySettingsMap['easyHealthWechat'].mchId}" class="span11"></div>
	                                    </div>
	                                    <div class="control-group">
	                                    	<label name="label_payKey" class="control-label">
	                                    		<#if paySettingsMap['easyHealthWechat'].isSubPay == 0>健康易微信支付密匙</#if><#if paySettingsMap['easyHealthWechat'].isSubPay == 1>健康易微信支付父商户密匙</#if>
	                                    	</label>
	                                    	<div class="controls"><input type="text" field="payKey" value="${paySettingsMap['easyHealthWechat'].payKey}" class="span11"></div>
	                                    </div>
	                                    <div class="control-group">
	                                    	<label name="label_certificatePath" class="control-label">
	                                    		<#if paySettingsMap['easyHealthWechat'].isSubPay == 0>健康易微信退费证书</#if><#if paySettingsMap['easyHealthWechat'].isSubPay == 1>健康易微信父商户退费证书</#if>
	                                    	</label>
	                                    	<div class="controls">
	                                        	<span class="btn-save btn-upload" style="float:left;">
													选择证书<input class="fileupload" field="certificatePath" type="file" id="uploadFile2" name="uploadFile" onchange="$attach.uploadFile(this,'easyHealthWechatFileNameDiv','easyHealthWechatAttachId','2');" value="${paySettingsMap['easyHealthWechat'].certificatePath }">
	                                        	</span>
	                                        	<div id="easyHealthWechatFileNameDiv" class="span5" style="border:#ccc 1px solid; height:40px; line-height:40px; display:inline-block; padding:0 5px;">${paySettingsMap['easyHealthWechat'].certificatePath }</div>
	                                    	</div>
	                                    </div>
                                    </div>
                                	<div id="easyHealthAlipay_input" style="display: none;">
                                    	<input type="hidden" field="id" value="${paySettingsMap['easyHealthAlipay'].id}" />
	                                    <input type="hidden" field="flag" value="<#if paySettingsMap['easyHealthAlipay'].id??>1<#else>0</#if>" />
	                                    <input type="hidden" field="payModeId" value="${paySettingsMap['easyHealthAlipay'].payModeId}" />
	                                    <input type="hidden" field="hospitalPaySettingsId" value="${paySettingsMap['easyHealthAlipay'].hpsId}" />
	                                    <div class="control-group"><label class="control-label">健康易支付宝合作者ID</label><div class="controls"><input type="text" field="mchId" value="${paySettingsMap['easyHealthAlipay'].mchId}" class="span11"></div></div>
	                                    <div class="control-group"><label class="control-label">健康易支付宝商家帐号</label><div class="controls"><input type="text" field="mchAccount" value="${paySettingsMap['easyHealthAlipay'].mchAccount}" class="span11"></div></div>
	                                    <div class="control-group"><label class="control-label">健康易支付宝支付密匙</label><div class="controls"><input type="text" field="payKey" value="${paySettingsMap['easyHealthAlipay'].payKey}" class="span11"></div></div>
	                                    <div class="control-group"><label class="control-label">健康易支付宝支付私钥</label><div class="controls"><input type="text" field="payPrivateKey" value="${paySettingsMap['easyHealthAlipay'].payPrivateKey}" class="span11"></div></div>
	                                    <div class="control-group"><label class="control-label">健康易支付宝支付公钥</label><div class="controls"><input type="text" field="payPublicKey" value="${paySettingsMap['easyHealthAlipay'].payPublicKey}" class="span11"></div></div>
									</div>
                                </form>
                            </div>
                        </div>
                        <!--内容 end-->
                    </div>
                </div>
            </div>
            <div class="footer-tool">
                <div class="row-fluid">
                    <button class="btn btn-remove" onclick="$hospital.back('${basePath}sys/platformSettings/toView?hospitalId=${hospitalId}');">上一步</button>
                    <button id="start_upload" class="btn btn-save"  onclick="$hospital.pay.savePaySettings();">下一步</button>
                </div>
            </div>

        </div>
    </div>
</div>
<!--content end-->
</body>
</html>
<script type="text/javascript">
	$hospital.id = '${hospitalId}';
	var basePath = '${basePath}';
	
	var checkPlatforms = $('.name-list li.active');
	if(checkPlatforms.length > 0){
		checkPlatforms.each(function(i, item) {
	    	var code = $(item).attr('code');
		    if($('#' + code + '_input').find(":text[field=mchId]").val() != ''){
		    	$('#' + code + '_input').show();
		    }else{
		    	$('#' + code + '_input').hide();
		    	$(item).removeClass("active");
		    }
	  	});
	}else{
		$('.name-list li').eq(0).addClass("active");
		var code = $('.name-list li').eq(0).attr("code")
		console.log(code);
		$('#' + code + '_wxts').show();
	}
	
</script>
