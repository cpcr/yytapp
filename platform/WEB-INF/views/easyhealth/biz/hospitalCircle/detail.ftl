<html>
<head>
  	<#include "/easyhealth/common/common.ftl">
    <title>三公里就医圈</title>
</head>
<body>
<div id="body">
    <div class="space15"></div>
    <ul class="yx-list">
        <li class="flex-wrap row-flex">
            <div class="title">机构</div>
            <div class="flexWidth1 textRight color666">${hospName}</div>
        </li>
        <li class="flex-wrap row-flex">
            <div class="title">电话</div>
            <div class="flexWidth1 textRight color666"><#if telphone!=''>${telphone}<#else>——</#if></div>
        </li>
        <li class="flex-wrap row-flex">
            <div class="title">地址</div>
            <div class="flexWidth1 textRight color666"><#if address!=''>${address}<#else>——</#if></div>
        </li>
    </ul>

    <div class="box-list fff accordion js-accordion">
        <div class="acc-li" onclick="showCentent();">
            <div class="acc-header js-acc-header">介绍</div>
            <ul class="acc-content ">
                <!-- <li class="item">
                </li> -->
                <li class="item noDataText">
                  	  暂时没有介绍
                </li>
            </ul>
        </div>
    </div>
    <div class="btn-w">
        <#if hospId!=''><button class="btn btn-ok btn-block" onclick="toRegister();">去挂号</button></#if>
    </div>
    <div class="space15"></div>
</div>
</body>
</html>
<script>

	$(function()
	{
		if(IS.isMacOS){
	        try{
	        	setTimeout("appHideNavRefresh();",1000);
		        } catch (e) {}}
		    else if(IS.isAndroid){
		        try{window.yx129.appHideNavRefresh();
		        } catch (e) {}
		    }
    });
    
	function toRegister()
	{
		var freshForm=$("<form></form>");
        freshForm.append($('<input type="hidden" name="userId" name="userId" value="${sessionUser.id}"/>'));
        freshForm.append($('<input type="hidden" name="openId" name="openId" value="${openId}"/>'));
		freshForm.append($('<input type="hidden" name="appCode" value="${appCode}"/>'));
		freshForm.append($('<input type="hidden" name="appId" value="${appId}"/>'));
		freshForm.append($('<input type="hidden" name="hospitalId" value="${hospId}"/>'));
		freshForm.append($('<input type="hidden" name="hospitalName" value="${hospName}"/>'));
		freshForm.append($('<input type="hidden" name="hospitalCode" value="${hospCode}"/>'));
		freshForm.append($('<input type="hidden" name="regType" value="1"/>'));
		freshForm.append($('<input type="hidden" name="areaCode" value="ShenZheng"/>'));
		freshForm.appendTo("body");
		freshForm.css('display','none');
		freshForm.attr("method","post");
		freshForm.attr("action","${basePath}/mobileApp/register/index");
		freshForm.submit();
	}
	
    function showCentent(){
        var obj  = $('.acc-content');

        if(obj.hasClass('show')){
            obj.removeClass('show')
            $('#js-more').html('展开详细');
        }else{
            obj.addClass('show')
            $('#js-more').html('收缩详细');
        }
    }



</script>
