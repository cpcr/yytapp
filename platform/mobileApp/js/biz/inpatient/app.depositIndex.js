var inpatientIndex = {
	init: function() {
		$("#inputPay").off('blur').on('blur', function () {
			var payFee = $(this).val();
			if (payFee) {
				if (!isNaN(payFee)) {
					payFee = Number(payFee);
					if (payFee <= 0) {
						$Y.tips('请输入正整数的补缴金额！');
						$(this).val('');
						$('#payFee').val('');
					} else if (payFee > 10000) {
		            	$Y.tips('押金补缴每次支持最大金额: 10000元！');
		            	$(this).val('');
		            	$('#payFee').val('');
		            } else {
		            	$(this).val(payFee)
		            	$('#payFee').val(payFee);
		            }
				} else {
					$Y.tips('请正确输入押金补缴金额！');
					$(this).val('');
					$('#payFee').val('');
				}
			} else {
				$('#payFee').val('');
			}
        });
		
		$('.c_tag span').off('click').on('click', function() { 
			if (!$(this).hasClass('active')) {
				$('.c_tag span').removeClass('active');
				$(this).addClass('active');
			}
			
			$('#inputPay').val($(this).attr('data-value'));
			$('#payFee').val($(this).attr('data-value'));
		});
		
		$('#payDeposit').off('click').on('click', function() {
			console.log('payFee:' + $('#payFee').val() + '元');
			if ($('#payFee').val()) {
				$('#payFee').val(Number($('#payFee').val()) * 100);
				inpatientIndex.generateOrder();
			} else {
				$Y.tips('请正确输入押金补缴金额！');
				$('#payFee').val('');
			}
		});
		
	},
	loadInpatientData: function() {
		$('#pay_detail').html('');
		$('#no_data').html('');
		$Y.loading.show('正在加载押金补缴信息...');
		// 选中的就诊人的admissionNo
		// $('#admissionNo').val('10086');
		// $('#inTime').val('999');
		var url = appPath + 'mobileApp/deposit/getPatientInfo';
		var datas = $('#voForm').serializeArray();
		$.ajax({
			type: 'POST',  
           	url: url,  
           	data: datas,  
           	dataType: 'json',  
           	timeout: 120000,
           	error: function(data) {
           		$Y.loading.hide();
           		// inpatientIndex.showNoPayData();
           		$('#voForm').attr('action', appPath + 'mobileApp/deposit/index?timeTemp=' + timeTemp);
				$('#voForm').submit();
           	},
           	success: function(data) {
           		$Y.loading.hide();
           		console.log(data);
           		if (data.status && data.status == 'OK' && data.message) {
           			inpatientIndex.formatData(data.message);
           		} else {
           			inpatientIndex.showNoPayData();
           		}
           	}
		});
	},
	formatData: function(data) {
		$('#totalFee').val(data.totalFee);
		$('#paidFee').val(data.payedFee);
		$('#balanceBeforePay').val(data.leftFee);
		
		$('#no_data').html('');
		var sHtml = '';
		$('#pay_detail').html('');
		
		sHtml += '<div class="box-list">';
		sHtml += '	<ul class="yx-list">';
		sHtml += '		<li>';
		sHtml += '			<div class="label">住院总费用</div>';
		sHtml += '			<div class="values color666"><span class="yellow">' + Number(data.totalFee / 100).toFixed(2) + '元</span></div>';
		sHtml += '		</li>';
		sHtml += '		<li>';
		sHtml += '			<div class="label">已缴押金</div>';
		sHtml += '			<div class="values color666"><span class="yellow">' + Number(data.payedFee / 100).toFixed(2) + '元</span></div>';
		sHtml += '		</li>';
		sHtml += '		<li>';
		sHtml += '			<div class="label">押金余额</div>';
		sHtml += '			<div class="values color666"><span class="yellow fontSize140">' + Number(data.leftFee / 100).toFixed(2) + '</span> 元</div>';
		sHtml += '		</li>';
		sHtml += '	</ul>';
		sHtml += '</div>';
		sHtml += '<div class="pageTitle" style="margin-bottom: 0px">请选择您要补缴的金额</div>';
		sHtml += '	<div class="box-list" style="margin-top: 0">';
		sHtml += '		<ul class="yx-list">';
		sHtml += '			<li>';
		sHtml += '				<div class="c_tag">';
		sHtml += '					<span data-value="500"><i>500元</i></span>';
		sHtml += '					<span data-value="1000"><i>1000元</i></span>';
		sHtml += '					<span data-value="2000"><i>2000元</i></span>';
		sHtml += '				</div>';
		sHtml += '			</li>';
		sHtml += '			<li>';
		sHtml += '				<div>';
		sHtml += '					<div style="margin-bottom: 10px">请输入您的补缴金额</div>';
		sHtml += '					<div style="position: relative;padding-right: 1.6em">';
		sHtml += '						<input id="inputPay" type="text" style="background-color:#e1e1e1;padding: 6px;border: 1px solid #DFDFDF;border-radius: 4px;" placeholder="请输入其它金额">';
		sHtml += '						<span style="position: absolute;top: 5px;right: 0">元</span>';
		sHtml += '					</div>';
		sHtml += '				</div>';
		sHtml += '			</li>';
		sHtml += '		</ul>';
		sHtml += '	</div>';
		sHtml += '</div>';
		
		sHtml += '<div class="section btn-w">';
	    sHtml += '	<div id="payDeposit" class="btn btn-ok btn-block" ontouchstart="$Y.hover.TouchOn(this)" ontouchend="$Y.hover.TouchOut(this)">确认支付</div>';
	    sHtml += '</div>';
		
		$('#pay_detail').append(sHtml);
		inpatientIndex.init();
	},
	showNoPayData: function() {
		var sHtml = '';
		
		sHtml += '<ul id="clinic-list" class="yx-list">';
		sHtml += '	<li class="noData">';
	    sHtml += '  	<p class="color666" style="text-align: center">没有查到您的押金补缴信息。</p>';
	    sHtml += '	</li>';
	    sHtml += '</ul>';
		
		$('#no_data').html('');
		$('#no_data').append(sHtml);
		$('#no_data').addClass('boxLi');
	},
	generateOrder: function() {
		$Y.loading.show('正在生成订单，请稍后...');
		var url = appPath + 'mobileApp/deposit/generateOrder';
		var datas = $('#voForm').serializeArray();
		$.ajax({
	       	type : 'POST',  
	       	url : url,  
	       	data : datas,  
	       	dataType : 'json',  
	       	timeout:120000,
	       	error: function(data) {
	       		$Y.loading.hide();
	       		new $Y.confirm({
		            ok:{title:'确定'},
		            content:'网络异常，订单生成失败，请稍后重试。'
		        });
	       	},
	       	success: function(data) {
	       		console.log(data);
	       		$Y.loading.hide();
	       		if (data.status == 'OK' && data.message && data.message.tradeMode) {
	       			// 下面是本机测试使用
	       			// $("#payForm").attr('action', appPath + 'mobileApp/clinic/clinicOrderInfo');
	       			$("#payForm").initFormData(data.message.pay);
	       			// 测试异常使用
	       			// $("#notifyMethodName").val("pangziInvoke");
	       			$("#payForm").submit();
	       		} else {
	       			new $Y.confirm({
			            ok:{title:'确定'},
			            content:'网络异常，订单生成失败，请稍后重试。'
			        });
	       		}
	       	}
		});
	}
};

$.fn.initFormData = function(data) {
	return this.each(function() {
		var elementDom;
        var elementDomName;
        if(!data || data== 'null') {
        	// 将值重置为默认值
        	this.reset(); 
        	return; 
        }
        
        $.each($(this).children(), function(i, item) {
        	// console.log(item.name + "=" + data[item.name]);
        	if (data[item.name] && data[item.name] != 'null') {
        		$(item).val(data[item.name]);
        	}
        });
	});
};

function loadData() {
	console.log('loadData....');
	$('#admissionNo').val($('#selectedCard').attr('data-admissionNo'));
	inpatientIndex.loadInpatientData();
}

$(function() {
	// inpatientIndex.loadInpatientData();
	$('#payFee').val('');
});