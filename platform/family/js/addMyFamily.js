var isSaveFamily=false;
$(function(){
	$('#nav3Bir').date();
	getCards();

	//对Date的扩展，将 Date 转化为指定格式的String   
	//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
	//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
	//例子：   
	//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
	//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
	Date.prototype.Format = function(fmt)   
	{ //author: meizz   
	var o = {   
	 "M+" : this.getMonth()+1,                 //月份   
	 "d+" : this.getDate(),                    //日   
	 "h+" : this.getHours(),                   //小时   
	 "m+" : this.getMinutes(),                 //分   
	 "s+" : this.getSeconds(),                 //秒   
	 "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	 "S"  : this.getMilliseconds()             //毫秒   
	};   
	if(/(y+)/.test(fmt))   
	 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
	for(var k in o)   
	 if(new RegExp("("+ k +")").test(fmt))   
	fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	return fmt;   
	}  
});

// 信息不正确提示
function showIncorrectTip(data) {
	$Y.loading.hide();
	var tip = $('#inputIncorrectTip').val();
	if (!tip || tip.indexOf('%replace%') < 0) {
		tip = '您输入的%replace%不正确';
	}
	$Y.tips(tip.replace('%replace%', data));
}

function ajaxBindFamily(obj, data) {
	$Y.loading.show('正在为您进行绑定他人就诊人信息');
	return $.ajax({
		type: "POST",
		url: appPath+"easyhealth/usercenter/myFamily/add",
		data: data,
		cache: false, 
		dataType: "json", 
		timeout: 120000,
		error: function(data) {
			$Y.loading.hide();
			new $Y.confirm({
	            ok:{title:'确定'},
	            content:'网络超时，请稍后在我的就诊人查看绑定结果。'
	        });
			$(obj).attr('disabled', false);
		},
		success: function(data) {
			$Y.loading.hide();
			console.log(data);
			if (data.status == 'OK') {
				var code = data.message.isSuccess;
				if (code == 0 || data.message.hasOldFamily=='T') {
					// 挂号过来的话，跳回挂号页面
					var forward = $('#forward').val();
					if (forward) {
						$('#voForm').attr('action', forward);
					} else {
						$('#voForm').attr('action', appPath+'easyhealth/usercenter/myFamily/index');
					}
                    $Y.tips('添加成功！');
                    $('#voForm').submit();
				} else {
					$Y.tips(data.message.msgInfo);
					$(obj).attr('disabled', false);
				}
			}
		}
	});
}

//验证手机号码
function validateMobile(data) {
	var reg = /^1\d{10}$/;								// 1开头的号码
	return reg.exec(data);
}

//验证姓名
function validateName(data) {
	var reg = /^[a-zA-Z0-9\u4e00-\u9fa5]{1,30}$/;		// 30位大写，小写，数字，中文
	return reg.exec(data);
}

//验证身份证
function validateIdNo(data, type) {
	// 1：二代身份证  2：港澳居民身份证  3：台湾居民身份证 4：护照
	var result = false;
	switch (type) {
		case 1: 
			result = idCardUtils.validateIdNo(data);
			break;
		case 2:
			result = true;
			break;
		case 3:
			result = true;
			break;
		case 4:
			result = true;
			break;
	}
	return result;
}


