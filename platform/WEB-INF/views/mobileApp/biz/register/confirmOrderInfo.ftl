<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <title>确认订单信息</title>
</head>
<body>
<div id="body">
    <div id="guoHao">
        <div class="box-list">
            <ul class="yx-list">
                <li>
                    <div class="label">医院名称</div>
                    <div class="values color666">${record.hospitalName}</div>
                </li>
                <li>
                    <div class="label">业务名称</div>
                    <div class="values color666">挂号费</div>
                </li>
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
                    <div class="label">就诊时间</div>
                    
                    <div class="values color666">${record.scheduleDate?string('yyyy-MM-dd')} 
                    <#if record.beginTime?exists && record.endTime?exists >
                        ${record.beginTime?string('HH:mm')}-${record.endTime?string('HH:mm')}
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
                    <div class="label">患者姓名</div>
                    <div class="values color666">${record.encryptedPatientName}</div>
                    <#--<div class="values color666">${record.patientName}</div>-->
                </li>
                <li>
                    <div class="label" style="width: 3em">卡号</div>
                    <div class="values color666">${record.cardNo}</div>
                </li>
                <#if record.checkFee ?exists>
                    <li>
                        <div class="label">挂号费</div>
                        <div class="values color666">
                            <span class="price">${(record.realRegFee + record.realTreatFee) / 100}</span> 元
                        </div>
                    </li>
                    <li>
                        <div class="label" style="max-width: 15em">检查费<font color="#ff9400">（缴完挂号费后缴纳）</font>
                        </div>
                        <div class="values color666">
                            <span class="price">${(record.checkFee) / 100}</span> 元
                        </div>
                    </li>
                <#else>
                    <li>
                        <div class="label">付款金额</div>
                        <div class="values color666">

                            <span class="price">${(record.realRegFee + record.realTreatFee) / 100}</span> 元

                        </div>
                    </li>
                </#if>
            </ul>
        </div>
    </div>
    <#if isPreferential == "true">
    <div class="section">
        <div class="box-tips"> <i class="icon-warn"></i>
           温馨提示：${regDiscountTip}
        </div>
    </div>
    </#if>
</div>
</body>
<script>
function doRefresh()
{
	$Y.loading.show('订单信息重载中...');
	setTimeout("$Y.loading.hide()",500);
}

function doGoBack()
{
    windowClose();
}
</script>
</html>
