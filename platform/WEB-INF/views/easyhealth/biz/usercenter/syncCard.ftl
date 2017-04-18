<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<link rel="stylesheet" href="${basePath}family/css/index.css"/>
<style>
.tips_content_txt,#am-loading_txt{font-size:.425rem!important}
</style>
<script>"use strict";!function(e,t){function i(){var t=n.getBoundingClientRect().width;t/m>540&&(t=540*m);var i=t/10;n.style.fontSize=i+"px",d.rem=e.rem=i}var a,r=e.document,n=r.documentElement,o=r.querySelector('meta[name="viewport"]'),l=r.querySelector('meta[name="flexible"]'),m=0,s=0,d=t.flexible||(t.flexible={});if(o){console.warn("将根据已有的meta标签来设置缩放比例");var p=o.getAttribute("content").match(/initial\-scale=([\d\.]+)/);p&&(s=parseFloat(p[1]),m=parseInt(1/s))}else if(l){var c=l.getAttribute("content");if(c){var u=c.match(/initial\-dpr=([\d\.]+)/),f=c.match(/maximum\-dpr=([\d\.]+)/);u&&(m=parseFloat(u[1]),s=parseFloat((1/m).toFixed(2))),f&&(m=parseFloat(f[1]),s=parseFloat((1/m).toFixed(2)))}}if(!m&&!s){var v=(e.navigator.appVersion.match(/android/gi),e.navigator.appVersion.match(/iphone/gi)),h=e.devicePixelRatio;m=v?h>=3&&(!m||m>=3)?3:h>=2&&(!m||m>=2)?2:1:1,s=1/m}if(n.setAttribute("data-dpr",m),!o)if(o=r.createElement("meta"),o.setAttribute("name","viewport"),o.setAttribute("content","initial-scale="+s+", maximum-scale="+s+", minimum-scale="+s+", user-scalable=no"),n.firstElementChild)n.firstElementChild.appendChild(o);else{var x=r.createElement("div");x.appendChild(o),r.write(x.innerHTML)}e.addEventListener("resize",function(){clearTimeout(a),a=setTimeout(i,300)},!1),e.addEventListener("pageshow",function(e){e.persisted&&(clearTimeout(a),a=setTimeout(i,300))},!1),"complete"===r.readyState?r.body.style.fontSize=12*m+"px":r.addEventListener("DOMContentLoaded",function(){r.body.style.fontSize=12*m+"px"},!1),i(),d.dpr=e.dpr=m,d.refreshRem=i,d.rem2px=function(e){var t=parseFloat(e)*this.rem;return"string"==typeof e&&e.match(/rem$/)&&(t+="px"),t},d.px2rem=function(e){var t=parseFloat(e)/this.rem;return"string"==typeof e&&e.match(/px$/)&&(t+="rem"),t}}(window,window.lib||(window.lib={}));</script>
<script src="${basePath}family/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script>

$(function() {
	var nowSelect,
	$addCard = $('.addCard'),
	$blackWrapper = $('.blackWrapper');

	
	//下拉框触发
	$('.contanier').on('click', '.isSelect', function() {
		var list = $(this).data('list').split('|'),
			_html = '';
		list.forEach(function(item) {
			ary = item.split(':'),
			_html += '<li key="' + ary[0] + '">' + ary[1] + '</li>';
		});
		$blackWrapper.removeClass('none').find('.selectList').html(_html);
		nowSelect = $(this);
	});
	//下拉框弹出
	$blackWrapper.on('click', '.selectCancle', function() {
		$blackWrapper.addClass('none');
	}).on('click', 'li', function() {
		nowSelect[nowSelect.is('input') ? 'val' : 'text']($(this).text());
		nowSelect.attr('key',$(this).attr('key'));
		($('#isCard').val() == '有' ? $('#idNum') : $('#city')).parents('li').removeClass('none')[$('#isCard').val() == '有' ? 'next' : 'prev']().addClass('none');
		$blackWrapper.addClass('none');
		setTimeout(function(){
			changeCardNoBySelectH($('#hospitalLists').attr('key'));
		},500)
	});
	var fromHospitalName="${fromHospitalName}";
	if(fromHospitalName&&fromHospitalName!=''){
		selectOnHospital(fromHospitalName);
	}
});

function selectOnHospital(hospitalname){
	$('#hospitalLists').click();
    $('.selectList li').each(function(i,e){
      $e = $(e);
      if($e.text() == hospitalname){ 
        $e.click();
        return;
      }
    });
}

