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
    <title>预约取号</title>
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
        
       *{
			margin: 0;
			padding: 0;
		}

		li{
			list-style-type: none;
		}
		
		body{
			background-color: #f2f2f2;
		}

		.reg-cont{
			width: 94%;
			margin: 3%;
			border-radius: 5px;
			background-color: #fff;
		}
		
		.reg-field-item{
			height: 28px;
			padding: 10px;
			line-height: 28px;
			border-bottom: 1px solid #E0E0E0;
		}
		
		.reg-field-item:last-child{
			border: 0;
		}
		
		.reg-field-item label{
			display: block;
			width: 100%;
		}
		
		.reg-field-item span{
			display: inline-block;
			width: 59%;
		}
		
		
		.reg-field-item .key{
			width: 39%;
			padding-left: 30px;
			box-sizing: border-box;
			background-position: left center; 
			background-repeat: no-repeat;
			background-size: 20px;
		}
		
		.reg-field-item input,
		.reg-field-item select{
			width: 100%;
			text-align: right;
			border: 0;
		}
		.reg-field-item input:focus{
			outline:none;
			background-color:transparent;
		}
		
		 .reg-field-item:nth-child(1) .key{
            background-image: url(${basePath}images/reservation/icon_quhao_hospital.png);
        }

        .reg-field-item:nth-child(2) .key{
            background-image: url(${basePath}images/reservation/icon_quhao_name.png);
        }

        .reg-field-item:nth-child(3) .key{
            background-image: url(${basePath}images/reservation/icon_quhao_sfz.png);
        }

        .reg-field-item:nth-child(4) .key{
            background-image: url(${basePath}images/reservation/icon_quhao_phone.png);
        }
		
		.tips{
			margin: 0 3%;
			font-size: 13px;
			text-indent: 20px;
			color: #F68332;
			background-image: url(${basePath}images/reservation/icon_quhao_tips.png);
			background-position: left center; 
			background-repeat: no-repeat;
			background-size: 16px;
		}
		
		.reg-btns-box{
			width: 94%;
			margin: 0 auto;
			line-height: 48px;
		}
		
		.reg-btns-box button{
			width: 100%;
			height: 48px;
			margin: 40px 0;
			color: #fff;
			background-color: #2297F7;
			border-radius: 3px;
			border: 0;
		}
		
		footer{
			margin-top: 50px;
			text-align: center;
		}
		footer a{
			color: #427EAF;
			text-decoration: none;
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
    <img src="${basePath}mobileApp/reservation/img/quhao_chatu@3x.png">
</header>
<p class="tip-warn">温馨提示: 请就诊当天提前半小时取号</p>
<section class="reg-box">
    <form method="post" action="${basePath}mobileApp/reservation/takeno" onsubmit="javascript: takeno(this);return false;">
        <ul class="reg-cont">
        <!--
                <li class="reg-field-item">
                    <label>
                        <span class="key">${user.encryptedName}</span>
                        <span class="value">${user.encryptedCardNo}</span>
                    </label>
                </li>-->

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
                        <!-- temp code (start) &ndash;&gt;-->
            <li class="reg-field-item">
                <label>
                    <span class="key">姓名</span>
                            <span class="value">
                                <input type="text" id="patName" name="patName" value="${user.encryptedName}" placeholder="请输入姓名" maxlength="50">
                            </span>
                </label>
            </li>
            <li class="reg-field-item">
                <label>
                    <span class="key">证件号</span>
                            <span class="value">
                                <input type="text" id="idCardNo" name="idCardNo" value="${user.encryptedCardNo}" placeholder="请输入证件号" maxlength="50">
                            </span>
                </label>
            </li>
            <!-- temp code (end) &ndash;&gt;-->
            <li class="reg-field-item">
                <label>
                    <span class="key">预约号</span>
                        <span class="value">
                            <input type="text" id="orderNo" name="orderNo" placeholder="请输入预约号" maxlength="50">
                        </span>
                </label>
            </li>
        </ul>
        <p class="tips">为他人取号目前仅支持自费支付</p>
        <div class="reg-btns-box">
            <button type="submit" class="reg-btn-next">去取号</button>
        </div>
        <input type="hidden" name="appId" value="${serviceId}">
        <input type="hidden" name="appCode" value="${appCode}">
        <input type="hidden" name="hospitalId">
        <input type="hidden" name="branchCode">
    </form>
</section>
<footer>
    <div>
        <a href="http://apptest.yunyichina.cn/mobileApp/demo/appointment.html">什么是预约号？</a>
    </div>
</footer>
<script src="${basePath}mobileApp/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
    function takeno(form) {
        var hospitals = document.getElementById("hospitals");
        var selectedHospital = hospitals.options[hospitals.selectedIndex];
        if (hospitals && selectedHospital) {
            var hospitalId = selectedHospital.id;
            var hospitalCode = selectedHospital.value;
            var orderNo = document.getElementById("orderNo").value;
            var pName=document.getElementById("patName").value;
            var idCardNo=document.getElementById("idCardNo").value;

            if(pName.length==0||idCardNo.length==0){
                swal({
                    title: "请输入姓名或证件号",
                    timer: 1000,
                    showConfirmButton: false
                });
                return false;
            }

            if (orderNo && orderNo.trim()) {
                document.getElementsByName("hospitalId")[0].value = hospitalId;
                document.getElementsByName("branchCode")[0].value = hospitalCode;
                form.submit();
            } else {
                swal({
                    title: "请输入预约号",
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

    function takenotemp(form) {
        var hospitals = document.getElementById("hospitals");
        var selectedHospital = hospitals.options[hospitals.selectedIndex];
        if (hospitals && selectedHospital) {
            var hospitalId = selectedHospital.id;
            var hospitalCode = selectedHospital.value;
            var pName = document.getElementById("pName").value;
            var pCard = document.getElementById("pCard").value;
            var orderNo = document.getElementById("orderNo").value;
            if (pName && pName.trim()) {
                if (pCard && pCard.trim()) {
                    if (orderNo && orderNo.trim()) {
                        document.getElementsByName("hospitalId")[0].value = hospitalId;
                        document.getElementsByName("branchCode")[0].value = hospitalCode;
                        form.submit();
                    } else {
                        swal({
                            title: "请输入预约号",
                            timer: 1000,
                            showConfirmButton: false
                        });
                    }
                } else {
                    swal({
                        title: "请输入证件号",
                        timer: 1000,
                        showConfirmButton: false
                    });
                }
            } else {
                swal({
                    title: "请输入姓名",
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