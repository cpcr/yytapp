<!DOCTYPE html>
<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>温馨提示</title>
</head>
<script>
	$(function()
	{
		setTimeout("WeixinJSBridge.call('closeWindow');",2000);
	});
</script>
<body>
<div id="body">
    <div id="success">
        <img src="${basePath}/mobileApp/images/wait-pic.png" width="150" />
        <div class="p color666" >${msg}</div>
        <div class="p color666" >2秒后关闭页面，请稍后...</div>
    </div>
</div>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>