function validateOther(obj){
	//$(obj).attr('disabled', true);
	var nav2rela=$('#nav2rela').attr('key');
	if(!nav2rela){
		showIncorrectTip("关系");
		return false;
	}
	
	var nav2Name=$('#nav2Name').val();
	if(!validateName(nav2Name)){
		showIncorrectTip("姓名");
		return false;
	}
	
	var idType2=$('#idType2').attr('key');
	if(!idType2){
		showIncorrectTip("证件类型");
		return false;
	}
	
	var nav2Id=$('#nav2Id').val();
	if(!validateIdNo(nav2Id,parseInt(idType2))){
		showIncorrectTip("证件号码");
		return false;
	}
	
	var nav2Phone=$('#nav2Phone').val();
	if(!validateMobile(nav2Phone)){
		showIncorrectTip("手机号码");
		return false;
	}

	if(idType2==2){
		var nav2Sex=$('#nav2Sex').attr('key');
		// alert("nav2Sex: "+nav2Sex);
		if(nav2Sex != 1 && nav2Sex != 2){
			showIncorrectTip("性别");
			return false;
		}


		var nav2Bir=$('#nav2Bir').val();
		var yearx = nav2Bir.substr(0,4);
		var monthx = nav2Bir.substr(4,2);
		var dayx = nav2Bir.substr(6,2);

		if(nav2Bir.length>8){
			showIncorrectTip("出生日期");
			return false;
		}
		var patt1=new RegExp("(19[0-9][0-9])|(2[0-9][0-9][0-9])|(18[89][0-9])");
		if(!patt1.test(yearx)){
			showIncorrectTip("出生年");
			return false;
		}
		var patt2=new RegExp("(^0[1-9]$)|(^1[0-2]$)");
		if(!patt2.test(monthx)){
			showIncorrectTip("出生月");
			return false;
		}
		var patt3=new RegExp("(^0[1-9]$)|(^1[0-9]$)|(^2[0-9])|(^3[01]$)");
		if(!patt3.test(dayx)){
			showIncorrectTip("出生日");
			return false;
		}
		var patt4=new RegExp("(^0[13578]$)|(^1[02]$)");
		if(!patt4.test(monthx)){
			if(monthx=='02'){
				if(yearx%4==0) {
					if(dayx=='30'||dayx=='31') {
						showIncorrectTip("出生年月");
						return false;
					}
				}else{
					if(dayx=='29'||dayx=='30'||dayx=='31'){
						showIncorrectTip("出生年月");
						return false;
					}
				}
			}else if(dayx=='31'){
				showIncorrectTip("出生年月");
				return false;
			}
		}
		nav2Bir = yearx + '-' + monthx + '-'+dayx;

		var year_now  = new Date().getFullYear();
		var month_now  = new Date().getMonth() + 1;
		var day_now  = new Date().getDate();

		if(year_now-yearx<=0 ){
			if(month_now-monthx<=0){
				if(day_now-dayx<0){
					showIncorrectTip("出生年月");
					return false;
				}
			}
		}

		var nav2Age = year_now - yearx;
	}
	
	var data = {
		appCode: $('input[name="appCode"]').val(),
		areaCode: $('input[name="areaCode"]').val(),
		openId: $('input[name="openId"]').val(),
		userId: $('input[name="userId"]').val(),
		name: nav2Name,
		mobile: nav2Phone,
		idType: idType2,
		idNo: nav2Id,
		birth: nav2Bir,
		sex: nav2Sex,
		address: '',
		ownership: nav2rela,
		codeType: '',
		age: nav2Age
	};
	return data;
}


function bindOther(obj){
	if(isSaveFamily){
		$('#voForm').attr('action', appPath+'easyhealth/usercenter/myFamily/index');
		$('#voForm').submit();
		return;
	}
	var flag=validateOther(obj);
	if(flag){
		ajaxBindFamily(obj,flag);
	}else{
		$(obj).attr('disabled', false);
	}
}

function validateChild(obj){
	$(obj).attr('disabled', true);
	var nav3Name=$('#nav3Name').val();
	if(!validateName(nav3Name)){
		showIncorrectTip("姓名");
		return false;
	}
	
	var nav3Sex=$('#nav3Sex').val();
	if(nav3Sex){
		if(nav3Sex=='男'){
			nav3Sex='1';
		}else{
			nav3Sex='2';
		}
	}else{
		showIncorrectTip("性别");
		return false;
	}
	
	var nav3Bir=$('#nav3Bir').val();
	
	if(!nav3Bir||nav3Bir==null||nav3Bir==''){
		showIncorrectTip("出生日期");
		return false;
	}

	var nowDate=new Date().Format("yyyy-MM-dd");
	if(nowDate<=nav3Bir){
		$Y.tips('出生日期在当前日期之后');
		return false;
	}
	
	var nav3PName=$('#nav3PName').val();
	if(!validateName(nav3PName)){
		showIncorrectTip("监护人姓名");
		return false;
	}
	
	var idType3=$('#idType3').attr('key');
	if(!idType3){
		showIncorrectTip("证件类型");
		return false;
	}
	
	var nav3PId=$('#nav3PId').val();
	if(!validateIdNo(nav3PId,parseInt(idType3))){
		showIncorrectTip("证件号码");
		return false;
	}
	
	var nav3PPhone=$('#nav3PPhone').val();
	if(!validateMobile(nav3PPhone)){
		showIncorrectTip("手机号码");
		return false;
	}

	var data = {
			appCode: $('input[name="appCode"]').val(),
			areaCode: $('input[name="areaCode"]').val(),
			openId: $('input[name="openId"]').val(),
			userId:$('input[name="userId"]').val(),
			name:nav3Name,
			idType: '',
			idNo: '',
			birth: nav3Bir,
			sex: nav3Sex,
			address: '',
			ownership: '3',
			guardName: nav3PName,
			guardIdType: idType3,
			guardIdNo: nav3PId,
			guardMobile: nav3PPhone,
			verifyCode: '',
			codeType: ''
	};
	return data;
}

