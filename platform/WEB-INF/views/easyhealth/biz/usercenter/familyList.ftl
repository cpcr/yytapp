<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
    <#-- bug:75 就诊人管理的页面标题调整为“就诊人管理” -->
    <title>就诊人管理</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
    <div class="familyInfo">
        <div class="box-tips icontips"><i class="iconfont"></i>温馨提示：最多添加${familyNumbers}位就诊人，请谨慎添加。</div>
        <div class="space15"></div>
        <div id="families" style="display:none;">
            <ul id="familyList" class="yx-list">
            </ul>
            <div class="noFamily" id="noFamily">还没有添加就诊人</div>
        </div>
        <div class="btn-w">
            <div class="btn btn-ok btn-block" onclick="addFamilies();">添加就诊人</div>
        </div>
    </div>
</div>
<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}">
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
    <input type="hidden" id="familyNumbers" name="familyNumbers" value="${familyNumbers}">
    <input type="hidden" id="familyId" name="familyId" value="">
    <input type="hidden" id="syncType" name="syncType" value="2">
</form>
<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script>
    // 两个一样，用户就不能绑卡了。
    var maxCard = Number('${familyNumbers}');
    var cardNum = Number('${familyNumbers}');

    $(function () {
        getFamilies();
    });

    function getFamilies() {
        var url = '${basePath}easyhealth/usercenter/myFamily/getFamilies';
        var datas = $("#voForm").serializeArray();
        console.log(datas);
        $Y.loading.show('正在为您加载就诊人数据');
        $.ajax({
            type: 'POST',
            url: url,
            data: datas,
            dataType: 'json',
            timeout: 120000,
            error: function (data) {
                $Y.loading.hide();
                var myBox = new $Y.confirm({
                    content: "加载就诊人信息异常，请稍后重试...",
                    ok: {
                        title: "确定",
                        click: function () {
                            // 关闭界面
                            console.log('关闭界面');
                            myBox.close();
                        }
                    }
                })
            },
            success: function (data) {
                console.log(data);
                $Y.loading.hide();
                if (data.status == 'OK' && data.message && data.message.entityList) {
                    cardNum = data.message.entityList.length;
                    if (data.message.entityList.length > 0) {
                        format(data.message.entityList);
                    } else {
                        showNoData();
                    }
                } else {
                    showNoData();
                }
            }
        });
    }

    function format(data) {
        var sHtml = '';
        $.each(data, function (i, item) {
            sHtml += '<li class="arrow" onclick="showFamilyDetail(this);" familyId="' + item.id + '">';
            sHtml += '	<div class="title fontSize120">' + item.encryptedName + '（' + item.ownershipLabel + '）</div>';
            //sHtml += '	<div class="des color999">' + item.idNo + '</div>';
            sHtml += '</li>';
        });

        $('#familyList').html('');
        $('#familyList').append(sHtml);
        showHasData();
    }

    function showFamilyDetail(obj) {
        var familyId = $(obj).attr('familyId');
        if (familyId) {
            $('#familyId').val(familyId);
            $('#voForm').attr('action', '${basePath}easyhealth/usercenter/familyInfo/index');
            $('#voForm').submit();
        }
    }

    function addFamilies() {
        // 检测还能不能添加就诊人
        if (cardNum >= maxCard) {
            // 最多只能绑定那么多个
            new $Y.confirm({
                content: '<div>每个用户最多可以绑定' + maxCard + '个就诊人。</div>',
                ok: {title: '确定'}
            });

            return false;
        } else {
            $('#voForm').attr('action', '${basePath}easyhealth/usercenter/myFamily/addMyFamily');
            $('#voForm').submit();
        }
    }

    function showHasData() {
        $('#families').show();
        $('#familyList').show();
        $('#noFamily').hide();
    }

    function showNoData() {
        $('#families').show();
        $('#familyList').hide();
        $('#noFamily').show();
    }

    // 刷新方法
    function doRefresh() {
        $('#voForm').attr('action', '${basePath}easyhealth/usercenter/myFamily/index');
        $('#voForm').submit();
    }

    // 返回方法
    function doGoBack() {
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
</script>