<!DOCTYPE html>
<html>
<head>
<#include "/mobileApp/common/common.ftl">
<title>待缴费明细</title>
<style>
    .i_arrow-1 {
        float: right;
        margin:  5px 5px 0 0;
        display: inline-block;
        border: solid #339FEB;
        border-width: 1px 1px 0 0;
        width: 8px;
        height: 8px;
        transform: rotate(45deg);
    }
    .i_ok {
        float: right;
        display: inline-block;
        width: 18px;
        height: 18px;
        background: url(${basePath}mobileApp/images/icon/i-ok.png) no-repeat;
        background-size: 100%;
        vertical-align: -3px;
    }
    .yx-list2 li {
        line-height: 1.5;
        padding: 0;
        margin: 0;
    }
    .yx-list2 p {
        padding: 0;
        overflow: hidden;
    }
</style>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)">
<div id="body">

<#if ruleConfig.clinicPrePayWarmTip?exists && ruleConfig.clinicPrePayWarmTip != "">
    <div class="section">
        <div class="box-tips">
            <i class="icon-warn"></i>
            温馨提示：${ruleConfig.clinicPrePayWarmTip}
        </div>
    </div>
</#if>

<#if isFromBack!="true">
    <#-- 限定时间内的提示信息 -->
    <div id="pay-detail-title" class="section">
    <div class="box-list">
        <ul class="yx-list">
            <li>
                <div class="label">就诊人</div>
                <div class="values color666">${commonParams.encryptedPatientName}</div>
            </li>
            <li>
                <div class="label">卡号</div>
                <div class="values color666">${commonParams.cardNo}</div>
            </li>
            <li>
                <div class="label">流水号</div>
                <div class="values color666">${commonParams.omitMzFeeId}</div>
            </li>
            <li>
                <div class="label">总金额</div>
                <div class="values color666">
                    <span class="yellow fontSize140">${(commonParams.totalFee / 100)?string('0.00')}</span> 元 ${ybf}
                </div>
            </li>
        </ul>
    </div>
    <div id="pay-detail"></div>
</#if>
<#if isFromBack=="true">
    <div id="success">
        <img src="${basePath}/mobileApp/images/wait-pic.gif" width="150" />
        <div class="p color666" >正在生成支付订单...</div>
    </div>
</#if>
</div>