function bindChild(obj){
	var data=validateChild(obj);
	if(data){
		ajaxBindFamily(obj,data);
	}else{
		$(obj).attr('disabled', false);
	}
}


function ajaxBindFamilyBeforeCard(data){
	isSaveFamily=false;
	var thisownership=data.ownership;
	//添加完就诊人后就进行绑卡操作
	$.ajax({
		type: "POST",
		url: appPath+"easyhealth/usercenter/myFamily/add",
		data: data,
		cache: false, 
		dataType: "json", 
		timeout: 120000,
		error: function(data) {
			$Y.loading.hide();
			new $Y.confirm({
	            ok:{title:'确定'},
	            content:'网络超时，请稍后在我的就诊人查看绑定结果。'
	        });
			$(obj).attr('disabled', false);
		},
		success: function(data) {
			$Y.loading.hide();
			console.log(data);
			if (data.status == 'OK') {
				var code = data.message.isSuccess;
				if (code == 0) {
					//设置新添加的就诊人ID
					$('#familyId').val(data.message.entity.id);
					$('.addCard').removeClass('none');
					if(thisownership==2||thisownership==4||thisownership==5||thisownership==6){
						disabledTrInput();
					}
				} else {
					if(data.message.hasOldFamily=='T'){
						$('#familyId').val(data.message.oldFamilyId);
						$('.addCard').removeClass('none');
						if(thisownership==2||thisownership==4||thisownership==5||thisownership==6){
							disabledTrInput();
						}
					}else{
						$Y.tips(data.message.msgInfo);
					}
				}
			}
		}
	});
}

function disabledTrInput(){
	isSaveFamily=true;
	$('#nav2rela').attr("disabled","disabled");
	$('#nav2rela').attr('style','background: #fff; color: #ccc;');
	$('#nav2Name').attr("disabled","disabled");
	$('#nav2Name').attr('style','background: #fff; color: #ccc;');
	$('#idType2').addClass("myDisabled");
	$('#nav2Id').attr("disabled","disabled");
	$('#nav2Id').attr('style','background: #fff; color: #ccc;');
	$('#nav2Phone').attr("disabled","disabled");
	$('#nav2Phone').attr('style','background: #fff; color: #ccc;');
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

function addETCard(obj){
	clearCardData();
	$('#syncType').val('3');
	var data=validateChild(obj);
	if(data){
		ajaxBindFamilyBeforeCard(data);
	}
}

function addBRCard(){
	clearCardData();
    $('.addCard').removeClass('none');
    $('#syncType').val('1');
}

function addTRCard(obj){
	clearCardData();
	$('#syncType').val($('#nav2rela').attr('key'));
	var data=validateOther(obj);
	if(data){
		ajaxBindFamilyBeforeCard(data);
	}
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
	$('#cardList'+syncType).html('');
	if(sHtml==''){
		$('#cardList'+syncType).append('<li class="nothing">请添加就诊卡</li>');
	}else{
		$('#cardList'+syncType).append(sHtml);
	}
}

function showCardInfo(obj) {
	$('#medicalcardId').val($(obj).attr('medicalcardId'));
	$('#voForm').attr('action', appPath+'easyhealth/usercenter/cardInfo/toView');
	$('#voForm').submit();
}
