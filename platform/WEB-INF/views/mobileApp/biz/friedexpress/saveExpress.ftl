<!--
	新建或更新配送地址
-->
<!DOCTYPE html>
<html>
<head>
    <#include "/mobileApp/common/common.ftl">
    <script type="text/javascript" src="${basePath}mobileApp/js/biz/friedexpress/app.saveExpress.js?v=1.18"></script>
    <script type="text/javascript" src="${basePath}mobileApp/js/biz/friedexpress/city.select.js?v=1.13"></script>
    <title>配送地址</title>
    <style>
        .city-select { overflow: hidden;}
        .city-select select {  float: left; width: auto; margin-right: 10px; padding: 5px 20px 5px 5px;}
        .i_arrow-1 {
            float: left;
            margin: 12px 0 0 -25px;
            display: inline-block;
            border: solid #999;
            border-width: 0 1px 1px 0;
            width: 8px;
            height: 8px;
            transform: rotate(45deg);
        }
    </style>
</head>
<body>

<div id="body">
    <div class="box-list">
        <ul class="yx-list flex">
            <li>
                <div class="city-select"></div>
            </li>
            
            <li>
                <div class="label">详细地址</div>
                <!--兼容三星-->
                <div class="values">
                    <div class="input-placeholder">
                        <input class="yx-input noBorder" type="text" name="detailAddr" value="${friedExpress.detailAddr}"/>
                    </div>
                </div>
                <!--兼容三星 end-->
            </li>
        </ul>
    </div>
    <!--联系人信息-->
    <div class="box-list">
        <ul class="yx-list flex">
            <li>
                <div class="label">联系人</div>
                <!--兼容三星-->
                <div class="values">
                    <div class="input-placeholder">
                        <input class="yx-input noBorder" type="text" name="name" value="${friedExpress.name}"/>
                    </div>
                </div>
                <!--兼容三星 end-->
            </li>
            <li>
                <div class="label">联系电话</div>
                <!--兼容三星-->
                <div class="values">
                    <div class="input-placeholder">
                        <input class="yx-input noBorder" type="tel" name="mobile" value="${friedExpress.mobile}" maxLength="11"/>
                    </div>
                </div>
                <!--兼容三星 end-->
            </li>
        </ul>
    </div>
    <!--联系人信息end-->
    
    <input type="hidden" name="hospitalId" value="${hospitalId}"/>
    <input type="hidden" name="platform" value="${platform}"/>
    <input type="hidden" name="openId" value="${openId}"/>
    
    <input type="hidden" name="province" value="${friedExpress.province}"/>
    <input type="hidden" name="city" value="${friedExpress.city}"/>
    <input type="hidden" name="area" value="${friedExpress.area}"/>
    
    <input type="hidden" name="id" value="${friedExpress.id}"/>
	<div class="section btn-w">
        <div class="btn-inline">
            <div class="btn btn-cancel btn-block" id="delBtn">删除</div>
            <div class="btn btn-ok btn-block" id="saveBtn">保存</div>
        </div>
    </div>
</div>

<#include "/mobileApp/common/yxw_footer.ftl">
    <script>
        function changePayType(domObj){
            var obj = $(domObj).find('i').first();
            if(obj.hasClass('icon-switch-right')){
                obj.removeClass('icon-switch-right');
            }else{
                obj.addClass('icon-switch-right');
            }
        }
        
    </script>
</body>
</html>