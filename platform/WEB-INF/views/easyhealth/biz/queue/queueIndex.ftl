<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<title>排队候诊</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
	<div>
        <div class="screeningBox">
            <ul class="yx-list">
                <li class="flex">
                    <div class="flexItem">
                        <label><span class="text" id="family" data-id=""></span>
                        <select name="familyFilter" id="familyFilter" class="select-screen-box" onchange="selectScreening(this); changeFamily(this);">
                            <#list families as item>
                            <option value="${item.id}">${item.encryptedName}(<#if item.ownership != 3>${item.encryptedIdNo}<#else>儿童</#if>)</option>
                            </#list>
                        </select>
                            <i class="iconfont"></i>
                        </label>
                    </div>
                    <div class="flexItem">
                        <label><span class="text" id="hospital" data-id=""></span>
                        <select name="hospitalFilter" id="hospitalFilter" class="select-screen-box" onchange="selectScreening(this); changeHospital(this);">
                            <option value="0">全部医院</option>
                            <#list hospitals as item>
                            <option value="${item.hospitalCode}">${item.hospitalName}</option>
                            </#list>
                        </select>
                            <i class="iconfont"></i>
                        </label>
                    </div>
                    <div class="flexItem">
                        <label><span class="text" id="queue" data-id=""></span>
                        <select name="queueFilter" id="queueFilter" class="select-screen-box" onchange="selectScreening(this); changeQueueType(this);">
                            <option value="1">候诊排队</option>
                            <option value="2">检查排队</option>
                            <option value="3">取药排队</option>
                        </select>
                            <i class="iconfont"></i>
                        </label>
                    </div>
                </li>
            </ul>
        </div>
        <div class="space15"></div>
        
        <ul class="yx-list fourList" style="display: none;" id="paymentList">
               
            </ul>
            
            <div class="noRecord" id="noRecord" style="display: none;">
		        <div id="success">
		            <div class="noticeEmpty"></div>
		            <div class="p color666">已关联的医院中，没有查询到您的任何排队信息</div>
		        </div>
		    </div>
        
        <div class="noFamily" id="noFamily" style="display: none;">
	        <div id="success">
	            <div class="noData"></div>
	            <div class="p color666" id="noCardTips"></div>
	        </div>
	        <div class="btn-w">
	            <div class="btn btn-ok btn-block" id="sync" onclick="syncCard();">关联</div>
	        </div>
	    </div>
	    <#--
	    <div class="btn-w">
	    	<div class="btn btn-ok btn-block" onclick="doGoBack();">返回</div>
	    	<div class="btn btn-ok btn-block" onclick="doRefresh();">刷新</div>
	    </div>
	    -->
    </div>
</div>
<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
	<input type="hidden" id="appId" name="appId" value="">
	<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
	<input type="hidden" id="familyId" name="familyId" value="">
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="" />
	<input type="hidden" id="hospitalId" name="hospitalId" value="">
	<input type="hidden" id="hospitalName" name="hospitalName" value="" />
	<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="" />
	<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="" />
	<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="" />
	<input type="hidden" id="patCardType" name="patCardType" value="" />
	<input type="hidden" id="patCardName" name="patCardName" value="" />
	<input type="hidden" id="patCardNo" name="patCardNo" value="" />
	<input type="hidden" id="queueType" name="queueType" value="" />
	<input type="hidden" id="patientMobile" name="patientMobile" value="" />
	<#--
	<input type="hidden" id="forwardUrl" name="forwardUrl" value="${basePath}easyhealth/queue/index" />
	-->
</form>
	<input type="hidden" id="moduleName" name="moduleName" value="排队" />

<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script src="${basePath}easyhealth/js/biz/commonQuery/eh.commonQuery.js?v=1.31" type="text/javascript"></script>
<script>
    function changeQueueType(obj) {
   		if (selectCards && selectCards.length > 0) {
   			$('#queueType').val($('#queue').attr('data-id'));
    		loadingData();
    		// 加载数据
    		loadData();
    	} else {
    		showHasNoCard();
    	}
    }
    
    function loadData() {
    	var queueType = $('#queue').attr('data-id');
    	$('#queueType').val(queueType);
    	var datas = $('#voForm').serializeArray();
    	var cards = {};
    	cards.name = "cards";
    	cards.value = JSON.stringify(selectCards);
    	datas.push(cards);
    	
    	$Y.loading.show('正在加载数据...');
		$.ajax({
			type: "POST",
			url: "${basePath}easyhealth/queue/getQueueList",
			data: datas,
			cache: false, 
			dataType: "json", 
			timeout: 600000,
			error: function(data) {
				$Y.loading.hide();
				console.log('加载排队数据异常');
				showHasNoData();
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				if (data.status == 'OK' && data.message && data.message.entityList && data.message.entityList.length > 0) {
					if (queueType == '1') {
						// 门诊候诊
						formatMzQueueData(data.message.entityList);
					} else if (queueType == '2') {
					 	// 检查排队
					 	formatExamineQueueData(data.message.entityList);
					} else if (queueType == '3') {
						// 取药排队
						formatMedicineQueueData(data.message.entityList);
					} else {
						// 暂时没有
					}
				} else {
					showHasNoData();
				}
			}
		})
		
    }
    
    function formatMzQueueData(data) {
    	var sHtml = '';
    	
    	$.each(data, function(i, item) {
    		$.each(item.entityList, function(j, detail) {
    			sHtml += '<div class="houzhen-wrap">';
            	sHtml += '	<div class="houzhen-infoList">';
                sHtml += '		<ul class="yx-list">';
                sHtml += '			<li>';
                sHtml += '				<div class="label">您前面还有</div>';
                sHtml += '				<div class="values"><span>' + (getValue(detail.frontNum)?getValue(detail.frontNum):'---') + '</span>人</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">正在就诊</div>';
                sHtml += '				<div class="values blue">' + (getValue(detail.currentNum)?getValue(detail.currentNum):'---') + '号</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">排队号</div>';
                sHtml += '				<div class="values"><span>' + (getValue(detail.serialNum)?getValue(detail.serialNum):'---') + '</span>号</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">候诊时间</div>';
                sHtml += '				<div class="values">请提前30分钟到医院就诊</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">就诊医生</div>';
                sHtml += '				<div class="values">' + (getValue(detail.doctorName)?getValue(detail.doctorName):'---') + '</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">就诊科室</div>';
                sHtml += '				<div class="values">' + (getValue(detail.deptName)?getValue(detail.deptName):'---') + '</div>';
                sHtml += '			</li>';
                sHtml += '		</ul>';
            	sHtml += '	</div>';
        		sHtml += '</div>';
    		});
    	});
    	
    	if (sHtml) {
    		sHtml += '<div class="btn-w">';
            sHtml += '	<div class="btn btn-ok btn-block" onclick="refreshQueue();">刷新排队进度</div>';
        	sHtml += '</div>';
    	}
    	
    	$('#paymentList').append(sHtml);
    	showHasData();
    }
    
    function formatExamineQueueData(data) {
    	var sHtml = '';
    	
    	$.each(data, function(i, item) {
    		$.each(item.entityList, function(j, detail) {
    			sHtml += '<div class="houzhen-wrap">';
            	sHtml += '	<div class="houzhen-infoList">';
                sHtml += '		<ul class="yx-list">';
                sHtml += '			<li>';
                sHtml += '				<div class="label">您前面还有</div>';
                sHtml += '				<div class="values"><span>' + (getValue(detail.frontNum)?getValue(detail.frontNum):'---') + '</span>人</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">正在就诊</div>';
                sHtml += '				<div class="values blue">' + (getValue(detail.currentNum)?getValue(detail.currentNum):'---') + '号</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">排队号</div>';
                sHtml += '				<div class="values"><span>' + (getValue(detail.serialNum)?getValue(detail.serialNum):'---') + '</span>号</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">名称</div>';
                sHtml += '				<div class="values">' + (getValue(detail.checkName)?getValue(detail.checkName):'---') + '</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">执行科室</div>';
                sHtml += '				<div class="values">' + (getValue(detail.deptName)?getValue(detail.deptName):'---') + '</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">科室地址</div>';
                sHtml += '				<div class="values">' + (getValue(detail.deptLocation)?getValue(detail.deptLocation):'---') + '</div>';
                sHtml += '			</li>';
                sHtml += '		</ul>';
            	sHtml += '	</div>';
        		sHtml += '</div>';
    		});
    	});
    	
    	if (sHtml) {
    		sHtml += '<div class="btn-w">';
            sHtml += '	<div class="btn btn-ok btn-block" onclick="refreshQueue();">刷新排队进度</div>';
        	sHtml += '</div>';
    	}
    	
    	$('#paymentList').append(sHtml);
    	showHasData();
    }
    
    function formatMedicineQueueData(data) {
    	var sHtml = '';
    	
    	$.each(data, function(i, item) {
    		$.each(item.entityList, function(j, detail) {
    			sHtml += '<div class="houzhen-wrap">';
            	sHtml += '	<div class="houzhen-infoList">';
                sHtml += '		<ul class="yx-list">';
                sHtml += '			<li>';
                sHtml += '				<div class="label">您前面还有</div>';
                sHtml += '				<div class="values"><span>' + (getValue(detail.frontNum)?getValue(detail.frontNum):'---') + '</span>人</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">正在就诊</div>';
                sHtml += '				<div class="values blue">' + (getValue(detail.currentNum)?getValue(detail.currentNum):'---') + '号</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">排队号</div>';
                sHtml += '				<div class="values"><span>' + (getValue(detail.serialNum)? getValue(detail.serialNum):'---') + '</span>号</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">药房名称</div>';
                sHtml += '				<div class="values">' + (getValue(detail.pharmacy)?getValue(detail.pharmacy):'---') + '</div>';
                sHtml += '			</li>';
                sHtml += '			<li>';
                sHtml += '				<div class="label">药房地点</div>';
                sHtml += '				<div class="values">' + (getValue(detail.localtion)?getValue(detail.localtion):'---') + '</div>';
                sHtml += '			</li>';
                sHtml += '		</ul>';
            	sHtml += '	</div>';
        		sHtml += '</div>';
    		});
    	});
    	
    	if (sHtml) {
    		sHtml += '<div class="btn-w">';
            sHtml += '	<div class="btn btn-ok btn-block" onclick="refreshQueue();">刷新排队进度</div>';
        	sHtml += '</div>';
    	}
    	
    	$('#paymentList').append(sHtml);
    	showHasData();
    }
    
    function getValue(data) {
		if (!data || data == 'null') {
			data = '';
		}
		return data;
	}
    
	function refreshQueue() {
		loadingData();
		loadData();
	}    
    
    function showDetails(obj) {
    	obj = $(obj).parent();
     	// 具体的就诊卡信息
    	$("#patientMobile").val($(obj).attr('data-patMobile'));
    	$("#hospitalCode").val($(obj).attr('data-hospitalCode'));
    	$("#hospitalName").val($(obj).attr('data-hospitalName'));
    	$("#hospitalId").val($(obj).attr('data-hospitalId'));
    	$("#branchHospitalCode").val($(obj).attr('data-branchCode'));
    	$("#branchHospitalName").val($(obj).attr('data-branchName'));
    	$("#branchHospitalId").val($(obj).attr('data-branchId'));
    	$("#cardType").val($(obj).attr('data-patCardType'));
    	$("#cardNo").val($(obj).attr('data-patCardNo'));
    	$("#patientName").val($(obj).attr('data-patCardName'));
    	// 展示信息
    	$("#doctorName").val($(obj).attr('data-doctor'));
		$("#mzFeeId").val($(obj).attr('data-id'));
		$("#deptName").val($(obj).attr('data-dept'));
		$("#totalFee").val($(obj).attr('data-total'));
		$("#payFee").val($(obj).attr('data-pay'));
		$("#medicareFee").val($(obj).attr('data-medicare'));
		$("#medicareType").val($(obj).attr('data-type'));
		
		$("#voForm").attr("action" , '${basePath}mobileApp/clinic/payDetail');
   		$("#voForm").submit();
    }
    
    function showHasNoCard() {
    	$('#noFamily').show();
    	$('#paymentList').hide();
		$('#noRecord').hide();
    }
    
    function showHasNoData() {
    	$('#noFamily').hide();
		$('#paymentList').hide();
		$('#noRecord').show();
    }
    
    function showHasData() {
    	$('#noFamily').hide();
		$('#paymentList').show();
		$('#noRecord').hide();
    }
    
    function loadingData() {
    	$('#noRecord').hide();
    	$('#noFamily').hide();
		$('#paymentList').hide();
		
		$('#paymentList').html('');
    }
    
	// 刷新方法
	function doRefresh() {
		$('#voForm').attr('action', '${basePath}easyhealth/queue/index');
		$('#voForm').submit();
	}
	
	// 返回方法
	function doGoBack() {
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
	
	$(function(){
		$("#hospitalFilter option").each(function(){
		   if($(this).val() == '${commonParams.hospitalCode}'){
			  $('#hospital').attr('data-id','${commonParams.hospitalCode}');
			  $('#hospital').text($(this).text());
		   }
		});
	});
</script>
<script type="text/javascript" src="${basePath}easyhealth/js/common/nav-list.js"></script>
