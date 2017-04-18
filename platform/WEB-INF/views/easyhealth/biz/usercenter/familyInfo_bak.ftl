<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<title><#if family.ownership==1>个人资料<#elseif family.ownership==3>儿童信息<#else>就诊人信息</#if></title>
<link rel="stylesheet" href="${basePath}family/css/index.css"/>

<style>
	.listTitle {
	    box-sizing: border-box;
	    margin: .44444rem 0 .27778rem;
	    padding: 0 .38889rem;
	    font-size: 1.68889rem;
	}
	.listTitle span:last-child {
	    float: right;
	    color: #2297f7;
	    padding-left: .27778rem;
	    background: url(../img/img_jiuzr_add.png?t=1465184198006) no-repeat left center;
	    background-size: .27778rem .27778rem;
	}
	.addCard {
	    position: fixed;
	    top: 0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    background: #f5f5f5;
	}
	.none {
    	display: none;
	}
</style>


</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
	<div class="familyInfo">
        <ul class="yx-list">
            <#if family.ownership!=1 && family.ownership!=3>
            <li class="flex">
                <div class="flexItem">关系</div>
                <div class="flexItem color666 textRight">${family.ownershipLabel}</div>
            </li>
            </#if>
            <li class="flex">
                <div class="flexItem">姓名</div>
                <div class="flexItem color666 textRight">${family.encryptedName}</div>
            </li>
            <#if family.ownership == 3>
            <li class="flex">
                <div class="flexItem">出生日期</div>
                <div class="flexItem color666 textRight">${family.birth}</div>
            </li>
            <li class="flex">
                <div class="flexItem">性别</div>
                <div class="flexItem color666 textRight">${family.sexLabel}</div>
            </li>
            </#if>
             <#--
            <li class="flex">
                <div class="flexItem">地址</div>
                <div class="flexItem color666 textRight">${family.address}</div>
            </li>
            -->
            <#if family.ownership!=3>
            <li class="flex">
                <div class="flexItem">证件类型</div>
                <div class="flexItem color666 textRight">${family.idTypeLabel}</div>
            </li>
            <li class="flex">
                <div class="flexItem">证件号码</div>
                <div class="flexItem color666 textRight">${family.encryptedIdNo}</div>
            </li>
            <li class="flex">
                <div class="flexItem">手机号码</div>
                <div class="flexItem color666 textRight">${family.encryptedMobile}</div>
            </li>
            </#if>
        </ul>
        <#if family.ownership == 3>
        <div class="space15"></div>
        <ul class="yx-list">
        	<li class="flex">
                <div class="flexItem">监护人姓名</div>
                <div class="flexItem color666 textRight">${family.encryptedGuardName}</div>
            </li>
        	<li class="flex">
                <div class="flexItem">监护人证件类型</div>
                <div class="flexItem color666 textRight">${family.guardIdTypeLabel}</div>
            </li>
            <li class="flex">
                <div class="flexItem">监护人证件号码</div>
                <div class="flexItem color666 textRight">${family.encryptedGuardIdNo}</div>
            </li>
            <li class="flex">
                <div class="flexItem">监护人手机号码</div>
                <div class="flexItem color666 textRight">${family.encryptedGuardMobile}</div>
            </li>
        </ul>
        </#if>

        <div class="add-jiuZhenRen">
            <div class="listTitle">
				<span>就诊卡管理</span>
				<span class="add" onclick="syncCards(this)">添加</span>
			</div>
            
            <div class="radio-list">
                <ul class="yx-list" id="cardList">

                </ul>
            </div>
            <div class="space15"></div>
            <#if commonParams.syncType != 1>
            <div class="btn-w">
                <div class="btn btn-ok btn-block" onclick="removeFamily();">移除就诊人</div>
            </div>
            </#if>
        </div>
    </div>
	
	<div class="addCard none">
				<ul class="inputList" style="margin: 0;">
					<li><label for="hs">医院</label><span><input type="text" class="isSelect newhs" placeholder="请选择" id="hs" readonly data-list="深圳市第二人民医院测试|深圳市第三人民医院" required /></span></li>
					<li><label for="isCard">是否有就诊卡</label><span><input type="text" class="isSelect newcard" placeholder="请选择" id="isCard" readonly data-list="没|有" required /></span></li>
					<li><label for="idNum">卡号</label><span><input type="text" class="newId" placeholder="请输入" id="idNum" required /></span></li>
					<li><label for="city">城市</label><span><input type="text" class="newId" placeholder="请输入如(广东深圳)" id="city" required /></span></li>
				</ul>
				<button class="btnSubmit addCardBtn">添加</button>
   </div>

