<html>
<head>
    <#include "/mobileApp/common/common.ftl">
    <title>挂号详情</title>
</head>
<body>
<div id="body">
    <div id="guoHao">

        <#if record.barcode?exists >
        <div class="box-list" style="padding: .5em;">
             <div>条形码</div>
                <div class="barCode">
                    <div id="barcodeTarget" class="barcodeTarget" style="margin: 0 auto;"></div>
            </div>
        </div>
        </#if>

        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">姓名</div>
                    <div class="values color666">${record.patientName}</div>
                    <#-- bug:71 挂号详情页面，就诊人姓名不脱敏 -->
                    <#--<div class="values color666">${record.encryptedPatientName}</div>-->
                </li>
                <li>
                    <div class="label">就诊卡号</div>
                    <div class="values color666">${record.cardNo}</div>
                </li>
            </ul>
        </div>

        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">科室</div>
                    <div class="values color666">${record.deptName}</div>
                </li>
                <li>
                    <div class="label">医生</div>
                    <div class="values color666">${record.doctorName} 
                    <#if !record.doctorTitle ??>
                    (${record.doctorTitle})
                    </#if>
                    </div>
                </li>
                <li>
                    <div class="label" style="max-width: 10em">挂号费</div>
                    <div class="values color666">
                        <span class="price">${((record.realRegFee + record.realTreatFee) / 100)?string("0.##")}</span> 元 
                        <span class="priceColor">
                            <#if     record.payStatus == 1 >
                                (未缴费)
                            <#elseif record.payStatus == 2>
                                (已缴费)
                            <#elseif record.payStatus == 3>
                                (已退费)
                            <#elseif record.payStatus == 4>
                                (处理中)
                            <#elseif record.payStatus == 5 >
                                (处理中)
                            <#else>
                                (网络异常,系统处理中)
                            </#if>
                        </span>
                    </div>
                </li>

                <li>
                    <div class="label">就诊地点</div>
                    <div class="values color666">${record.visitLocation}</div>
                </li>
                <li>
                    <div class="label">预约时间</div>
                    <div class="values color666">${record.scheduleDate?string('yyyy-MM-dd')}  
                    <#if record.beginTime?exists && record.endTime?exists >
                        ${record.beginTime?string('HH:mm')}-${record.endTime?string('HH:mm')}
                    <#elseif record.beginTime?exists && !record.endTime?exists>
                        ${record.beginTime?string('HH:mm')}
                    <#else>
                        <#if record.timeFlag == '1'>
                                                                        上午
                        </#if>
                        <#if record.timeFlag == '2'>
                                                                        下午
                        </#if>
                        <#if record.timeFlag == '3'>
                                                                        晚上
                        </#if>
                        <#if record.timeFlag == '4'>
                                                                        全天
                        </#if>
                    </#if>
                   </div>
                </li>
                <li>
                    <div class="label">排队号</div>
                    <div class="values color666">
                        <#if record.serialNum?length gt 5>
                        <#-- bug:46 支付宝服务窗挂号详情页面排队号字体显示不一致 -->
                        ${record.serialNum}
                        <#else>
                        ${record.serialNum} 号
                        </#if>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <#if isSupportRefund == 9 && record.payStatus == 2>
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
        <#if ruleConfig.regSuccessOnDutyTip ??>
            ${ruleConfig.regSuccessOnDutyTip}
        </#if>
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <#elseif record.regStatus == 1 && record.payStatus == 2>
    <!--挂号成功（已缴费）-->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
        <#if record.regType == 1>
            ${ruleConfig.regSuccessHadPayTip}
        <#else>
            ${ruleConfig.regSuccessOnDutyTip}
        </#if>
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn-inline">
            <button type="button" class="btn btn-cancel btn-block" id="refundBtn" onclick="refundConfirm(this)">取消预约</button>
            <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
        </div>
        <!--
        <div class="btn btn-ok btn-block" onclick="goDidipasnger()">滴滴打车</div>
        -->
    </div>
    <!--挂号成功（已缴费） end-->

    <#elseif record.regStatus == 1 && record.payStatus == 1 && record.onlinePaymentType == 3>
    <!--挂号成功 （未缴费）-->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
            <#if ruleConfig.regSuccessNoPayTip ??>
                ${ruleConfig.regSuccessNoPayTip}
            <#else>
                                          请在就诊时间段开始前30分钟在医院窗口或手机支付挂号费,否则号源将会作废,并视为爽约.
            </#if>
        </div>
    </div>
    <div class="section btn-w">
        <#--
            <button type="button" class="btn btn-cancel btn-block " onclick="cancelRegister(this)">取消预约</button>
        -->
            <button type="button" class="btn btn-block" id="payBtn" onclick="payMentReg(this)">支付取号</button>
    </div>
    <!--挂号成功 （未缴费） end-->

    <#elseif record.regStatus == 1 && record.payStatus == 1 && record.onlinePaymentType == 2>
    <!--挂号成功 -->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
            <#if ruleConfig.regSuccessNoPayTip ??>
                ${ruleConfig.regSuccessNoPayTip}
            <#else>
                                          请在就诊时间段开始前30分钟在医院窗口或手机支付挂号费,否则号源将会作废,并视为爽约.
            </#if>
        </div>
    </div>
    <div class="section btn-w">
        <#--
            <button type="button" class="btn btn-cancel btn-block " onclick="cancelRegister(this)">取消预约</button>
            -->
            <div class="btn btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <!--挂号成功  end-->

    <#elseif record.regStatus == 10 && record.payStatus == 3>
    <!--挂号失败（已退费） -->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
                                因网络异常,该挂号失败,挂号费已退回,请注意查收,如需挂号请重新选择.
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <!--挂号失败（已退费） end-->
    
    <#elseif record.regStatus == 3 && record.payStatus == 1>
    <!--挂号超时 -->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
            <#if ruleConfig.regPayTimeOutTip ??>
                ${ruleConfig.regPayTimeOutTip}
            <#else>
                                          该挂号在规定时间内没支付,已被取消.
            </#if>
           
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <!--挂号超时 end-->

    <#elseif record.regStatus == 4>
    <!--取消挂号(停诊退费） -->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
                                    因医生临时停诊,该挂号已被取消,挂号费已被退回,请选择其它医生挂号.
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <!--取消挂号(停诊退费）end -->
    
    <#elseif record.regStatus == 2 && record.payStatus == 3>
    <!--取消挂号(已退费） -->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
                            该挂号已被取消,挂号费已被退回,请注意查收.
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <!--取消挂号(已退费）end -->

    <#elseif record.regStatus == 2 && record.payStatus == 1>
    <!--取消挂号 -->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
          该挂号已被取消,如需挂号,请重新预约.
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <!--取消挂号end -->

    <#elseif record.regStatus == 0 && record.payStatus == 1>
    <!--挂号（锁号中） -->
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
            <input type="hidden" id="leftSecond" value="${leftSecond}">
                                温馨提示：请在<span id="leftSecondSpan" style="color: red;"></span>分钟内完成支付，逾期号源将会作废，需要重新挂号。
        </div>
    </div>
    <div class="section btn-w">
        <#--
            <button type="button" class="btn btn-cancel btn-block" onclick="cancelRegister(this)">取消预约</button>
            -->
            <button type="button" class="btn btn-block" id="payBtn" onclick="payMentReg(this)">支付取号</button>
    </div>
    <!--挂号（锁号中）end -->
    <#elseif record.regStatus == 6 || record.regStatus == 9>
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
                            因网络原因支付异常,系统核实中..
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <#elseif record.regStatus == 7 || record.regStatus == 8>
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
                            因网络原因挂号异常,系统处理中..
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block" onclick="goRegInfoList()">确定</div>
    </div>
    <#elseif record.regStatus == 11>
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
                            业务异常,系统无法自动处理,请联系客服人工处理,对您造成不便,深感抱歉.
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block " onclick="goRegInfoList()">确定</div>
    </div>
    <#elseif record.regStatus == 12>
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
                            业务异常,系统无法自动处理,请到医院窗口处理,对您造成不便,深感抱歉.
        </div>
    </div>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block " onclick="goRegInfoList()">确定</div>
    </div>
    <#else>
    <div class="section btn-w">
        <div class="btn btn-ok btn-block " onclick="goRegInfoList()">确定</div>
    </div> 
    </#if>
</div>
<form id="paramsForm" method="post">
    <!-- 支付类型 --->
    <input type="hidden" id="tradeMode" name="tradeMode" value="${payParams.tradeMode}"/>
    <input type="hidden" id="appId" name="appId" value="${record.appId}" />
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
    <input type="hidden" id="appCode" name="appCode" value="${record.appCode}" />
    <input type="hidden" id="hospitalId" name="hospitalId" value="${record.hospitalId}" />
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="${record.hospitalCode}" />
    <input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${record.branchHospitalId}" />
    <input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${record.branchHospitalCode}" />
    <input type="hidden" id="openId" name="openId"  value="${record.openId}"/>
    <input type="hidden" id="patientName" name="patientName"  value="${record.patientName}"/>
    <input type="hidden" id="cardNo" name="cardNo"  value="${record.cardNo}"/>
    <input type="hidden" id="deptName" name="deptName"  value="${record.deptName}"/>
    <input type="hidden" id="doctorName" name="doctorName"  value="${record.doctorName}"/>
    <input type="hidden" id="doctorTitle" name="doctorTitle"  value="${record.doctorTitle}"/>
    <input type="hidden" id="realRegFee" name="realRegFee"  value="${record.realRegFee}"/>
    <input type="hidden" id="realTreatFee" name="realTreatFee"  value="${record.realTreatFee}"/>
    <input type="hidden" id="visitLocation" name="visitLocation"  value="${record.visitLocation}"/>
    <input type="hidden" id="scheduleDate" name="scheduleDate"  value="${record.scheduleDate?string('yyyy-MM-dd')}"/>
    <#if record.beginTime??>
    <input type="hidden" id="beginTime" name="beginTime"  value="${record.beginTime?string('HH:mm')}"/>
    </#if>
    <#if record.endTime??>
    <input type="hidden" id="endTime" name="endTime"  value="${record.endTime?string('HH:mm')}"/>
    </#if>
    <input type="hidden" id="serialNum" name="serialNum"  value="${record.serialNum}"/> 
    <input type="hidden" id="regStatus" name="regStatus"  value="${record.regStatus}"/>
    <input type="hidden" id="payStatus" name="payStatus"  value="${record.payStatus}"/>
    <input type="hidden" id="orderNo" name="orderNo"  value="${record.orderNo}"/>
    <input type="hidden" id="hisOrdNo" name="hisOrdNo"  value="${record.hisOrdNo}"/>
    <input type="hidden" id="regMode" name="regMode"  value="${record.regMode}"/>
    <input type="hidden" id="regType" name="regType"  value="${record.regType}"/>
    <input type="hidden" id="agtOrdNum" name="agtOrdNum" value="${record.agtOrdNum}" />
    <input type="hidden" id="recordTitle" name="recordTitle" value="${record.recordTitle}" />
    <input type="hidden" id="receiptNum" name="receiptNum" value="${record.receiptNum}" />
    <input type="hidden" id="refundHisOrdNo" name="refundHisOrdNo" value="${record.refundHisOrdNo}" />
    
    <input type="hidden" id="failMsg" name="failMsg" />
</form>


<#if record.payStatus == 1 && isCanPayMent>
<form id="payForm" method="post" action="${tradeUrl}/pay/info/">
    <!-- 支付类型 --->
    <input type="hidden" id="tradeMode" name="tradeMode" value="${payParams.tradeMode}"/>
    <input type="hidden" id="tradeModeyb" name="tradeModeyb" value="${payParams.tradeModeyb}"/>
    <input type="hidden" id="org_name" name="org_name"  value="${payParams.org_name}"/>
    <input type="hidden" id="appId" name="appId" value="${record.appId}"/> 
    <input type="hidden" id="appCode" name="appCode" value="${record.appCode}"/>
    <input type="hidden" id="mchId" name="mchId" value="${payParams.mchId}"/> 
    <!-- 商户key-->
    <input type="hidden" id="key" name="key" value="${payParams.key}" /> 
    <!-- 支付openId（支付宝支付实际未应用到此参数） -->
    <input type="hidden" id="openId" name="openId" value="${payParams.openId}"/> 
    <!-- 支付成功链接地址 -->
    <input type="hidden" id="successUrl" name="successUrl" value="${payParams.successUrl}"/> 
    <!-- 支付显示内容链接地址-->
    <input type="hidden" id="infoUrl" name="infoUrl" value="${payParams.infoUrl}"/> 
    <!-- 标准平台订单号 -->
    <input type="hidden" id="orderNo" name="orderNo" value="${record.orderNo}"/> 
    <!-- 商品信息 -->
    <input type="hidden" id="subject" name="subject" value="${record.recordTitle}"/>
    <!-- 支付备注 --> 
    <input type="hidden" id="payRemark" name="payRemark" value="${payParams.payRemark}"/> 
    <!-- 在线支付控制  :1：必须在线支付    2：不用在线支付     3：支持暂不支付 -->
    <input type="hidden" id="onlinePaymentControl" name="onlinePaymentControl" value="${payParams.onlinePaymentControl}"/> 
    <!-- 支付超时时间 --->
    <input type="hidden" id="payTimeoutTime" name="payTimeoutTime" value="${payParams.payTimeoutTime}"/> 
    <!-- 暂不支付链接地址 -->
    <input type="hidden" id="afterPayUrl" name="afterPayUrl" value="${payParams.afterPayUrl}"/> 
    <!-- 支付金额 -->
    <input type="hidden" id="totalFee" name="totalFee" value="${payParams.totalFee}"/> 
    <!-- 异步返回地址  -->
    <input type="hidden" id="notifyUrl" name="notifyUrl" value="${payParams.notifyUrl}"/> 
    <!-- 回调业务处理方法 -->
    <input type="hidden" id="notifyMethodName" name="notifyMethodName" value="${payParams.notifyMethodName}"/> 
    <!-- 展示订单信息的页面的高度-->
    <input type="hidden" id="orderInfoHeight" name="orderInfoHeight" value="${payParams.orderInfoHeight}"/> 
    <!-- 父商户appId-->
    <input type="hidden" id="parentAppId" name="parentAppId" value="${payParams.parentAppId}"/> 
    <!-- 父商户Secret-->
    <input type="hidden" id="parentSecret" name="parentSecret" value="${payParams.parentSecret}"/> 
    <!---==================== PayAli ==================== -->
    <!---  支付公钥 --->
    <input type="hidden" id="publicKey" name="publicKey" value="${payParams.publicKey}"/> 
     <!--- 支付私钥 --->
    <input type="hidden" id="privateKey" name="privateKey" value="${payParams.privateKey}"/> 
     <!--- 卖家支付宝账号--->
    <input type="hidden" id="mchAccount" name="mchAccount" value="${payParams.mchAccount}"/> 
     <!--- 中断返回地址 --->
    <input type="hidden" id="merchantUrl" name="merchantUrl" value="${payParams.merchantUrl}"/> 
     
    <!---==================== PayWechat ====================  --->
    <!--  子商户支付openId --->
    <input type="hidden" id="mchOpenId" name="mchOpenId" value="${payParams.mchOpenId}"/> 
     <!--- 子商户mchId --->
    <input type="hidden" id="subMchId" name="subMchId" value="${payParams.subMchId}"/> 
    <!--- 支付订单生成ip --->
    <input type="hidden" id="spbillCreateIp" name="spbillCreateIp" value="${payParams.spbillCreateIp}" /> 
    <!--- 商户secret --->
    <input type="hidden" id="secret" name="secret" value="${payParams.secret}"/> 
    <!--- 支付prepayId --->
    <input type="hidden" id="prepayId" name="prepayId" value="${payParams.prepayId}"/> 
    <!--- 支付签名 --->
    <input type="hidden" id="paySign" name="paySign" value="${payParams.paySign}"/> 
    <!--- 附加参数 --->
    <input type="hidden" id="attach" name="attach" value="${payParams.attach}"/> 
    <!--  支付随机数 --->
    <input type="hidden" id="nonceStr" name="nonceStr" value="${payParams.nonceStr}"/> 
</form>
</#if>

<#if record.payStatus == 2>
<form id="refundForm" method="post" action="${tradeUrl}/refund/info/">
    <!-- 交易类型 -->
    <input type="hidden" id="tradeMode" name="tradeMode" />
    <!-- 商户appId -->
    <input type="hidden" id="appId" name="appId" />
    <!-- 商户appCode -->
    <input type="hidden" id="appCode" name="appCode" />
    <!-- openId -->
    <input type="hidden" id="openId" name="openId" />
    <!-- 商户mchId -->
    <input type="hidden" id="mchId" name="mchId" />
    <!-- 商户key -->
    <input type="hidden" id="key" name="key" />
    <!-- 掌上医院标准平台支付订单号 -->
    <input type="hidden" id="orderNo" name="orderNo" />
    <!-- 掌上医院标准平台退款订单号 -->
    <input type="hidden" id="refundOrderNo" name="refundOrderNo" />
    <!-- 第3方交易机构支付订单号 -->
    <input type="hidden" id="agtOrdNum" name="agtOrdNum" />
    <!-- 退款备注 -->
    <input type="hidden" id="refundRemark" name="refundRemark" />
    
    
    <!-- 退款失败链接地址 -->
    <input type="hidden" id="failUrl" name="failUrl" />
    <!-- 业务处理链接地址   接附加参数调用 要求返回 1：成功 0：失败 -->
    <input type="hidden" id="dealWithUrl" name="dealWithUrl" />
    <!-- 退款成功链接地址 -->
    <input type="hidden" id="successUrl" name="successUrl" />
    
    <!-- 总金额 -->
    <input type="hidden" id="totalFee" name="totalFee" />
    <!-- 退款金额 -->
    <input type="hidden" id="refundFee" name="refundFee" />
    
    
    <!-- ************************** Ali param ***************************** -->
    <!-- 支付宝私钥 -->
    <input type="hidden" id="privateKey" name="privateKey" />
    <!-- 支付公钥 -->
    <input type="hidden" id="publicKey" name="publicKey" />
    <!-- 支付宝卖家帐号 -->
    <input type="hidden" id="mchAccount" name="mchAccount" />
    <!-- 退款请求时间退款请求的当前时间。格式为：yyyy-MM-dd hh:mm:ss -->
    <input type="hidden" id="refundDate" name="refundDate" />
    
    <!-- 
                        退款批次号
                        每进行一次即时到账批量退款，都需要提供一个批次号，通过该批次号可以查询这一批次的退款交易记录，对于每一个合作伙伴，传递的每一个批次号都必须保证唯一性。
                        格式为：退款日期（8位）+流水号（3～24位）。
                        不可重复，且退款日期必须是当天日期。流水号可以接受数字或英文字符，建议使用数字，但不可接受“000”。 
    -->
    <input type="hidden" id="batchNo" name="batchNo" />
    <!-- 
                        总笔数
                        总笔数 即参数detail_data的值中，“#”字符出现的数量加1，最大支持1000笔（即“#”字符出现的最大数量为999个）。
         2011011201037066^5.00^协商退款
    -->
    <input type="hidden" id="batchNum" name="batchNum" />
    <!-- 单笔数据集 退款请求的明细数据 -->
    <input type="hidden" id="detailData" name="detailData" />

    <!-- ************************* Wechat params **************************************** -->
    <!-- 子商户mchId -->
    <input type="hidden" id="subMchId" name="subMchId" />
    <!-- 操作员帐号，默认为商户号 -->
    <input type="hidden" id="opUserId" name="opUserId" />
    <!-- 退款签名 -->
    <input type="hidden" id="refundSign" name="refundSign" />
    <!-- 退款随机数 -->
    <input type="hidden" id="nonceStr" name="nonceStr" />
    <!-- 附加参数 -->
    <input type="hidden" id="attach" name="attach" />
    <!-- 退款配置ID -->
    <input type="hidden" id="paySettingId" name="paySettingId" />
    <!-- 退款配置密钥文件名 -->
    <input type="hidden" id="refundFileName" name="refundFileName" />
    <!-- 子商户mchId -->
    <input type="hidden" id="parentAppId" name="parentAppId" />
    <!-- 子商户mchId -->
    <input type="hidden" id="parentSecret" name="parentSecret" />
</form>
</#if>
<#include "/mobileApp/common/yxw_footer.ftl">
    <script type="text/javascript" src="${basePath}mobileApp/js/common/jquery-barcode.min.js"></script>
</body>
</html>
<script type="text/javascript">
$(function(){
    //隐藏刷新
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

    generateBarcode('${record.barcode}');
});

function generateBarcode(barcode) {
    // 内容
    var value = barcode;

    // 码制（看医院）
    var codeStyle = '4';

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
        addQuietZone: false
    };

    $("#barcodeTarget").html("").show().barcode(value, btype, settings);
};

var msgInfo = '${msgInfo}';
if(msgInfo != ""){
  var msgInfoBox = new $Y.confirm({
        content:'<div>' + msgInfo + '</div>',
        ok:{
            title: '确定',
            click:function(){ //参数可为空，没有默认方法,不会自动关闭窗体，可用  myBox.close()来关闭  
                msgInfoBox.close();
            }
        }
  }); 
}

var isCanPayMent = '${isCanPayMent}';
</script>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/registerinfo/app.regRecordInfo.js"></script>