<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <title>支付成功</title>
</head>
<body>
<div id="body">
    <div id="success">
        <img src="${basePath}mobileApp/images/wait-pic.png" width="110" />
        <div class="p color666" id="msginfo">支付成功，正在提交给医院，请耐心等待。</div>
    </div>

    <div class="section btn-w" id="buttonDiv">
        <div class="btn btn-block" onclick="goNext()">确定</div>
    </div>
</div>
<form id="paramsForm" method="post">
<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
<input type="hidden" id="orderNo" name="orderNo" value="${commonParams.orderNo}">
<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}">
<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}">
<input type="hidden" id="tradeMode" name="tradeMode" value="${commonParams.tradeMode}">
<input type="hidden" id="tradeNo" name="tradeNo" value="${commonParams.tradeNo}">
<input type="hidden" id="tradeAmout" name="tradeAmout" value="${commonParams.tradeAmout}">
<input type="hidden" id="regType" name="regType" value="${commonParams.regType}">
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>
<script type="text/javascript">
$(function(){
	// var timerConfirmOrder = setTimeout(hisPayConfirm, 1000);
    hisPayConfirm();
    
    function hisPayConfirm(){
		var reqUrl =  "${basePath}mobileApp/deposit/depositOrderConfirm";
	    var datas = $("#paramsForm").serializeArray(); 
	    $.ajax({  
		    type: 'POST',  
		    url: reqUrl,  
		    data: datas,  
		    dataType: 'json',  
		    timeout: 120000,
		    success: function(data) { 
		        $("#msginfo").html(data.message.msgInfo)
		        $("#buttonDiv").show();
		        if(data.message.isSuccess){
		            isSuccess = true;  
		            setTimeout(timeCount, 1000);
		        }else{
		            isSuccess = false;
		        }
		     },  
		     error: function(data) {  
		        $Y.loading.hide()
		        errorBox =  new $Y.confirm({
		            content:'<div>网络异常,系统自动处理中,查看结果信息.</div>',
		            ok:{title: '确定'}
		        }) 
		     }  
		}); 
	}
	
    $("#buttonDiv").hide();
});
var isSuccess = false;

function timeCount(){
    var time = $("#timeCount").html();
    time = parseInt(time) - 1;
    if(time == 0){
        goNext();
    }else{
        $("#timeCount").html(time);
        setTimeout(timeCount, 1000);
    }
}

function goNext(){
	/*
    if(isSuccess){
        window.location = "";
    }else{
    	var tradeMode = '${commonParams.tradeMode}';
    	if (tradeMode == '1') {
        	WeixinJSBridge.invoke('closeWindow',{},function(res){});
        } else {
        	AlipayJSBridge.call('closeWebview');
        }
    }
    */
    var tradeMode = '${commonParams.tradeMode}';
	if (tradeMode == '1') {
    	WeixinJSBridge.invoke('closeWindow',{},function(res){});
    } else {
    	AlipayJSBridge.call('closeWebview');
    }
}
</script>
