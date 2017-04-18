<html>
<head>
    <#include "/easyhealth/common/common.ftl">
    <title>更多服务</title>
</head>
<body>
<div id="body">
    <div id="myCenter">
        <div class="space15"></div>
        <span style="margin-left: 18px;">妇幼中心</span>
        <ul class="yx-list listRow">
            <li class="arrow" onclick="go('${basePath}statistics/static/buliding',true);"><div class="u-img"><i class="iconfont i-green">&#xe648;</i></div>产科床位</li>
            <li class="arrow"  onclick="go('${basePath}statistics/static/buliding',true);"><div class="u-img"><i class="iconfont i-blue">&#xe647;</i></div>儿童疫苗</li>
        </ul>
				<!--<div class="space15"></div>-->
        <span style="margin-left: 18px;">分级诊疗</span>
        <ul class="yx-list listRow">
            <li class="arrow"  onclick="go('${basePath}easyhealth/communitycenter/communityHealth/getAdministrativeRegion?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng',1);"><div class="u-img"><i class="iconfont i-orange">&#xe654;</i></div>社康中心</li>
            <li class="arrow" onclick="go('${basePath}statistics/static/buliding',true);"><div class="u-img"><i class="iconfont i-green">&#xe648;</i></div>巡诊专家</li>
        </ul>
        <!--<div class="space15"></div>-->
        <span style="margin-left: 18px;">便民服务</span>
        <ul class="yx-list listRow">
            <li class="arrow"  onclick="go('${basePath}easyhealth/life/index',true);"><div class="u-img"><i class="iconfont i-orange">&#xe654;</i></div>周边生活圈</li>
        </ul>
    </div>
</div>
<#include "/easyhealth/common/footer.ftl">
</body>
</html>