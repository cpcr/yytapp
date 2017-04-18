/**
 * 医院管理后台js
 */

var $hospital = {};

/**
 * 搜索医院
 */
$hospital.search = function() {
  document.forms[0].submit();
}

$hospital.back = function(url) {
	location.href = url;
}

$hospital.toAdd = function() {

	var parentAppId = jQuery("#appid").attr("value");
	var currentHospitalId=jQuery("#hospitalId").attr("value");
	var platformsId = jQuery("#platforms").find("option:selected").attr("value");
	
	if(parentAppId==null||parentAppId==''){

		alert('AppId不能为空!');
		return;
	}

	var url="getHospitalNotInAppHospital?parentAppId="+parentAppId+"&currentHospitalId="+currentHospitalId+"&platformsId="+platformsId;
	//location.href = url;
	$hospital.openwindow(url,'新增',800,600);
	//window.showModalDialog(url, 'newwindow', 'height=500, width=400, top=0, left=0, toolbar=no, menubar=yes, scrollbars=yes,resizable=yes,location=no, status=no');
}

/**
 * 医院管理分页
 */
$hospital.changePage = function(pageNum, pageSize) {
  if (pageNum) {
    var pages = $('form input[name="pages"]').val();
    var pageNumInput = $('form input[name="pageNum"]');

    // 如果输入的页数是非数字，则还是跳到当前页
    if (isNaN(pageNum)) {
      pageNum = pageNumInput.val();
    }

    // 如果页数大于总页数，则跳至最后一页，如页数小于最小页数，则跳至第一页
    pageNum = pageNum > pages ? pages : pageNum;
    pageNum = pageNum < 1 ? 1 : pageNum;

    pageNumInput.val(pageNum);

    // 如果修改了每页显示的数量
    if (pageSize) {
      $('form input[name="pageSize"]').val(pageSize);
    }
    $hospital.search();
  }
}

$hospital.getAppId=function(){

	var platformsId = jQuery("#platforms").find("option:selected").attr("value");
	var hospitalId = jQuery("#hospitalId").attr("value");
	if(platformsId!='0'){

		var url  = "getAppId?hospitalId=" + hospitalId + "&platformId="+platformsId;
		window.location = url;
	}else{

		$("#appid").val('');
	}

}

$hospital.openwindow = function(url, name, iWidth, iHeight) {

	var url; // 转向网页的地址;

	var name; // 网页名称，可为空;

	var iWidth; // 弹出窗口的宽度;

	var iHeight; // 弹出窗口的高度;

	var iTop = (window.screen.availHeight - 30 - iHeight) / 2; // 获得窗口的垂直位置;

	var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; // 获得窗口的水平位置;

	window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');

}


$hospital.toDelete=function(btn) {

	if(confirm("确认要删除？")) {

		var id = $(btn).parent().siblings().eq(1).text();

		$.ajax({
			url : 'delete',
			data :{
				id:id
			},
			async : true,
			dataType : 'json',
			type : 'POST',
			error : function(XMLHQ, errorMsg) {
				console.log(errorMsg);
				alert(errorMsg);
			},
			success : function(data) {
				console.dir(data);
				console.log(data.status);
				if (data.status == 'OK') {

					$hospital.getAppId();
				} else {
					alert(data.message);
				}
			}
		});
	}
}





/**
 * 验证电话和手机号码
 * @param value
 * @returns {Boolean}
 */
function checkTel(value){
    var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
    var isMob=/^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$/;
   // var value=document.getElementById("ss").value.trim();
    if(isMob.test(value) || isPhone.test(value)){
        return true;
    }else{
        return false;
    }
}


/**
 * 新增App下面的医院
 */
$hospital.save = function() {
	
	var name = jQuery.trim($('form input[name="name"]').val());
	var code = jQuery.trim($('form input[name="code"]').val());
	var contactName = jQuery.trim($('form input[name="contactName"]').val());
	var contactTel = jQuery.trim($('form input[name="contactTel"]').val());
	var guideURL = jQuery.trim($('form input[name="guideURL"]').val());
	var cloudURL = jQuery.trim($('form input[name="cloudURL"]').val());
	var trafficURL = jQuery.trim($('form input[name="trafficURL"]').val());
	var logo = jQuery.trim($('form input[name="logo"]').val());
	var areaCode  = jQuery.trim($('form select[name="areaCode"]').find("option:selected").val());
	var reg = /^[\u4E00-\u9FA5A-Za-z0-9_]{1,50}$/;
	if (!reg.test(name)) {
		console.log(name);
		alert('请填写正确的医院名称');
		return false;
	}
	
	if(areaCode == ''){
		alert('请选择医院区域');
		return false;
	}
  
	if(contactName.length > 20){
	  	console.log(contactName);
	  	alert('联系人过长');
	  	return false;
	}
	if(contactTel != ''){
		if(!checkTel(contactTel)){
			alert('联系人电话格式错误');
			return false;
		}
	} 
	  
    var id = $('form input[name="id"]').val();
    $.ajax({
    	url : 'save',
    	data : {
    		id : id,
    		name : name,
    		code : code,
    		contactName : contactName,
    		contactTel : contactTel,
    		areaCode : areaCode,
    		guideURL:guideURL,
    		cloudURL:cloudURL,
    		trafficURL:trafficURL,
    		logo:logo
    	},
    	async : true,
    	dataType : 'json',
    	type : 'POST',
    	error : function(XMLHQ, errorMsg) {
    		console.log(errorMsg);
    		alert(errorMsg);
    	},
    	success : function(data) {
    		console.dir(data);
    		console.log(data.status);
    		if (data.status == 'OK') {
    			location.href = '../branchHospital/toView?hospitalId=' + data.id;
    		} else {
    			alert(data.message);
    		}
    	}
    });
}


/**
 * 单行编辑医院按钮click事件
 */
$hospital.toEdit = function(btn) {
	var id = $(btn).parent().siblings().eq(1).text();
	location.href = 'toEdit?id=' + id;
}




$hospital.sort=function(btn) {
	var id = $(btn).parent().siblings().eq(1).text();
	var sortValue=prompt("请输入排序值(必须是整数)：","");//将输入的内容赋给变量 name ，
	if((/(^[1-9]\d*$)/.test(sortValue))||(/(^-[1-9]\d*$)/.test(sortValue))||sortValue=='0'){
		$.ajax({
			url : 'sort',
			data :{
				id:id,
				sort:sortValue
			},
			async : true,
			dataType : 'json',
			type : 'POST',
			error : function(XMLHQ, errorMsg) {
				console.log(errorMsg);
				alert(errorMsg);
			},
			success : function(data) {
				console.dir(data);
				console.log(data.status);
				if (data.status == 'OK') {
					$hospital.getAppId();
				} else {
					alert(data.message);
				}
			}
		});
	}else{
		alert("请输入整数！");
	}
}

 