</div>



<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
	<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
	<input type="hidden" id="familyId" name="familyId" value="${family.id}">
	<input type="hidden" id="syncType" name="syncType" value="${commonParams.syncType}">
	<input type="hidden" id="medicalcardId" name="medicalcardId" value="">
	<input type="hidden" id="forward" name="forward" value="${commonParams.forward}">
</form>

<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script>
	$(function() {
		getCards();
	})

	function removeFamily() {
		// 跳往就诊人列表
		console.log('我要移除就诊人了.');
		
		$Y.loading.show('正在移除就诊人...');
		var datas = $('#voForm').serializeArray();
		$.ajax({
			type: "POST",
			url: "${basePath}easyhealth/usercenter/familyInfo/unbindFamily",
			data: datas,
			cache: false, 
			dataType: "json", 
			timeout: 600000,
			error: function(data) {
				$Y.loading.hide();
				showMessageBox('移除就诊人失败，请稍后重试。');
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				if (data.status == 'OK') {
					var code = data.message.isSuccess;
					var tips = data.message.msgInfo ? data.message.msgInfo : '移除就诊人失败，请稍后重试。';
					
					if (code == 0) {
						// 成功，跳转回列表
						$('#voForm').attr('action', '${basePath}easyhealth/usercenter/myFamily/index');
						$('#voForm').submit();
					} else {
						showMessage(tips);
					}
				} else {
					showMessageBox('移除就诊人失败，请稍后重试。');
				}
			}
		})
	}
	
	function getCards() {
		$Y.loading.show('正在加载绑卡信息...');
		var datas = $('#voForm').serializeArray();
		$.ajax({
			type: "POST",
			url: "${basePath}easyhealth/usercenter/familyInfo/getCards",
			data: datas,
			cache: false, 
			dataType: "json", 
			timeout: 600000,
			error: function(data) {
				$Y.loading.hide();
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				if (data.status == 'OK' && data.message && data.message.entityList && data.message.entityList.length > 0) {
					formatData(data.message.entityList);
				}
			}
		})
	}
	
	function formatData(data) {
		var sHtml = '';
		
		$.each(data, function(i, item) {
			sHtml += '<li class="arrow" onclick="showCardInfo(this);" medicalcardId="' + item.id + '">';
            sHtml += '	<div class="title fontSize120">' + item.cardNo + '</div>';
            sHtml += '	<div class="des color666">' + item.hospitalName + '</div>';
            sHtml += '</li>';
		});
		
		$('#cardList').html('');
		$('#cardList').append(sHtml);
	}
	
	function showCardInfo(obj) {
		$('#medicalcardId').val($(obj).attr('medicalcardId'));
		$('#voForm').attr('action', '${basePath}easyhealth/usercenter/cardInfo/toView');
		$('#voForm').submit();
	}
	
	function showMessageBox(data) {
		new $Y.confirm({
	        ok:{title:'确定'},
	        content: data
	    });
	};
	
	function syncCards() {
		if(1==1){
		  $('.addCard').removeClass('none');
		  return;
		}
	
	
		$('#voForm').attr('action', '${basePath}easyhealth/usercenter/syncCard/index');
		$('#voForm').submit();
	}
	
	// 刷新方法
	function doRefresh() {
		$('#voForm').attr('action', '${basePath}easyhealth/usercenter/familyInfo//index');
		$('#voForm').submit();
	}
	
	// 返回方法
	function doGoBack() {
		var forward = '${commonParams.forward}';
		var url = "";
		if (forward) {
			if (forward.indexOf('userCenterIndex') != -1) {
				if(IS.isMacOS){
					try {
		              window.appCloseView(true);
		  			} catch (e) {
		            //  alert('IOS的方法出错');
		          	}
				}else if(IS.isAndroid){
		          	try {
		              window.yx129.appCloseView(true);
		          	} catch (e) {
		           	//   alert('Android的方法出错');
		          	}
		       	}else{
		       		go(appPath + 'easyhealth/userCenterIndex');
		        }
			}
		} else {
			var syncType = $('#syncType').val();
			if (syncType == 1) {
				// 本人跳回关联页面
				// url = "${basePath}easyhealth/usercenter/syncCard/index";
				url = "${basePath}easyhealth/userCenterIndex";
			} else if (syncType == 2) {
				// 返回就诊人列表页面
				url = "${basePath}easyhealth/usercenter/myFamily/index";
			}
			
			$('#voForm').attr('action', url);
			$('#voForm').submit();
		}
	}
</script>