function getValue(data) {
	if (data && data != 'null') {
		return data;
	} else {
	 	return "";
	}
}

function syncCard() {
	var hospital=$('#hospital').html();
	if(hospital && hospital!='全部医院'){
		$('#hospitalName').val(hospital);
	}
	$('#voForm').attr('action', appPath + 'easyhealth/usercenter/syncCard/index');
	$('#voForm').submit();
	// 需要调用壳的方法，使用goUrl的方式来打开。
	//go(appPath + 'easyhealth/usercenter/syncCard/index?openId=' + $('#openId').val() + '&appCode=alipay&areaCode=ShenZheng&syncType=2&familyId=' + $('#familyId').val(),true);
}

var cards = {};
var selectCards = [];

$(function() {
	$.each($('select'), function(i, item) {
		var sText = $(item).find("option:selected").text();
		var obj = $(item).parent().find('.text');
		$(obj).text(sText);
		$(obj).attr('data-id', $(item).val());
		
		if ($(obj).attr('id') == 'family') {
			//$('#noCardTips').text(sText + '还没有关联医院就诊卡信息，无法查询' + $('#moduleName').val() + '信息，请先去关联医院就诊卡信息，或者切换其他就诊人查询。');
			$('#noCardTips').text('请先绑定就诊卡');
			$('#familyId').val($(item).val());
		}
	});
	
	$('#reportType').val(1);
	//getAllCards();
	getAllCardsNew();
});

function selectScreening(obj){
    var option = obj.children[obj.selectedIndex];
    var html = option.innerHTML;
    obj.previousElementSibling.innerHTML = html;
    $(obj.previousElementSibling).attr('data-id', $(option).val());
    
    if ($(obj).attr('name') == 'familyFilter') {
    	//$('#noCardTips').text(sText + '还没有关联医院就诊卡信息，无法查询' + $('#moduleName').val() + '信息，请先去关联医院就诊卡信息，或者切换其他就诊人查询。');
		$('#noCardTips').text('请先绑定就诊卡');
		$('#familyId').val($(option).val());
	}
}

function getAllCards() {
	$Y.loading.show('正在初始化就诊卡信息...');
	$.ajax({
		type: "POST",
		url: appPath + "mobileApp/common/findCardsForEasyHealth",
		data: {
			openId: $('#openId').val()
		},
		cache: false, 
		dataType: "json", 
		timeout: 600000,
		error: function(data) {
			$Y.loading.hide();
			console.log('获取就诊卡异常');
			showHasNoCard();
		},
		success: function(data) {
			$Y.loading.hide();
			console.log(data);
			if (data.status == 'OK' && data.message && data.message.length > 0) {
				cards = data.message;
				// 过滤数据
				var cardNo = $('#cardNo').val();
				var hospitalCode = $('#hospitalCode').val();
				if (cardNo && cardNo!='' && hospitalCode && hospitalCode!='') {
					filterCardByCardNoAndHospitalCode();
					getAllCardsAfter();
				} else {
					var isFromNew = $('#isFromNew').val();
					if (isFromNew && isFromNew == 'false') {
						loadLastHospital($("#familyFilter").find("option:selected").attr("userId"));
					}
				}
			} else {
				showHasNoCard();
			}
		}
	})
}

function getAllCardsAfter() {
	// 加载数据
	var familyId = $('#family').attr('data-id');
	var hospitalCode = $('#hospital').attr('data-id');
	selectCards = findCards(familyId, hospitalCode);
	if (selectCards && selectCards.length > 0) {
		loadingData();
		loadData();
	} else {
		showHasNoCard();
	}
}

function loadLastHospital(userId) {
    $.ajax({
        type: "POST",
        url:  appPath + "easyhealth/clinic/getLastHospital",
        data: {
            userId: userId
        },
        cache: false, 
        dataType: "json", 
        timeout: 600000,
        error: function(data) {
            console.log('获取最后挂号医院异常');
            getAllCardsAfter();
        },
        success: function(data) {
            if (data.status == 'OK' && data.message && data.message.hospital) {
                var hospital = data.message.hospital;
                var obj = $("#hospitalFilter");
                obj.val(hospital.code);
                $('#hospital').text(hospital.name);
                $('#hospital').attr('data-id', hospital.code);
                changeHospital(obj);
            }
            getAllCardsAfter();
        }
    });
}

function filterCardByCardNoAndHospitalCode() {
	var cardNo = $('#cardNo').val();
	var hospitalCode = $('#hospitalCode').val();
	if (cardNo && hospitalCode) {
		// 需要指定医院指定到卡
		$.each(cards, function(i, item) {
			if (item.cardNo == cardNo && item.hospitalCode == hospitalCode) {
				// 家人
				var familyId = item.familyId;
				var familyOption = $('#familyFilter option[value="' + familyId + '"]');
				// familyOption.attr("selected", true);
				$('#familyFilter').val(familyId);
				$('#family').text(item.encryptedPatientName);
				$('#family').attr('data-id', familyId);
				$('#family').attr('data-userId', item.userId);
				
				// 医院
				var hospitalOption = $('#hospitalFilter option[value="' + hospitalCode + '"]');
				// hospitalOption.attr("selected", true);
				$('#hospitalFilter').val(hospitalCode);
				$('#hospital').text(item.hospitalName);
				$('#hospital').attr('data-id', hospitalCode);
				return;
			}
		});
	} else {
		return ;
	}
}

function findCards(familyId, hospitalCode) {
	var resultCards = [];
	if (hospitalCode == '0') {
		$.each(cards, function(i, item) {
			if (item.familyId == familyId) {
				// 还需要加一个判断，这个卡所在的医院是否支持这个操作... 			----2015-12-30
				var option = $('#hospitalFilter option[value="' + item.hospitalCode + '"]');
				if (option && option.length > 0) {
					resultCards.push(item);
				}
			}
		});
	} else {
		$.each(cards, function(i, item) {
			if (item.hospitalCode == hospitalCode && item.familyId == familyId) {
				resultCards.push(item);
			}
		});
	}
	
	return resultCards;
}

function changeHospital(obj) {
	var hospitalCode = $(obj).val();
	var familyId = $('#family').attr('data-id');
	var isClinic = $('#isClinic').val();
	var hospitalCode = $('#hospital').attr('data-id');
	if (isClinic && isClinic == 'true') {
		if(hospitalCode == 'szsdsrmyy' || hospitalCode == 'bjdxszyy' || hospitalCode == 'szsdermyy' || hospitalCode == 'xgdxszyy') {
			var query = "http://jky.yunyichina.cn/mobileApp/inpatient/redirect/waitPayList?appCode=alipay&appId=2015102000489434&orgAppCode=yyt48fe49dbe6eb1cee&hospitalCode="+hospitalCode;
		    location.replace(query);
		    return;
		}
	} 
	
	selectCards = findCards(familyId, hospitalCode);
	
	if (selectCards && selectCards.length > 0) {
		loadingData();
		// 加载数据
		loadData();
	} else {
		showHasNoCard();
	}
}

function changeFamily(obj) {
		var familyId = $(obj).val()
	var hospitalCode = $('#hospital').attr('data-id');
	
	selectCards = findCards(familyId, hospitalCode);
	
	if (selectCards && selectCards.length > 0) {
		loadingData();
		// 加载数据
		loadData();
	} else {
		showHasNoCard();
	}
}