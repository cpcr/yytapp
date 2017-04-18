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

	$hospital.close = function () {

		window.opener.location.href=window.opener.location.href;
		window.close();
	}


	$hospital.save = function () {

		var parentAppId = jQuery("#parentAppId").attr("value");
		//var currentHospitalId=jQuery("#currentHospitalId").attr("value");

		var chk = jQuery("#hospital_tab").find(":checkbox[name=chkHospitals]");
		var hospitalIds = new Array();
		chk.each(function (idx, item) {
			if (jQuery(item).parent().hasClass("check")) {
				hospitalIds[idx] = jQuery(item).val();
			}
		});
		console.log(hospitalIds);
		if (hospitalIds.length > 0) {
			if (confirm("确定要添加所选医院吗？")) {
				$.ajax({
					url: 'save',
					data: {
						hospitalIds: hospitalIds,
						parentAppId: parentAppId
					},
					async: true,
					dataType: 'json',
					type: 'POST',
					error: function (XMLHQ, errorMsg) {
						console.log(errorMsg);
						alert(errorMsg);
					},
					success: function (data) {
						console.dir(data);
						if (data.status == 'OK') {

							$hospital.search();
							window.opener.location.href=window.opener.location.href;
						} else {
							alert(data.message);
						}
					}
				});
			}
		} else {
			alert("对不起，您未选择医院!");
		}
	}

 
