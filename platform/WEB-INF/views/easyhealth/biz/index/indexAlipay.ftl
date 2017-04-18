<html>
<head>
    <#include "/easyhealth/common/common.ftl">
    <title>健康易</title>
</head>
<style type="text/css">
    html,body{ height: 100%;}
    .iconfont.i_fontMed{ font-size: 60px;}
</style>
<body  style="background-color: #fff;">
	<div id="search-wrap">
	  <div id="index_main">
	    <div class="grid_w">
	        <div class="grid" onclick="go('${basePath}easyhealth/listindex/registerIndex?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',1)">
	            <div class="box">
	                <i class="iconfont i_fontMed i_greed">&#xe62c;</i> <br/>
	                <span class="label">挂号</span>
	            </div>
	        </div>
	        <div class="grid" onclick="go('${basePath}easyhealth/queue/index?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',true);">
	            <div class="box">
	                <i class="iconfont i_fontMed i_blue">&#xe628;</i> <br/>
	                <span class="label">候诊</span>
	            </div>
	        </div>
	        <div class="grid" onclick="go('${basePath}easyhealth/clinic/payIndex?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',true);">
	            <div class="box">
	                <i class="iconfont i_fontMed i_orange">&#xe624;</i> <br/>
	                <span class="label">缴费</span>
	            </div>
	        </div>
	        <div class="grid" onclick="go('${basePath}easyhealth/report/reportIndex?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',true);">
	            <div class="box">
	                <i class="iconfont i_fontMed i_greed">&#xe626;</i> <br/>
	                <span class="label">查报告</span>
	            </div>
	        </div>
	
	        <div class="grid"  onclick="go('${basePath}easyhealth/msgcenter/msgCenterListView?userId=${sessionUser.id}', true)">
	            <div class="box">
	                <i class="iconfont i_fontMed i_yellow">&#xe62e;</i> <br/>
	                <span class="label">看消息</span>
	            </div>
	        </div>
	
	        <div class="grid">
	            <div class="box">
	                <img class="picThumb des" src="${basePath}easyhealth/images/icon9.png" width="50" height="50"/><br/>
	            </div>
	        </div>
	    </div>
	
		</div>
	</div>
</body>
<script>
		
</script>
<script src="${basePath}easyhealth/js/biz/index/eh.index.js" type="text/javascript"></script>
<script src="${basePath}easyhealth/js/biz/tophp.common.js" type="text/javascript"></script>
<script src="${basePath}easyhealth/js/common/swipe.js" type="text/javascript"></script>
</html>