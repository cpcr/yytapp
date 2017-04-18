<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<link rel="stylesheet" href="${basePath}family/css/index.css"/>
<link rel="stylesheet" href="${basePath}family/css/date.css"/>

<style>
body{-webkit-overflow-scrolling:auto}
.tips_content_txt,#am-loading_txt{font-size:.525rem!important}
</style>
<script src="${basePath}family/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="${basePath}family/js/date.js" type="text/javascript" charset="utf-8"></script>
<script src="${basePath}family/js/iscroll.js" type="text/javascript" charset="utf-8"></script>
<script src="${basePath}family/js/addMyFamily.js?v=1.0.1" type="text/javascript" charset="utf-8"></script>
<script>"use strict";!function(e,t){function i(){var t=n.getBoundingClientRect().width;t/m>540&&(t=540*m);var i=t/10;n.style.fontSize=i+"px",d.rem=e.rem=i}var a,r=e.document,n=r.documentElement,o=r.querySelector('meta[name="viewport"]'),l=r.querySelector('meta[name="flexible"]'),m=0,s=0,d=t.flexible||(t.flexible={});if(o){console.warn("将根据已有的meta标签来设置缩放比例");var p=o.getAttribute("content").match(/initial\-scale=([\d\.]+)/);p&&(s=parseFloat(p[1]),m=parseInt(1/s))}else if(l){var c=l.getAttribute("content");if(c){var u=c.match(/initial\-dpr=([\d\.]+)/),f=c.match(/maximum\-dpr=([\d\.]+)/);u&&(m=parseFloat(u[1]),s=parseFloat((1/m).toFixed(2))),f&&(m=parseFloat(f[1]),s=parseFloat((1/m).toFixed(2)))}}if(!m&&!s){var v=(e.navigator.appVersion.match(/android/gi),e.navigator.appVersion.match(/iphone/gi)),h=e.devicePixelRatio;m=v?h>=3&&(!m||m>=3)?3:h>=2&&(!m||m>=2)?2:1:1,s=1/m}if(n.setAttribute("data-dpr",m),!o)if(o=r.createElement("meta"),o.setAttribute("name","viewport"),o.setAttribute("content","initial-scale="+s+", maximum-scale="+s+", minimum-scale="+s+", user-scalable=no"),n.firstElementChild)n.firstElementChild.appendChild(o);else{var x=r.createElement("div");x.appendChild(o),r.write(x.innerHTML)}e.addEventListener("resize",function(){clearTimeout(a),a=setTimeout(i,300)},!1),e.addEventListener("pageshow",function(e){e.persisted&&(clearTimeout(a),a=setTimeout(i,300))},!1),"complete"===r.readyState?r.body.style.fontSize=12*m+"px":r.addEventListener("DOMContentLoaded",function(){r.body.style.fontSize=12*m+"px"},!1),i(),d.dpr=e.dpr=m,d.refreshRem=i,d.rem2px=function(e){var t=parseFloat(e)*this.rem;return"string"==typeof e&&e.match(/rem$/)&&(t+="px"),t},d.px2rem=function(e){var t=parseFloat(e)/this.rem;return"string"==typeof e&&e.match(/px$/)&&(t+="rem"),t}}(window,window.lib||(window.lib={}));</script>
<script type="text/javascript">
			$(function() {
				//时间选择触发
				$('#nav3Bir').date();
				
				var nowSelect,
					$addCard = $('.addCard'),
					$blackWrapper = $('.blackWrapper');
				//选项卡切换
				$('.navList li').click(function() {
					if(!$(this).hasClass('isWKT')){
						var index = $(this).index();
						if (!$(this).hasClass('active')) $(this).addClass('active').siblings().removeClass('active');
						$('.nav' + (index + 1)).removeClass('none').siblings('.navPage').addClass('none');
					}
				})
				//添加就诊卡
				/*
				$('.listTitle').on('click', '.add', function() {
					$addCard.removeClass('none');
				})
				*/
				/*就诊卡按键
				$addCard.on('click', '.addCardBtn', function(e) {
					$addCard.addClass('none');
					//ajax
					var hs = $addCard.find('.newhs').val(),
						card = $addCard.find('.newcard').val(),
						newId = $addCard.find('.newId').val(),
						newList = '';
					newList = '<li><p>' + newId + '</p><p>' + hs + '</p></li>';
					if (hs && card && newId) {
						$('.navPage:visible').find('.cardList').append(newList).end().find('.nothing').remove();
					} else {
						alert('请填写完整资料才能提交!');
					}
				})
				*/
				//下拉框触发
				$('.contanier').on('click', '.isSelect', function() {
					if(!$(this).hasClass("myDisabled")){
						var list = $(this).data('list').split('|'),
						_html = '';
						list.forEach(function(item) {
							ary = item.split(':'),
							_html += '<li key="' + ary[0] + '">' + ary[1] + '</li>';
						});
						$blackWrapper.removeClass('none').find('.selectList').html(_html);
						$.isAJAX = $(this).hasClass('newhs');
						nowSelect = $(this);
					}
				})
				//下拉框弹出
				$blackWrapper.on('click', '.selectCancle', function() {
					$blackWrapper.addClass('none');
				}).on('click', 'li', function() {
					nowSelect[nowSelect.is('input') ? 'val' : 'text']($(this).text());
					nowSelect.attr('key',$(this).attr('key'));
					($('#isCard').val() == '有' ? $('#idNum') : $('#city')).parents('li').removeClass('none')[$('#isCard').val() == '有' ? 'next' : 'prev']().addClass('none');
					$blackWrapper.addClass('none');
					$.isAJAX && changeCardNoBySelectH($(this).attr('key'));

					if($(this).text() == '二代身份证') {
						$('.c-info').hide();
					} else if($(this).text() == '港澳居民身份证') {
                        $('.c-info').show();
					}
				})
				
				//提交数据
				$('.btnSubmit').click(function(){
					if($('.btnSubmit').hasClass('none')) return false;
					$('.navPage:visible').find('input').each(function(i,e){
						console.log($(this).val())
					})
				})
			});
