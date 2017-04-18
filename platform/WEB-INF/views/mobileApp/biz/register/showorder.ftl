<html>
<#include "/mobileApp/common/common.ftl">
<head>
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
	<meta HTTP-EQUIV="expires" CONTENT="0"> 
    <title>确认挂号信息</title>
    <style>
    	.btn-bingka{ 
    		background-color:#11ba98;
    		border:1px solid #10a98a;
    		border-radius:2px;
    		display:inline-block;
    		line-height:2em;
    		text-align:center;
    		color:#fff;
    		padding:0 1em;
    		margin:0;
    		position:absolute;
    		right:5px;top:11px
    	}
    	
    	.btn-bingka:hover,.btn-bingka .hover{
    		background-color:#10a98a;
    		color:#fff
    	}
    	
    	.yx-list .label.hasButton {
    		max-width: none;
    	}
    	
    	.yx-list .label.hasNoButton {
    		max-width: 6em;
    	}
    </style>
</head>
<body>
showorder:${showorder}
datas:${showorder};
appcode:${appcode};
tradeUrl:${tradeUrl};
<form id="payForm" method="post" action="${tradeUrl}/pay/info/">
    <!-- 支付类型 --->
    <!-- 是否医保 -->
    <#-- 医保参数  start -->
    <!--是否医保卡支付 0 不是 1 是 -->
	<input type="hidden" id="isInsurance" name="isInsurance" value="0" />
	<!--医疗证号 -->
	<input type="hidden" id="medicalCardNo" name="medicalCardNo" value="${mcb.medical_card_id}" />
	<!--医保卡号-->
	<input type="hidden" id="medicareCardNo" name="medicareCardNo"  value="${mcb.medical_card_no}"/>
	<!--机构名称-->
	<input type="hidden" id="org_name" name="org_name" value="${mcb.card_org_name}" />
	<!--机构编号-->
	<input type="hidden" id="org_no" name="org_no"   value="${mcb.card_org_no}"/>
	<#-- 医保参数  end -->
    <input type="hidden" id="tradeMode" name="tradeMode" value="5"/>
    <input type="hidden" id="appId" name="appId" value=""/> 
    <input type="hidden" id="appCode" name="appCode" value=""/>
    <input type="hidden" id="userId" name="userId" value="" />
    <input type="hidden" id="mchId" name="mchId" value=""/> 
    <!-- 商户key-->
    <input type="hidden" id="key" name="key" /> 
    <!-- 支付openId（支付宝支付实际未应用到此参数） -->
    <input type="hidden" id="openId" name="openId" value=""/> 
    <!-- 支付成功链接地址 -->
    <input type="hidden" id="successUrl" name="successUrl" value=""/> 
    <!-- 支付显示内容链接地址-->
    <input type="hidden" id="infoUrl" name="infoUrl" value=""/> 
    <!-- 标准平台订单号 -->
    <input type="hidden" id="orderNo" name="orderNo" value=""/> 
    <!-- 商品信息 -->
    <input type="hidden" id="subject" name="subject" value=""/>
    <!-- 支付备注 --> 
    <input type="hidden" id="payRemark" name="payRemark" value=""/> 
    <!-- 在线支付控制  :1：必须在线支付    2：不用在线支付     3：支持暂不支付 -->
    <input type="hidden" id="onlinePaymentControl" name="onlinePaymentControl" value=""/> 
    <!-- 支付超时时间 --->
    <input type="hidden" id="payTimeoutTime" name="payTimeoutTime" value=""/> 
    <!-- 暂不支付链接地址 -->
    <input type="hidden" id="afterPayUrl" name="afterPayUrl" value=""/> 
    <!-- 支付金额 -->
    <input type="hidden" id="totalFee" name="totalFee" value=""/> 
    <!-- 异步返回地址  -->
    <input type="hidden" id="notifyUrl" name="notifyUrl" value=""/> 
    <!-- 回调业务处理方法 -->
    <input type="hidden" id="notifyMethodName" name="notifyMethodName" value=""/> 
    <!-- 展示订单信息的页面的高度-->
    <input type="hidden" id="orderInfoHeight" name="orderInfoHeight" value=""/> 
    <!-- 父商户appId-->
    <input type="hidden" id="parentAppId" name="parentAppId" value=""/> 
    <!-- 父商户Secret-->
    <input type="hidden" id="parentSecret" name="parentSecret" value=""/> 
    
    <!---==================== PayAli ==================== -->
    <!---  支付公钥 --->
    <input type="hidden" id="publicKey" name="publicKey" value=""/> 
     <!--- 支付私钥 --->
    <input type="hidden" id="privateKey" name="privateKey" value=""/> 
     <!--- 卖家支付宝账号--->
    <input type="hidden" id="mchAccount" name="mchAccount" value=""/> 
     <!--- 中断返回地址 --->
    <input type="hidden" id="merchantUrl" name="merchantUrl" value=""/> 
     
    <!---==================== PayWechat ====================  --->
    <!--  子商户支付openId --->
    <input type="hidden" id="mchOpenId" name="mchOpenId" value=""/> 
     <!--- 子商户mchId --->
    <input type="hidden" id="subMchId" name="subMchId" value=""/> 
    <!--- 支付订单生成ip --->
    <input type="hidden" id="spbillCreateIp" name="spbillCreateIp" /> 
    <!--- 商户secret --->
    <input type="hidden" id="secret" name="secret" value=""/> 
    <!--- 支付prepayId --->
    <input type="hidden" id="prepayId" name="prepayId" value=""/> 
    <!--- 支付签名 --->
    <input type="hidden" id="paySign" name="paySign" value=""/> 
    <!--- 附加参数 --->
    <input type="hidden" id="attach" name="attach" value=""/> 
    <!--  支付随机数 --->
    <input type="hidden" id="nonceStr" name="nonceStr" value=""/> 
</form>
</html>
<script type="text/javascript">
var showorder=${showorder};
var datas=${datas};
var appcode=${appcode};
if(showorder=="1"){
 var reqUrl = appPath + "mobileApp/register/confirm/generateOrder";
 $.ajax({  
        type : 'POST',  
        url  : reqUrl,  
        data : datas,  
        dataType : 'json',  
        timeout  : 120000,
        success  : function(data) { 
           
            if(data.message.isSuccess){
            	if(data.message.currentRegStatus == STATE_NORMAL_HAD){
            		if(data.message.currentRegOrderNo!=null || data.message.currentOpenId !=null ){
            			var currentRegOrderNo = data.message.currentRegOrderNo;
                		var currentOpenId = data.message.currentOpenId;
                		window.location = appPath + "mobileApp/register/infos/showOrderInfo?reqSource=confirmReg&orderNo=" +currentRegOrderNo + "&openId=" + currentOpenId+"&isInsurance="+isInsurance;
            		}
              
              }else{
            		
            		$("#payForm").formEdit(data.message.pay);
            		if(data.message.tradeUrl != "" && appcode == "easyHealth"){
        				$("#payForm").attr("action" , data.message.tradeUrl);
        			}
                    $("#payForm").submit();
            	}
            }
         },  
         error : function(data) {  
            
            errorBox =  new $Y.confirm({
                content:'<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                ok:{title: '确定'}
            }) 
            
         }  
    }); 
}
</script>