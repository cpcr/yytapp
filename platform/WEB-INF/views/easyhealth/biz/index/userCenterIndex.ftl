<html>
<head>
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
	<meta HTTP-EQUIV="expires" CONTENT="0">
	<#include "/easyhealth/common/common.ftl">
		<title>个人中心</title>
</head>
<body>
<div id="body">
	<div id="myCenter">
		<div class="space15"></div>
		<#if sessionUser.cardNo>
			<ul class="yx-list userList">
				<li class="pic arrow" onclick="go('${basePath}easyhealth/usercenter/familyInfo/index?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&syncType=1&forward=userCenterIndex&appId=${commonParams.appId}', true)">
					<#if sessionUser.sex == 1>
						<img src="${basePath}easyhealth/images/man-def.png" width="60" height="60"/>
					</#if>
					<#if sessionUser.sex == 2>
            			<img src="${basePath}easyhealth/images/girl-def.png" width="60" height="60"/>
					</#if>
					<div class="info">
						<div class="title">${sessionUser.encryptedName}
							<#if sessionUser.sex == 1>
								<i class="iconfont icon-man">&#xe63a;</i>
							</#if>
							<#if sessionUser.sex == 2>
                                <i class="iconfont icon-girl">&#xe639;</i>
							</#if>
						</div>
						<!-- <div class="name color999">${sessionUser.encryptedCardNo}</div> -->
						<div class="name color999">${sessionUser.encryptedAccount}</div>
					</div>
				</li>
			</ul>
			<#else>
				<ul class="yx-list userList">
					<li class="pic arrow" onclick="go('${basePath}easyhealth/user/toPerfectUserInfo', true)">
						<#if sessionUser.sex == 2>
							<img src="${basePath}easyhealth/images/girl-def.png" width="60" height="60"/>
							<#else>
								<img src="${basePath}easyhealth/images/man-def.png" width="60" height="60"/>
						</#if>
						<div class="info">请先完善资料</div>
					</li>
				</ul>
		</#if>
		<div class="space15"></div>
		<ul class="yx-list listRow" >
			<li class="arrow" onclick="go('${basePath}easyhealth/usercenter/syncCard/index?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng', true);"><div class="u-img"><i class="iconfont i-orange">&#xe684;</i></div>同步本人医院信息</li>
			<li class="arrow" onclick="go('${basePath}easyhealth/usercenter/myFamily/index?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng', true);"><div class="u-img"><i class="iconfont i-orange">&#xe632;</i></div>我的就诊人</li>
			<#--
			<li class="arrow" onclick="go('${basePath}mobileApp/medicalcard/family/hospitalList?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng', true);"><div class="u-img"><i class="iconfont i-orange">&#xe632;</i></div>我的就诊人</li>
			-->
			<li class="arrow" onclick="go('${basePath}easyhealth/usercenter/historyRegDoctorIndex?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng', true)"><div class="u-img"><i class="iconfont i-blue">&#xe630;</i></div>我的医生</li>
            <li class="arrow" onclick="go('${basePath}easyhealth/usercenter/toRegRecordList?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&appId=${commonParams.appId}', true)"><div class="u-img"><i class="iconfont i-yellow">&#xe637;</i></div>挂号记录</li>
			<li class="arrow" onclick="go('${basePath}mobileApp/clinic/paidIndex?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&appId=${commonParams.appId}', true)"><div class="u-img"><i class="iconfont i-green">&#xe636;</i></div>缴费记录</li>
			<li class="arrow" onclick="go('${basePath}easyhealth/fukangbao?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',true);"><div class="u-img"><i class="iconfont i-yellow">&#xe653;</i></div>福康宝</li>
			<li class="arrow" onclick="go('${basePath}mobileApp/vote/listByuserId?userId=${sessionUser.id}&appCode=easyHealth&bizCode=2&viewType=allVote', true)"><div class="u-img"><i class="iconfont i-blue">&#xe640;</i></div>就诊评价</li>
			<li class="arrow" class="serverGif" onclick="go('${basePath}mobileApp/customService/toFeedback?userId=${sessionUser.id}&type=1',true)"><div class="u-img"><i class="iconfont i-green">&#xe63f;</i></div>客服中心</li>

			<#--
			<li class="arrow" class="serverGif" onclick="go('${basePath}easyhealth/common/familyList',true)"><div class="u-img"><i class="iconfont i-green">&#xe63f;</i></div>临时测试</li>
			-->
		</ul>
		<div class="space15" id="my_last_li"></div>
		<ul class="yx-list listRow">
			<li class="arrow" onclick="go('http://www.yunyichina.cn/show.php?pid=747',true);"><div class="u-img"><i class="iconfont i-blue">&#xe682;</i></div>帮助中心</li>
			<!-- <li class="flex">
                  <div class="flexItem"><div class="u-img"><i class="iconfont i-orange">&#xe667;</i></div>当前版本</div>
                <div class="flexItem color999 w120 textRight" id="nowAppVersion"></div>
              </li>
              <li class="arrow" onclick="go('${basePath}easyhealth/usercenter/aboutUs',true);"><div class="u-img"><i class="iconfont i-green">&#xe681;</i></div>关于我们</li> -->
			<li class="flex arrow" onclick="go('${basePath}easyhealth/usercenter/aboutUs',true);">
				<div class="flexItem"><div class="u-img"><i class="iconfont i-orange">&#xe681;</i></div>关于云医通</div>
				<div class="flexItem color999 w120 textRight" id="nowAppVersion" style="margin-right:10px;"></div>
			</li>
			<li class="arrow" onclick="go('${basePath}easyhealth/usercenter/settings?userId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',true);"><div class="u-img"><i class="iconfont i-green">&#xe66a;</i></div>设置</li>
		</ul>
		<div class="space15"></div>
	</div>
</div>
<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script src="${basePath}easyhealth/js/biz/index/eh.index.js" type="text/javascript"></script>
<script type="text/javascript">
	function getVersion() {
		//android函数原型	window.yx129.appGetVersion();
		//ios 函数原型	appGetVersion();

		var appVersion = "未知";
		if(IS.isMacOS) {
			appVersion = appGetVersion();
		} else if(IS.isAndroid) {
			appVersion = window.yx129.appGetVersion();
		}
		return appVersion;
	}

	$(function(){
		setTimeout(function(){
			$("#nowAppVersion").text(getVersion());
		}, 500);
	});
</script>