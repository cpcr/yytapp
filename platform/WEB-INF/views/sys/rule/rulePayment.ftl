<html>
<head>
<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/rule/sys.rule.js"></script>
    <title>缴费规则配置</title>
</head>
<body>
<#include "./sys/common/hospital_setting.ftl">
   <div id="content-header">
        <div class="widget-title">
            <h3 class="title">缴费规则</h3>
            <#include "/sys/rule/rule_select.ftl">
        </div>
    </div>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
            <div class="widget-box bangKa">
                <div class="space10"></div>
                <form class="form-horizontal evenBg"  id="rulePaymentForm">
                    <input type="hidden" name="hospitalId" value="${rulePayment.hospitalId}"/>
                    <input type="hidden" id="id" name="id" value="${rulePayment.id}"/>
                    <div class="widget-content peiZhi">
                        <div class="row-fluid">
                            <div class="control-group w162">
                                <label class="control-label" style="padding-top: 15px">健康易支付方式配置</label>
                                <div class="controls">
                                    <div class="line">是否显示微信支付　　
                                        <label
                                            <#if rulePayment.isViewWeiXin == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewWeiXin" value="1"
                                            <#if rulePayment.isViewWeiXin == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />显示
                                        </label>
                                        <label
                                            <#if rulePayment.isViewWeiXin == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewWeiXin" value="0"
                                            <#if rulePayment.isViewWeiXin == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不显示
                                        </label>
                                    </div>
                                    <div class="line">是否使用微信支付　　
                                        <label
                                            <#if rulePayment.isUseWeiXinTrade == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseWeiXinTrade" value="1"
                                            <#if rulePayment.isUseWeiXinTrade == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />使用
                                        </label>
                                        <label
                                            <#if rulePayment.isUseWeiXinTrade == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseWeiXinTrade" value="0"
                                            <#if rulePayment.isUseWeiXinTrade == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不使用
                                        </label>
                                    </div>
                                    <div class="line">是否显示支付宝支付　
                                        <label
                                            <#if rulePayment.isViewAlipay == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewAlipay" value="1"
                                            <#if rulePayment.isViewAlipay == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />显示
                                        </label>
                                        <label
                                            <#if rulePayment.isViewAlipay == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewAlipay" value="0"
                                            <#if rulePayment.isViewAlipay == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不显示
                                        </label>
                                    </div>
                                    <div class="line">是否使用支付宝支付　
                                        <label
                                            <#if rulePayment.isUseAlipayTrade == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseAlipayTrade" value="1"
                                            <#if rulePayment.isUseAlipayTrade == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />使用
                                        </label>
                                        <label
                                            <#if rulePayment.isUseAlipayTrade == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseAlipayTrade" value="0"
                                            <#if rulePayment.isUseAlipayTrade == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不使用
                                        </label>
                                    </div>
                                    <div class="line">是否显示健康卡支付　
                                        <label
                                            <#if rulePayment.isViewHealthCard == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewHealthCard" value="1"
                                            <#if rulePayment.isViewHealthCard == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />显示
                                        </label>
                                        <label
                                            <#if rulePayment.isViewHealthCard == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewHealthCard" value="0"
                                            <#if rulePayment.isViewHealthCard == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不显示
                                        </label>
                                    </div>
                                    <div class="line">是否使用健康卡支付　
                                        <label
                                            <#if rulePayment.isUseHealthCardTrade == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseHealthCardTrade" value="1"
                                            <#if rulePayment.isUseHealthCardTrade == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />使用
                                        </label>
                                        <label
                                            <#if rulePayment.isUseHealthCardTrade == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseHealthCardTrade" value="0"
                                            <#if rulePayment.isUseHealthCardTrade == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不使用
                                        </label>
                                    </div>
                                    <div class="line">是否显示医保卡支付　
                                        <label
                                            <#if rulePayment.isViewInsuranceHealthCard == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewInsuranceHealthCard" value="1"
                                            <#if rulePayment.isViewInsuranceHealthCard == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />显示
                                        </label>
                                        <label
                                            <#if rulePayment.isViewInsuranceHealthCard == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewInsuranceHealthCard" value="0"
                                            <#if rulePayment.isViewInsuranceHealthCard == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不显示
                                        </label>
                                    </div>
                                    <div class="line">是否使用医保卡支付　
                                        <label
                                            <#if rulePayment.isUseInsuranceHealthCardTrade == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseInsuranceHealthCardTrade" value="1"
                                            <#if rulePayment.isUseInsuranceHealthCardTrade == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />使用
                                        </label>
                                        <label
                                            <#if rulePayment.isUseInsuranceHealthCardTrade == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseInsuranceHealthCardTrade" value="0"
                                            <#if rulePayment.isUseInsuranceHealthCardTrade == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不使用
                                        </label>
                                    </div>
                                    <div class="line">是否显示银联支付　　
                                        <label
                                            <#if rulePayment.isViewUnionpay == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewUnionpay" value="1"
                                            <#if rulePayment.isViewUnionpay == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />显示
                                        </label>
                                        <label
                                            <#if rulePayment.isViewUnionpay == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewUnionpay" value="0"
                                            <#if rulePayment.isViewUnionpay == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不显示
                                        </label>
                                    </div>
                                    <div class="line">是否使用银联支付　　
                                        <label
                                            <#if rulePayment.isUseUnionpayTrade == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseUnionpayTrade" value="1"
                                            <#if rulePayment.isUseUnionpayTrade == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />使用
                                        </label>
                                        <label
                                            <#if rulePayment.isUseUnionpayTrade == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseUnionpayTrade" value="0"
                                            <#if rulePayment.isUseUnionpayTrade == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不使用
                                        </label>
                                    </div>
                                    <div class="line">是否显示中信银行支付
                                        <label
                                            <#if rulePayment.isViewCITICBank == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewCITICBank" value="1"
                                            <#if rulePayment.isViewCITICBank == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />显示
                                        </label>
                                        <label
                                            <#if rulePayment.isViewCITICBank == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewCITICBank" value="0"
                                            <#if rulePayment.isViewCITICBank == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不显示
                                        </label>
                                    </div>
                                    <div class="line">是否使用中信银行支付
                                        <label
                                            <#if rulePayment.isUseCITICBankTrade == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseCITICBankTrade" value="1"
                                            <#if rulePayment.isUseCITICBankTrade == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />使用
                                        </label>
                                        <label
                                            <#if rulePayment.isUseCITICBankTrade == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isUseCITICBankTrade" value="0"
                                            <#if rulePayment.isUseCITICBankTrade == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不使用
                                        </label>
                                    </div>
                                    <div class="line">默认支付方式　
                                        <label
                                            <#if rulePayment.defaultTradeType == 7>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="defaultTradeType" value="7"
                                            <#if rulePayment.defaultTradeType == 7>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />健康卡
                                        </label>
                                        <label
                                            <#if rulePayment.defaultTradeType == 3>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="defaultTradeType" value="3"
                                            <#if rulePayment.isUseCITICBankTrade == 3>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />微信
                                        </label>
                                        <label
                                            <#if rulePayment.defaultTradeType == 4>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="defaultTradeType" value="4"
                                            <#if rulePayment.defaultTradeType == 4>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />支付宝
                                        </label>
                                        <label
                                            <#if rulePayment.defaultTradeType == 8>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="defaultTradeType" value="8"
                                            <#if rulePayment.defaultTradeType == 8>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />医保
                                        </label>
                                        <label
                                            <#if rulePayment.defaultTradeType == 5>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="defaultTradeType" value="5"
                                            <#if rulePayment.defaultTradeType == 5>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />银联
                                        </label>
                                        <label
                                            <#if rulePayment.defaultTradeType == 9>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="defaultTradeType" value="9"
                                            <#if rulePayment.defaultTradeType == 9>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />中信银行
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label" style="padding-top: 15px">页面样式及流程配置</label>
                                <div class="controls">
                                    <div class="line">门诊缴费是否支持合并支付：
                                        <label
                                            <#if rulePayment.isSupportCombinedPayments == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isSupportCombinedPayments" value="1"
                                            <#if rulePayment.isSupportCombinedPayments == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />支持
                                        </label>
                                        <label
                                            <#if rulePayment.isSupportCombinedPayments == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isSupportCombinedPayments" value="0"
                                            <#if rulePayment.isSupportCombinedPayments == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不支持
                                        </label>
                                    </div>
                                    <div class="line">门诊缴费是否支持医保结算：
                                        <label
                                            <#if rulePayment.isSupportHealthPayments == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isSupportHealthPayments" value="1"
                                            <#if rulePayment.isSupportHealthPayments == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />支持
                                        </label>
                                        <label
                                            <#if rulePayment.isSupportHealthPayments == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isSupportHealthPayments" value="0"
                                            <#if rulePayment.isSupportHealthPayments == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不支持
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label">住院押金补缴最低缴费金额</label>
                                <div class="controls" style="padding-top: 12px">
                                    <input type="text" class="span2 input33" name="hospitalDepositMinMoney" 
                                            id="hospitalDepositMinMoney" value="${rulePayment.hospitalDepositMinMoney}" />　元
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label" style="padding-top:75px">提示语配置</label>
                                <div class="controls">
                                    <div class="line">
                                        <span class="text3">门诊缴费不支持医保结算提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33"name="notSupportHealthPaymentsTip" 
                                            id="notSupportHealthPaymentsTip" value="${rulePayment.notSupportHealthPaymentsTip}" />
                                    </div>
                                    <div class="line">
                                        <span class="text3">门诊缴费支持医保结算提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33"name="supportHealthPaymentsTip" 
                                            id="supportHealthPaymentsTip" value="${rulePayment.supportHealthPaymentsTip}" />
                                    </div>
                                    <div class="line">
                                        <span class="text3">门诊缴费失败提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33"name="outpatientPaymentFailedTip" 
                                            id="outpatientPaymentFailedTip" value="${rulePayment.outpatientPaymentFailedTip}" />
                                    </div>
                                    <div class="line">
                                        <span class="text3">押金补缴失败提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33"name="depositPaymentFailedTip" 
                                            id="depositPaymentFailedTip" value="${rulePayment.depositPaymentFailedTip}" />
                                    </div>
                                    <div class="line">
                                        <span class="text3">门诊缴费支付前温馨提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33"name="clinicPrePayWarmTip" 
                                            id="clinicPrePayWarmTip" value="${rulePayment.clinicPrePayWarmTip}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space20"></div>
                    <button class="btn btn-save" type="button" onclick="ruleJS.saveRule('rulePaymentForm' , 'RulePayment')">保存</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>