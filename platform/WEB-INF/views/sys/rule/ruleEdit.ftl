<html>
<head>
<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/rule/sys.rule.js"></script>
    <title>编辑规则配置</title>
</head>
<body>
<!--sidebar-menu end-->
<!--content str-->
<#include "./sys/common/hospital_setting.ftl">
    <div id="content-header">
        <div class="widget-title">
            <h3 class="title">全局规则</h3>
            <#include "/sys/rule/rule_select.ftl">
        </div>
    </div>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
            <div class="widget-box bangKa">
                <div class="space10"></div>
                <form class="form-horizontal evenBg" id="editRuleForm">
                    <input type="hidden" name="hospitalId" value="${ruleEdit.hospitalId}"/>
                    <input type="hidden" id="id" name="id" value="${ruleEdit.id}"/>
                    <div class="widget-content">
                        <div class="row-fluid">
                            <div class="control-group">
                                <label class="control-label">页面皮肤配置</label>
                                <div class="controls">
                                    <span class="sub_label">微信服务号：</span>
                                    <#if ruleEdit.skinWeixinType == 0>
                                         <label  class="radio inline check">
                                    <#else>
                                         <label  class="radio inline">
                                    </#if> 
                                         <input type="radio" name="skinWeixinType"  value="0"  
                                               <#if ruleEdit.skinWeixinType == 0>
                                                    checked="checked"
                                               <#else>
                                               </#if>
                                         />蓝色
                                    </label>
                                    
                                    <label 
                                         <#if ruleEdit.skinWeixinType == 1>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if> 
                                         <input type="radio" name="skinWeixinType"  value="1"
                                               <#if ruleEdit.skinWeixinType == 1>
                                                    checked="checked"
                                               <#else></#if> 
                                         />绿色
                                    </label>
                                    

                                    <span  class="sub_label p83">支付宝服务窗：</span>
                                    <label 
                                        <#if ruleEdit.skinAlipayType == 0>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="skinAlipayType"  value="0" 
                                           <#if ruleEdit.skinAlipayType == 0>checked="checked"<#else></#if>
                                        />蓝色
                                    </label>
                                    <label 
                                         <#if ruleEdit.skinAlipayType == 1>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="skinAlipayType"  value="1"
                                            <#if ruleEdit.skinAlipayType == 1>checked="checked"<#else></#if>
                                        />绿色
                                    </label>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label">是否有分院</label>
                                <div class="controls ">
                                     <label 
                                        <#if ruleEdit.isHasBranch == 1>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="isHasBranch"  value="1" 
                                           <#if ruleEdit.isHasBranch == 1>checked="checked"<#else></#if>
                                        />是
                                    </label>
                                    <label 
                                         <#if ruleEdit.isHasBranch == 0>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="isHasBranch"  value="0"
                                            <#if ruleEdit.isHasBranch == 0>checked="checked"<#else></#if>
                                        />否
                                    </label>
                                </div>
                            </div>
                             <div class="control-group">
                                <label class="control-label">是否显示平台菜单</label>
                                <div class="controls">
                                     <label 
                                        <#if ruleEdit.isShowAppMenu == 1>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="isShowAppMenu"  value="1" 
                                           <#if ruleEdit.isShowAppMenu == 1>checked="checked"<#else></#if>
                                        />是
                                    </label>
                                    <label 
                                         <#if ruleEdit.isShowAppMenu == 0>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="isShowAppMenu"  value="0"
                                            <#if ruleEdit.isShowAppMenu == 0>checked="checked"<#else></#if>
                                        />否
                                    </label>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" style=" padding-top: 0px;">添加就诊人配置</label>
                                <div class="line">同一个账号允许添加就诊人个数：
                                    <input type="text" name="addVpNum" id="addVpNum" value="${ruleEdit.addVpNum}" class="span1 input33"/> 个
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" style=" padding-top: 28px;">停诊信息推送配置</label>
                                <div class="controls ">
                                    <div class="line">
                                        <span class="sub_label">接受停诊信息方式：</span>
                                        <label 
                                            <#if ruleEdit.acceptStopInfoType == 0>
                                                class="radio inline check">
                                            <#else>
                                                class="radio inline">
                                            </#if>
                                           <input type="radio" name="acceptStopInfoType" value="0"
                                                <#if ruleEdit.acceptStopInfoType == 0>checked="checked"<#else></#if> 
                                           >医院HIS主动推送
                                        </label>
                                        <label 
                                            <#if ruleEdit.acceptStopInfoType == 1>
                                                class="radio inline check">
                                            <#else>
                                                class="radio inline">
                                            </#if>
                                            <input type="radio" name="acceptStopInfoType" value="1"
                                                <#if ruleEdit.acceptStopInfoType == 1>checked="checked"<#else></#if> 
                                            />云医通定时轮询
                                        </label>
                                    </div>
                                    <div class="line">推送停诊信息时间：
                                        <input type="text" class="span2 input33" id="pushInfoTime" 
                                               name="pushInfoTime" 
                                            <#if ruleEdit.pushInfoTime ??>
                                                 value="${ruleEdit.pushInfoTime?string('HH:mm')}"
                                            <#else>
                                                 value=""
                                            </#if> 
                                         /> (例如18:00)
                                    </div>
                                    <div class="line">停诊查询天数：
                                        <input type="text" class="span2 input33" id="pushInfoDay" name="pushInfoDay" 
                                        	<#if ruleEdit.pushInfoDay ??>
                                                 value="${ruleEdit.pushInfoDay}"
                                            <#else>
                                                 value="1"
                                            </#if> 
                                         /> (默认一天)
                                    </div>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">获取患者门诊缴费信息的方式</label>
                                <div class="controls" style="padding-top: 20px">
                                    <label 
                                        <#if ruleEdit.paymentInfoGetType == 0>
                                             class="radio inline check">
                                        <#else>
                                             class="radio inline">
                                        </#if> 
                                        <input type="radio" name="paymentInfoGetType" value="0"
                                            <#if ruleEdit.paymentInfoGetType == 0>checked="checked"<#else></#if> 
                                        >医院HIS主动推送
                                    </label>
                                    <label 
                                        <#if ruleEdit.paymentInfoGetType == 1>
                                             class="radio inline check">
                                        <#else>
                                             class="radio inline">
                                        </#if> 
                                        <input type="radio" name="paymentInfoGetType" value="1"
                                            <#if ruleEdit.paymentInfoGetType == 1>checked="checked"<#else></#if> 
                                        />云医通定时轮询
                                    </label>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label" style="padding-top: 32px">住院功能查询控制</label>
                                <div class="controls ">
                                     <div class="inline">
                                            <#if ruleEdit.inpatientInquiryMode == 0>
                                                <label class="radio check">
                                            <#else>
                                                <label class="radio">
                                            </#if> 
                                            <input type="radio" name="inpatientInquiryMode" value="0"
                                                 <#if ruleEdit.inpatientInquiryMode == 0>checked="checked"<#else></#if> 
                                            />仅通过门诊信息查询住院信息
                                            </label>
                                    </div>
                                    <div class="inline">
                                        <#if ruleEdit.inpatientInquiryMode == 1>
                                             <label class="radio check">
                                        <#else>
                                             <label class="radio">
                                        </#if> 
                                        <input type="radio" name="inpatientInquiryMode" value="1"
                                              <#if ruleEdit.inpatientInquiryMode == 1>checked="checked"<#else></#if>
                                        />仅通过住院号/住院流水号查询住院信息
                                        </label>
                                    </div>
                                    <div class="inline">
                                        <#if ruleEdit.inpatientInquiryMode == 2>
                                             <label class="radio check">
                                        <#else>
                                             <label class="radio">
                                        </#if> 
                                        <input type="radio" name="inpatientInquiryMode" value="2"
                                                <#if ruleEdit.inpatientInquiryMode == 2>checked="checked"<#else></#if>
                                        />可通过以上两种方式查询住院信息
                                        </label>
                                   </div>
                                </div>
                            </div>
                            
                            <div>
                                <label class="control-label" style=" padding-top: 0px;">底部Logo信息</label>
                                <div>
                                    <input type="text" name="footLogoInfo" id="footLogoInfo"  value="${ruleEdit.footLogoInfo}" style="width:75%;" />
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label" style="padding-top: 32px">扫码付门诊预下单接口返回内容控制</label>
                                <div class="controls ">
                                     <div class="line">
                                        <#if ruleEdit.clinicScanBarcodePayMode == 0>
                                            <label class="radio check">
                                        <#else>
                                            <label class="radio">
                                        </#if> 
                                        <input type="radio" name="clinicScanBarcodePayMode" value="0"
                                             <#if ruleEdit.clinicScanBarcodePayMode == 0>checked="checked"<#else></#if> 
                                        />barcode
                                        </label>
                                        <#if ruleEdit.clinicScanBarcodePayMode == 1>
                                             <label class="radio check">
                                        <#else>
                                             <label class="radio">
                                        </#if> 
                                        <input type="radio" name="clinicScanBarcodePayMode" value="1"
                                              <#if ruleEdit.clinicScanBarcodePayMode == 1>checked="checked"<#else></#if>
                                        />待缴费链接
                                        </label>
                                        <input type="text" name="clinicScanBarcodePayInfo" id="clinicScanBarcodePayInfo"  value="${ruleEdit.clinicScanBarcodePayInfo}" style="width:75%;" />
                                    </div>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label">是否接入代煎配送</label>
                                <div class="controls" style="padding-top: 20px">
                                    <label 
                                        <#if ruleEdit.isSupportFried == 1>
                                             class="radio inline check">
                                        <#else>
                                             class="radio inline">
                                        </#if> 
                                        <input type="radio" name="isSupportFried" value="1"
                                            <#if ruleEdit.isSupportFried == 1>checked="checked"<#else></#if> 
                                        >是
                                    </label>
                                    <label 
                                        <#if ruleEdit.isSupportFried == 0>
                                             class="radio inline check">
                                        <#else>
                                             class="radio inline">
                                        </#if> 
                                        <input type="radio" name="isSupportFried" value="0"
                                            <#if ruleEdit.isSupportFried == 0>checked="checked"<#else></#if> 
                                        />否
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space20"></div>
                    <button class="btn btn-save" type="button" onclick="ruleJS.saveRule('editRuleForm' , 'RuleEdit')">保存</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!--content end-->
</body>
</html>
