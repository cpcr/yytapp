<#--
	证件类型  1：二代身份证  2：港澳居民身份证  3：台湾居民身份证 4：护照
	就诊人类型  1 本人   2 他人   3 儿童
-->
<!DOCTYPE html>
<html>
<head>
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
	<meta HTTP-EQUIV="expires" CONTENT="0"> 
    <#include "/mobileApp/common/common.ftl">
    <title>住院押金补缴</title>
</head>
<body>
<div id="body" style="min-height: 910px;">
	<div id="guoHaoJiLv">
	    <div id="nav"></div>
	    <div id="js-navContent" style="display: block;">
	    	<div id="pay_detail"></div>
		    <div id="no_data"></div>
	    </div>
	</div> 
</div>

<form id="voForm" method="post">
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
	<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}" />
	<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
	<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
	<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
	<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
	<input type="hidden" id="payMode" name="payMode" value="${(commonParams.appCode == 'wechat')?string('1', '2')}" />
	<input type="hidden" id="admissionNo" name="admissionNo"  />
	<input type="hidden" id="inTime" name="inTime" />
	<input type="hidden" id="inpatientId" name="inpatientId"  />
	<input type="hidden" id="totalFee" name="totalFee" />
	<input type="hidden" id="paidFee" name="paidFee" />
	<input type="hidden" id="balanceBeforePay" name="balanceBeforePay" />
	<!-- 用户输入或选中的支付金额 -->
	<input type="hidden" id="payFee" name="payFee" value="" />
	<input type="hidden" id="forward" name="forward" value="${basePath}mobileApp/deposit/index" />
</form>

<form id="payForm" method="post" action="${tradeUrl}/pay/info/">
    <!-- 支付类型 --->
    <input type="hidden" id="tradeMode" name="tradeMode" value=""/>
    <input type="hidden" id="appId" name="appId" value=""/> 
    <input type="hidden" id="appCode" name="appCode" value=""/>
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

<#include "/mobileApp/common/yxw_footer.ftl">
<!-- 引入js -->
<script type="text/javascript" src="${basePath}mobileApp/js/common/jquery.cookie.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/inpatient/app.depositIndex.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/inpatient/card-list.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/inpatient/nav-list.js"></script>
</body>
</html>