function changeCardNoBySelectH(data){
	$('#idNum').val('');
	var dataArr=data.split(',');
	if(dataArr[0]&&dataArr[0]!=''){
		$('#appId').val(dataArr[0]);
	}
	if(dataArr[1]&&dataArr[1]!=''){
		$('#appCode').val(dataArr[1]);
	}
	if(dataArr[2]&&dataArr[2]!=''){
		$('#hospitalName').val(dataArr[2]);
	}
	if(dataArr[3]&&dataArr[3]!=''){
		$('#hospitalId').val(dataArr[3]);
	}
	if(dataArr[4]&&dataArr[4]!=''){
		$('#hospitalCode').val(dataArr[4]);
	}


    //是否有就诊卡选择标示
    var hasCard=$('#isCard').attr('key');
    if(!isCard||isCard==''){
        $Y.tips('请选择是否有就诊卡');
        return;
    }
    $('#hasCard').val(hasCard);
	
	var datas=$('#voForm').serializeArray();
	$.ajax({
        type: "POST",
        url: appPath+"easyhealth/usercenter/syncCard/syncMedicalcardNewest?isQueryCardNo=Y",
        data: datas,
        cache: false,
        dataType: "json",
        timeout: 30000,
        error: function (data) {
            
        },
        success: function (data) {
            if (data.status == 'OK') {

                if(data.message.filingState){
                    $("#isCard").removeClass("isSelect");
                }else{
                    $("#isCard").addClass("isSelect");
                }

                if(data.message.isCardNo=='Y' && data.message.cardNo && data.message.cardNo!='null'){
                	$('#idNum').val(data.message.cardNo);
                }
            }
        }
    });
}

function addSyncCard(){
	var dataStr=$('#hospitalLists').attr('key');
	if(!dataStr||dataStr==''){
		$Y.tips('请选择医院');
		return;
	}
	var dataArr=dataStr.split(',');
	if(dataArr[0]&&dataArr[0]!=''){
		$('#appId').val(dataArr[0]);
	}
	if(dataArr[1]&&dataArr[1]!=''){
		$('#appCode').val(dataArr[1]);
	}
	if(dataArr[2]&&dataArr[2]!=''){
		$('#hospitalName').val(dataArr[2]);
	}
	if(dataArr[3]&&dataArr[3]!=''){
		$('#hospitalId').val(dataArr[3]);
	}
	if(dataArr[4]&&dataArr[4]!=''){
		$('#hospitalCode').val(dataArr[4]);
	}
	
	var hasCard=$('#isCard').attr('key');
	if(!isCard||isCard==''){
		$Y.tips('请选择是否有就诊卡');
		return;
	}
	$('#hasCard').val(hasCard);
	if(hasCard==0){//没有就诊卡
		var address=$('#city').val();
		if(!address||address==''){
			$Y.tips('请输入城市');
			return;
		}else{
			$('#address').val(address);
		}
	}else{
		var medicalcardId=$('#idNum').val();
		if(!medicalcardId||medicalcardId==''){
			$Y.tips('请输入就诊卡号');
			return;
		}else{
			$('#medicalcardId').val(medicalcardId);
		}
	}
	var datas=$('#voForm').serializeArray();
	$.ajax({
        type: "POST",
        url: appPath+"easyhealth/usercenter/syncCard/syncMedicalcardNewest",
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
                	$Y.tips('添加成功！');
					closeAppWindow();           	
                } else {
                	$Y.tips('添加失败！');
                }
            } else if(data.status == 'PROMPT'){
            	$Y.tips(data.message);
            } else {
            	$Y.tips('添加失败！');
            }
        }
    });
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

</script>

<title><#if commonParams.syncType==1>添加本人就诊卡<#elseif commonParams.syncType==3>添加儿童就诊卡<#else>添加他人就诊卡</#if></title>
</head>
<body style="background: #f5f5f5;">
		<div class="blackWrapper none">
			<ul class="selectList"></ul>
			<button class="selectCancle">取消</button>
		</div>
		<div class="contanier">
			<div class="addCard">
				<ul class="inputList" style="margin: 0;">
					<li><label for="hospitalLists">医院</label><span><input type="text" class="isSelect newhs" placeholder="请选择" id="hospitalLists" readonly data-list="${hospitalLists}" required /></span></li>
					<li><label for="isCard">是否有就诊卡</label><span><input type="text" class="isSelect newcard" placeholder="请选择" id="isCard" readonly data-list="0:没|1:有" required value="有" key="1"/></span></li>
					<li><label for="idNum">卡号</label><span><input type="text" class="newId" placeholder="请输入" id="idNum" required /></span></li>
					<li class="none"><label for="city">城市</label><span><input type="text" class="newId" placeholder="请输入如(广东深圳)" id="city" required /></span></li>
				</ul>
				<button class="btnSubmit addCardBtn" onclick="addSyncCard()">添加</button>
			</div>

		</div>
<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}">
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
    <input type="hidden" id="forward" name="forward" value="${commonParams.forward}">
    <input type="hidden" id="syncType" name="syncType" value="${commonParams.syncType}">
    <input type="hidden" id="familyId" name="familyId" value="${commonParams.familyId}">
    <input type="hidden" id="hospitalId" name="hospitalId" value="">
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="">
    <input type="hidden" id="hospitalName" name="hospitalName" value="">
    <input type="hidden" id="hasCard" name="hasCard" value="">
    <input type="hidden" id="medicalcardId" name="medicalcardId" value="">
    <input type="hidden" id="address" name="address" value="">
</form>
</body>
</html>