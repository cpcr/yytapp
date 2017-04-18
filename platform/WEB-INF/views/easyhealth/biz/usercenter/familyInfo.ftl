<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<link rel="stylesheet" href="${basePath}family/css/index.css"/>
<style>
.tips_content_txt,#am-loading_txt{font-size:.425rem!important}
</style>
<script>"use strict";!function(e,t){function i(){var t=n.getBoundingClientRect().width;t/m>540&&(t=540*m);var i=t/10;n.style.fontSize=i+"px",d.rem=e.rem=i}var a,r=e.document,n=r.documentElement,o=r.querySelector('meta[name="viewport"]'),l=r.querySelector('meta[name="flexible"]'),m=0,s=0,d=t.flexible||(t.flexible={});if(o){console.warn("将根据已有的meta标签来设置缩放比例");var p=o.getAttribute("content").match(/initial\-scale=([\d\.]+)/);p&&(s=parseFloat(p[1]),m=parseInt(1/s))}else if(l){var c=l.getAttribute("content");if(c){var u=c.match(/initial\-dpr=([\d\.]+)/),f=c.match(/maximum\-dpr=([\d\.]+)/);u&&(m=parseFloat(u[1]),s=parseFloat((1/m).toFixed(2))),f&&(m=parseFloat(f[1]),s=parseFloat((1/m).toFixed(2)))}}if(!m&&!s){var v=(e.navigator.appVersion.match(/android/gi),e.navigator.appVersion.match(/iphone/gi)),h=e.devicePixelRatio;m=v?h>=3&&(!m||m>=3)?3:h>=2&&(!m||m>=2)?2:1:1,s=1/m}if(n.setAttribute("data-dpr",m),!o)if(o=r.createElement("meta"),o.setAttribute("name","viewport"),o.setAttribute("content","initial-scale="+s+", maximum-scale="+s+", minimum-scale="+s+", user-scalable=no"),n.firstElementChild)n.firstElementChild.appendChild(o);else{var x=r.createElement("div");x.appendChild(o),r.write(x.innerHTML)}e.addEventListener("resize",function(){clearTimeout(a),a=setTimeout(i,300)},!1),e.addEventListener("pageshow",function(e){e.persisted&&(clearTimeout(a),a=setTimeout(i,300))},!1),"complete"===r.readyState?r.body.style.fontSize=12*m+"px":r.addEventListener("DOMContentLoaded",function(){r.body.style.fontSize=12*m+"px"},!1),i(),d.dpr=e.dpr=m,d.refreshRem=i,d.rem2px=function(e){var t=parseFloat(e)*this.rem;return"string"==typeof e&&e.match(/rem$/)&&(t+="px"),t},d.px2rem=function(e){var t=parseFloat(e)/this.rem;return"string"==typeof e&&e.match(/px$/)&&(t+="rem"),t}}(window,window.lib||(window.lib={}));</script>
<script src="${basePath}family/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="${basePath}family/js/familyInfo.js?v=1.0.1" type="text/javascript" charset="utf-8"></script>