<form id="voForm" method="post">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}"/>
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}"/>
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}"/>
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}"/>
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}"/>
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}"/>
    <input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
    <input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}"/>
    <input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}"/>
    <input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}"/>
    <input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}"/>
    <input type="hidden" id="cardType" name="cardType" value="${commonParams.cardType}"/>
    <input type="hidden" id="cardNo" name="cardNo" value="${commonParams.cardNo}"/>
    <input type="hidden" id="patientName" name="patientName" value="${commonParams.patientName}"/>
    <input type="hidden" id="patientMobile" name="patientMobile" value="${commonParams.patientMobile}"/>
    <input type="hidden" id="payIds" name="payIds" value=""/>
    <input type="hidden" id="totalFee" name="totalFee" value="${commonParams.totalFee}"/>
    <input type="hidden" id="medicareFee" name="medicareFee" value="${commonParams.medicareFee}"/>
    <input type="hidden" id="payFee" name="payFee" value="${commonParams.payFee}"/>
    <input type="hidden" id="payMode" name="payMode" value="${(commonParams.appCode == 'wechat')?string('1', '2')}"/>
    <input type="hidden" id="tradeMode" name="tradeMode" value="${(commonParams.appCode == 'wechat')?string('1', '2')}"/>
    <input type="hidden" id="medicareType" name="medicareType" value="${commonParams.medicareType}"/>
    <input type="hidden" id="doctorName" name="doctorName" value="${commonParams.doctorName}"/>
    <input type="hidden" id="deptName" name="deptName" value="${commonParams.deptName}"/>
    <input type="hidden" id="visitWay" name="visitWay" value="${commonParams.visitWay}"/>
    <input type="hidden" id="supportMedicare" name="supportMedicare" value="${rule.isSupportHealthPayments}"/>
    <input type="hidden" id="isShowTradeMode" name="isShowTradeMode" value="${commonParams.isShowTradeMode}"/>
    <input type="hidden" id="accountAmout" name="accountAmout" value="${commonParams.accountAmout}"/>

    <input type="hidden" id="ssBillNumber" name="ssBillNumber" value="${commonParams.ssBillNumber}"/>
    <input type="hidden" id="insuranceAmout" name="insuranceAmout" value="${commonParams.insuranceAmout}"/>
    <input type="hidden" id="medicareAmout" name="medicareAmout" value="${commonParams.medicareAmout}"/>

    <input type="hidden" id="payAmount" name="payAmount" payAmout="${commonParams.payAmout}"/>
    <input type="hidden" id="isInsurance" name="isInsurance" value="${isInsurance}"/>
    <input type="hidden" id="orderNo" name="orderNo" value="${commonParams.orderNo}"/>
    <input type="hidden" id="ownership" name="ownership" value="${commonParams.ownership}"/>

    <input type="hidden" id="canUseInsurance" name="canUseInsurance" value="${commonParams.canUseInsurance}"/>
    <!--onlyUseInsurance 0 不限制 1限制只能用医保支付-->
    <input type="hidden" id="onlyUseInsurance" name="onlyUseInsurance" value="${onlyUseInsurance}"/>

    <input type="hidden" id="cancelSerialNo" name="cancelSerialNo" value="${commonParams.cancelSerialNo}"/>
    <input type="hidden" id="cancelBillNo" name="cancelBillNo" value="${commonParams.cancelBillNo}"/>

    <!-- 预结算所需参数 -->
    <input type="hidden" id="patCardTypeVO" name="patCardType" value="${commonParams.cardType}"/>
    <input type="hidden" id="patCardNoVO" name="patCardNo" value="${commonParams.cardNo}"/>
    <input type="hidden" id="mzFeeIdVO" name="mzFeeId" value="${commonParams.mzFeeId}"/>
    <input type="hidden" id="mzBillIdVO" name="mzBillId" value="${commonParams.mzBillId}"/>
    <input type="hidden" id="deptCodeVO" name="deptCode" value="${commonParams.deptCode}"/>
    <input type="hidden" id="doctorCodeVO" name="doctorCode" value="${commonParams.doctorCode}"/>

    <input type="hidden" id="tradeModeyb" name="tradeModeyb" value="${tradeModeyb}"/>
    <input type="hidden" id="payFamilyId" name="payFamilyId" value="${commonParams.familyId}"/>
    <input type="hidden" id="familyId" name="familyId" value="${commonParams.familyId}"/>
    
    <input type="hidden" id="isSupportFried" name="isSupportFried" value="${commonParams.isSupportFried}" />
    <input type="hidden" id="friedExpressId" name="friedExpressId" value="${friedExpressId}">
    <input type="hidden" id="recipeId" name="recipeId" value="${recipeId}">
</form>

<#-- 如果需要走医保结算流程，返回错误或者没有医保等，都直接以自费进行结算 -->
<#-- 是否需要进行额外的医保结算流程 -->
<input type="hidden" id="needCalcMedicare" name="needCalcMedicare" value="0"/>
<#-- 需要走医保计算流程，是否已经完成了医保结算 -->
<input type="hidden" id="hadCalcMedicare" name="hadCalcMedicare" value="0"/>

