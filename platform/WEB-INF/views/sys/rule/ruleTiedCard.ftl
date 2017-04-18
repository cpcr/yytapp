<html>
<head>
<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/rule/sys.rule.js"></script>
    <title>绑卡规则配置</title>
</head>
<body>
<!--sidebar-menu end-->
<!--content str-->
<#include "./sys/common/hospital_setting.ftl">
    <div id="content-header">
        <div class="widget-title">
            <h3 class="title">绑卡规则</h3>
            <#include "/sys/rule/rule_select.ftl">
        </div>
    </div>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
            <div class="widget-box bangKa">
                <div class="space10"></div>
                <form class="form-horizontal evenBg" id="ruleTiedCardForm">
                    <input type="hidden" name="hospitalId" value="${ruleTiedCard.hospitalId}"/>
                    <input type="hidden" id="id" name="id" value="${ruleTiedCard.id}"/>
                    <div class="widget-content">
                        <div class="row-fluid">
                            <div class="control-group">
                                <label class="control-label">就诊人类型</label>
                                <div class="controls ">
                                    <label
                                        <#if ruleTiedCard.visitingPersonType?contains("1")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="visitingPersonTypeArray" value="1"
                                        <#if ruleTiedCard.visitingPersonType?contains("1")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />本人
                                    </label>
                                    <label
                                        <#if ruleTiedCard.visitingPersonType?contains("2")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="visitingPersonTypeArray" value="2"
                                        <#if ruleTiedCard.visitingPersonType?contains("2")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />他人
                                    </label>
                                    <label
                                        <#if ruleTiedCard.visitingPersonType?contains("3")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="visitingPersonTypeArray" value="3"
                                        <#if ruleTiedCard.visitingPersonType?contains("3")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />儿童
                                    </label>
                                </div>
                            </div>
                             <div class="control-group">
                                <label class="control-label">就诊卡类型</label>
                                <div class="controls">
                                    <label
                                        <#if ruleTiedCard.cardType?contains("1")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="cardTypeArray" value="1"
                                        <#if ruleTiedCard.cardType?contains("1")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />就诊卡
                                    </label>
                                    <label
                                        <#if ruleTiedCard.cardType?contains("3")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="cardTypeArray" value="3"
                                        <#if ruleTiedCard.cardType?contains("3")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />医保卡 
                                    </label>
                                    <label
                                        <#if ruleTiedCard.cardType?contains("2")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="cardTypeArray" value="2"
                                        <#if ruleTiedCard.cardType?contains("2")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />社保卡
                                    </label>
                                    <label
                                        <#if ruleTiedCard.cardType?contains("4")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="cardTypeArray" value="4"
                                        <#if ruleTiedCard.cardType?contains("4")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />住院号
                                    </label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">证件类型</label>
                                <div class="controls">
                                    <label
                                        <#if  ruleTiedCard.certificatesType?contains("1")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                            <input type="checkbox" name="certificatesTypeArray" value="1"
                                                <#if ruleTiedCard.certificatesType?contains("1")>
                                                checked="checked"
                                                <#else>
                                                </#if>
                                            /> 二代身份证 
                                    </label>
                                    <label
                                        <#if ruleTiedCard.certificatesType?contains("2") >
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                            <input type="checkbox" name="certificatesTypeArray" value="2"
                                                <#if ruleTiedCard.certificatesType?contains("2")>
                                                checked="checked"
                                                <#else>
                                                </#if>
                                            /> 港澳居民身份证 
                                     </label>
                                     <label
                                        <#if ruleTiedCard.certificatesType?contains("3")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                            <input type="checkbox" name="certificatesTypeArray" value="3"
                                                <#if ruleTiedCard.certificatesType?contains("3")>
                                                checked="checked"
                                                <#else>
                                                </#if>
                                            /> 台湾居民身份证 
                                     </label>
                                     <label
                                        <#if ruleTiedCard.certificatesType?contains("4")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                            <input type="checkbox" name="certificatesTypeArray" value="4"
                                                <#if ruleTiedCard.certificatesType?contains("4")>
                                                checked="checked"
                                                <#else>
                                                </#if>
                                            /> 护照 
                                     </label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">卡号</label>
                                <div class="controls ">
                                    <label
                                        <#if ruleTiedCard.isShowCardNo == 1>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="isShowCardNo" value="1"
                                        <#if ruleTiedCard.isShowCardNo == 1>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />显示 
                                    </label>
                                    <label
                                        <#if ruleTiedCard.isShowCardNo == 0>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="isShowCardNo" value="0"
                                        <#if ruleTiedCard.isShowCardNo == 0>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />隐藏 
                                    </label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">温馨提示</label>
                                <div class="controls ">
                                                                                                        提示语内容　
                                       <input type="text" placeholder="点击输入提示语" 
                                       class="span5 input33" name="tipWarmContent" value="${ruleTiedCard.tipWarmContent}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">绑卡提示</label>
                                <div class="controls ">
                                                                                                        提示语内容　
                                       <textarea style="height:150px;" placeholder="点击输入提示语" 
                                       class="span5 input33" name="tiedCardTip_temp" id="tiedCardTip_temp" value="${ruleTiedCard.tiedCardTip}"></textarea>
                                       <input type="hidden" value="${ruleTiedCard.tiedCardTip}" name="tiedCardTip" id="tiedCardTip"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">在线建档</label>
                                <div class="controls ">
                                     <label
                                        <#if ruleTiedCard.isShowOnlineFiling == 1>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="isShowOnlineFiling" value="1"
                                        <#if ruleTiedCard.isShowOnlineFiling == 1>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />显示 
                                    </label>
                                    <label
                                        <#if ruleTiedCard.isShowOnlineFiling == 0>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="isShowOnlineFiling" value="0"
                                        <#if ruleTiedCard.isShowOnlineFiling == 0>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />隐藏 
                                    </label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">添加就诊人时需要验证内容的类型</label>
                                <div class="controls ">
                                    <label
                                        <#if ruleTiedCard.verifyConditionType?contains("1")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="verifyConditionTypeArray" value="1"
                                        <#if ruleTiedCard.verifyConditionType?contains("1")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />姓名
                                    </label>
                                    <label
                                        <#if ruleTiedCard.verifyConditionType?contains("2")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="verifyConditionTypeArray" value="2"
                                        <#if ruleTiedCard.verifyConditionType?contains("2")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />身份证 
                                    </label>
                                    <label
                                        <#if ruleTiedCard.verifyConditionType?contains("3")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="verifyConditionTypeArray" value="3"
                                        <#if ruleTiedCard.verifyConditionType?contains("3")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />手机号 
                                    </label>
                                    <label
                                        <#if ruleTiedCard.verifyConditionType?contains("4")>
                                           class="checkboxTwo inline check">
                                        <#else>
                                           class="checkboxTwo inline">
                                        </#if> 
                                        <input type="checkbox" name="verifyConditionTypeArray" value="4"
                                        <#if ruleTiedCard.verifyConditionType?contains("4")>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />卡号 
                                    </label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" style=" padding-top: 28px;">确认添加按钮</label>
                                <div class="controls ">
                                    <div class="line">
                                                                                                            未正确填写信息时提示
                                        　                                                               <input type="text" placeholder="点击输入提示语" class="span5 input33"
                                         name="inputIncorrectTip" value="${ruleTiedCard.inputIncorrectTip}" />
                                    </div>
                                    <div class="line">
                                                                                                            未完整填写信息时提示　
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33"
                                         name="inputIncompleteTip" value="${ruleTiedCard.inputIncompleteTip}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space20"></div>
                    <button class="btn btn-save" type="button" onclick="ruleJS.saveRule('ruleTiedCardForm' , 'RuleTiedCard')">保存</button>
                </form>
            </div>
        </div>

    </div>
</div>
<!--content end-->
</body>
</html>
