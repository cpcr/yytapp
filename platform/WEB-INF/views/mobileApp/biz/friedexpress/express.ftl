<!--
	用户只能设置配送信息
 -->
<!DOCTYPE html>
<html>
<head>
<#include "/mobileApp/common/common.ftl">
    <title>选择配送地址</title>
    <style>
        .page-title { font-size: 16px; padding: 10px 10px 15px; }
        .n-box-list { margin-bottom: 40px; }
        .n-box-list li { padding: 10px; background: #fff; margin-bottom: 15px; }
        .add-btn { float: right; color: #339FEB; }
        .address-edit { width: 3em; color: #339FEB; white-space: nowrap; }
        .addressContent { display: -webkit-box;display: -webkit-flex;display: flex; }
        .i-radio { display: block; height: 17px; width: 20px; margin: 10px 10px 0 0; -webkit-appearance: none; border-radius: 50%; border: 1px solid #666; }
        .i-radio:checked { background: #339FEB; border-color: #339FEB; }
        .address-detail { width: 100%; line-height: 1.2; }
        .name { margin-bottom: 5px; }
    </style>
</head>
<body>

<div id="body">
    <div class="page-title">选择配送地址<span class="add-btn">添加地址</span></div>
    <div class="n-box-list">
        <ul class="addReceivingAddress-list">
        <#if !(expressList??) || expressList?size==0>
            <li class="tip">您还没有保存任何配送地址</li>
        <#else>
        </#if>

        <#if expressList?? && expressList?size != 0>
            <#list expressList as addr>
                <li class="addressContent">
                        <!-- 单选表单控件 -->
                        <input class="i-radio" type="radio" name="checkAddr" value="${addr.id}"
                               <#if addr.isDefault==1>checked=checked</#if>
                        />

                        <div class="address-detail">
                            <div class="name">
                                ${addr.name}（${addr.mobile?substring(0,3)}****${addr.mobile?substring(7,11)}）
                        </div>
                            ${addr.province+addr.city+addr.area+addr.detailAddr}
                    </div>
                        <#if addr.openId!="-1" && addr.openId!="-2" && addr.openId!="-3">
                            <div class="address-edit">修改</div>
                        </#if>
                </li>
            </#list>
        </#if>
            
        </ul>
    </div>

    <input type="hidden" name="openId" value="${openId}"/>
    <input type="hidden" name="hospitalId" value="${hospitalId}"/>
    <div class="section btn-w">
        <div class="btn btn-block" id="btnSave">确认</div>
    </div>
</div>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/friedexpress/app.express.js?v=1.14"></script>

<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>