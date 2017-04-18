<!DOCTYPE html>
<html>
<head>
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <meta charset="UTF-8">
    <meta content="width=device-width ,maximum-scale=1" name="viewport">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta content="none" http-equiv="x-rim-auto-match">
    <link rel="stylesheet" href="${basePath}easyhealth/css/style.css">
    <title>温馨提示</title>
    <style type="text/css">
        body {
            background-color: rgb(238, 238, 238);
        }

        .errormsg {
            text-align: center;
        }

        .error-part {
            margin-top: 30%;
        }
    </style>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)">
<div id="body">
    <div id="content">
        <div id="error">
            <div id="error-part" class="error-part">
                <div class="noticeEmpty"></div>
                <#if errormsg??>
                    <div class="p color666 errormsg">${errormsg}</div>
                <#else>
                    <div class="p color666 errormsg">无访问权限</div>
                </#if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
