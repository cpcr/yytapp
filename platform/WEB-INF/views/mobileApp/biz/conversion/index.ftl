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
    <title>一键转医保</title>
    <style type="text/css">
        body .sweet-alert h2 {
            font-size: 20px;
            font-weight: normal;
        }
        footer div {
            position: absolute;
            width: 100%;
            bottom: 7px;
            text-align: center;
        }
        footer div a {
            color: #2297F7;
            font-size: 14px;
            text-decoration: none;
            font-family: "microsoft yahei";
        }
    </style>
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
    <link rel="stylesheet" type="text/css" href="${basePath}mobileApp/reservation/css/registration.css">
    <link rel="stylesheet" type="text/css" href="${basePath}mobileApp/sweetalert/sweetalert.css">
</head>
<body>
<header class="banner">

</header>
<p class="tip-warn">
<#if medicalCardNo?exists && medicalCardNo!="" >
    温馨提示: 已绑定医保卡,卡号:${medicalCardNo}
<#else>
    温馨提示: 需尚未绑定医保卡,无法使用该功能
</#if>
</p>
<section class="reg-box">
    <form method="post" action="${basePath}mobileApp/conversion/regRecordList" onsubmit="javascript: check(this);return false;">
        <ul class="reg-cont">
            <li class="reg-field-item">
                <label>
                    <span class="key">${user.encryptedName}</span>
                    <span class="value">${user.encryptedCardNo}</span>
                </label>
            </li>
            <li class="reg-field-item">
                <label>
                    <span class="key">医院</span>
                        <span class="value value-arrow">
                            <select id="hospitals">
                                <#list hospitals as hospital>
                                    <option id="${hospital.hospitalId}" value="${hospital.hospitalCode}">
                                        ${hospital.hospitalName}
                                    </option>
                                </#list>
                            </select>
                        </span>
                </label>
            </li>
        </ul>
        <div class="reg-btns-box">
            <button type="submit" class="reg-btn-next">确认</button>
        </div>
        <input type="hidden" id="appId" name="appId" value="${appId}">
        <input type="hidden" id="appCode" name="appCode" value="${appCode}">
        <input type="hidden" name="hospitalId">
        <input type="hidden" name="hospitalCode">
        <input type="hidden" name="branchHospitalId">
        <input type="hidden" name="branchHospitalCode">
        <input type="hidden" id="medicalCardNo" name="medicalCardNo" value="${medicalCardNo}">
        <input type="hidden" id="medicalCardId" name="medicalCardId" value="${medicalCardId}">
    </form>
</section>
<footer>
    <div>

    </div>
</footer>
<script src="${basePath}mobileApp/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
    function check(form) {
        var hospitals = document.getElementById("hospitals");
        var selectedHospital = hospitals.options[hospitals.selectedIndex];
        if (hospitals && selectedHospital) {
            var hospitalId = selectedHospital.id;
            var hospitalCode = selectedHospital.value;
            var medicalCardNo = document.getElementById("medicalCardNo").value;
            if (medicalCardNo && medicalCardNo.trim()) {
                document.getElementsByName("hospitalId")[0].value = hospitalId;
                document.getElementsByName("hospitalCode")[0].value = hospitalCode;
                form.submit();
            } else {
                swal({
                    title: "尚未绑定医保卡",
                    timer: 1000,
                    showConfirmButton: false
                });
            }
        } else {
            swal({
                title: "请选择医院",
                timer: 1000,
                showConfirmButton: false
            });
        }
        return false;
    }
</script>
</body>
</html>