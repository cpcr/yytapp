<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <title>等待出号</title>
</head>
<body>
<div id="body">
    <div id="success">
        <img src="${basePath}mobileApp/images/wait-pic.png" width="110"/>
        <div class="p color666" id="msginfo"> 正在出号中,请耐心等待.您也可以稍后在挂号记录中查看出号情况.</div>
    </div>
    <div class="section btn-w" id="buttonDiv">
        <div class="btn btn-block" onclick="goNext()">确定</div>
    </div>
</div>
<form id="paramsForm" method="post">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}"/>
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
    <input type="hidden" id="orderNo" name="orderNo" value="${commonParams.orderNo}">
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}">
    <input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}">
    <input type="hidden" id="tradeMode" name="tradeMode" value="${commonParams.tradeMode}">
    <input type="hidden" id="tradeNo" name="tradeNo" value="${commonParams.tradeNo}">
    <input type="hidden" id="tradeAmout" name="tradeAmout" value="${commonParams.tradeAmout}">
    <input type="hidden" id="regType" name="regType" value="${commonParams.regType}">
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>
<script type="text/javascript">
    $(function () {
        hisPayConfirm();
        $("#buttonDiv").hide();
    });

    var isSuccess = false;

    function hisPayConfirm() {
        var reqUrl = "${basePath}mobileApp/register/confirm/hisPayConfirm";
        var datas = $("#paramsForm").serializeArray();
        $.ajax({
            type: 'POST',
            url: reqUrl,
            data: datas,
            dataType: 'json',
            timeout: 600000,
            success: function (data) {
                $("#msginfo").html(data.message.msgInfo)
                $("#buttonDiv").show();
                if (data.message.isSuccess) {
                    isSuccess = true;
                    setTimeout(timeCount, 1000);
                } else {
                    isSuccess = false;
                }
            },
            error: function (data) {
                $Y.loading.hide()
                errorBox = new $Y.confirm({
                    content: '<div>网络超时,系统自动处理中,请稍后在挂号记录中查看结果</div>',
                    ok: {title: '确定'}
                })
            }
        });
    }

    function timeCount() {
        var time = $("#timeCount").html();
        time = parseInt(time) - 1;
        if (time == 0) {
            goNext();
        } else {
            $("#timeCount").html(time);
            setTimeout(timeCount, 1000);
        }
    }

    function goNext() {
        //添加时间戳 解决移动段 返回不请求服务端的bug
        var now = new Date();
        var timeTemp = now.getTime();
        var toViewUrl = $("#toViewUrl").val();
        //挂号费缴费成功后，继续支付检查费
        if(toViewUrl == 'showPayDetail'){
            window.location = "${basePath}mobileApp/register/infos/showPayDetail?orderNo=${commonParams.orderNo}&openId=${commonParams.openId}&timeTemp=" + timeTemp;
        }
        //挂号费缴费成功后，展示挂号详情界面
        else{
            window.location = "${basePath}mobileApp/register/infos/showOrderInfo?orderNo=${commonParams.orderNo}&openId=${commonParams.openId}&timeTemp=" + timeTemp;
        }
    }
</script>
