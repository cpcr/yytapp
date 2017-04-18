<html>
<head>
    <#include "/easyhealth/common/common.ftl">
    <title>云医通</title>
</head>
<style type="text/css">
    html,body{
        height: 100%;
    }
</style>
<body>
	<div class="home">
        <div class="operMenu">
            <div class="desc" onclick="go('${basePath}easyhealth/listindex/registerIndex?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',1)">
                <i>&#xe68b;</i>
                <p>去挂号</p>
            </div>
        </div>
        <div class="operMenu menuColor" onclick="go('${basePath}easyhealth/clinic/payIndex?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',true);">
            <div class="desc">
                <i>&#xe68b;</i>
                <p>去缴费</p>
            </div>
        </div>
        <div class="operMenu menuColor" onclick="go('${basePath}easyhealth/queue/index?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',true);">
            <div class="desc">
                <i>&#xe68b;</i>
                <p>查排队</p>
            </div>
        </div>
        <div class="operMenu" onclick="go('${basePath}easyhealth/report/reportIndex?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',true);">
            <div class="desc">
                <i>&#xe68b;</i>
                <p>查报告</p>
            </div>
        </div>
        
        <div class="otherMenu">
            <div class="desc" onclick="go('${basePath}easyhealth/common/familyList',true);">
                <i class="i_greed newMsg">&#xe62e;</i>
                <p>扫码报到</p>
            </div>
        </div>
        <div class="otherMenu">
            <div class="desc" onclick="go('${basePath}statistics/static/buliding',true);">
                <i class="i_greed newMsg">&#xe62e;</i>
                <p>住院出院</p>
            </div>
        </div>
        <div class="otherMenu">
            <div class="desc" onclick="go('${basePath}statistics/static/moreService',true);">
                <i class="i_greed newMsg">&#xe62e;</i>
                <p>更多服务</p>
            </div>
        </div>
    </div>
</body>
<script>
		function goDidipasnger(){
			if(IS.isMacOS){ 
				appCallOtherApp("didipasnger");
			}else if(IS.isAndroid){
				window.yx129.appCallOtherApp("com.sdu.didi.psnger");
			}
		}
		
    $(function(){
        $(document).on('touchmove',function(e){
            e.preventDefault();
        })
        var swipeNav = $('.swipe-nav').find('span');
        var selected = swipeNav.eq(0);
        selected.addClass('selected');
        var elem = document.getElementById('mySwipe');
        window.mySwipe = Swipe(elem, {
            continuous: false,
            stopPropagation: true,
            transitionEnd: function(index, element) {
                if(selected != swipeNav.eq(index)){
                    selected.removeClass('selected');
                    selected = swipeNav.eq(index);
                    selected.addClass('selected');
                }  
            }
        });
        $('.index2-navList-item')
        .on('touchstart',function(e){
            // e.preventDefault();
            $(this).addClass('touchHover')
        })
        .on('touchend',function(){
            $(this).removeClass('touchHover')
        })
        
        var hasMessage = '${(msgCount?exists) && (msgCount > 0)}';
		setTimeout(function(){initEasyHealthMsg();},1000);
    })
    
	initEasyHealthMsg = function() {
		var hasMessage = '${(msgCount?exists) && (msgCount > 0)}';
		if (IS.isMacOS) {
			try {
				appSetTabPoint(1, 0);
				if (hasMessage == 'true') {
					appSetTabPoint(1, 1);
				} else {
					appSetTabPoint(1, 0);
				}
			} catch (e) {
				//alert('关闭页面失败');
			}
		} else if (IS.isAndroid) {
			try {
				window.yx129.appSetTabPoint(1, 0);
				if (hasMessage == 'true') {
					window.yx129.appSetTabPoint(1, 1);
				} else {
					window.yx129.appSetTabPoint(1, 0);
				}
			} catch (e) {
				//alert('关闭页面失败');
			}
	
		} else {
			//go(appPath + '/easyhealth/user/toLogin');
		}
	}
</script>
<script src="${basePath}easyhealth/js/biz/index/eh.index.js" type="text/javascript"></script>
<script src="${basePath}easyhealth/js/biz/tophp.common.js" type="text/javascript"></script>
<script src="${basePath}easyhealth/js/common/swipe.js" type="text/javascript"></script>
</html>