<title><#if family.ownership==1>本人信息<#elseif family.ownership==3>儿童信息<#else>他人信息</#if></title>
</head>
<body style="background: #f5f5f5;">
		<div class="blackWrapper none">
			<ul class="selectList"></ul>
			<button class="selectCancle">取消</button>
		</div>
		
		<div class="contanier">
			<div class="nav1 navPage">
				    <#if family.ownership==1>
					    <ul class="inputList">
						    <li><label for="nav1Name">姓名</label><span><input type="text" id='nav1Name' readonly style="background: #fff; color: #ccc;" value="${family.encryptedName}"/></span></li>
							<li><label for="nav1Id">${family.idTypeLabel}</label><span><input type="text" id="nav1Id" readonly style="background: #fff; color: #ccc;" value="${family.encryptedIdNo}"/></span></li>
							<li><label for="nav1Phone">手机号码</label><span><input type="text" id="nav1Phone"  readonly style="background: #fff; color: #ccc;" value="${family.encryptedMobile}"/></span></li>
						</ul>
					<#elseif family.ownership==3>
						<ul class="inputList">
							<li><label for="nav3Name">姓名</label><span><input type="text" id="nav3Name" readonly style="background: #fff; color: #ccc;" value="${family.encryptedName}"/></span></li>
							<li><label for="nav3Sex">性别</label><span><input type="text" id="nav3Sex" readonly style="background: #fff; color: #ccc;" value="${family.sexLabel}"/></span></li>
							<li><label for="nav3Bir">出生日期</label><span><input type="text" id="nav3Bir" readonly style="background: #fff; color: #ccc;" value="${family.birth}"/></span></li>
						</ul>
						<ul class="inputList">
							<li><label for="nav3PName">监护人姓名</label><span><input type="text" id="nav3PName" readonly style="background: #fff; color: #ccc;" value="${family.encryptedGuardName}"/></span></li>
							<li><label for="nav3PId">${family.guardIdTypeLabel}</label><span><input type="text" id="nav3PId" readonly style="background: #fff; color: #ccc;" value="${family.encryptedGuardIdNo}"/></span></li>
							<li><label for="nav3PPhone">监护人手机</label><span><input type="text" id="nav3PPhone" readonly style="background: #fff; color: #ccc;" value="${family.encryptedGuardMobile}"/></span></li>
						</ul>
					<#else>
					    <ul class="inputList">
							<li><label for="nav2rela">关系</label><span><input type="text" id="nav2rela" readonly style="background: #fff; color: #ccc;" value="${family.ownershipLabel}"/></span></li>
							<li><label for="nav2Name">姓名</label><span><input type="text" id="nav2Name" readonly style="background: #fff; color: #ccc;" value="${family.encryptedName}"/></span></li>
							<li><label for="nav2Id">${family.idTypeLabel}</label><span><input type="text" id="nav2Id" readonly style="background: #fff; color: #ccc;" value="${family.encryptedIdNo}"/></span></li>
							<li><label for="nav2Phone">手机号码</label><span><input type="text" id="nav2Phone" readonly style="background: #fff; color: #ccc;" value="${family.encryptedMobile}"/></span></li>
						</ul>
					</#if>
				<div class="listTitle">
					<span>就诊卡管理</span>
					<span class="add" onclick="addCard(this)">添加</span>
				</div>

				<ul class="cardList" id="cardList">
				</ul>
				<#if family.ownership!=1>
					<button class="btnSubmit" onclick="removeFamily();">删除</button>
				</#if>
			</div>

			<div class="addCard none">
				<ul class="inputList" style="margin: 0;">
					<li><label for="hospitalLists">医院</label><span><input type="text" class="isSelect newhs" placeholder="请选择" id="hospitalLists" readonly data-list="${hospitalLists}" required /></span></li>
					<li><label for="isCard">是否有就诊卡</label><span><input type="text" class="isSelect newcard" placeholder="请选择" id="isCard" readonly data-list="0:没|1:有" required value="有" key="1"/></span></li>
					<li><label for="idNum">卡号</label><span><input type="text" class="newId" placeholder="请输入" id="idNum" required /></span></li>
					<li class="none"><label for="city">城市</label><span><input type="text" class="newId" placeholder="请输入如(广东深圳)" id="city" required /></span></li>
				</ul>
				<button class="btnSubmit addCardBtn" onclick="addSyncCard()">添加</button>
			</div>

		</div>
<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}">
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
    <input type="hidden" id="forward" name="forward" value="${commonParams.forward}">
    <input type="hidden" id="syncType" name="syncType" value="${family.ownership}">
    <input type="hidden" id="familyId" name="familyId" value="${family.id}">
    <input type="hidden" id="hospitalId" name="hospitalId" value="">
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="">
    <input type="hidden" id="hospitalName" name="hospitalName" value="">
    <input type="hidden" id="hasCard" name="hasCard" value="">
    <input type="hidden" id="medicalcardId" name="medicalcardId" value="">
    <input type="hidden" id="address" name="address" value="">
</form>
</body>
</html>