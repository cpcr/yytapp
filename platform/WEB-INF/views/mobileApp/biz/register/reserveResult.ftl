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
    <title>预约结果</title>
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
</head>
<body>
<#if regStatus == "0">
<section class="reg-box">
    <div class="reg-cont">
        <img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_success@3x.png">
        <p class="tips-hint">挂号(医保)成功</p>
        <p class="tips-msg">
            您好，${user.name}(${serialNum})，请于<span class="reg-color-blue">${scheduleDate}</span>&nbsp;当天就诊前进行支付取号。
        </p>
        <p class="tips-msg">
            温馨提示：医保挂号只能在就诊当天进行支付取号。
        </p>
    </div>
</section>
<#else>
<section class="reg-box">
    <div class="reg-cont">
        <img class="tips-icon" src="${basePath}mobileApp/reservation/img/quhao_weizhifu@3x.png">
        <p class="tips-hint">挂号(医保)失败</p>
    </div>
</section>
</#if>
</body>
</html>
