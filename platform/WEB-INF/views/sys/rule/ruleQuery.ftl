<html>
<head>
<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/rule/sys.rule.js"></script>
    <title>查询规则配置</title>
</head>
<body>
<#include "./sys/common/hospital_setting.ftl">
   <div id="content-header">
        <div class="widget-title">
            <h3 class="title">查询规则</h3>
            <#include "/sys/rule/rule_select.ftl">
        </div>
    </div>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
            <div class="widget-box bangKa">
                <div class="space10"></div>
                <form class="form-horizontal evenBg" id="ruleQueryForm">
                    <input type="hidden" name="hospitalId" value="${ruleQuery.hospitalId}"/>
                    <input type="hidden" id="id" name="id" value="${ruleQuery.id}"/>
                    <div class="widget-content">
                        <div class="row-fluid">
                        	<div class="control-group w162">
                                <label class="control-label">候诊队列查询的类别</label>
                                <div class="controls">
                                    <label
                                        <#if  ruleQuery.queueType?contains("1")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="queueTypeArray" value="1"
                                            <#if ruleQuery.queueType?contains("1")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                        /> 门诊候诊排队信息 
                                    </label>
                                    <label
                                        <#if  ruleQuery.queueType?contains("2")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="queueTypeArray" value="2"
                                            <#if ruleQuery.queueType?contains("2")>
                                            checked="checked"
                                            <#else>
                                            </#if>
                                         /> 检查/检验/体检排队信息
                                    </label>
                                    <label
                                        <#if  ruleQuery.queueType?contains("3")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="queueTypeArray" value="3"
                                            <#if ruleQuery.queueType?contains("3")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                         /> 取药排队信息
                                    </label>
                                    <label
                                        <#if  ruleQuery.queueType?contains("3")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="queueTypeArray" value="4"
                                            <#if ruleQuery.queueType?contains("3")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                         /> 报告出具进度
                                    </label>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label">报告可查询的类别</label>
                                <div class="controls">
                                    <label
                                        <#if  ruleQuery.reportCouldQueryType?contains("1")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="reportCouldQueryTypeArray" value="1"
                                            <#if ruleQuery.reportCouldQueryType?contains("1")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                        /> 检验 
                                    </label>
                                    <label
                                        <#if  ruleQuery.reportCouldQueryType?contains("2")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="reportCouldQueryTypeArray" value="2"
                                            <#if ruleQuery.reportCouldQueryType?contains("2")>
                                            checked="checked"
                                            <#else>
                                            </#if>
                                         /> 检查 
                                    </label>
                                    <label
                                        <#if  ruleQuery.reportCouldQueryType?contains("3")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="reportCouldQueryTypeArray" value="3"
                                            <#if ruleQuery.reportCouldQueryType?contains("3")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                         /> 体检
                                    </label>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label">报告详情的界面样式</label>
                                <div class="controls ">
                                    <label
                                        <#if ruleQuery.reportViewCssType == 1>
                                             class="radio inline check">
                                        <#else>
                                             class="radio inline">
                                        </#if> 
                                        <input type="radio" name="reportViewCssType" value="1"
                                        <#if ruleQuery.reportViewCssType == 1>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />数据样式
                                    </label>
                                    <label
                                        <#if ruleQuery.reportViewCssType == 2>
                                             class="radio inline check">
                                        <#else>
                                             class="radio inline">
                                        </#if> 
                                        <input type="radio" name="reportViewCssType" value="2"
                                        <#if ruleQuery.reportViewCssType == 2>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />图形样式
                                    </label>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label">预约记录可查询的类别</label>
                                <div class="controls">
                                     <label
                                        <#if  ruleQuery.bespeakRecordQueryType?contains("1")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="bespeakRecordQueryTypeArray" value="1"
                                            <#if ruleQuery.bespeakRecordQueryType?contains("1")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                         /> 预约挂号
                                    </label>
                                    <label
                                        <#if  ruleQuery.bespeakRecordQueryType?contains("2")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="bespeakRecordQueryTypeArray" value="2"
                                            <#if ruleQuery.bespeakRecordQueryType?contains("2")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                         /> 预约体检
                                    </label>
                                    <label
                                        <#if  ruleQuery.bespeakRecordQueryType?contains("3")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="bespeakRecordQueryTypeArray" value="3"
                                            <#if ruleQuery.bespeakRecordQueryType?contains("3")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                         /> 预约加床
                                    </label>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label">缴费记录可查询的类别</label>
                                <div class="controls">
                                    <label
                                        <#if  ruleQuery.paymentRecordQueryType?contains("1")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="paymentRecordQueryTypeArray" value="1"
                                            <#if ruleQuery.paymentRecordQueryType?contains("1")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                         /> 门诊缴费
                                    </label>
                                    <label
                                        <#if  ruleQuery.paymentRecordQueryType?contains("2")>
                                            class="checkboxTwo inline check">
                                        <#else>
                                            class="checkboxTwo inline">
                                        </#if>
                                        <input type="checkbox" name="paymentRecordQueryTypeArray" value="2"
                                            <#if ruleQuery.paymentRecordQueryType?contains("2")>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                         /> 住院押金补缴
                                    </label>
                                </div>
                            </div>
                            <div class="control-group w162" >
                                <label class="control-label">详情是否显示条形码</label>
                                <div class="controls ">
                                     <label 
                                        <#if ruleQuery.isShowBarcode == 1>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="isShowBarcode"  value="1" 
                                           <#if ruleQuery.isShowBarcode == 1>checked="checked"<#else></#if>
                                        />是
                                    </label>
                                    <label 
                                         <#if ruleQuery.isShowBarcode == 0>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="isShowBarcode"  value="0"
                                            <#if ruleQuery.isShowBarcode == 0>checked="checked"<#else></#if>
                                        />否
                                    </label>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label">条形码显示内容</label>
                                <div class="controls ">
                                     <label 
                                        <#if ruleQuery.barcodeData == 1>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="barcodeData"  value="1" 
                                           <#if ruleQuery.barcodeData == 1>checked="checked"<#else></#if>
                                        />接口返回的条形码
                                    </label>
                                    <label
                                         <#if ruleQuery.barcodeData == 2>
                                            class="radio inline check">
                                         <#else>
                                            class="radio inline">
                                         </#if>
                                        <input type="radio" name="barcodeData"  value="2"
                                            <#if ruleQuery.barcodeData == 2>checked="checked"<#else></#if>
                                        />就诊卡号
                                    </label>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label">条形码格式</label>
                                <div class="controls ">
                                    <label
                                        <#if ruleQuery.barcodeStyle == 1>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="barcodeStyle" value="1"
                                        <#if ruleQuery.barcodeStyle == 1>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />EAN码
                                    </label>
                                    <label
                                        <#if ruleQuery.barcodeStyle == 2>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="barcodeStyle" value="2"
                                        <#if ruleQuery.barcodeStyle == 2>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />UPC码 
                                    </label>
                                    <label
                                        <#if ruleQuery.barcodeStyle == 3>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="barcodeStyle" value="3"
                                        <#if ruleQuery.barcodeStyle == 3>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />39码
                                    </label>
                                    <label
                                        <#if ruleQuery.barcodeStyle == 4>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="barcodeStyle" value="4"
                                        <#if ruleQuery.barcodeStyle == 4>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />128码 
                                    </label>
                                    <label
                                        <#if ruleQuery.barcodeStyle == 5>
                                           class="radio inline check">
                                        <#else>
                                           class="radio inline">
                                        </#if> 
                                        <input type="radio" name="barcodeStyle" value="5"
                                        <#if ruleQuery.barcodeStyle == 5>
                                            checked="checked"
                                        <#else>
                                        </#if>
                                        />库德巴码 
                                    </label>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label" style="padding-top: 80px">查询时间控制</label>
                                <div class="controls">
                                    <div class="line">报告记录允许查询时长 
                                        <input type="text" class="span1 input33" name="reportRecordQueryMaxMonths" 
                                            value="${ruleQuery.reportRecordQueryMaxMonths}" /> 个月
                                    </div>
                                    <div class="line">预约记录允许查询时长
                                        <input type="text" class="span1 input33" name="bespeakRecordQueryMaxMonths"
                                            value="${ruleQuery.bespeakRecordQueryMaxMonths}" /> 个月
                                    </div>
                                    <div class="line">缴费记录允许查询时长 
                                        <input type="text" class="span1 input33" name="paymentRecordQueryMaxMonths" 
                                            value="${ruleQuery.paymentRecordQueryMaxMonths}" /> 个月
                                    </div>
                                    <div class="line">一日清单允许查询时长 
                                        <input type="text" class="span1 input33" name="oneDayRecordMaxMonths" 
                                            value="${ruleQuery.oneDayRecordMaxMonths}" /> 个月
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space20"></div>
                    <button class="btn btn-save" type="button" onclick="ruleJS.saveRule('ruleQueryForm' , 'RuleQuery')">保存</button>
                </form>
            </div>
        </div>

    </div>
</div>
<!--content end-->
</body>
</html>
