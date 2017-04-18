<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
    <#include "/mobileApp/common/common.ftl">
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
    <section class="reg-box">
        <div class="reg-cont">
            <img class="tips-icon" src="${basePath}images/reservation/img_success.png">
            <p class="tips-hint">挂号成功，${totalFee}元</p>
            <p class="tips-msg">
                您好，${username}，您的排队号是<span class="reg-color-blue">${serialNum}</span>，
                请于<span class="reg-color-blue">${visitTime}</span>&nbsp;前到${hospitalName}&nbsp;<span class="reg-color-blue">${visitLocation}</span>&nbsp;就诊。
            </p>
        </div>
        <div class="reg-btns-box">
            <div class="btn btn-ok btn-block" style="background-color: white;border: 1px solid #ccc;" onclick="showOrderInfo();"><span style="color: black;">更多订单信息</span></div>
        </div>
        <div class="reg-btns-box">
            <div class="btn btn-ok btn-block" onclick="closeWindow();">确定</div>
        </div>
    </section>
    <#include "/mobileApp/common/yxw_footer.ftl">
    <script type="text/javascript">
        window.onload = function() {
            var value = ${barcode};
            var codeStyle = '4';
            var btype = '';
            switch (codeStyle) {
                case '1':
                    btype = 'ean8';
                    break;
                case '2':
                    btype = 'upc';
                    break;
                case '3':
                    btype = 'code39';
                    break;
                case '4':
                    btype = 'code128';
                    break;
                case '5':
                    btype = 'codabar';
                    break;
                default:
                    btype = 'code128';
            }
            var renderer = 'css';
            var settings = {
                output: renderer,
                bgColor: '#FFFFFF',
                color: '#000000',
                barWidth: 2,
                barHeight: 50,
                moduleSize: 5,
                posX: 10,
                posY: 20,
                addQuietZone: false
            };
            $("#barcodeTarget").html("").show().barcode(value, btype, settings);
        };

        function showOrderInfo() {
            var now = new Date();
            var timeTemp = now.getTime();
            window.location = "${basePath}mobileApp/register/infos/showOrderInfo?orderNo=${orderNo}&openId=${openId}&userId=${userId}&isDetail=yep&timeTemp=" + timeTemp;
        }

        function closeWindow(){
            var appCode = jQuery("#appCode").val();
            if(appCode == "easyHealth"){
                if(IS.isMacOS){
                    appCloseView();
                }else if(IS.isAndroid){
                    yyc.appCloseView();
                }
            }else{
                try{
                    WeixinJSBridge.invoke('closeWindow',{},function(res){});
                }catch(e){
                    AlipayJSBridge.call('closeWebview');
                }
            }
        }
    </script>
</body>
</html>