<#-- 健康易支付方式 -->
<input type="hidden" id="isViewHealthCard" name="isViewHealthCard" value="${ruleConfig.isViewHealthCard}"/>
<input type="hidden" id="isUseHealthCardTrade" name="isUseHealthCardTrade" value="${ruleConfig.isUseHealthCardTrade}"/>
<input type="hidden" id="isViewAlipay" name="isViewAlipay" value="${ruleConfig.isViewAlipay}"/>
<input type="hidden" id="isUseAlipayTrade" name="isUseAlipayTrade" value="${ruleConfig.isUseAlipayTrade}"/>
<input type="hidden" id="isViewWeiXin" name="isViewWeiXin" value="${ruleConfig.isViewWeiXin}"/>
<input type="hidden" id="isUseWeiXinTrade" name="isUseWeiXinTrade" value="${ruleConfig.isUseWeiXinTrade}"/>
<input type="hidden" id="isViewInsuranceHealthCard" name="isViewInsuranceHealthCard" value="${ruleConfig.isViewInsuranceHealthCard}"/>
<input type="hidden" id="isUseInsuranceHealthCardTrade" name="isUseInsuranceHealthCardTrade" value="${ruleConfig.isUseInsuranceHealthCardTrade}"/>
<input type="hidden" id="isViewUnionpay" name="isViewUnionpay" value="${ruleConfig.isViewUnionpay}"/>
<input type="hidden" id="isUseUnionpayTrade" name="isUseUnionpayTrade" value="${ruleConfig.isUseUnionpayTrade}"/>
<input type="hidden" id="isViewCITICBank" name="isViewCITICBank" value="${ruleConfig.isViewCITICBank}"/>
<input type="hidden" id="isUseCITICBankTrade" name="isUseCITICBankTrade" value="${ruleConfig.isUseCITICBankTrade}"/>
<input type="hidden" id="isUseCITICBankTrade" name="isUseCITICBankTrade" value="${ruleConfig.isUseCITICBankTrade}"/>
<input type="hidden" id="defaultTradeType" name="defaultTradeType" value="${ruleConfig.defaultTradeType}"/>

<#-- add by zkw 2016-05-14 -->
<input type="hidden" id="hospitalAppId" name="hospitalAppId" value="${hospitalAppId}"/>

<input type="hidden" id="isFromBack" name="isFromBack" value="${isFromBack}">

