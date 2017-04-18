<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width ,maximum-scale=1">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="format-detection" content="telephone=no">
		<meta http-equiv="x-rim-auto-match" content="none">
		<title>深圳智慧医院</title>
		<#include "/easyhealth/common/common.ftl">
	    <link rel="stylesheet" href="${basePath}citysvc/css/style.css?v=0"/>
	    <link rel="stylesheet" type="text/css" href="${basePath}citysvc/css/index.css"/>
	</head>
	<body>
		<div class="contanier">
			<div class="index-top">
				<div class="index-topImg"></div>
				<p class="index-topName">${sessionUser.name}</p>
				<p class="index-topNum">${sessionUser.encryptedMobile}</p>
				<a class="index-topTips" href="javascript:void(0)" onclick="go('${basePath}easyhealth/usercenter/familyInfo/index?openId=${sessionUser.id}&appCode=alipay&areaCode=ShenZheng')"></a>
			</div>
			<div class="index-wrapper">
				<div class="index-wrapperTitle">就医服务</div>
				<ul class="index-wrapperList2">
					<li onclick="go('${basePath}mobileApp/register/hospitalList?appId=${APP_ID}&openId=${sessionUser.id}&regType=2&appCode=alipay&areaCode=ShenZheng')">
						<div class="index-wrapperList2-tap yibao"></div>
						<i class="iconfont i-blue">&#xe600;</i>
						<strong>当天挂号</strong>
					</li>
					<li onclick="go('${basePath}easyhealth/alipay/scan/list?appCode=alipay&appId=${APP_ID}&areaCode=ShenZheng')">
						<div></div>
						<i class="iconfont i-green">&#xe601;</i>
						<strong>扫码报到</strong>
					</li>
					<li onclick="go('${basePath}easyhealth/clinic/payIndex?appId=${APP_ID}&openId=${sessionUser.id}&appCode=alipay&areaCode=ShenZheng')">
						<div class="index-wrapperList2-tap yibao"></div>
						<i class="iconfont i-green">&#xe606;</i>
						<strong>门诊缴费</strong>
					</li>
					<li onclick="go('${basePath}easyhealth/usercenter/myFamily/index?userId=${sessionUser.id}&appCode=alipay&areaCode=ShenZheng')">
						<i class="iconfont i-green">&#xe605;</i>
						<strong>就诊人管理</strong>
					</li>
					<li onclick="go('${basePath}easyhealth/usercenter/toRegRecordList?appId=${APP_ID}&openId=${sessionUser.id}&appCode=alipay&areaCode=ShenZheng')">
						<div></div>
						<i class="iconfont i-green">&#xe603;</i>
						<strong>挂号记录</strong>
					</li>
					<li onclick="go('${basePath}mobileApp/clinic/paidIndex?appId=${APP_ID}&openId=${sessionUser.id}&appCode=alipay&areaCode=ShenZheng')">
						<div></div>
						<i class="iconfont i-green">&#xe604;</i>
						<strong>缴费记录</strong>
					</li>
					<li onclick="alert('功能建设中...')">
						<i class="iconfont i-green">&#xe602;</i>
						<strong>常见问题</strong>
					</li>
				</ul>
			</div>
			
			<div class="index-footer" onclick="go('${basePath}mobileApp/customService/toFeedback?type=1&openId=${sessionUser.id}&appCode=alipay&areaCode=ShenZheng')">
				<i class="iconfont i-green">&#xe608;</i>意见反馈
			</div>
			
		</div>
	</body>
</html>