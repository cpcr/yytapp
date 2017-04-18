<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<title>报告查询</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
	<div id="payRecord">
        <div class="screeningBox">
            <ul class="yx-list">
                <li class="flex">
                    <div class="flexItem">
                        <label><span class="text" id="family" data-id="" data-userId=""></span>
                        <select name="familyFilter" id="familyFilter" class="select-screen-box" onchange="selectScreening(this); changeFamily(this); setOwnership(this)">
                            <#list families as item>
                            <option value="${item.id}" ownership="${item.ownership}" userId="${item.userId}">${item.encryptedName}(<#if item.ownership != 3>${item.encryptedIdNo}<#else>儿童</#if>)</option>
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
                </li>
            </ul>
        </div>
        <div class="space15"></div>
        
        <div class="section" id="reportContent">
            <ul class="yx-list js-tagContent show noBorder" style="display: none;" id="reportList">
               
            </ul>
            
            <div class="noRecord" id="noRecord" style="display: none;">
		        <div id="success">
		            <div class="noticeEmpty"></div>
		            <div class="p color666">已关联的医院中，没有查询到您的任何报告项目</div>
		        </div>
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
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
	<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
	<input type="hidden" id="familyId" name="familyId" value="">
	<input type="hidden" id="reportType" name="reportType" value="1">
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="" />
	<input type="hidden" id="hospitalId" name="hospitalId" value="">
	<input type="hidden" id="hospitalName" name="hospitalName" value="" />
	<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="" />
	<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="" />
	<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="" />
	<input type="hidden" id="patCardType" name="patCardType" value="" />
	<input type="hidden" id="patCardNo" name="patCardNo" value="" />
	<input type="hidden" id="detailId" name="detailId" value="" />
	<input type="hidden" id="admissionNo" name="admissionNo" value="" />
	<input type="hidden" id="doctorName" name="doctorName" value="" />
	<input type="hidden" id="deptName" name="deptName" value="" />
	<input type="hidden" id="reportTime" name="reportTime" value="" />
	<input type="hidden" id="executeTime" name="executeTime" value="" />
	<input type="hidden" id="patCardName" name="patCardName" value="" />
	<input type="hidden" id="checkType" name="checkType" value="" />
	<input type="hidden" id="idNo" name="idNo" value="" />
	<input type="hidden" id="fileAddress" name="fileAddress" value="" />
	<#--
	<input type="hidden" id="forwardUrl" name="forwardUrl" value="${basePath}easyhealth/report/reportIndex" />
	-->
	<input type="hidden" id="syncType" name="syncType" value="">
</form>
	<input type="hidden" id="moduleName" name="moduleName" value="报告" />
<input type="hidden" id="cardsList" name="cardsList" value="${cardsList}" />
<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script src="${basePath}easyhealth/js/biz/commonQuery/eh.commonQuery.js?v=1.65" type="text/javascript"></script>
<script>
function getAllCardsNew() {
    var cardsList = eval('${cardsList}');
    if (cardsList && cardsList.length > 0) {
        cards = cardsList;
        // 过滤数据
        var cardNo = $('#cardNo').val();
        var hospitalCode = $('#hospitalCode').val();
        if (cardNo && cardNo!='' && hospitalCode && hospitalCode!='') {
            filterCardByCardNoAndHospitalCode();
            getAllCardsAfter();
        } else {
            loadLastHospital($("#familyFilter").find("option:selected").attr("userId"));
        }
    } else {
        showHasNoCard();
    }
}

    var globalMark = '';
    var hasDate = 'false';
    function loadData() {
        globalMark = new Date().getTime();
        hasDate = 'false';
        $Y.loading.show('正在加载数据...');
        for(var i=0;i<selectCards.length;i++) {
           batchLoadData(selectCards[i], globalMark, i);
        }       
    }
    
    function afterLoadData() {
        if(hasDate != 'true') {
           showHasNoData();
        }
    }
    
    function batchLoadData(scards, mark, fornum) {
    	var datas = $('#voForm').serializeArray();
    	var cards = {};
    	cards.name = "cards";
    	cards.value = "["+JSON.stringify(scards)+"]";
    	datas.push(cards);
    	var marks = {};
        marks.name = "mark";
        marks.value = mark;
        datas.push(marks);
        
    	$Y.loading.show('正在加载数据...');
		$.ajax({
			type: "POST",
			url: "${basePath}easyhealth/report/getReportList",
			data: datas,
			cache: false, 
			dataType: "json", 
			timeout: 600000,
			error: function(data) {
				$Y.loading.hide();
				console.log('加载待缴费数据异常');
				if(hasDate!='true') {
                    hasDate = 'false';
                    if((fornum+1) == selectCards.length) {
                        afterLoadData();
                    }
                }
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				if (data.status == 'OK' && data.message && data.message.entityList && data.message.entityList.length > 0) {
					if(data.message.mark == globalMark) {
					   hasDate = 'true';
    				    formatList(data.message.entityList);
					}
				} else {
					if(hasDate!='true') {
                        hasDate = 'false';
                        if((fornum+1) == selectCards.length) {
                            afterLoadData();
                        }
                    }
				}
			}
		})
    }
    
    function formatList(data) {
        var sHtml = '';
        
        $.each(data, function(i, item) {
            $.each(item.entityList, function(j, detail) {
                if(item.reportType == 1) {
                    sHtml += '<li onclick="showDetails(this);" class="arrow" ' + 
                         ' data-idNo="' + getValue(item.idNo) + '"' +
                         ' data-hospitalCode="' + getValue(item.hospitalCode) + '"' +
                         ' data-hospitalName="' + getValue(item.hospitalName) + '"' +
                         ' data-hospitalId="' + getValue(item.hospitalId) + '"' +
                         ' data-branchCode="' + getValue(item.branchCode) + '"' +
                         ' data-branchName="' + getValue(item.branchName) + '"' +
                         ' data-branchId="' + getValue(item.branchId) + '"' +
                         ' data-branchId="' + getValue(item.branchId) + '"' +
                         ' data-patCardType="' + getValue(item.patCardType) + '"' +
                         ' data-patCardNo="' + getValue(item.patCardNo) + '"' +
                         ' data-patCardName="' + getValue(item.patCardName) + '"' +
                         ' data-doctor="' + getValue(detail.inspectDoctor) + '"' +
                         ' data-reportTime="' + getValue(detail.reportTime) + '"' +
                         ' data-id="' + getValue(detail.inspectId) + '"' +
                         ' data-dept="' + getValue(detail.deptName) + '"' +
                         ' data-fileAddress="' + getValue(detail.fileAddress) + '"' +
                         ' data-reportType="' + getValue(item.reportType) + '"' +
                         ' data-executeTime="' + getValue(detail.provingTime) + '">';
                    sHtml += '  <div class="title">' + getValue(detail.inspectName) + '</div>';
                    sHtml += '  <div class="mate color999">' + detail.reportTime + '</div>';
                    sHtml += '  <div class="mate color999">' + getValue(item.hospitalName) + '</div>';
                    sHtml += '</li>';
                } else if(item.reportType == 2) {
                    sHtml += '<li onclick="showDetails(this);" class="arrow" ' + 
                         ' data-idNo="' + getValue(item.idNo) + '"' +
                         ' data-hospitalCode="' + getValue(item.hospitalCode) + '"' +
                         ' data-hospitalName="' + getValue(item.hospitalName) + '"' +
                         ' data-hospitalId="' + getValue(item.hospitalId) + '"' +
                         ' data-branchCode="' + getValue(item.branchCode) + '"' +
                         ' data-branchName="' + getValue(item.branchName) + '"' +
                         ' data-branchId="' + getValue(item.branchId) + '"' +
                         ' data-branchId="' + getValue(item.branchId) + '"' +
                         ' data-patCardType="' + getValue(item.patCardType) + '"' +
                         ' data-patCardNo="' + getValue(item.patCardNo) + '"' +
                         ' data-patCardName="' + getValue(item.patCardName) + '"' +
                         ' data-doctor="' + getValue(detail.doctorName) + '"' +
                         ' data-reportTime="' + getValue(detail.reportTime) + '"' +
                         ' data-id="' + getValue(detail.checkId) + '"' +
                         ' data-dept="' + getValue(detail.deptName) + '"' +
                         ' data-executeTime="' + getValue(detail.checkTime) + '"' +
                         ' data-fileAddress="' + getValue(detail.fileAddress) + '"' +
                         ' data-reportType="' + getValue(item.reportType) + '"' +
                         ' data-checkType="' + getValue(detail.checkType) + '">';
                    sHtml += '  <div class="title">' + getValue(detail.checkName) + '</div>';
                    sHtml += '  <div class="mate color999">' + detail.reportTime + '</div>';
                    sHtml += '  <div class="mate color999">' + getValue(item.hospitalName) + '</div>';
                    sHtml += '</li>';
                }
            });
        });
        
        $('#reportList').append(sHtml);
        showHasData();
    }
    
    function formatInspectList(data) {
    	var sHtml = '';
    	
    	$.each(data, function(i, item) {
    		$.each(item.entityList, function(j, detail) {
    			sHtml += '<li onclick="showDetails(this);" class="arrow" ' + 
    					 ' data-idNo="' + getValue(item.idNo) + '"' +
    					 ' data-hospitalCode="' + getValue(item.hospitalCode) + '"' +
    					 ' data-hospitalName="' + getValue(item.hospitalName) + '"' +
    					 ' data-hospitalId="' + getValue(item.hospitalId) + '"' +
    					 ' data-branchCode="' + getValue(item.branchCode) + '"' +
    					 ' data-branchName="' + getValue(item.branchName) + '"' +
    					 ' data-branchId="' + getValue(item.branchId) + '"' +
    					 ' data-branchId="' + getValue(item.branchId) + '"' +
    					 ' data-patCardType="' + getValue(item.patCardType) + '"' +
    					 ' data-patCardNo="' + getValue(item.patCardNo) + '"' +
    					 ' data-patCardName="' + getValue(item.patCardName) + '"' +
    					 ' data-doctor="' + getValue(detail.doctorName) + '"' +
    					 ' data-reportTime="' + getValue(detail.reportTime) + '"' +
    					 ' data-id="' + getValue(detail.inspectId) + '"' +
    					 ' data-dept="' + getValue(detail.deptName) + '"' +
    					 ' data-fileAddress="' + getValue(detail.fileAddress) + '"' +
    					 ' data-executeTime="' + getValue(detail.provingTime) + '">';
                sHtml += '	<div class="title">' + getValue(detail.inspectName) + '</div>';
                sHtml += '	<div class="mate color999">' + detail.reportTime.substring(0, 10) + '</div>';
                sHtml += '	<div class="mate color999">' + getValue(item.hospitalName) + '</div>';
                sHtml += '</li>';
    		});
    	});
    	
    	$('#reportList').append(sHtml);
    	showHasData();
    }
    
    function formatExamineList(data) {
    	var sHtml = '';
    	
    	$.each(data, function(i, item) {
    		$.each(item.entityList, function(j, detail) {
    			sHtml += '<li onclick="showDetails(this);" class="arrow" ' + 
    					 ' data-idNo="' + getValue(item.idNo) + '"' +
    					 ' data-hospitalCode="' + getValue(item.hospitalCode) + '"' +
    					 ' data-hospitalName="' + getValue(item.hospitalName) + '"' +
    					 ' data-hospitalId="' + getValue(item.hospitalId) + '"' +
    					 ' data-branchCode="' + getValue(item.branchCode) + '"' +
    					 ' data-branchName="' + getValue(item.branchName) + '"' +
    					 ' data-branchId="' + getValue(item.branchId) + '"' +
    					 ' data-branchId="' + getValue(item.branchId) + '"' +
    					 ' data-patCardType="' + getValue(item.patCardType) + '"' +
    					 ' data-patCardNo="' + getValue(item.patCardNo) + '"' +
    					 ' data-patCardName="' + getValue(item.patCardName) + '"' +
    					 ' data-doctor="' + getValue(detail.doctorName) + '"' +
    					 ' data-reportTime="' + getValue(detail.reportTime) + '"' +
    					 ' data-id="' + getValue(detail.checkId) + '"' +
    					 ' data-dept="' + getValue(detail.deptName) + '"' +
    					 ' data-executeTime="' + getValue(detail.checkTime) + '"' +
    					 ' data-fileAddress="' + getValue(detail.fileAddress) + '"' +
    					 ' data-checkType="' + getValue(detail.checkType) + '">';
                sHtml += '	<div class="title">' + getValue(detail.checkName) + '</div>';
                sHtml += '	<div class="mate color999">' + detail.reportTime.substring(0, 10) + '</div>';
                sHtml += '	<div class="mate color999">' + getValue(item.hospitalName) + '</div>';
                sHtml += '</li>';
    		});
    	});
    	
    	$('#reportList').append(sHtml);
    	showHasData();
    }
    
    function showDetails(obj) {
     	// 具体的就诊卡信息
    	$("#idNo").val($(obj).attr('data-idNo'));
    	$("#hospitalCode").val($(obj).attr('data-hospitalCode'));
    	$("#hospitalName").val($(obj).attr('data-hospitalName'));
    	$("#hospitalId").val($(obj).attr('data-hospitalId'));
    	$("#branchHospitalCode").val($(obj).attr('data-branchCode'));
    	$("#branchHospitalName").val($(obj).attr('data-branchName'));
    	$("#branchHospitalId").val($(obj).attr('data-branchId'));
    	$("#patCardType").val($(obj).attr('data-patCardType'));
    	$("#patCardNo").val($(obj).attr('data-patCardNo'));
    	$("#patCardName").val($(obj).attr('data-patCardName'));
    	// 展示信息
    	$("#doctorName").val($(obj).attr('data-doctor'));
		$("#reportTime").val($(obj).attr('data-reportTime'));
		$("#detailId").val($(obj).attr('data-id'));
		$("#deptName").val($(obj).attr('data-dept'));
		$("#executeTime").val($(obj).attr('data-executeTime'));
		$("#checkType").val($(obj).attr('data-checkType'));
		$("#fileAddress").val($(obj).attr('data-fileAddress'));
		$("#reportType").val($(obj).attr('data-reportType'));
		
		$("#voForm").attr("action" , '${basePath}/mobileApp/reports/reportDetail');
   		$("#voForm").submit();
    }
    
    function showHasNoCard() {
    	$('#noFamily').show();
		$('#reportContent').hide();
    }
    
    function showHasNoData() {
    	$('#noFamily').hide();
		$('#reportContent').show();
		$('#reportList').hide();
		$('#noRecord').show();
    }
    
    function showHasData() {
    	$('#noFamily').hide();
		$('#reportContent').show();
		$('#reportList').show();
		$('#noRecord').hide();
    }
    
    function loadingData() {
    	$('#noRecord').hide();
    	$('#noFamily').hide();
		$('#reportContent').show();
		$('#reportList').hide();
		
		$('#reportList').html('');
    }
    
    // 刷新方法
	function doRefresh() {
		$('#voForm').attr('action', '${basePath}easyhealth/report/reportIndex');
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
	
	function setOwnership(obj) {
       var ownership = $(obj).find("option:selected").attr("ownership");
       if(ownership != "1") {
           $('#syncType').val("2");
       } else {
           $('#syncType').val("1");
       }
    }
</script>
<script type="text/javascript" src="${basePath}easyhealth/js/common/nav-list.js"></script>
