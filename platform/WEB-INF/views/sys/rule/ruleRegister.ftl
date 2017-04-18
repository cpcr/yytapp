<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/rule/sys.rule.js"></script>
    <title>挂号规则配置</title>
</head>
<body>
<#include "./sys/common/hospital_setting.ftl">
    <div id="content-header">
        <div class="widget-title">
            <h3 class="title">挂号规则</h3>
            <#include "/sys/rule/rule_select.ftl">
        </div>
    </div>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
            <div class="widget-box bangKa">
                <div class="space10"></div>
                <form class="form-horizontal evenBg" id="ruleRegisterForm">
                    <input type="hidden" name="hospitalId" value="${ruleRegister.hospitalId}"/>
                    <input type="hidden" id="id" name="id" value="${ruleRegister.id}"/>
                    <div class="widget-content guaHao">
                        <div class="row-fluid">
                            <div class="control-group w162">
                                <label class="control-label" style="padding-top:70px;width:150px;">页面样式及流程设置</label>
                                <div class="controls" style="margin-left: 213px;">
                                    <div class="line">
                                        <span class="text">医院是否有分院：</span>
                                        <label
                                            <#if ruleRegister.isHasBranch == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasBranch" value="1"
                                            <#if ruleRegister.isHasBranch == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />是
                                        </label>
                                        <label
                                            <#if ruleRegister.isHasBranch == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasBranch" value="0"
                                            <#if ruleRegister.isHasBranch == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />否
                                        </label>
                                    </div>
                                    <div class="line">
                                        <span class="text">医院是否有二级科室：</span>
                                        <label
                                            <#if ruleRegister.isHasGradeTwoDept == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasGradeTwoDept" value="1"
                                            <#if ruleRegister.isHasGradeTwoDept == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />是
                                        </label>
                                        <label
                                            <#if ruleRegister.isHasGradeTwoDept == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasGradeTwoDept" value="0"
                                            <#if ruleRegister.isHasGradeTwoDept == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />否
                                        </label>
                                    </div>
                                    <div class="line">
                                        <span class="text">医院是配置搜索医生功能：</span>
                                        <label
                                            <#if ruleRegister.isHasSearChDoctor == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasSearChDoctor" value="1"
                                            <#if ruleRegister.isHasSearChDoctor == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />是
                                        </label>
                                        <label
                                            <#if ruleRegister.isHasSearChDoctor == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasSearChDoctor" value="0"
                                            <#if ruleRegister.isHasSearChDoctor == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />否
                                        </label>
                                    </div>
                                    <div class="line">
                                        <span class="text">医院是否有当班挂号：</span>
                                        <label
                                            <#if ruleRegister.isHasOnDutyReg == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasOnDutyReg" value="1"
                                            <#if ruleRegister.isHasOnDutyReg == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />是
                                        </label>
                                        <label
                                            <#if ruleRegister.isHasOnDutyReg == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasOnDutyReg" value="0"
                                            <#if ruleRegister.isHasOnDutyReg == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />否
                                        </label>
                                    </div>
                                    <div class="line">
                                        <span class="text">医院是否有预约挂号：</span>
                                        <label
                                            <#if ruleRegister.isHasAppointmentReg == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasAppointmentReg" value="1"
                                            <#if ruleRegister.isHasAppointmentReg == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />是
                                        </label>
                                        <label
                                            <#if ruleRegister.isHasAppointmentReg == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isHasAppointmentReg" value="0"
                                            <#if ruleRegister.isHasAppointmentReg == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />否
                                        </label>
                                    </div>
                                    <div class="line">
                                        <span class="text">预约挂号日历显示天数：</span>
                                        <div class="my_select">
                                            <select name="calendarDaysType" id="calendarDaysType">
                                                <option value="0" <#if ruleRegister.calendarDaysType == 0>selected="selected"</#if>>实际天数</option>
                                                <option value="7" <#if ruleRegister.calendarDaysType == 7>selected="selected"</#if>>7天</option>
                                                <option value="8" <#if ruleRegister.calendarDaysType == 8>selected="selected"</#if>>8天</option>
                                                <option value="9" <#if ruleRegister.calendarDaysType == 9>selected="selected"</#if>>9天</option>
                                                <option value="10" <#if ruleRegister.calendarDaysType == 10>selected="selected"</#if>>10天</option>
                                                <option value="15" <#if ruleRegister.calendarDaysType == 15>selected="selected"</#if>>15天</option>
                                                <option value="20" <#if ruleRegister.calendarDaysType == 20>selected="selected"</#if>>20天</option>
                                                <option value="30" <#if ruleRegister.calendarDaysType == 30>selected="selected"</#if>>30天</option>
                                            </select>
                                        </div>
                                        <#--<label-->
                                            <#--<#if ruleRegister.calendarDaysType == 1>-->
                                               <#--class="radio inline check">-->
                                            <#--<#else>-->
                                               <#--class="radio inline">-->
                                            <#--</#if> -->
                                            <#--<input type="radio" name="calendarDaysType" value="1"-->
                                            <#--<#if ruleRegister.calendarDaysType == 1>-->
                                                <#--checked="checked"-->
                                            <#--<#else>-->
                                            <#--</#if>-->
                                            <#--/>7天-->
                                        <#--</label>-->
                                             <#--<label-->
                                            <#--<#if ruleRegister.calendarDaysType == 2>-->
                                               <#--class="radio inline check">-->
                                            <#--<#else>-->
                                               <#--class="radio inline">-->
                                            <#--</#if> -->
                                            <#--<input type="radio" name="calendarDaysType" value="2"-->
                                            <#--<#if ruleRegister.calendarDaysType == 2>-->
                                                <#--checked="checked"-->
                                            <#--<#else>-->
                                            <#--</#if>-->
                                            <#--/>15天-->
                                        <#--</label>-->
                                        <#--<label-->
                                            <#--<#if ruleRegister.calendarDaysType == 3>-->
                                               <#--class="radio inline check">-->
                                            <#--<#else>-->
                                               <#--class="radio inline">-->
                                            <#--</#if> -->
                                            <#--<input type="radio" name="calendarDaysType" value="3"-->
                                            <#--<#if ruleRegister.calendarDaysType == 3>-->
                                                <#--checked="checked"-->
                                            <#--<#else>-->
                                            <#--</#if>-->
                                            <#--/>30天-->
                                        <#--</label>-->
                                    </div>
                                    <div class="line">
                                        <span class="text">号源缓存天数：</span>
                                        <input type="text" class="span2 input33" name="sourceCacheDays" id="sourceCacheDays" style="width:80px;"
                                            value="${ruleRegister.sourceCacheDays}"/> 天
                                    </div>
                                    <div class="line">
                                        <span class="text">是否显示病情描述：</span>
                                        <label
                                            <#if ruleRegister.isViewDiseaseDesc == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewDiseaseDesc" value="1"
                                            <#if ruleRegister.isViewDiseaseDesc == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />是
                                        </label>
                                        <label
                                            <#if ruleRegister.isViewDiseaseDesc == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="isViewDiseaseDesc" value="0"
                                            <#if ruleRegister.isViewDiseaseDesc == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />否
                                        </label>
                                    </div>
                                    <div class="line">
                                        <span class="text">在线支付控制：</span>
                                        <label style="width:120px;"
                                            <#if ruleRegister.onlinePaymentControl == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="onlinePaymentControl" value="1"
                                            <#if ruleRegister.onlinePaymentControl == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />必须在线支付
                                        </label>
                                        <label style="width:120px;"
                                            <#if ruleRegister.onlinePaymentControl == 2>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="onlinePaymentControl" value="2"
                                            <#if ruleRegister.onlinePaymentControl == 2>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不用在线支付
                                        </label>
                                        <label style="width:120px;"
                                            <#if ruleRegister.onlinePaymentControl == 3>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if> 
                                            <input type="radio" name="onlinePaymentControl" value="3"
                                            <#if ruleRegister.onlinePaymentControl == 3>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />支持暂不支付
                                        </label>
                                    </div>
                                    <div class="line">
                                        <span class="text">当班挂号是否支持退费：</span>
                                         <label
                                            <#if ruleRegister.isSupportRefundOnDuty == 1>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if>
                                            <input type="radio" name="isSupportRefundOnDuty" value="1"
                                            <#if ruleRegister.isSupportRefundOnDuty == 1>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />支持
                                        </label>
                                              <label
                                            <#if ruleRegister.isSupportRefundOnDuty == 0>
                                               class="radio inline check">
                                            <#else>
                                               class="radio inline">
                                            </#if>
                                            <input type="radio" name="isSupportRefundOnDuty" value="0"
                                            <#if ruleRegister.isSupportRefundOnDuty == 0>
                                                checked="checked"
                                            <#else>
                                            </#if>
                                            />不支持
                                        </label>
                                    </div>
                                    <div class="line">
                                        <span class="text">预约挂号是否支持退费：</span>
                                        <label
                                        <#if ruleRegister.isSupportRefundAppointment == 1>
                                                class="radio inline check">
                                        <#else>
                                            class="radio inline">
                                        </#if>
                                            <input type="radio" name="isSupportRefundAppointment" value="1"
                                            <#if ruleRegister.isSupportRefundAppointment == 1>
                                                   checked="checked"
                                            <#else>
                                            </#if>
                                            />支持
                                        </label>
                                        <label
                                        <#if ruleRegister.isSupportRefundAppointment == 0>
                                                class="radio inline check">
                                        <#else>
                                            class="radio inline">
                                        </#if>
                                            <input type="radio" name="isSupportRefundAppointment" value="0"
                                            <#if ruleRegister.isSupportRefundAppointment == 0>
                                                   checked="checked"
                                            <#else>
                                            </#if>
                                            />不支持
                                        </label>
                                    </div>
                                    
                                    <div class="line">
                                        <span class="text">取号规则：</span>
                                        <label
                                        <#if ruleRegister.reservationRule == 1>
                                                class="radio inline check">
                                        <#else>
                                            class="radio inline">
                                        </#if>
                                            <input type="radio" name="reservationRule" value="1"
                                            <#if ruleRegister.reservationRule == 1>
                                                   checked="checked"
                                            <#else>
                                            </#if>
                                            />全天取号
                                        </label>
                                        <label
                                        <#if ruleRegister.reservationRule == 0>
                                                class="radio inline check">
                                        <#else>
                                            class="radio inline">
                                        </#if>
                                            <input type="radio" name="reservationRule" value="0"
                                            <#if ruleRegister.reservationRule == 0>
                                                   checked="checked"
                                            <#else>
                                            </#if>
                                            />当班取号
                                        </label>
                                        <input type="text" class="span2 input33" name="reservationHourRule" id="reservationHourRule" style="width:80px;"
                                                value="${ruleRegister.reservationHourRule}"/>时
                                    </div>
                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label" style="padding-top: 225px;width:150px;">挂号节点控制</label>
                                <div class="controls" style="margin-left: 213px;">
                                    <div class="line">
                                        <span class="text2" style="width:270px;">当班挂号允许挂号时间段：</span>
                                        <input type="text" class="span2 input33" name="onDutyRegStartTime" id="onDutyRegStartTime" 
                                            value="${ruleRegister.onDutyRegStartTime?string('HH:mm')}"/> -
                                        <input type="text" class="span2 input33" name="onDutyRegEndTime" id="onDutyRegEndTime" 
                                            value="${ruleRegister.onDutyRegEndTime?string('HH:mm')}"/>　(例如00:00 - 16:00)
                                    </div>
                                    <div class="line">
                                        <span class="text2" style="width:270px;">允许预约明天号的截止时间点：</span>
                                        <input type="text" class="span2 input33" name="appointmentTomorrowEndTime" id="appointmentTomorrowEndTime" 
                                            value="${ruleRegister.appointmentTomorrowEndTime?string('HH:mm')}"/>　(例如16:00)</div>
                                    <div class="line">
                                        <span class="text2" style="width:270px;">(必须在线支付)挂号支付时间：</span>
                                        <input type="text" class="span2 input33" name="paymentTimeOutTime" id="paymentTimeOutTime"
                                            value="${ruleRegister.paymentTimeOutTime}"/>　分钟</div>
                                    <div class="line">
                                        <span class="text2" style="width:270px;">每张就诊卡每天允许挂同一医生号次数：</span>
                                        <input type="text" class="span2 input33" name="regMaximumSameDoctor" id="regMaximumSameDoctor"
                                            value="${ruleRegister.regMaximumSameDoctor}"/>　次</div>
                                    <div class="line">
                                        <span class="text2" style="width:270px;">每张就诊卡每天允许挂号次数：</span>
                                        <input type="text" class="span2 input33" name="regMaximumInDay" id="regMaximumInDay" 
                                            value="${ruleRegister.regMaximumInDay}"/>　次</div>
                                    <div class="line">
                                        <span class="text2" style="width:270px;">每张就诊卡每周允许挂号次数：</span>
                                        <input type="text" class="span2 input33" name="regMaximumInWeek" id="regMaximumInWeek" 
                                            value="${ruleRegister.regMaximumInWeek}"/>　次</div>
                                    <div class="line">
                                        <span class="text2" style="width:270px;">每张就诊卡每月允许挂号次数：</span>
                                        <input type="text" class="span2 input33" name="regMaximumInMonth" id="regMaximumInMonth" 
                                            value="${ruleRegister.regMaximumInMonth}"/>　次</div>
                                    <div class="line">
                                        <span class="text2" style="width:270px;">每张就诊卡每天允许取消挂号次数：</span>
                                        <input type="text" class="span2 input33" name="regCancelMaxnumInDay" id="regCancelMaxnumInDay" 
                                            value="${ruleRegister.regCancelMaxnumInDay}"/>　次</div>
                                    <div class="line"><span class="text2" style="width:270px;">(暂不支付)支付截止时间点：</span>
                                        <div class="my_select">
                                            <select name="notPaidpayOffType" id="notPaidpayOffType" onchange="onchangeNotPaidpayOffType();">
                                                <option value="1" <#if ruleRegister.notPaidpayOffType == 1>selected="selected"</#if>>就诊前一天几点</option>
                                                <option value="2" <#if ruleRegister.notPaidpayOffType == 2>selected="selected"</#if>>就诊当天几点</option>
                                                <option value="3" <#if ruleRegister.notPaidpayOffType == 3>selected="selected"</#if>>就诊时间段前几小时</option>
                                                <option value="4" <#if ruleRegister.notPaidpayOffType == 4>selected="selected"</#if>>就诊时间段开始前多少分钟</option>
                                                <option value="5" <#if ruleRegister.notPaidpayOffType == 5>selected="selected"</#if>>就诊时间段开始的时间</option>
                                                <option value="6" <#if ruleRegister.notPaidpayOffType == 6>selected="selected"</#if>>就诊时间段结束的时间</option>
                                                <option value="7" <#if ruleRegister.notPaidpayOffType == 7>selected="selected"</#if>>就诊时间结束前多少分钟</option>
                                                <option value="8" <#if ruleRegister.notPaidpayOffType == 8>selected="selected"</#if>>不限制</option>
                                            </select>
                                        </div>　
                                        <input type="text" 
                                        <#if  ruleRegister.notPaidpayOffType == 5 || ruleRegister.notPaidpayOffType == 6 || ruleRegister.notPaidpayOffType ==8>
                                        style="display:none" 
                                        </#if>
                                        class="span2 input33" name="notPaidpayOffTime" id="notPaidpayOffTime" 
                                            value="${ruleRegister.notPaidpayOffTime}"/>　
                                    </div>
                                    <div class="line"><span class="text2" style="width:270px;">取消预约挂号截止时间点：</span>
                                        <div class="my_select">
                                            <select name="cancelBespeakCloseType" id="cancelBespeakCloseType" onchange="onchangeBespeakCloseType();">
                                                <option value="1" <#if ruleRegister.cancelBespeakCloseType == 1>selected="selected"</#if>>就诊前一天几点</option>
                                                <option value="2" <#if ruleRegister.cancelBespeakCloseType == 2>selected="selected"</#if>>就诊当天几点</option>
                                                <option value="3" <#if ruleRegister.cancelBespeakCloseType == 3>selected="selected"</#if>>就诊时间段前几小时</option>
                                                <option value="4" <#if ruleRegister.cancelBespeakCloseType == 4>selected="selected"</#if>>就诊时间段开始前多少分钟</option>
                                                <option value="5" <#if ruleRegister.cancelBespeakCloseType == 5>selected="selected"</#if>>就诊时间段开始的时间</option>
                                                <option value="6" <#if ruleRegister.cancelBespeakCloseType == 6>selected="selected"</#if>>就诊时间段结束的时间</option>
                                                <option value="7" <#if ruleRegister.cancelBespeakCloseType == 7>selected="selected"</#if>>就诊时间结束前多少分钟</option>
                                                <option value="8" <#if ruleRegister.cancelBespeakCloseType == 8>selected="selected"</#if>>不限制</option>
                                            </select>
                                        </div>　
                                        <input type="text" 
                                        <#if  ruleRegister.cancelBespeakCloseType == 5 || ruleRegister.cancelBespeakCloseType == 6 || ruleRegister.cancelBespeakCloseType ==8>
                                        style="display:none" 
                                        </#if>
                                            class="span2 input33" name="cancelBespeakEndTime" id="cancelBespeakEndTime" 
                                            value="${ruleRegister.cancelBespeakEndTime}"/>　
                                    </div>
                                    <div class="line"><span class="text2" style="width:270px;">取消当班挂号截止时间点：</span>
                                        <div class="my_select">
                                            <select name="cancelOnDutyCloseType" id="cancelOnDutyCloseType" onchange="onchangeOnDutyCloseType();">
                                                <option value="1" <#if ruleRegister.cancelOnDutyCloseType == 1>selected="selected"</#if>>就诊当天几点</option>
                                                <option value="2" <#if ruleRegister.cancelOnDutyCloseType == 2>selected="selected"</#if>>就诊时间段开始前几小时</option>
                                                <option value="3" <#if ruleRegister.cancelOnDutyCloseType == 3>selected="selected"</#if>>就诊时间段开始前多少分钟</option>
                                                <option value="4" <#if ruleRegister.cancelOnDutyCloseType == 4>selected="selected"</#if>>就诊时间段开始的时间</option>
                                                <option value="5" <#if ruleRegister.cancelOnDutyCloseType == 5>selected="selected"</#if>>就诊时间段结束的时间</option>
                                                <option value="6" <#if ruleRegister.cancelOnDutyCloseType == 6>selected="selected"</#if>>就诊时间段结束前多少分钟</option>
                                                <option value="7" <#if ruleRegister.cancelOnDutyCloseType == 7>selected="selected"</#if>>不限制</option>
                                            </select>
                                        </div>　
                                        <input type="text" 
                                        <#if  ruleRegister.cancelOnDutyCloseType == 4 || ruleRegister.cancelOnDutyCloseType == 5 || ruleRegister.cancelOnDutyCloseType ==7>
                                        style="display:none" 
                                        </#if>
                                        class="span2 input33" name="cancelOnDutyEndTimes" id="cancelOnDutyEndTimes" 
                                            value="${ruleRegister.cancelOnDutyEndTimes}"/>　
                                    </div>

                                </div>
                            </div>
                            <div class="control-group w162">
                                <label class="control-label" style="padding-top: 410px;width:150px;">提示语设置</label>
                                <div class="controls" style="margin-left: 213px;">
                                    <div class="line">
                                        <span class="text3" style="width:270px;">所选日期没有号源信息提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="noSourceTipContent" 
                                            id="noSourceTipContent" value="${ruleRegister.noSourceTipContent}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">当班挂号温馨提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="onDutyRegTipContent" 
                                            id="onDutyRegTipContent" value="${ruleRegister.onDutyRegTipContent}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过当班挂号截止时间点的提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="onDutyRegOverTimeTip" 
                                            id="onDutyRegOverTimeTip" value="${ruleRegister.onDutyRegOverTimeTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过预约明天号截止时间点的提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="bespeakRegOverTimeTip" 
                                            id="bespeakRegOverTimeTip" value="${ruleRegister.bespeakRegOverTimeTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">挂号失败提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="regFailedTip" 
                                            id="regFailedTip" value="${ruleRegister.regFailedTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">可享受医院挂号优惠提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="regDiscountTip" 
                                            id="regDiscountTip" value="${ruleRegister.regDiscountTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过每天挂同一医生号次数提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="overMaximumSameDoctorTip" 
                                            id="overMaximumSameDoctorTip" value="${ruleRegister.overMaximumSameDoctorTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过每天允许挂号次数提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="overMaximumInDayTip" 
                                            id="overMaximumInDayTip" value="${ruleRegister.overMaximumInDayTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过每周允许挂号次数提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="overMaximumInWeekTip" 
                                            id="overMaximumInWeekTip" value="${ruleRegister.overMaximumInWeekTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过每月允许挂号次数提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="overMaximumInMonthTip" 
                                            id="overMaximumInMonthTip" value="${ruleRegister.overMaximumInMonthTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过每天允许取消挂号次数提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="overCancelMaxnumInDayTip" 
                                            id="overCancelMaxnumInDayTip" value="${ruleRegister.overCancelMaxnumInDayTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过取消预约挂号截止时间点提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="cancelBespeakTimeOutTip" 
                                            id="cancelBespeakTimeOutTip" value="${ruleRegister.cancelBespeakTimeOutTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">超过取消当班挂号截止时间点提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="cancelOnDutyTimeOutTip" 
                                            id="cancelOnDutyTimeOutTip" value="${ruleRegister.cancelOnDutyTimeOutTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">黑名单用户挂号提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="blacklistUserRegTip" 
                                            id="blacklistUserRegTip" value="${ruleRegister.blacklistUserRegTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">确认支付信息提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="confirmRegInfoTip" 
                                            id="confirmRegInfoTip" value="${ruleRegister.confirmRegInfoTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">挂号支付超时提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="regPayTimeOutTip" 
                                            id="regPayTimeOutTip" value="${ruleRegister.regPayTimeOutTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">挂号成功（已缴费）时提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="regSuccessHadPayTip" 
                                            id="regSuccessHadPayTip" value="${ruleRegister.regSuccessHadPayTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">挂号成功（未缴费）时提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="regSuccessNoPayTip" 
                                            id="regSuccessNoPayTip" value="${ruleRegister.regSuccessNoPayTip}"/>　
                                    </div>
                                    <div class="line">
                                        <span class="text3" style="width:270px;">挂号成功（当班挂号）时提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="regSuccessOnDutyTip" 
                                            id="regSuccessOnDutyTip" value="${ruleRegister.regSuccessOnDutyTip}"/>　
                                    </div>
									<div class="line">
                                        <span class="text3" style="width:270px;">挂号前温馨提示语：</span>
                                        <input type="text" placeholder="点击输入提示语" class="span5 input33" name="preRegisterWarmTip" 
                                            id="preRegisterWarmTip" value="${ruleRegister.preRegisterWarmTip}"/>　
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space20"></div>
                    <button class="btn btn-save" type="button" onclick="ruleJS.saveRule('ruleRegisterForm' , 'RuleRegister')">保存</button>
                </form>
            </div>
        </div>

    </div>
</div>
<!--content end-->
</body>
</html>
<script type="text/javascript">
function onchangeOnDutyCloseType(){
   var type =  $("#cancelOnDutyCloseType").val();
   if(type == 4 || type == 5 || type == 7){
        $("#cancelOnDutyEndTimes").hide();
        $("#cancelOnDutyEndTimes").val("");
   }else{
        $("#cancelOnDutyEndTimes").show();
   }
}
function onchangeBespeakCloseType(){
   var type =  $("#cancelBespeakCloseType").val();
   if(type == 5 || type == 6 || type == 8){
        $("#cancelBespeakEndTime").hide();
        $("#cancelBespeakEndTime").val("");
   }else{
        $("#cancelBespeakEndTime").show();
   }
}
function onchangeNotPaidpayOffType(){
   var type =  $("#notPaidpayOffType").val();
   if(type == 5 || type == 6 || type == 8){
        $("#notPaidpayOffTime").hide();
        $("#notPaidpayOffTime").val("");
   }else{
        $("#notPaidpayOffTime").show();
   }
}


</script>