</script>
	
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/idCardUtils.js"></script>
<title>添加就诊人</title>
</head>

	<body style="background: #f5f5f5;" id="body">
		<div id="datePlugin"></div>
		<div class="blackWrapper none">
			<ul class="selectList"></ul>
			<button class="selectCancle">取消</button>
		</div>

		<div class="contanier">
			<ul class="navList">
				<li class="active">本人</li>
				<li>他人</li>
				<li class="isWKT">儿童</li>
			</ul>

			<div class='navListH'></div>

			<div class="nav1 navPage">
				<ul class="inputList">
					<li><label for="nav1Name">姓名</label><span><input value="${family.encryptedName}" type="text" placeholder="请输入" id='nav1Name' required readonly style="background: #fff; color: #ccc;"/></span></li>
					<li><label for="nav1Id">${family.idTypeLabel}</label><span><input value="${family.encryptedIdNo}" type="text" id="nav1Id" placeholder="请输入" required readonly style="background: #fff; color: #ccc;"/></span></li>
					<li><label for="nav1Phone">手机</label><span><input type="text" placeholder="请输入" id="nav1Phone" required value="${family.encryptedMobile}" readonly style="background: #fff; color: #ccc;"/></span></li>
				</ul>

				<div class="listTitle">
					<span>就诊卡管理</span>
					<span class="add" onclick="addBRCard(this)">添加</span>
				</div>

				<ul class="cardList" id="cardList1">
					
				</ul>
			</div>

			<div class="nav2 navPage none">
				<ul class="inputList">
					<li><label for="nav2rela">关系</label><span><input type="text" class="isSelect" placeholder="请选择" readonly data-list="4:父母|6:伴侣|5:兄弟姐妹|2:其他" id="nav2rela"  required /></span></li>
					<li><label for="nav2Name">姓名</label><span><input type="text" placeholder="请输入" id="nav2Name" required /></span></li>
					<li><label id="idType2" class="isSelect" data-list="1:二代身份证|2:港澳居民身份证" key="1">二代身份证</label><span><input type="text" placeholder="请输入" id="nav2Id" required/></span></li>
					<li><label for="nav2Phone">手机</label><span><input type="text" placeholder="请输入" id="nav2Phone" required /></span></li>

                    <li class="c-info" style="display: none"><label for="nav2Sex">性别</label><span><input type="text" class="isSelect" placeholder="请选择" id="nav2Sex" readonly data-list="1:男|2:女" required /></span></li>
                    <#--<li><label for="nav2Age">年龄</label><span><input type="text" placeholder="二代身份证可不填" id="nav2Age" required /></span></li>-->
                    <li class="c-info" style="display: none"><label for="nav2Bir">出生日期</label><span><input type="text" placeholder="如:19981012" id="nav2Bir" required /></span></li>

				</ul>

				<div class="listTitle">
					<span>就诊卡管理</span>
					<span class="add" onclick="addTRCard(this)">添加</span>
				</div>

				<ul class="cardList"  id="cardListTR">
					<li class="nothing">请添加就诊卡</li>
				</ul>

				<button class="btnSubmit" onclick="bindOther(this)">保存</button>
			</div>

			<div class="nav3 navPage none">
				<ul class="inputList">
					<li><label for="nav3Name">姓名</label><span><input type="text" placeholder="请输入" id="nav3Name" required /></span></li>
					<li><label for="nav3Sex">性别</label><span><input type="text" class="isSelect" placeholder="请选择" readonly id="nav3Sex" data-list="1:男|2:女" required /></span></li>
					<li><label for="nav3Bir">出生日期</label><span><input type="text" placeholder="请输入" id="nav3Bir" required /></span></li>
				</ul>

				<ul class="inputList">
					<li><label for="nav3PName">监护人姓名</label><span><input type="text" placeholder="请输入" id="nav3PName" required /></span></li>
					<li><label for="idType3">证件类型</label><span><input type="text" class="isSelect" placeholder="请选择" readonly data-list="1:二代身份证|2:港澳通行证" id="idType3" required value="二代身份证" key="1"/></span></li>
					<li><label for="nav3PId">监护人证件号</label><span><input type="text" placeholder="请输入" id="nav3PId" required /></span></li>
					<li><label for="nav3PPhone">监护人手机</label><span><input type="text" placeholder="请输入" id="nav3PPhone" required /></span></li>
				</ul>

				<div class="listTitle">
					<span>就诊卡管理</span>
					<span class="add" onclick="addETCard(this)">添加</span>
				</div>

				<ul class="cardList"  id="cardList3">
					<li class="nothing">请添加就诊卡</li>
				</ul>

				<button class="btnSubmit" onclick="bindChild(this)">保存</button>
			</div>

			<div class="addCard none">
				<ul class="inputList" style="margin: 0;">
					<li><label for="hospitalLists">医院 </label><span><input type="text" class="isSelect newhs" placeholder="请选择" id="hospitalLists" readonly data-list="${hospitalLists}" required /></span></li>
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
			<input type="hidden" id="syncType" name="syncType" value="1">
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