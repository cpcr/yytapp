<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telphone=no, email=no">
    <meta name="renderer" content="webkit">
    <meta name="HandheldFriendly" content="true">
    <meta name="screen-orientation" content="portrait">
    <meta name="x5-orientation" content="portrait">
    <title>取号结果</title>
    <script>"use strict";
    !function (e, t) {
        function i() {
            var t = n.getBoundingClientRect().width;
            t / m > 540 && (t = 540 * m);
            var i = t / 10;
            n.style.fontSize = i + "px", d.rem = e.rem = i
        }

        var a, r = e.document, n = r.documentElement, o = r.querySelector('meta[name="viewport"]'), l = r.querySelector('meta[name="flexible"]'), m = 0, s = 0, d = t.flexible || (t.flexible = {});
        if (o) {
            console.warn("将根据已有的meta标签来设置缩放比例");
            var p = o.getAttribute("content").match(/initial\-scale=([\d\.]+)/);
            p && (s = parseFloat(p[1]), m = parseInt(1 / s))
        } else if (l) {
            var c = l.getAttribute("content");
            if (c) {
                var u = c.match(/initial\-dpr=([\d\.]+)/), f = c.match(/maximum\-dpr=([\d\.]+)/);
                u && (m = parseFloat(u[1]), s = parseFloat((1 / m).toFixed(2))), f && (m = parseFloat(f[1]), s = parseFloat((1 / m).toFixed(2)))
            }
        }
        if (!m && !s) {
            var v = (e.navigator.appVersion.match(/android/gi), e.navigator.appVersion.match(/iphone/gi)), h = e.devicePixelRatio;
            m = v ? h >= 3 && (!m || m >= 3) ? 3 : h >= 2 && (!m || m >= 2) ? 2 : 1 : 1, s = 1 / m
        }
        if (n.setAttribute("data-dpr", m), !o)if (o = r.createElement("meta"), o.setAttribute("name", "viewport"), o.setAttribute("content", "initial-scale=" + s + ", maximum-scale=" + s + ", minimum-scale=" + s + ", user-scalable=no"), n.firstElementChild)n.firstElementChild.appendChild(o); else {
            var x = r.createElement("div");
            x.appendChild(o), r.write(x.innerHTML)
        }
        e.addEventListener("resize", function () {
            clearTimeout(a), a = setTimeout(i, 300)
        }, !1), e.addEventListener("pageshow", function (e) {
            e.persisted && (clearTimeout(a), a = setTimeout(i, 300))
        }, !1), "complete" === r.readyState ? r.body.style.fontSize = 12 * m + "px" : r.addEventListener("DOMContentLoaded", function () {
            r.body.style.fontSize = 12 * m + "px"
        }, !1), i(), d.dpr = e.dpr = m, d.refreshRem = i, d.rem2px = function (e) {
            var t = parseFloat(e) * this.rem;
            return "string" == typeof e && e.match(/rem$/) && (t += "px"), t
        }, d.px2rem = function (e) {
            var t = parseFloat(e) / this.rem;
            return "string" == typeof e && e.match(/px$/) && (t += "rem"), t
        }
    }(window, window.lib || (window.lib = {}));</script>
    <link rel="stylesheet" href="${basePath}mobileApp/reservation/css/registration.css">
    <script type="text/javascript" src="${basePath}mobileApp/js/common/jquery.min1.9.js"></script>
</head>
<body>
<#if resultType == "0">
    <section class="reg-box">
        <div class="reg-cont">
            <img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_success@3x.png">
            <p class="tips-hint">取号成功</p>
            <p class="tips-msg">
                您好，您的排队号是<span class="reg-color-blue">${serialNum}</span>，
                请于<span class="reg-color-blue">${visitTime}</span>&nbsp;前到${hospitalName}&nbsp;<span class="reg-color-blue">${deptLocation}</span>&nbsp;就诊。
            </p>
        </div>
    </section>
</#if>
<#if resultType == "1">
    <section class="reg-box">
        <div class="reg-cont">
            <img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_success@3x.png">
            <p class="tips-hint">您已经取过号了，请到科室就诊</p>
            <p class="tips-msg">
                您好，您的排队号是<span class="reg-color-blue">${serialNum}</span>，
                请于<span class="reg-color-blue">${visitTime}</span>&nbsp;前到${hospitalName}&nbsp;<span class="reg-color-blue">${visitLocation}</span>&nbsp;就诊。
            </p>
        </div>
    </section>
</#if>
<#if resultType == "2">
    <section class="reg-box">
        <div class="reg-cont">
            <img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_weidao@3x.png">
            <p class="tips-hint">未到取号时间，请在就诊当天取号</p>
        </div>
    </section>
</#if>
<#if resultType == "3">
    <section class="reg-box">
        <div class="reg-cont">
            <img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_chaoshi@3x.png">
            <p class="tips-hint">超过取号时间，请重新挂号</p>
        </div>
    </section>
</#if>
<#if resultType == "4">
    <section class="reg-box">
        <div class="reg-cont">
            <img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_chaoshi@3x.png">
            <p class="tips-hint">未到取号时间，请在7点后进行取号</p>
        </div>
    </section>
</#if>
<#if resultType == "5">
    <section class="reg-box">
        <div class="reg-cont">
            <img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_chaoshi@3x.png">
            <p class="tips-hint">未到取号时间，请在12点后进行取号</p>
        </div>
    </section>
</#if>
<#if resultType == "6">
<section class="reg-box">
    <div class="reg-cont">
        <img class="tips-icon" src="${basePath}mobileApp/reservation/img/nolist@3x.png">
        <p class="tips-hint">查不到预约单</p>
        <p class="tips-msg">
            查不到&nbsp;<span class="reg-color-blue">${username}</span>&nbsp;(&nbsp;<span class="reg-color-blue">预约号:&nbsp;${orderNo}</span>&nbsp;)&nbsp;的预约挂号订单，请于就诊当天输入正确的预约号码取号。
        </p>
    </div>
</section>
</#if>
<#if resultType == "-1">
    <section class="reg-box">
        <div class="reg-cont">
            <!--<img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_weizhifu@3x.png">
           <p class="tips-hint">取号前请先支付挂号费</p>
            <p class="tips-hint">正在加载...</p>-->
        </div>
        <div class="reg-btns-box">
            <form method="post" id="payForm" action="${basePath}mobileApp/register/confirm/registerInfo">
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
                <input type="hidden" name="ownerShipFlag" value="${ownerShipFlag}">
                <input type="hidden" name="reserveFamilyId" value="${reserveFamilyId}">
                <!--<div class="reg-btns-box">
                    <button type="submit" class="reg-btn-next">去支付</button>
                </div>-->
            </form>

            <script type="text/javascript">
                $(function(){
                    document.getElementById("payForm").submit();
                });
            </script>
        </div>
    </section>
</#if>
</body>
</html>


