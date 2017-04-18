<html>
<head>
    <#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/json_utils.js"></script>
    <script type="text/javascript" src="${basePath}js/sys/hospital/sys.hospital.js?v=1.0.3"></script>
    <title>接入平台</title>
</head>
<body>
	<#include "./sys/common/hospital_setting.ftl">
    <div id="content-header">
        <div class="widget-title"><h3 class="title">接入平台</h3></div>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="row-fluid">
                <div class="space10"></div>
                <div class="myStep s3">
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
                                	<li <#if platformSettingsMap['wechat'].id?exists >class="active"</#if> value="${platformSettingsMap['wechat'].pfId}" code="wechat" onclick="$hospital.platform.switchTab(this);"><a href="javascript:void(0);"><label ><i class="checkbox-opt"></i><span class="text">微信</span></label></a></li>
                                	<li <#if platformSettingsMap['alipay'].id?exists> class="active"</#if> value="${platformSettingsMap['alipay'].pfId}" code="alipay" onclick="$hospital.platform.switchTab(this);"><a href="javascript:void(0);"><label ><i class="checkbox-opt"></i><span class="text">支付宝</span></label></a></li>
                                	<li <#if platformSettingsMap['easyHealth'].id?exists>class="active"</#if> value="${platformSettingsMap['easyHealth'].pfId}" code="easyHealth" easyHealth="true" onclick="$hospital.platform.switchTab(this);"><a href="javascript:void(0);"><label ><i class="checkbox-opt"></i><span class="text">健康易</span></label></a></li>
                                	
                                </ul>
                            </div>
                            <div class="h-content">
                                <form class="form-horizontal">
                                    <div class="space30"></div>
                                    <div id="wechat_input" >
	                                    <input type="hidden" field="id" value="${platformSettingsMap['wechat'].id}" />
	                                    <input type="hidden" field="platformId" value="${platformSettingsMap['wechat'].pfId}" />
	                                    <input type="hidden" field="hospitalPlatformSettingsId" value="${platformSettingsMap['wechat'].hpsId}" />
	                                    <input type="hidden" field="token" value="${platformSettingsMap['wechat'].token}" />
                                        <input type="hidden" field="wechatOldAppId" id="wechatOldAppId" value="${platformSettingsMap['wechat'].appId}" />
	                                    <div class="control-group"><label class="control-label" >微信AppId</label><div class="controls"><input type="text" field="appId" value="${platformSettingsMap['wechat'].appId}" class="span11" onkeyup="$hospital.platform.changeUrl(this,'wechat_span')"/></div></div>
	                                    <div class="control-group"><label class="control-label" >微信AppSecret</label><div class="controls"><input type="text" field="privateKey" value="${platformSettingsMap['wechat'].privateKey}" class="span11"/></div></div>
                                    </div>
                                    <div id="alipay_input" style="display: none;">
	                                    <input type="hidden" field="id" value="${platformSettingsMap['alipay'].id}" />
	                                    <input type="hidden" field="platformId" value="${platformSettingsMap['alipay'].pfId}" />
	                                    <input type="hidden" field="hospitalPlatformSettingsId" value="${platformSettingsMap['alipay'].hpsId}" />
                                        <input type="hidden" field="alipayOldAppId" id="alipayOldAppId" value="${platformSettingsMap['alipay'].appId}" />
	                                    <div class="control-group"><label class="control-label" >支付宝AppId</label><div class="controls"><input type="text" field="appId" value="${platformSettingsMap['alipay'].appId}" class="span11" onkeyup="$hospital.platform.changeUrl(this,'alipay_span')"/></div></div>
	                                    <div class="control-group"><label class="control-label" >支付宝私匙</label><div class="controls"><input type="text" field="privateKey" value="${platformSettingsMap['alipay'].privateKey}" class="span11"/></div></div>
	                                    <div class="control-group"><label class="control-label" >支付宝公匙</label><div class="controls"><input type="text" field="publicKey" value="${platformSettingsMap['alipay'].publicKey}" class="span11"/></div></div>
                                    </div>
                                    <div id="easyHealth_input" style="display: none;">
	                                    <input type="hidden" field="id" value="${platformSettingsMap['easyHealth'].id}" />
	                                    <input type="hidden" field="platformId" value="${platformSettingsMap['easyHealth'].pfId}" />
	                                    <input type="hidden" field="hospitalPlatformSettingsId" value="${platformSettingsMap['easyHealth'].hpsId}" />
	                                    <div class="control-group">
	                                    	<label class="control-label" >健康易AppId</label>
	                                    	<div class="controls">
	                                    		<input type="text" field="appId" readonly="readonly" value="${platformSettingsMap['easyHealth'].appId}" class="span11"/>
	                                    	</div>
	                                    </div>
                                    </div>
                                   
                                    <div class="space30"></div>
                                </form>
                                <div class="caption">
                                    <div id="wechat_wxts" class="unit" style="display: none;">
                                        <h5 class="title">温馨提示：<small>请将下面的数据填写到微信公众平台指定位置</small></h5>
                                        <p> URL：${wechatAccessUrl}<span id="wechat_span">${platformSettingsMap['wechat'].appId}</span></p>
                                        <p>Token：${platformSettingsMap['wechat'].token}</p>
                                        <p>授权域名：${wechatDomain}</p>
                                    </div>
                                    <div id="alipay_wxts" style="padding:1px 18px 30px; display: none;">
                                        <h5 class="title">温馨提示：<small>请将下面的数据填写到支付宝公众平台指定位置</small></h5>
                                        <p style="margin: 0; line-height: 24px; color: #8999a9; font-size: 13px;"> URL：${alipayAccessUrl}</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-tool">
                <div class="row-fluid">
                    <button class="btn btn-remove" onclick="$hospital.back('${basePath}sys/branchHospital/toView?hospitalId=${hospitalId}');">上一步</button>
                    <button class="btn btn-save" onclick="$hospital.platform.savePlatformSettings();">下一步</button>
                </div>
            </div>

        </div>
    </div>
</div>
<!--content end-->
<!-- 版权声明 -->
<#include "./sys/common/footer.ftl">

</body>
</html>
<script type="text/javascript">
	$hospital.id = '${hospitalId}';
	var checkPlatforms = $('.name-list li.active');
	if(checkPlatforms.length > 0){
		checkPlatforms.each(function(i, item) {
	    	var code = $(item).attr('code');
		    if($('#' + code + '_input').find(":text[field=appId]").val() != ''){
		    	$('#' + code + '_input').show();
		    	$('#' + code + '_wxts').show();
		    }else{
		    	$('#' + code + '_input').hide();
		    	$('#' + code + '_wxts').hide();
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
