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
		changeCardNoBySelectH($(this).attr('key'));
	});
});

$(function(){
	getCards();
});



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

function removeFamily() {
		// 跳往就诊人列表
		$Y.loading.show('正在移除就诊人...');
		var datas = $('#voForm').serializeArray();
		$.ajax({
			type: "POST",
			url: appPath+"easyhealth/usercenter/familyInfo/unbindFamily",
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
						$('#voForm').attr('action', appPath+'easyhealth/usercenter/myFamily/index');
						$('#voForm').submit();
					} else {
						showMessage(tips);
					}
				} else {
					showMessageBox('移除就诊人失败，请稍后重试。');
				}
			}
		});
}


function getCards() {
	$Y.loading.show('正在加载绑卡信息...');
	var datas = $('#voForm').serializeArray();
	$.ajax({
		type: "POST",
		url: appPath+"easyhealth/usercenter/familyInfo/getCards",
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
		sHtml += '<li onclick="showCardInfo(this);" medicalcardId="' + item.id + '">';
        sHtml += '	<p>' + item.cardNo + '</p>';
        sHtml += '	<p>' + item.hospitalName + '</p>';
        sHtml += '</li>';
	});
	var syncType=$('#syncType').val();
	if(syncType!='1'&&syncType!='3'){
		syncType='TR';
	}
	$('#cardList').html('');
	if(sHtml==''){
		$('#cardList').append('<li class="nothing">请添加就诊卡</li>');
	}else{
		$('#cardList').append(sHtml);
	}
}

function showCardInfo(obj) {
	$('#medicalcardId').val($(obj).attr('medicalcardId'));
	$('#voForm').attr('action', appPath+'easyhealth/usercenter/cardInfo/toView');
	$('#voForm').submit();
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
                	$('.addCard').addClass('none');
                	getCards();
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

function addCard(){
	 $('.addCard').removeClass('none');
	 clearCardData();
}

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

function fillCardNo(){
	
}


function clearCardData(){
	$('#hospitalLists').val('')
	$('#hospitalLists').attr('key','');
	$('#isCard').val('有');
	$('#isCard').attr('key','1');
	$('#idNum').parents('li').removeClass('none');
	$('#city').parents('li').addClass('none');
	$('#idNum').val('');
	$('#city').val('');
}

