<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <title>取号结果</title>
    <style type="text/css">
        .box-slot {
            min-height: 300px;
            text-align: center;
            padding: 0 10px;
        }

        .pic-tips {
            margin-top: 50px;
            margin-bottom: 20px;
        }

        .info-tips {
            margin-bottom: 15px;
            color: #777;
        }

        .des-slot {
            padding: 30px;
            text-align: left;
        }

        .info-color {
            color: rgb(34, 151, 247);
        }

        .pic-success {
            margin-top: 50px;
            margin-bottom: 30px;
            text-align: center
        }

        .text-center {
            text-align: center;
        }
    </style>
</head>
<body>
<div id="body">
<#if resultType == "111">
    <div class="box-list box-slot">
        <div class="pic pic-tips">
            <img src="${basePath}images/reservation/img_takno.png" width="50" height="50"/>
        </div>
        <div class="info info-tips">您已经取过号了，请到科室就诊</div>
        <div class="des des-slot">
            您好，您的排队号是<span class="info-color">${serialNum}</span>，
            请于<span class="info-color">${visitTime}</span>前到<span>${hospitalName}</span>
            <span class="info-color">${visitLocation}</span>就诊。
        </div>
    </div>
</#if>
<#if resultType == "222">
    <div class="box-list box-slot">
        <div class="pic pic-tips">
            <img src="${basePath}images/reservation/img_takno.png" width="50" height="50"/>
        </div>
        <div class="info">超过取号时间，请重新挂号</div>
    </div>
</#if>
<#if resultType == "333">
    <div class="box-list box-slot">
        <div class="pic pic-tips">
            <img src="${basePath}images/reservation/img_takno.png" width="50" height="50"/>
        </div>
        <div class="info">未到取号时间，请在就诊当天取号</div>
    </div>
</#if>
<#if resultType == "444">
    <div class="box-list box-slot">
        <div class="pic pic-tips">
            <img src="${basePath}images/reservation/img_takno.png" width="50" height="50"/>
        </div>
        <div class="info info-tips">查不到预约单</div>
        <div class="info">查不到<span class="info-color">${username}</span>(<span
                class="info-color">预约号: ${orderNo}</span>)的预约挂号订单，请于就诊当天输入正确的预约号码取号。
        </div>
    </div>
</#if>
<#if resultType == "0">
    <div class="box-list box-slot">
        <div class="pic pic-success">
            <img src="${basePath}images/reservation/img_success.png" width="50" height="50"/>
        </div>
        <div class="info info-tips">取号成功</div>
        <div class="des">
            您好，您的排队号是<span class="info-color">${serialNum}</span>，
            请于<span class="info-color">${visitTime}</span>前到<span>${hospitalName}</span>
            <span class="info-color">${deptLocation}</span>就诊。
        </div>
    </div>
</#if>
<#if resultType == "-1">
    <div class="box-list box-slot">
        <div class="pic pic-tips">
            <img src="${basePath}images/reservation/img_topay.png" width="50" height="50"/>
        </div>
        <div class="info">取号前请先支付挂号费</div>
    </div>
    <div class="text-center">
        <div class="section btn-w">
            <form method="post" action="${basePath}mobileApp/register/confirm/registerInfo">
                <input type="hidden" name="userId" value="${user.id}">
                <input type="hidden" name="openId" value="${user.account}">
                <input type="hidden" name="showDays" value="${showDays}">
                <input type="hidden" name="appCode" value="${appCode}">
                <input type="hidden" name="appId" value="${serviceId}">
                <input type="hidden" name="hospitalId" value="${branchHospital.hospitalId}">
                <input type="hidden" name="hospitalCode" value="${branchHospital.hospitalCode}">
                <input type="hidden" name="hospitalName" value="${branchHospital.hospitalName}">
                <input type="hidden" name="branchHospitalId" value="${branchHospital.id}">
                <input type="hidden" name="branchHospitalCode" value="${branchHospital.code}">
                <input type="hidden" name="branchHospitalName" value="${branchHospital.name}">
                <input type="hidden" name="deptCode" value="${data.deptCode}">
                <input type="hidden" name="deptName" value="${data.deptName}">
                <input type="hidden" name="doctorCode" value="${data.doctorCode}">
                <input type="hidden" name="doctorName" value="${data.doctorName}">
                <input type="hidden" name="selectRegDate" value="${data.scheduleDate}">
                <input type="hidden" name="category" value="${category}">
                <input type="hidden" name="doctorTitle" value="${doctorTitle}">
                <input type="hidden" name="doctorBeginTime" value="${data.beginTime}">
                <input type="hidden" name="doctorEndTime" value="${data.endTime}">
                <input type="hidden" name="regFee" value="${data.regFee}">
                <input type="hidden" name="treatFee" value="${data.treatFee}">
                <input type="hidden" name="regType" value="${data.regType}">
                <input type="hidden" name="areaCode" value="${areaCode}">
                <input type="hidden" name="workId" value="${data.workId}">
                <input type="hidden" name="timeFlag" value="${timeFlag}">
                <input type="hidden" name="sStreatFee" value="${data.SStreatFee}">
                <input type="hidden" name="viaFlag" value="${viaFlag}">
                <input type="hidden" name="reserveOrderNo" value="${reserveOrderNo}">
                <button type="submit" class="btn btn-block">去支付</button>
            </form>
        </div>
    </div>
</#if>
</div>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>