<input type="hidden" id="medicarePayUrl" name="medicarePayUrl" value="${tradeUrl}/pay/info3/">
<input type="hidden" id="friedExpress" name="friedExpress" value="${friedExpress}">
<form id="payForm" method="post" action="${tradeUrl}/pay/info2/">
    <#-- 医保参数 start -->
    <!-- 是否医保卡支付 0 不是 1 是 -->
    <input type="hidden" id="isInsurance" name="isInsurance" value="0"/>
    <!--医疗证号 -->
    <input type="hidden" id="medicalCardNo" name="medicalCardNo" value="${medical_id}"/>
    <!--医保卡号-->
    <input type="hidden" id="medicareCardNo" name="medicareCardNo" value="${medical_no}"/>
    <!--机构名称-->
    <input type="hidden" id="org_name" name="org_name" value="${card_name}"/>
    <!--机构编号-->
    <input type="hidden" id="org_no" name="org_no" value="${card_no}"/>
    <input type="hidden" id="ssBillNumber" name="ssBillNumber" value=""/>
    <#-- 医保参数 end -->
    <!--医院编码 -->
    <input type="hidden"  name="hospitalCode" value="${commonParams.hospitalCode}" />
    <input type="hidden"  name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
    <#--医院编码end-->
    <!-- 支付类型 --->
    <input type="hidden" id="tradeMode" name="tradeMode" value=""/>
    <input type="hidden" id="tradeModeyb" name="tradeModeyb" value="${tradeModeyb}"/>

    <input type="hidden" id="appId" name="appId" value=""/>
    <input type="hidden" id="appCode" name="appCode" value=""/>
    <input type="hidden" id="mchId" name="mchId" value=""/>
    <!-- 商户key -->
    <input type="hidden" id="key" name="key"/>
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
    <input type="hidden" id="onlinePaymentControl" name="onlinePaymentControl" value="1"/>
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
    <input type="hidden" id="spbillCreateIp" name="spbillCreateIp"/>
    <!--- 商户secret --->
    <input type="hidden" id="secret" name="secret" value=""/>
    <!--- 支付prepayId --->
    <input type="hidden" id="prepayId" name="prepayId" value=""/>
    <!--- 支付签名 --->
    <input type="hidden" id="paySign" name="paySign" value=""/>
    <!--- 附加参数 --->
    <input type="hidden" id="attach" name="attach" value=""/>

    <input type="hidden" id="insuranceAmout" name="insuranceAmout" value=""/>
    <input type="hidden" id="medicareAmout" name="medicareAmout" value=""/>
    <input type="hidden" id="accountAmout" name="accountAmout" value=""/>
    <input type="hidden" id="payAmout" name="payAmout" value=""/>

    <input type="hidden" id="userId" name="userId" value=""/>

    <!-- 预结算所需参数 -->
    <input type="hidden" id="cancelBillNoVOO" name="cancelBillNo" value=""/>
    <input type="hidden" id="cancelSerialNoVOO" name="cancelSerialNo" value=""/>
    <input type="hidden" id="sSBillNoVOO" name="sSBillNo" value=""/>
    <input type="hidden" id="sSFeeNoVOO" name="sSFeeNo" value=""/>
    <input type="hidden" id="mzFeeIdVOO" name="mzFeeId" value=""/>
    <input type="hidden" id="mzBillIdVOO" name="mzBillId" value=""/>
    <input type="hidden" id="friedExpressId" name="friedExpressId" value="${friedExpressId}">
    <input type="hidden" id="recipeId" name="recipeId" value="">
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
<script type="text/javascript" src="${basePath}mobileApp/js/common/nav-list.js"></script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/clinic/app.payDetail.js?v=1.49"></script>
<script type="text/javascript">
    $(function () {
        var isFromBack = $("#isFromBack").val();
        if (isFromBack && isFromBack == "true") {
            payDetail.medicarePay();
        }

        if (IS.isMacOS) {
            try {
                setTimeout("appHideNavRefresh();", 1000);
            } catch (e) {

            }
        } else if (IS.isAndroid) {
            try {
                window.yx129.appHideNavRefresh();
            } catch (e) {

            }
        }
    });

    function doGoBack() {
        var freshFrom = $("<form></form>");
        freshFrom.append($('<input type="hidden"  name="openId" value="${commonParams.openId}" />'));
        freshFrom.append($('<input type="hidden"  name="appCode" value="${commonParams.appCode}" />'));
        freshFrom.append($('<input type="hidden"  name="appId" value="${commonParams.appId}" />'));
        freshFrom.append($('<input type="hidden"  name="areaCode" value="${commonParams.areaCode}" />'));
        freshFrom.append($('<input type="hidden"  name="cardType" value="${commonParams.cardType}" />'));
        freshFrom.append($('<input type="hidden"  name="cardNo" value="${commonParams.cardNo}" />'));
        freshFrom.append($('<input type="hidden"  name="visitWay" value="${commonParams.visitWay}" />'));
        freshFrom.append($('<input type="hidden"  name="hospitalCode" value="${commonParams.hospitalCode}" />'));
        freshFrom.append($('<input type="hidden"  name="hospitalId" value="${commonParams.hospitalId}">'));
        freshFrom.append($('<input type="hidden"  name="hospitalName" value="${commonParams.hospitalName}" />'));
        freshFrom.append($('<input type="hidden"  name="branchHospitalName" value="${commonParams.branchHospitalName}" />'));
        freshFrom.append($('<input type="hidden"  name="branchHospitalId" value="${commonParams.branchHospitalId}" />'));
        freshFrom.append($('<input type="hidden"  name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />'));
        freshFrom.appendTo("body");
        freshFrom.css('display', 'none');
        freshFrom.attr("method", "post");
        var url = "${basePath}easyhealth/clinic/payIndex";
        if ($('#visitWay').val() == '1') {
            url = "${basePath}easyhealth/clinic/payIndexFromMsg";
        }
        freshFrom.attr("action", url);
        freshFrom.submit();
    }

    function chooce_mzYB(domObj) {
        var obj = $(domObj).find('i').first();
        if (obj.hasClass('icon-switch-right')) {
            obj.removeClass('icon-switch-right');
            var query = appPath + "/mobileApp/clinic/payDetail";
            window.location.href = query;
        } else {
            obj.addClass('icon-switch-right');
            var query = appPath + "/mobileApp/medicalcard/bind/queryauthrize?createandpay_source_flag=1&appId=${commonParams.appId}&hospitalAppId=${hospitalAppId}";
            window.location.href = query;
        }
    }
</script>
</body>
</html>
