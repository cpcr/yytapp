<!DOCTYPE html>
<html>
<head>
<meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<meta HTTP-EQUIV="expires" CONTENT="0"> 
<#include "/mobileApp/common/common.ftl">
<title>${(commonParams.appCode=='easyHealth')?string("我的就诊人", "就诊人信息")}</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)">
	<div id="body">
	    <div id="myCenter">
	    </div>
	    <div id="bindCard">
		    
	    </div>
	</div>
	<form id="voForm" method="post" action="">
		<input type="hidden" id="openId" name="openId" value="${commonParams.openId}" />
		<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}" />
		<input type="hidden" id="appId" name="appId" value="${commonParams.appId}" />
		<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
		<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}" />
		<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
		<input type="hidden" id="id" name="id" value="" />
		<input type="hidden" id="bindCardType" name="bindCardType" value="${(commonParams.appCode=='easyHealth')?string("0", "2")}" />
	</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
<script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/idCardUtils.js"></script>
<script type="text/javascript">
	$(function() {
		$Y.loading.show('正在获取就诊人就诊卡信息...');
		// getFamilies();
		setTimeout(1000, getFamilies());
	});
	
	function getFamilies() {
		var now = new Date();
		var timeTemp = now.getTime();
		
		var platform = 1;
		var appCode = '${commonParams.appCode}';
		if (appCode == 'wechat') {
			platform = 1;
		} else if (appCode == 'alipay') {
			platform = 2;
		} else if (appCode == 'easyHealth') {
			platform = 3;
		}
		
		$.ajax({
			url: appPath + 'mobileApp/medicalcard/family/getFamilies?timeTemp=' + timeTemp,
			data: {
				openId: '${commonParams.openId}',
				platform: platform,
				appId: '${commonParams.appId}',
				appCode: '${commonParams.appCode}',
				hospitalCode: '${commonParams.hospitalCode}',
				hospitalId: '${commonParams.hospitalId}',
				ownership: '2',
				state: '1'
			},
			type: "post",
			dataType: "json", 
			global: false,
			cache: false,
			timeout: 5000,
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				$Y.loading.hide();
				// showMessageBox('获取就诊人就诊卡信息失败，请稍后重试。');
				// 加载错误，重新进入加载，后台确保没有异常 try..catch
				$('#voForm').attr('action', '${basePath}mobileApp/medicalcard/family/toView?timeTemp=' + timeTemp);
				$('#voForm').submit();
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				if (data.status == 'OK') {
					formatData(data.message);
					bindUserInfoEvent();
				} else {
					showMessageBox('获取就诊人就诊卡信息失败，请稍后重试。');
				}
			}
		})
	};
	
	function bindUserInfoEvent() {
		$('.pic').off('click').on('click', function(event) {
			event.stopPropagation();
	        event.preventDefault();
	        
	        var id = $(this).attr('data-value');
	        if (id && id != 'null') {
	        	$('input[name="id"]').val(id);
	        	$('#voForm').attr('action', '${basePath}mobileApp/medicalcard/userinfo/toView');
	        	$('#voForm').submit();
	        } else {
	        	showMessageBox('查看就诊人信息异常，请稍后重试。');
	        }
		});
		
		$('.btn-ok').off('click').on('click', function(event) {
		    event.stopPropagation();
		    event.preventDefault();
		    
		    $Y.loading.show('正在进行绑卡检测');
			var url = "${basePath}mobileApp/common/whetherCanBindCard";
			var datas = $("#voForm").serializeArray();
			$.ajax({
	           	type : 'POST',  
	           	url : url,  
	           	data : datas,  
	           	dataType : 'json',  
	           	timeout:120000,
	           	error: function(data) {
	           		$Y.loading.hide();
	           		new $Y.confirm({
			            ok: {title:'确定'},
			            content: '网络异常，无法进行绑卡操作'
			        });
	           	},
	           	success : function(data) {
	           		console.log(data);
	           		$Y.loading.hide();
	           		if (data.status == 'OK') {
	           			if (data.message.canBindCard == '1') {
	           				$('#voForm').attr('action', '${basePath}mobileApp/medicalcard/bind/toView');
	           				if ($('#appCode').val() == 'easyHealth' && data.message.selfCards == '1') {
	           					$('#bindCardType').val(2);
	           				}
			   				$('#voForm').submit();
	           			} else {
	           				new $Y.confirm({
					            ok: {title:'确定'},
					            content: '每个账号只可以添加' + data.message.maxCardCount + '张就诊人就诊卡。'
					        });
	           			}
	           		} else {
	           			new $Y.confirm({
				            ok: {title:'确定'},
				            content: '网络异常，无法进行绑卡操作'
				        });
	           		}
	           	}
	    	})
		});
	}
	
	function initAge(birth) {
		if (birth) {
			var age = idCardUtils.getAge(birth);
			if (age || age == '0') {
				return age + '岁';
			} 
		}
	}
	
	function formatData(data) {
		var warmingTips = '';
		var btnText = '';
		var noDataTips = '';
		
		if ('${commonParams.appCode}' == 'easyHealth') {
	    	warmingTips += '温馨提示：每个账号可以添加' + (Number('${maxCardCount}') + 1) + '个就诊卡。';
	    	btnText = '添加就诊卡';
	    	noDataTips = '您还没添加任何就诊人，请先添加。';
	    } else {
	    	warmingTips += '温馨提示：每个账号可以添加${maxCardCount}张就诊人就诊卡。';
	    	btnText = '添加就诊人';
	    	noDataTips = '您还没有绑定就诊人就诊人。';
	    }
		var sHtml = '';
		
		if (data.length > 0) {
			// 有就诊人
			sHtml += '<div class="box-list">';
			sHtml += '	<ul class="yx-list">';
			$.each(data, function(i, item){
				sHtml += '<li class="pic" data-value="' + item.id + '">';
                sHtml += '	<img src="${basePath}mobileApp/images/' + ((item.sex == '1') ? 'man-def.png' : 'girl-def.png') + '" width="60" height="60">';
                sHtml += '  	<div class="info">';
                sHtml += '      	<div class="name">' + item.encryptedPatientName  + '<i class="icon-myCenter ' + ((item.sex == '1') ? 'icon-man' : 'icon-girl') + '"></i></div>';
                sHtml += '        	<div class="color999">' + initAge(item.birth)  + '</div>';
                sHtml += '   	</div>';
                sHtml += '	    <i class="icon-arrow"></i>';
                sHtml += '</li>';
			});
			sHtml += '	</ul>';
			sHtml += '</div>';
			
			$('#myCenter').html('');
			$('#myCenter').append(sHtml);
	
		} else {
			// 无就诊人
			showNoFamilies(noDataTips);
		}
		
		sHtml = '';
		
		sHtml += '<div class="section">';
	    sHtml += '	<div class="box-tips"> <i class="icon-warn"></i>' + warmingTips + '</div>';
	    sHtml += '</div>';
	    sHtml += '<div class="section btn-w">';
	    sHtml += '<div class="btn btn-ok btn-block" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">' + btnText + '</div>';
	    sHtml += '</div>';
		
		$('#bindCard').html('');
		$('#bindCard').append(sHtml);
	}
	
	function showMessageBox(data) {
		new $Y.confirm({
	        ok:{title:'确定'},
	        content: data
	    });
	};
	
	function showNoFamilies(data) {
		var sHtml = '';
		sHtml += '<div id="success">';
		sHtml += '	<img src="' + appPath + 'mobileApp/images/noData-pic.png" width="110">';
		sHtml += '	<div class="p color666">' + (data ? data : '您还没有绑定就诊人就诊人') + '</div>';
		sHtml += '</div>';
		sHtml += '';
		$('#myCenter').html('');
		$('#myCenter').append(sHtml);
	}
	
	function doRefresh()
	{
			var freshFrom=$("<form></form>");
			freshFrom.append($('<input type="hidden"  name="openId" value="${commonParams.openId}" />'));
			freshFrom.append($('<input type="hidden"  name="appCode" value="${commonParams.appCode}" />'));
			freshFrom.append($('<input type="hidden"  name="appId" value="${commonParams.appId}" />'));
			freshFrom.append($('<input type="hidden"  name="hospitalCode" value="${commonParams.hospitalCode}" />'));
			freshFrom.append($('<input type="hidden"  name="hospitalId" value="${commonParams.hospitalId}">'));
			freshFrom.append($('<input type="hidden"  name="hospitalName" value="${commonParams.hospitalName}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalName" value="${commonParams.branchHospitalName}" />'));
			freshFrom.append($('<input type="hidden"  name="branchHospitalId" value="${commonParams.branchHospitalId}" />'));
			freshFrom.append($('<input type="hidden" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />'));
			freshFrom.append($('<input type="hidden"  name="reportType" value="${commonParams.checkType}" />'));
			freshFrom.appendTo("body");
			freshFrom.css('display','none');
			freshFrom.attr("method","post");
			freshFrom.attr("action","${basePath}mobileApp/medicalcard/family/toView");
			freshFrom.submit();
	}
	
	function doGoBack()
	{
		window.location.href="${basePath}mobileApp/medicalcard/family/hospitalList?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng";
	}
</script>
</html>