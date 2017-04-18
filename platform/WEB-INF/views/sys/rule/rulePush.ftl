<html>
<head>
	<#include "/sys/common/common.ftl">
    <title>推送规则</title>
    <script type="text/javascript" src="${basePath}js/sys/rule/sys.rule.js"></script>
</head>
<body>
<!--header str-->
	<#include "./sys/common/hospital_setting.ftl">
    <div id="content-header">
        <div class="widget-title">
            <h3 class="title">推送规则</h3>
            <#include "/sys/rule/rule_select.ftl">
        </div>
    </div>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
        	<div class="space30"></div>
        	<div class="row-fluid">
	            <div class="pull-left">
	                <ul class="tabs">
	                    <li><a href="#tab1" class="select">微信</a></li>
	                    <li><a href="#tab2">支付宝</a></li>
	                    <li><a href="#tab3">健康易</a></li>
	                </ul>
	            </div>
       		</div>
        	<div class="space10"></div>
            <div class="widget-box bangKa tab_content" id="tab1">
                <div class="space10"></div>
                <form class="form-horizontal evenBg" id="editRuleFormWechat">
                	<input type="hidden" name="hospitalId" value="${rulePushWechat.hospitalId}"/>
                    <input type="hidden" id="id" name="id" value="${rulePushWechat.id}"/>
                    <input type="hidden" id="platformType" name="platformType" value="wechat"/>
                    <div class="widget-content guaHao">
                        <div class="row-fluid">
                            <div class="control-box <#if rulePushWechat.bindCardSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">绑卡成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.bindCardSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="bindCardSuc" value="1" <#if rulePushWechat.bindCardSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.bindCardSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="bindCardSuc" value="0" <#if rulePushWechat.bindCardSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="bindCardSucCode" value="${rulePushWechat.bindCardSucCode}" />
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.createCardSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">建档成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.createCardSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="createCardSuc" value="1" <#if rulePushWechat.createCardSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.createCardSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="createCardSuc" value="0" <#if rulePushWechat.createCardSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="createCardSucCode" value="${rulePushWechat.createCardSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.predayVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">就诊前一天是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.predayVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="predayVisit" value="1" <#if rulePushWechat.predayVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.predayVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="predayVisit" value="0" <#if rulePushWechat.predayVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="predayVisitCode" value="${rulePushWechat.predayVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.curdayVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">就诊当天是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.curdayVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="curdayVisit" value="1" <#if rulePushWechat.curdayVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.curdayVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="curdayVisit" value="0" <#if rulePushWechat.curdayVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="curdayVisitCode" value="${rulePushWechat.curdayVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.lockResSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">锁号成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.lockResSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="lockResSuc" value="1" <#if rulePushWechat.lockResSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.lockResSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="lockResSuc" value="0" <#if rulePushWechat.lockResSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="lockResSucCode" value="${rulePushWechat.lockResSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.onDutyPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">当班挂号成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.onDutyPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="onDutyPaySuc" value="1" <#if rulePushWechat.onDutyPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.onDutyPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="onDutyPaySuc" value="0" <#if rulePushWechat.onDutyPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="onDutyPaySucCode" value="${rulePushWechat.onDutyPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.appointPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">预约挂号成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.appointPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPaySuc" value="1" <#if rulePushWechat.appointPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.appointPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="appointPaySuc" value="0" <#if rulePushWechat.appointPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"  name="appointPaySucCode" value="${rulePushWechat.appointPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.appointPayFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.appointPayFail == 1>check<#else></#if> " style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPayFail" value="1" <#if rulePushWechat.appointPayFail == 1>checked="checked"<#else></#if> >是</label>
                                        <label class="radio inline <#if rulePushWechat.appointPayFail == 0>check<#else></#if> "> 
                                        <input type="radio" name="appointPayFail" value="0" <#if rulePushWechat.appointPayFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="appointPayFailCode" value="${rulePushWechat.appointPayFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.appointPayExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.appointPayExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPayExp" value="1" <#if rulePushWechat.appointPayExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.appointPayExp == 0>check<#else></#if>" > 
                                        <input type="radio" name="appointPayExp" value="0" <#if rulePushWechat.appointPayExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="appointPayExpCode" value="${rulePushWechat.appointPayExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.cancelOnDuty == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">取消当班挂号是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushWechat.cancelOnDuty == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="cancelOnDuty" value="1" <#if rulePushWechat.cancelOnDuty == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushWechat.cancelOnDuty == 0>check<#else></#if>"> 
                                        <input type="radio" name="cancelOnDuty" value="0" <#if rulePushWechat.cancelOnDuty == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="cancelOnDutyCode" value="${rulePushWechat.cancelOnDutyCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.cancelAppointment == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">取消预约挂号是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.cancelAppointment == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="cancelAppointment" value="1" <#if rulePushWechat.cancelAppointment == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.cancelAppointment == 0>check<#else></#if>"> 
                                        <input type="radio" name="cancelAppointment" value="0" <#if rulePushWechat.cancelAppointment == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="cancelAppointmentCode" value="${rulePushWechat.cancelAppointmentCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.refundSuccess == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.refundSuccess == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="refundSuccess" value="1" <#if rulePushWechat.refundSuccess == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.refundSuccess == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundSuccess" value="0" <#if rulePushWechat.refundSuccess == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="refundSuccessCode" value="${rulePushWechat.refundSuccessCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.refundFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.refundFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="refundFail" value="1" <#if rulePushWechat.refundFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.refundFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundFail" value="0" <#if rulePushWechat.refundFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="refundFailCode" value="${rulePushWechat.refundFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.refundException == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.refundException == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio"  name="refundException" value="1" <#if rulePushWechat.refundException == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.refundException == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundException" value="0" <#if rulePushWechat.refundException == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"name="refundExceptionCode" value="${rulePushWechat.refundExceptionCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.stopVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">医生停诊是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.stopVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="stopVisit" value="1" <#if rulePushWechat.stopVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.stopVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="stopVisit" value="0" <#if rulePushWechat.stopVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="stopVisitCode" value="${rulePushWechat.stopVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.waitVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">候诊排队是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.waitVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="waitVisit" value="1" <#if rulePushWechat.waitVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.waitVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="waitVisit" value="0" <#if rulePushWechat.waitVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="waitVisitCode" value="${rulePushWechat.waitVisitCode}" />
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.clinicPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.clinicPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPaySuc" value="1" <#if rulePushWechat.clinicPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.clinicPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio"  name="clinicPaySuc" value="0" <#if rulePushWechat.clinicPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPaySucCode" value="${rulePushWechat.clinicPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.clinicPayFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.clinicPayFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPayFail" value="1" <#if rulePushWechat.clinicPayFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.clinicPayFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPayFail" value="0" <#if rulePushWechat.clinicPayFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPayFailCode" value="${rulePushWechat.clinicPayFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.clinicPayExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.clinicPayExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPayExp" value="1" <#if rulePushWechat.clinicPayExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.clinicPayExp == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPayExp" value="0" <#if rulePushWechat.clinicPayExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"  name="clinicPayExpCode" value="${rulePushWechat.clinicPayExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.payDepositSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.payDepositSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositSuc" value="1" <#if rulePushWechat.payDepositSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.payDepositSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="payDepositSuc" value="0" <#if rulePushWechat.payDepositSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositSucCode" value="${rulePushWechat.payDepositSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.payDepositFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.payDepositFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositFail" value="1" <#if rulePushWechat.payDepositFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.payDepositFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="payDepositFail" value="0" <#if rulePushWechat.payDepositFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositFailCode" value="${rulePushWechat.payDepositFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.payDepositExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushWechat.payDepositExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositExp" value="1" <#if rulePushWechat.payDepositExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushWechat.payDepositExp == 0>check<#else></#if>">
                                        <input type="radio" name="payDepositExp" value="0" <#if rulePushWechat.payDepositExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositExpCode" value="${rulePushWechat.payDepositExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.generateReport == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">报告出结果是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushWechat.generateReport == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="generateReport" value="1" <#if rulePushWechat.generateReport == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushWechat.generateReport == 0>check<#else></#if>"> 
                                        <input type="radio" name="generateReport" value="0" <#if rulePushWechat.generateReport == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="generateReportCode" value="${rulePushWechat.generateReportCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.clinicRefundSuc == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushWechat.clinicRefundSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicRefundSuc" value="1" <#if rulePushWechat.clinicRefundSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushWechat.clinicRefundSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicRefundSuc" value="0" <#if rulePushWechat.clinicRefundSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicRefundSucCode" value="${rulePushWechat.clinicRefundSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.clinicPartRefundSuc == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊部分退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushWechat.clinicPartRefundSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPartRefundSuc" value="1" <#if rulePushWechat.clinicPartRefundSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushWechat.clinicPartRefundSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPartRefundSuc" value="0" <#if rulePushWechat.clinicPartRefundSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPartRefundSucCode" value="${rulePushWechat.clinicPartRefundSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.sendComment == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">发表评价后是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushWechat.sendComment == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="sendComment" value="1" <#if rulePushWechat.sendComment == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushWechat.sendComment == 0>check<#else></#if>"> 
                                        <input type="radio" name="sendComment" value="0" <#if rulePushWechat.sendComment == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="sendCommentCode" value="${rulePushWechat.sendCommentCode}"/>
                                </div>
                            </div>
                            
                            <div class="control-box <#if rulePushWechat.finishUserInfo == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">完成注册后是否推送完善资料提示</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushWechat.finishUserInfo == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="finishUserInfo" value="1" <#if rulePushWechat.finishUserInfo == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushWechat.finishUserInfo == 0>check<#else></#if>"> 
                                        <input type="radio" name="finishUserInfo" value="0" <#if rulePushWechat.finishUserInfo == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="finishUserInfoCode" value="${rulePushWechat.finishUserInfoCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushWechat.clinicPaySuccessAdvice == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊支付成功后，是否发送推广信息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushWechat.clinicPaySuccessAdvice == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPaySuccessAdvice" value="1" <#if rulePushWechat.clinicPaySuccessAdvice == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushWechat.clinicPaySuccessAdvice == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPaySuccessAdvice" value="0" <#if rulePushWechat.clinicPaySuccessAdvice == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPaySuccessAdviceCode" value="${rulePushWechat.clinicPaySuccessAdviceCode}"/>
                                </div>
                            </div>

                            <div class="control-box <#if rulePushWechat.sendSmsMessage == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">精准消息推送</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.sendSmsMessage == 1>check<#else></#if>" style="margin-right: 50px; display: inline;">
                                            <input type="radio" name="sendSmsMessage" value="1" <#if rulePushAlipay.sendSmsMessage == 1>checked="checked"<#else></#if>>入库并推送消息</label>
                                        <label class="radio inline  <#if rulePushAlipay.sendSmsMessage == 2>check<#else></#if>">
                                            <input type="radio" name="sendSmsMessage" value="2" <#if rulePushAlipay.sendSmsMessage == 2>checked="checked"<#else></#if>>仅入库(不推送消息)</label>
                                        <label class="radio inline  <#if rulePushWechat.sendSmsMessage == 0>check<#else></#if>">
                                            <input type="radio" name="sendSmsMessage" value="0" <#if rulePushWechat.sendSmsMessage == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <div class="space20"></div>
                    <button class="btn btn-save" type="button" onclick="ruleJS.saveRule('editRuleFormWechat' , 'RulePush')">保存</button>
                </form>
            </div>
            <!--支付宝-->
           <div class="widget-box bangKa tab_content" id="tab2" style="display:none">
                <div class="space10"></div>
                <form class="form-horizontal evenBg" id="editRuleFormAlipay">
                	<input type="hidden" name="hospitalId" value="${rulePushAlipay.hospitalId}"/>
                    <input type="hidden" id="id" name="id" value="${rulePushAlipay.id}"/>
                    <input type="hidden" id="platformType" name="platformType" value="alipay"/>
                    <div class="widget-content guaHao">
                        <div class="row-fluid">
                            <div class="control-box <#if rulePushAlipay.bindCardSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">绑卡成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.bindCardSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="bindCardSuc" value="1" <#if rulePushAlipay.bindCardSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.bindCardSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="bindCardSuc" value="0" <#if rulePushAlipay.bindCardSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="bindCardSucCode" value="${rulePushAlipay.bindCardSucCode}" />
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.createCardSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">建档成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.createCardSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="createCardSuc" value="1" <#if rulePushAlipay.createCardSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.createCardSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="createCardSuc" value="0" <#if rulePushAlipay.createCardSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="createCardSucCode" value="${rulePushAlipay.createCardSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.predayVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">就诊前一天是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.predayVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="predayVisit" value="1" <#if rulePushAlipay.predayVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.predayVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="predayVisit" value="0" <#if rulePushAlipay.predayVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="predayVisitCode" value="${rulePushAlipay.predayVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.curdayVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">就诊当天是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.curdayVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="curdayVisit" value="1" <#if rulePushAlipay.curdayVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.curdayVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="curdayVisit" value="0" <#if rulePushAlipay.curdayVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="curdayVisitCode" value="${rulePushAlipay.curdayVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.lockResSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">锁号成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.lockResSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="lockResSuc" value="1" <#if rulePushAlipay.lockResSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.lockResSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="lockResSuc" value="0" <#if rulePushAlipay.lockResSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="lockResSucCode" value="${rulePushAlipay.lockResSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.onDutyPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">当班支付成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.onDutyPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="onDutyPaySuc" value="1" <#if rulePushAlipay.onDutyPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.onDutyPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="onDutyPaySuc" value="0" <#if rulePushAlipay.onDutyPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="onDutyPaySucCode" value="${rulePushAlipay.onDutyPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.appointPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">预约支付成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.appointPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPaySuc" value="1" <#if rulePushAlipay.appointPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.appointPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="appointPaySuc" value="0" <#if rulePushAlipay.appointPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"  name="appointPaySucCode" value="${rulePushAlipay.appointPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.appointPayFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号支付失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.appointPayFail == 1>check<#else></#if> " style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPayFail" value="1" <#if rulePushAlipay.appointPayFail == 1>checked="checked"<#else></#if> >是</label>
                                        <label class="radio inline <#if rulePushAlipay.appointPayFail == 0>check<#else></#if> "> 
                                        <input type="radio" name="appointPayFail" value="0" <#if rulePushAlipay.appointPayFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="appointPayFailCode" value="${rulePushAlipay.appointPayFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.appointPayExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号支付异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.appointPayExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPayExp" value="1" <#if rulePushAlipay.appointPayExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.appointPayExp == 0>check<#else></#if>" > 
                                        <input type="radio" name="appointPayExp" value="0" <#if rulePushAlipay.appointPayExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="appointPayExpCode" value="${rulePushAlipay.appointPayExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.cancelOnDuty == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">取消当班挂号是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.cancelOnDuty == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="cancelOnDuty" value="1" <#if rulePushAlipay.cancelOnDuty == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushAlipay.cancelOnDuty == 0>check<#else></#if>"> 
                                        <input type="radio" name="cancelOnDuty" value="0" <#if rulePushAlipay.cancelOnDuty == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="cancelOnDutyCode" value="${rulePushAlipay.cancelOnDutyCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.cancelAppointment == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">取消预约挂号是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.cancelAppointment == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="cancelAppointment" value="1" <#if rulePushAlipay.cancelAppointment == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.cancelAppointment == 0>check<#else></#if>"> 
                                        <input type="radio" name="cancelAppointment" value="0" <#if rulePushAlipay.cancelAppointment == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="cancelAppointmentCode" value="${rulePushAlipay.cancelAppointmentCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.refundSuccess == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.refundSuccess == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="refundSuccess" value="1" <#if rulePushAlipay.refundSuccess == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.refundSuccess == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundSuccess" value="0" <#if rulePushAlipay.refundSuccess == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="refundSuccessCode" value="${rulePushAlipay.refundSuccessCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.refundFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.refundFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="refundFail" value="1" <#if rulePushAlipay.refundFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.refundFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundFail" value="0" <#if rulePushAlipay.refundFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="refundFailCode" value="${rulePushAlipay.refundFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.refundException == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.refundException == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio"  name="refundException" value="1" <#if rulePushAlipay.refundException == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.refundException == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundException" value="0" <#if rulePushAlipay.refundException == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"name="refundExceptionCode" value="${rulePushAlipay.refundExceptionCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.stopVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">医生停诊是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.stopVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="stopVisit" value="1" <#if rulePushAlipay.stopVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.stopVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="stopVisit" value="0" <#if rulePushAlipay.stopVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="stopVisitCode" value="${rulePushAlipay.stopVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.waitVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">候诊排队是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.waitVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="waitVisit" value="1" <#if rulePushAlipay.waitVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.waitVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="waitVisit" value="0" <#if rulePushAlipay.waitVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="waitVisitCode" value="${rulePushAlipay.waitVisitCode}" />
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.clinicPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.clinicPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPaySuc" value="1" <#if rulePushAlipay.clinicPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.clinicPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio"  name="clinicPaySuc" value="0" <#if rulePushAlipay.clinicPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPaySucCode" value="${rulePushAlipay.clinicPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.clinicPayFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.clinicPayFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPayFail" value="1" <#if rulePushAlipay.clinicPayFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.clinicPayFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPayFail" value="0" <#if rulePushAlipay.clinicPayFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPayFailCode" value="${rulePushAlipay.clinicPayFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.clinicPayExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.clinicPayExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPayExp" value="1" <#if rulePushAlipay.clinicPayExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.clinicPayExp == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPayExp" value="0" <#if rulePushAlipay.clinicPayExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"  name="clinicPayExpCode" value="${rulePushAlipay.clinicPayExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.payDepositSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.payDepositSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositSuc" value="1" <#if rulePushAlipay.payDepositSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.payDepositSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="payDepositSuc" value="0" <#if rulePushAlipay.payDepositSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositSucCode" value="${rulePushAlipay.payDepositSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.payDepositFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.payDepositFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositFail" value="1" <#if rulePushAlipay.payDepositFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.payDepositFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="payDepositFail" value="0" <#if rulePushAlipay.payDepositFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositFailCode" value="${rulePushAlipay.payDepositFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.payDepositExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushAlipay.payDepositExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositExp" value="1" <#if rulePushAlipay.payDepositExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushAlipay.payDepositExp == 0>check<#else></#if>">
                                        <input type="radio" name="payDepositExp" value="0" <#if rulePushAlipay.payDepositExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositExpCode" value="${rulePushAlipay.payDepositExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.generateReport == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">报告出结果是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.generateReport == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="generateReport" value="1" <#if rulePushAlipay.generateReport == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushAlipay.generateReport == 0>check<#else></#if>"> 
                                        <input type="radio" name="generateReport" value="0" <#if rulePushAlipay.generateReport == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="generateReportCode" value="${rulePushAlipay.generateReportCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.clinicRefundSuc == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.clinicRefundSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicRefundSuc" value="1" <#if rulePushAlipay.clinicRefundSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushAlipay.clinicRefundSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicRefundSuc" value="0" <#if rulePushAlipay.clinicRefundSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicRefundSucCode" value="${rulePushAlipay.clinicRefundSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.clinicPartRefundSuc == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊部分退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.clinicPartRefundSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPartRefundSuc" value="1" <#if rulePushAlipay.clinicPartRefundSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushAlipay.clinicPartRefundSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPartRefundSuc" value="0" <#if rulePushAlipay.clinicPartRefundSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPartRefundSucCode" value="${rulePushAlipay.clinicPartRefundSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushAlipay.sendComment == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">发表评价后是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.sendComment == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="sendComment" value="1" <#if rulePushAlipay.sendComment == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushAlipay.sendComment == 0>check<#else></#if>"> 
                                        <input type="radio" name="sendComment" value="0" <#if rulePushAlipay.sendComment == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="sendCommentCode" value="${rulePushAlipay.sendCommentCode}"/>
                                </div>
                            </div>
                            
                            <div class="control-box <#if rulePushAlipay.finishUserInfo == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">完成注册后是否推送完善资料提示</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.finishUserInfo == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="finishUserInfo" value="1" <#if rulePushAlipay.finishUserInfo == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushAlipay.finishUserInfo == 0>check<#else></#if>">
                                        <input type="radio" name="finishUserInfo" value="0" <#if rulePushAlipay.finishUserInfo == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="finishUserInfoCode" value="${rulePushAlipay.finishUserInfoCode}"/>
                                </div>
                            </div>
                            
                            <div class="control-box <#if rulePushAlipay.clinicPaySuccessAdvice == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊支付成功后，是否发送推广信息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.clinicPaySuccessAdvice == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPaySuccessAdvice" value="1" <#if rulePushAlipay.clinicPaySuccessAdvice == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushAlipay.clinicPaySuccessAdvice == 0>check<#else></#if>">
                                        <input type="radio" name="clinicPaySuccessAdvice" value="0" <#if rulePushAlipay.clinicPaySuccessAdvice == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPaySuccessAdviceCode" value="${rulePushAlipay.clinicPaySuccessAdviceCode}"/>
                                </div>
                            </div>

                            <div class="control-box <#if rulePushAlipay.sendSmsMessage == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">精准消息推送</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.sendSmsMessage == 1>check<#else></#if>" style="margin-right: 50px; display: inline;">
                                            <input type="radio" name="sendSmsMessage" value="1" <#if rulePushAlipay.sendSmsMessage == 1>checked="checked"<#else></#if>>入库并推送消息</label>
                                        <label class="radio inline  <#if rulePushAlipay.sendSmsMessage == 2>check<#else></#if>">
                                            <input type="radio" name="sendSmsMessage" value="2" <#if rulePushAlipay.sendSmsMessage == 2>checked="checked"<#else></#if>>仅入库(不推送消息)</label>
                                        <label class="radio inline  <#if rulePushAlipay.sendSmsMessage == 0>check<#else></#if>">
                                            <input type="radio" name="sendSmsMessage" value="0" <#if rulePushAlipay.sendSmsMessage == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space20"></div>
                    <button class="btn btn-save" type="button" onclick="ruleJS.saveRule('editRuleFormAlipay' , 'RulePush')">保存</button>
                </form>
            </div>
            <!--健康易-->
            <div class="widget-box bangKa tab_content" id="tab3" style="display:none">
                <div class="space10"></div>
                <form class="form-horizontal evenBg" id="editRuleFormEasyHealth">
                	<input type="hidden" name="hospitalId" value="${rulePushEasyHealth.hospitalId}"/>
                    <input type="hidden" id="id" name="id" value="${rulePushEasyHealth.id}"/>
                    <input type="hidden" id="platformType" name="platformType" value="easyHealth"/>
                    <div class="widget-content guaHao">
                        <div class="row-fluid">
                            <div class="control-box <#if rulePushEasyHealth.bindCardSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">绑卡成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.bindCardSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="bindCardSuc" value="1" <#if rulePushEasyHealth.bindCardSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.bindCardSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="bindCardSuc" value="0" <#if rulePushEasyHealth.bindCardSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="bindCardSucCode" value="${rulePushEasyHealth.bindCardSucCode}" />
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.createCardSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">建档成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.createCardSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="createCardSuc" value="1" <#if rulePushEasyHealth.createCardSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.createCardSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="createCardSuc" value="0" <#if rulePushEasyHealth.createCardSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="createCardSucCode" value="${rulePushEasyHealth.createCardSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.predayVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">就诊前一天是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.predayVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="predayVisit" value="1" <#if rulePushEasyHealth.predayVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.predayVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="predayVisit" value="0" <#if rulePushEasyHealth.predayVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="predayVisitCode" value="${rulePushEasyHealth.predayVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.curdayVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">就诊当天是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.curdayVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="curdayVisit" value="1" <#if rulePushEasyHealth.curdayVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.curdayVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="curdayVisit" value="0" <#if rulePushEasyHealth.curdayVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="curdayVisitCode" value="${rulePushEasyHealth.curdayVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.lockResSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">锁号成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.lockResSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="lockResSuc" value="1" <#if rulePushEasyHealth.lockResSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.lockResSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="lockResSuc" value="0" <#if rulePushEasyHealth.lockResSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="lockResSucCode" value="${rulePushEasyHealth.lockResSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.onDutyPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">当班支付成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.onDutyPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="onDutyPaySuc" value="1" <#if rulePushEasyHealth.onDutyPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.onDutyPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="onDutyPaySuc" value="0" <#if rulePushEasyHealth.onDutyPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="onDutyPaySucCode" value="${rulePushEasyHealth.onDutyPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.appointPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">预约支付成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.appointPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPaySuc" value="1" <#if rulePushEasyHealth.appointPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.appointPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="appointPaySuc" value="0" <#if rulePushEasyHealth.appointPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"  name="appointPaySucCode" value="${rulePushEasyHealth.appointPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.appointPayFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号支付失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.appointPayFail == 1>check<#else></#if> " style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPayFail" value="1" <#if rulePushEasyHealth.appointPayFail == 1>checked="checked"<#else></#if> >是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.appointPayFail == 0>check<#else></#if> "> 
                                        <input type="radio" name="appointPayFail" value="0" <#if rulePushEasyHealth.appointPayFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="appointPayFailCode" value="${rulePushEasyHealth.appointPayFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.appointPayExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号支付异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.appointPayExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="appointPayExp" value="1" <#if rulePushEasyHealth.appointPayExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.appointPayExp == 0>check<#else></#if>" > 
                                        <input type="radio" name="appointPayExp" value="0" <#if rulePushEasyHealth.appointPayExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="appointPayExpCode" value="${rulePushEasyHealth.appointPayExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.cancelOnDuty == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">取消当班挂号是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushEasyHealth.cancelOnDuty == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="cancelOnDuty" value="1" <#if rulePushEasyHealth.cancelOnDuty == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushEasyHealth.cancelOnDuty == 0>check<#else></#if>"> 
                                        <input type="radio" name="cancelOnDuty" value="0" <#if rulePushEasyHealth.cancelOnDuty == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="cancelOnDutyCode" value="${rulePushEasyHealth.cancelOnDutyCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.cancelAppointment == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">取消预约挂号是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.cancelAppointment == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="cancelAppointment" value="1" <#if rulePushEasyHealth.cancelAppointment == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.cancelAppointment == 0>check<#else></#if>"> 
                                        <input type="radio" name="cancelAppointment" value="0" <#if rulePushEasyHealth.cancelAppointment == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="cancelAppointmentCode" value="${rulePushEasyHealth.cancelAppointmentCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.refundSuccess == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.refundSuccess == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="refundSuccess" value="1" <#if rulePushEasyHealth.refundSuccess == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.refundSuccess == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundSuccess" value="0" <#if rulePushEasyHealth.refundSuccess == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="refundSuccessCode" value="${rulePushEasyHealth.refundSuccessCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.refundFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.refundFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="refundFail" value="1" <#if rulePushEasyHealth.refundFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.refundFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundFail" value="0" <#if rulePushEasyHealth.refundFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="refundFailCode" value="${rulePushEasyHealth.refundFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.refundException == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">挂号退费异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.refundException == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio"  name="refundException" value="1" <#if rulePushEasyHealth.refundException == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.refundException == 0>check<#else></#if>"> 
                                        <input type="radio" name="refundException" value="0" <#if rulePushEasyHealth.refundException == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"name="refundExceptionCode" value="${rulePushEasyHealth.refundExceptionCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.stopVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">医生停诊是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.stopVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="stopVisit" value="1" <#if rulePushEasyHealth.stopVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.stopVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="stopVisit" value="0" <#if rulePushEasyHealth.stopVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="stopVisitCode" value="${rulePushEasyHealth.stopVisitCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.waitVisit == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">候诊排队是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.waitVisit == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="waitVisit" value="1" <#if rulePushEasyHealth.waitVisit == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.waitVisit == 0>check<#else></#if>"> 
                                        <input type="radio" name="waitVisit" value="0" <#if rulePushEasyHealth.waitVisit == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="waitVisitCode" value="${rulePushEasyHealth.waitVisitCode}" />
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.clinicPaySuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.clinicPaySuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPaySuc" value="1" <#if rulePushEasyHealth.clinicPaySuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.clinicPaySuc == 0>check<#else></#if>"> 
                                        <input type="radio"  name="clinicPaySuc" value="0" <#if rulePushEasyHealth.clinicPaySuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPaySucCode" value="${rulePushEasyHealth.clinicPaySucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.clinicPayFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.clinicPayFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPayFail" value="1" <#if rulePushEasyHealth.clinicPayFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.clinicPayFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPayFail" value="0" <#if rulePushEasyHealth.clinicPayFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPayFailCode" value="${rulePushEasyHealth.clinicPayFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.clinicPayExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">门诊缴费异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.clinicPayExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPayExp" value="1" <#if rulePushEasyHealth.clinicPayExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.clinicPayExp == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPayExp" value="0" <#if rulePushEasyHealth.clinicPayExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;"  name="clinicPayExpCode" value="${rulePushEasyHealth.clinicPayExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.payDepositSuc == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.payDepositSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositSuc" value="1" <#if rulePushEasyHealth.payDepositSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.payDepositSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="payDepositSuc" value="0" <#if rulePushEasyHealth.payDepositSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositSucCode" value="${rulePushEasyHealth.payDepositSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.payDepositFail == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴失败是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.payDepositFail == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositFail" value="1" <#if rulePushEasyHealth.payDepositFail == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.payDepositFail == 0>check<#else></#if>"> 
                                        <input type="radio" name="payDepositFail" value="0" <#if rulePushEasyHealth.payDepositFail == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositFailCode" value="${rulePushEasyHealth.payDepositFailCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.payDepositExp == 1>show<#else></#if>">
                                <div class="control-group w235">
                                    <label class="control-label">押金补缴异常是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes <#if rulePushEasyHealth.payDepositExp == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="payDepositExp" value="1" <#if rulePushEasyHealth.payDepositExp == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline <#if rulePushEasyHealth.payDepositExp == 0>check<#else></#if>">
                                        <input type="radio" name="payDepositExp" value="0" <#if rulePushEasyHealth.payDepositExp == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="payDepositExpCode" value="${rulePushEasyHealth.payDepositExpCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.generateReport == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">报告出结果是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushEasyHealth.generateReport == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="generateReport" value="1" <#if rulePushEasyHealth.generateReport == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushEasyHealth.generateReport == 0>check<#else></#if>"> 
                                        <input type="radio" name="generateReport" value="0" <#if rulePushEasyHealth.generateReport == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="generateReportCode" value="${rulePushEasyHealth.generateReportCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.clinicRefundSuc == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushEasyHealth.clinicRefundSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicRefundSuc" value="1" <#if rulePushEasyHealth.clinicRefundSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushEasyHealth.clinicRefundSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicRefundSuc" value="0" <#if rulePushEasyHealth.clinicRefundSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicRefundSucCode" value="${rulePushEasyHealth.clinicRefundSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.clinicPartRefundSuc == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊部分退费成功是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushEasyHealth.clinicPartRefundSuc == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPartRefundSuc" value="1" <#if rulePushEasyHealth.clinicPartRefundSuc == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushEasyHealth.clinicPartRefundSuc == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPartRefundSuc" value="0" <#if rulePushEasyHealth.clinicPartRefundSuc == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPartRefundSucCode" value="${rulePushEasyHealth.clinicPartRefundSucCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.sendComment == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">发表评价后是否推送消息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushEasyHealth.sendComment == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="sendComment" value="1" <#if rulePushEasyHealth.sendComment == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushEasyHealth.sendComment == 0>check<#else></#if>"> 
                                        <input type="radio" name="sendComment" value="0" <#if rulePushEasyHealth.sendComment == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="sendCommentCode" value="${rulePushEasyHealth.sendCommentCode}"/>
                                </div>
                            </div>
                            <div class="control-box <#if rulePushEasyHealth.finishUserInfo == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">完成注册后是否推送完善资料提示</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushEasyHealth.finishUserInfo == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="finishUserInfo" value="1" <#if rulePushEasyHealth.finishUserInfo == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushEasyHealth.finishUserInfo == 0>check<#else></#if>"> 
                                        <input type="radio" name="finishUserInfo" value="0" <#if rulePushEasyHealth.finishUserInfo == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="finishUserInfoCode" value="${rulePushEasyHealth.finishUserInfoCode}"/>
                                </div>
                            </div>
                            
                             <div class="control-box <#if rulePushEasyHealth.clinicPaySuccessAdvice == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">门诊支付成功后，是否发送推广信息</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushEasyHealth.clinicPaySuccessAdvice == 1>check<#else></#if>" style="margin-right: 50px; display: inline;"> 
                                        <input type="radio" name="clinicPaySuccessAdvice" value="1" <#if rulePushEasyHealth.clinicPaySuccessAdvice == 1>checked="checked"<#else></#if>>是</label>
                                        <label class="radio inline  <#if rulePushEasyHealth.clinicPaySuccessAdvice == 0>check<#else></#if>"> 
                                        <input type="radio" name="clinicPaySuccessAdvice" value="0" <#if rulePushEasyHealth.clinicPaySuccessAdvice == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                                <div class="control-input">
                                    模版编码<input type="text" placeholder="" class="span5 input33" style="margin-left: 15px; display: inline;" name="clinicPaySuccessAdviceCode" value="${rulePushEasyHealth.clinicPaySuccessAdviceCode}"/>
                                </div>
                            </div>
                            
                            <div class="control-box <#if rulePushEasyHealth.sendSmsMessage == 1>show<#else></#if> ">
                                <div class="control-group w235">
                                    <label class="control-label">精准消息推送</label>
                                    <div class="controls ">
                                        <label class="radio inline yes  <#if rulePushAlipay.sendSmsMessage == 1>check<#else></#if>" style="margin-right: 50px; display: inline;">
                                            <input type="radio" name="sendSmsMessage" value="1" <#if rulePushAlipay.sendSmsMessage == 1>checked="checked"<#else></#if>>入库并推送消息</label>
                                        <label class="radio inline  <#if rulePushAlipay.sendSmsMessage == 2>check<#else></#if>">
                                            <input type="radio" name="sendSmsMessage" value="2" <#if rulePushAlipay.sendSmsMessage == 2>checked="checked"<#else></#if>>仅入库(不推送消息)</label>
                                        <label class="radio inline  <#if rulePushEasyHealth.sendSmsMessage == 0>check<#else></#if>">
                                            <input type="radio" name="sendSmsMessage" value="0" <#if rulePushEasyHealth.sendSmsMessage == 0>checked="checked"<#else></#if>>否</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space20"></div>
                    <button class="btn btn-save" type="button" onclick="ruleJS.saveRule('editRuleFormEasyHealth' , 'RulePush')">保存</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!--content end-->
</body>
</html>
<script type="text/javascript">
   $(document).on('click','.js_yes',function(){
        if($(this).hasClass('check')){
            $(this).parents('.control-box ').addClass('show')
        }
    });
    $('.tabs li a').click(function(){
    	$(this).addClass('select');
    	$(this).parent().siblings().children().removeClass('select');
    });
    /*选中 是。 显示 模版编码*/
    $(document).on('click','input[type=radio]',function(){
        var p = $(this).parents('label');
        var pc = $(this).parents('.yes');
        var ps =  $(this).parents('.control-box');
        var name = $(this).attr('name');
        $('form input[name='+name+']').parents('label').removeClass('check');
        p.addClass('check');
        if(pc.hasClass('check')){
            ps.addClass('show');
        }else{
            ps.removeClass('show');
        }
    });
    $(document).ready( function () {
        //Default Action
        $( ".tab_content" ).hide();  //Hide all content
        $( "ul.tabs li:first" ).addClass( "active" ).show();  //Activate first tab
        $( ".tab_content:first" ).show();  //Show first tab content
        //On Click Event
        $( "ul.tabs li" ).click( function () {
            $( "ul.tabs li" ).removeClass( "active" );  //Remove any "active" class
            $( this ).addClass( "active" );  //Add "active" class to selected tab
            $( ".tab_content" ).hide();  //Hide all tab content
            var  activeTab = $( this ).find( "a" ).attr( "href" );  //Find the rel attribute value to identify the active tab + content
            $(activeTab).fadeIn();  //Fade in the active content
            return   false ;
        });
    });

</script>