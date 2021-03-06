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
	                    <div class="values color666">住院押金补缴</div>
	                </li>
	                <li>
	                    <div class="label">患者姓名</div>
	                    <div class="values color666">${record.encryptedPatientName}</div>
	                </li>
	                <li>
	                    <div class="label" style="width: 3em">卡号</div>
	                    <div class="values color666">${record.cardNo}</div>
	                </li>
	                <li>
	                    <div class="label" style="width: 3em">住院号</div>
	                    <div class="values color666">${record.admissionNo}</div>
	                </li>
	                <li>
	                    <div class="label">付款金额</div>
	                    <div class="values color666">
	                        <span class="price">${(record.payFee?number / 100)?string('0.00')}</span> 元
	                    </div>
	                </li>
	            </ul>
	        </div>
	    </div>
		<div class="section">
	        <div class="box-tips">
	        	<i class="icon-warn"></i>
	        	吓死宝宝了
	        </div>
	    </div>
	</div>
</body>
</html>