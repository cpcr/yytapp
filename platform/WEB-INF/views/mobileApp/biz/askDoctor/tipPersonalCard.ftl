<!DOCTYPE html>
<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>温馨提示</title>
</head>
<body>
<div id="body">
    <div id="success">
        <img src="${basePath}/images/noData-pic.png" width="110" />
        <div class="p color666" >使用该服务需要添加“本人”就诊人，请先添加。</div>
    </div>

    <div class="section btn-w">
        <div class="btn btn-block btn-ok" onclick="addCard()">添加本人就诊卡</div>
    </div>
    <input type="hidden" id="appCode" value="${appCode}">
    <input type="hidden" id="appId" value="${appId}">
    <input type="hidden" id="redirect_uri" value="${redirect_uri}">
</div>
<script>
	function addCard()
	{
		window.location ="/mobileApp/medicalcard/bind/toView?appCode="
		+$('#appCode').val()+"&appId="+$('#appId').val()+"&redirect_uri="+$('#redirect_uri').val();
	}
</script>
<div id="copyright"> 云医通出品 </div>
</body>
</html>
