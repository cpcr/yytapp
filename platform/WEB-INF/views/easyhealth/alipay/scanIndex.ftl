<html>
<head>
<#include "/easyhealth/common/common.ftl">
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <title>报到取号</title>
</head>
<body>
<div id="body">
    <div class="section">
        <div class="box-tips icontips">
            <i class="iconfont"></i>温馨提示：扫一扫医院的“报到二维码”即可自动报到，无需排队。本功能目前只在深圳市第三人民医院试运行，后续将支持更多医院。
        </div>
    </div>
    <div class="scanList">
        <div class="page-title">请选择要报到的就诊人</div>
        <div class="scanChoose">
            <ul class="yx-list">
            <#list entityList as family>
                <li class="scan_item <#if family.ownership == 1>show</#if>" familyId="${family.id}" openId="${family.userId}">
                    <i class="iconfont">&#xe69a;</i>${family.encryptedName}（${family.ownershipLabel}）
                </li>
            </#list>
            </ul>
        </div>
        <div class="btn-w">
            <div class="btn btn-ok btn-block" onclick="doScanCode();">开始扫码</div>
        </div>
    </div>
</div>
<form id="voForm" method="post">
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}"/>
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}"/>
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}"/>
</form>
<#include "/easyhealth/common/footer.ftl">
<script src="${basePath}easyhealth/js/common/nav-list.js" type="text/javascript"></script>
<script src="https://static.alipay.com/aliBridge/1.0.0/aliBridge.min.js"></script>
</body>
</html>
<script type="text/javascript">
    var appVersion = '';
    $(function () {
        $('.scan_item').click(function () {

            if ($(this).hasClass('show')) {
                $(this).removeClass('show');
            } else {
                $('.scan_item').removeClass('show');
                $(this).addClass('show');
            }
        });
        appVersion = '';
        setTimeout(function () {
            appVersion = getVersion();
        }, 500);
    });

    function getVersion() {
        //android函数原型	window.yx129.appGetVersion();
        //ios 函数原型	appGetVersion();
        var appVersion = "未知";
        if (IS.isMacOS) {
            appVersion = appGetVersion();
        } else if (IS.isAndroid) {
            appVersion = window.yx129.appGetVersion();
        }
        return appVersion;
    }

    function scanCode() {
        // 验证
        var obj = $('li.show');
        if (obj.length == 0) {
            myBox = new $Y.confirm({
                title: "",
                content: "<div style='text-align: center;'>请选择要报到的就诊人</div>",
                ok: {
                    title: "我知道了",
                    click: function () {
                        myBox.close();
                    }
                }
            });
        } else {
            // 验证版本号 低于1.1.6版本(测试版本可能带T的)
            var newVersion = '1.1.6_t';
            if (appVersion.localeCompare(newVersion) == -1) {
                myBox = new $Y.confirm({
                    title: "",
                    content: "<div style='text-align: center;'>请先更新程序版本再使用此功能！</div>",
                    ok: {
                        title: "我知道了",
                        click: function () {
                            myBox.close();
                        }
                    }
                });
            } else {
                var urlParams = '&familyId=' + $(obj).attr('familyId') +
                        '&openId=' + $(obj).attr('openId') +
                        '&appCode=' + '${commonParams.appCode}' +
                        '&areaCode=' + '${commonParams.areaCode}';
                if (IS.isMacOS) {
                    try {
                        window.appScan(urlParams);
                    } catch (e) {
                        //  alert('IOS的方法出错');
                    }
                } else if (IS.isAndroid) {
                    try {
                        window.yx129.appScan(urlParams);
                    } catch (e) {
                        //   alert('Android的方法出错');
                    }
                } else {
                    go(appPath + 'easyhealth/userCenterIndex');
                }
            }
        }
    }

    function doScanCode() {
        var obj = $('li.show');
        if (navigator.userAgent.indexOf("AlipayClient") === -1) {
            alert('请在支付宝钱包内运行');
        } else if (obj.length == 0) {
            myBox = new $Y.confirm({
                title: "",
                content: "<div style='text-align: center;'>请选择要报到的就诊人</div>",
                ok: {
                    title: "我知道了",
                    click: function () {
                        myBox.close();
                    }
                }
            });
        } else {
            if ((Ali.alipayVersion).slice(0, 3) >= 8.1) {
                Ali.scan({
                    type: 'qr' //qr(二维码) / bar(条形码) / card(银行卡号)
                }, function (result) {
                    if (result.errorCode) {
                        //没有扫码的情况
                        //errorCode=10，用户取消
                        //errorCode=11，操作失败
                        if (result.errorCode == 10) {
                            Ali.alert({
                                title: 'Tips',
                                message: "用户取消",
                                button: '确定'
                            });
                        } else if (result.errorCode == 11) {
                            Ali.alert({
                                title: 'Tips',
                                message: "操作失败",
                                button: '确定'
                            });
                        } else {
                            Ali.alert({
                                title: 'Tips',
                                message: "服务器异常",
                                button: '确定'
                            });
                        }
                    } else {
                        //成功扫码的情况
                        //result.barCode	string	扫描所得条码数据
                        //result.qrCode	string	扫描所得二维码数据
                        //result.cardNumber	string	扫描所得银行卡号
//                        Ali.alert({
//                            title: 'Tips',
//                            message: "扫码成功",
//                            button: '确定'
//                        });
                        var result = result.qrCode;
                        var urlParams = '&familyId=' + $(obj).attr('familyId') +
                                '&openId=' + $(obj).attr('openId') +
                                '&appCode=' + '${commonParams.appCode}' +
                                '&areaCode=' + '${commonParams.areaCode}';
                        var target = result + urlParams;
                        window.location.href = target;
                    }
                });
            } else {
                Ali.alert({
                    title: '亲',
                    message: '请升级您的钱包到最新版',
                    button: '确定'
                });
            }
        }
    }
</script>