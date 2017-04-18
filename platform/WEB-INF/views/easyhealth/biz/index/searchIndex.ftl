<html>
<head>
    <#include "/easyhealth/common/common.ftl">
    <title>智能搜索</title>
</head>
<style type="text/css">
    html,body{ height: 100%;}
</style>
<body id="body">
<div id="search-wrap">
    <div id="myCenter">
        <div class="space15"></div>
        <ul class="yx-list listRow">
            <li class="arrow" onclick="go('${basePath}easyhealth/search/index?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&searchType=hospital',1);"><div class="u-img"><i class="iconfont i-orange">&#xe63e;</i></div>搜医院</li>
            <li class="arrow" onclick="go('${basePath}easyhealth/search/index?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&searchType=dept',true);"><div class="u-img"><i class="iconfont i-blue">&#xe63d;</i></div>搜科室</li>
            <li class="arrow" onclick="go('${basePath}easyhealth/search/index?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&searchType=doctor',true);"><div class="u-img"><i class="iconfont i-yellow">&#xe65c;</i></div>搜医生</li>
            <!-- <li class="arrow" onclick="go('${basePath}easyhealth/building',true);"><div class="u-img"><i class="iconfont i-green">&#xe63c;</i></div>搜症状</li> -->
        </ul>

    </div>
</div>
<#--
<div id="search-wrap">
    <div id="index_main">
    <div class="grid_w">
        <div class="grid" onclick="go('${basePath}easyhealth/search/index?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&searchType=hospital',1);">
            <div class="box">
                <img class="picThumb" src="${basePath}easyhealth/images/greenSkin/search/icon/icon_s2.png" width=" 70" height=" 70"/><br/>
                <span class="label">搜医院</span>
            </div>
        </div>
        <div class="grid" onclick="go('${basePath}easyhealth/search/index?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&searchType=dept',true);">
            <div class="box">
                <img class="picThumb" src="${basePath}easyhealth/images/greenSkin/search/icon/icon_s5.png" width=" 70" height=" 70"/><br/>
                <span class="label">搜科室</span>
            </div>
        </div>
        <div class="grid" onclick="go('${basePath}easyhealth/search/index?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&searchType=doctor',true);">
            <div class="box">
                <img class="picThumb" src="${basePath}easyhealth/images/greenSkin/search/icon/icon_s1.png" width="70" height="70"/><br/>
                <span class="label">搜医生</span>
            </div>
        </div>
        <div class="grid" onclick="go('${basePath}easyhealth/building',true);">
            <div class="box">
                <img class="picThumb" src="${basePath}easyhealth/images/greenSkin/search/icon/icon_s3.png" width="70" height="70"/><br/>
                <span class="label">搜症状</span>
            </div>
        </div>

        <div class="grid"  onclick="go('${basePath}easyhealth/building',true);">
            <div class="box">
                <img class="picThumb" src="${basePath}easyhealth/images/greenSkin/search/icon/icon_s4.png" width="70" height="70"/><br/>
                <span class="label">搜药品</span>
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
-->
</body>
</html>
<script src="${basePath}easyhealth/js/biz/index/eh.index.js" type="text/javascript"></script>
