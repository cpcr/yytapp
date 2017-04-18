<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
    <title>关联医院就诊卡</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
    <div class="userCardBox">
        <div class="box-tips icontips">
            <i class="iconfont">&#xe60d;</i>
            使用医院服务（如挂号、缴费、查报告）之前，需要先关联在医院的就诊卡信息。
        </div>
        <div class="page-title">选择医院</div>
        <ul class="yx-list">
        <#list entityList as item>
            <li class="flex">
                <div class="flexItem fontSize1	">${item.hospitalName}</div>
                <div class="flexItem textRight"
                     appId="${item.appId}" appCode="${item.appCode}"
                     hospitalName="${item.hospitalName}" hospitalId="${item.hospitalId}"
                     hospitalCode="${item.hospitalCode}">
                    <span class="color999 syncTips" style="display: none;">正在关联...</span>
                    <div class="btn-async" onclick="syncCard(this);">关联就诊卡</div>
                    <div class="btn-async" onclick="bindCard(this);" style="display: none;">手动绑卡</div>
                </div>
            </li>
        </#list>
        </ul>
        <div class="btn-w" id="btnDone">
            <div type="button" class="btn btn-ok btn-block" onclick="closeAppWindow();">完成</div>
        </div>
    </div>
</div>
<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}"/>
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
    <input type="hidden" id="syncType" name="syncType" value="${commonParams.syncType}">
    <input type="hidden" id="hospitalId" name="hospitalId" value="">
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="">
    <input type="hidden" id="hospitalName" name="hospitalName" value="">
    <input type="hidden" id="familyId" name="familyId" value="${commonParams.familyId}">
</form>
<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script>
    function syncCard(obj) {
        enableShellButtonEvent = false;
        $(obj).attr('disabled', true);
        $(obj).hide();
        var tipsElement = $(obj).parent().find('.syncTips');
        tipsElement.show();
        tipsElement.removeClass('red');
        tipsElement.addClass('color999');

        var parentObj = $(obj).parent();
        $('#hospitalId').val($(parentObj).attr('hospitalId'));
        $('#hospitalCode').val($(parentObj).attr('hospitalCode'));
        $('#hospitalName').val($(parentObj).attr('hospitalName'));
        $('#appId').val($(parentObj).attr('appId'));

        var datas = $('#voForm').serializeArray();
        console.log(datas);

        $.ajax({
            type: "POST",
            url: "${basePath}easyhealth/usercenter/syncCard/syncMedicalcard",
            data: datas,
            cache: false,
            dataType: "json",
            timeout: 30000,
            error: function (data) {
                enableShellButtonEvent = true;
                new $Y.confirm({
                    ok: {title: '确定'},
                    content: '网络超时，请稍后在我的就诊人查看绑定结果。'
                });
                $(obj).attr('disabled', false);

                tipsElement.removeClass('color999');
                tipsElement.addClass('red');
                tipsElement.text('关联失败');
                $(obj).hide();
                $(obj).siblings('.btn-async').show();
            },
            success: function (data) {
                console.log(data);
                enableShellButtonEvent = true;
                if (data.status == 'OK') {
                    var isSuccess = data.message.isSuccess;
                    if (isSuccess == 0) {
                        tipsElement.removeClass('color999');
                        tipsElement.addClass('skinColor');
                        tipsElement.text('成功');
                    } else {
                        // 失败
                        tipsElement.removeClass('color999');
                        tipsElement.addClass('red');
                        tipsElement.text('关联失败');
                        $(obj).hide();
                        $(obj).siblings('.btn-async').show();
                        // $(obj).show();
                    }
                } else {
                    // 失败
                    tipsElement.removeClass('color999');
                    tipsElement.addClass('red');
                    tipsElement.text('关联失败');
                    $(obj).hide();
                    $(obj).siblings('.btn-async').show();
                    // $(obj).show();
                }
            }
        });
    }

    function bindCard(obj) {
        $(obj).attr('disabled', true);
        $(obj).hide();
        var tipsElement = $(obj).parent().find('.syncTips');
        tipsElement.show();
        tipsElement.removeClass('red');
        tipsElement.addClass('color999');

        var parentObj = $(obj).parent();
        $('#hospitalId').val($(parentObj).attr('hospitalId'));
        $('#hospitalCode').val($(parentObj).attr('hospitalCode'));
        $('#hospitalName').val($(parentObj).attr('hospitalName'));
        $('#appId').val($(parentObj).attr('appId'));

        // 使用goUrl的方式过去，绑定后，跳回这个页面，并自动刷新。
        var url = '${basePath}easyhealth/usercenter/medicalcard/index' +
                '?appId=' + $('#appId').val() +
                '&appCode=' + $('#appCode').val() +
                '&openId=' + $('#openId').val() +
                '&areaCode=' + $('#areaCode').val() +
                '&familyId=' + $('#familyId').val() +
                '&hospitalId=' + $('#hospitalId').val() +
                '&syncType=' + $('#syncType').val() +
                '&hospitalCode=' + $('#hospitalCode').val();
        go(url);
    }

    function closeAppWindow() {
        var appCode = $('#appCode').val();
        var areaCode = $('#areaCode').val();
        var userId = $('#userId').val();
        var openId = $('#openId').val();
        var appId = $('#appId').val();
        var params = "appCode=" + appCode + "&areaCode=" + areaCode + "&userId=" + userId + "&openId=" + openId + "&appId=" + appId;
        window.location.href = appPath + 'easyhealth/userCenterIndex?' + params;
    }

    function viewMyCards() {
        console.log('查看本人就诊卡');
        $('#voForm').attr('action', '${basePath}easyhealth/usercenter/familyInfo/index');
        $('#voForm').submit();
    }

    var enableShellButtonEvent = true;

    // 刷新方法
    function doRefresh() {
        if (enableShellButtonEvent) {
            $('#voForm').attr('action', '${basePath}easyhealth/usercenter/syncCard/index');
            $('#voForm').submit();
        }
    }

    // 返回方法
    function doGoBack() {
        if (enableShellButtonEvent) {
            if (IS.isMacOS) {
                try {
                    window.appCloseView(true);
                } catch (e) {
                    //  alert('IOS的方法出错');
                }
            } else if (IS.isAndroid) {
                try {
                    window.yx129.appCloseView(true);
                } catch (e) {
                    //   alert('Android的方法出错');
                }
            } else {
                go(appPath + 'easyhealth/userCenterIndex');
            }
        }
    }
</script>