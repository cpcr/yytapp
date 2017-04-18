<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width ,maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="x-rim-auto-match" content="none">
    <#include "/easyhealth/common/common.ftl">
    <title>${msgTemplate.title}</title>
    <script type="text/javascript" src="${basePath}/easyhealth/js/biz/msgcenter/detail.js"></script>
    <script type="text/javascript">
    $(function(){
	    if('${msgTemplate.iconPath}'!=null&&'${msgTemplate.iconPath}'!=''){
	    var path= window.location.protocol+"//"+window.location.host;
	        $("#iconShow").attr("src",path+'${msgTemplate.iconPath}');
	    }
	    
    });
    
    </script>
</head>
<body>
<div id="body">
	<input type="hidden" id="openId" name="openId" value="${sessionUser.id}">
    <section class="mod-notice">
    	<article class="noticeBox">
    		<div class="noticeIcon">
    		<img id='iconShow' alt=''>
    			<p>${msgTemplate.title}</p>
    		</div>
    		<#list msgTemplate.msgTemplateContents as msgTemplateContent>
    			<#if msgTemplateContent.sort==1>
    				<#if msgTemplateContent.value!=null&&msgTemplateContent.value?trim!="">
	    			<div class="noticeTip">
	    			${msgTemplateContent.value}
	    			</div>
	    			</#if>
    			  <#break>
    			</#if>
    		</#list>
    		<div class="noticeInfo">
    		<#list msgTemplate.msgTemplateContents as msgTemplateContent>
    			<#if msgTemplateContent.sort!=1 && msgTemplateContent.sort !=99>
    				<p><span>${msgTemplateContent.keyword}：</span>${msgTemplateContent.value}</p>
    			</#if>
    		</#list>
    		<#list msgTemplate.msgTemplateContents as msgTemplateContent>
    			<#if msgTemplateContent.sort==99>
    				<#if msgTemplateContent.value!=null>
    				<div class="noticeTip2">
    					${msgTemplateContent.keyword}：${msgTemplateContent.value}
    				</div>
    				</#if>
    				<#break>
    			</#if>
    		</#list>
    		</div>
    		
    	</article>
        <!-- <article class="noticeBtn">
            <span class="btn1">挂号详情</span>
            <span class="btn1">交通详情</span>
        </article> -->
        <#if (msgTemplate.msgTemplateFunctions?size>0)>
        	<#list msgTemplate.msgTemplateFunctions as msgTemplateFunction>
        		<#if msgTemplateFunction.functionCode!=null&&msgTemplateFunction.functionCode?trim!="">
		        <div class="btn-w">
		            <button type="button" class="btn btn-ok btn-block" onClick="${msgTemplateFunction.functionCode}">${msgTemplateFunction.functionName}</button>
		        </div>
		        </#if>
	        </#list>
        </#if>
    </section>
</div>
</body>
</html>

<script type="text/javascript">
    $(function(){
    if('${msgTemplate.animationPath}'!=null&&'${msgTemplate.animationPath}'!=""){
    	var path= window.location.protocol+"//"+window.location.host;
       	$Y.animationGif(path+'${msgTemplate.animationPath}');
    }
    	
    });
</script>