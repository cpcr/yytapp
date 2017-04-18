<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<title>挂号记录</title>
</head>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">

<div id="body">
    <div id="guoHao">
        <div class="screeningBox">
            <ul class="yx-list">
                <li class="flex">
                    <div class="flexItem">
                        <label>
                        	<span class="text">全部医院</span>
                            <select id="hospitalFilter" name="hospitalFilter" class="select-screen-box" onchange="filterRecord(this)">
                                <option value="0">全部医院</option>
                                <#list entityList as item>
                                	<option value="${item.hospitalCode}">${item.hospitalName}</option>
                                </#list>
                            </select>
                            <i class="iconfont">&#xe66d;</i>
                        </label>
                    </div>
                    <div class="flexItem">
                        <label>
                        	<span class="text">全部日期</span>
                            <select id="dateFilter" name="dateFilter" class="select-screen-box"  onchange="filterRecord(this)">
                                <option value="0">全部日期</option>
                                <option value="1">今天</option>
                                <option value="2">近3天</option>
                                <option value="3">近7天</option>
                                <option value="4">近30天</option>
                            </select>
                            <i class="iconfont">&#xe66d;</i>
                        </label>
                    </div>
                </li>
            </ul>
        </div>
        <div class="space15"></div>
        <div id="records" >
        	
        </div>
    </div>
</div>

<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}">
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
	<input type="hidden" id="appId" name="appId" value="">
	<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
	<input type="hidden" id="hospitalId" name="hospitalId" value="" />
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="" />
	<input type="hidden" id="hospitalName" name="hospitalName" value="" />
	<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="" />
	<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="" />
	<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="" />
	<input type="hidden" id="cardNo" name="cardNo" value="" />
	<input type="hidden" id="orderNo" name="orderNo" value="" />
</form>
<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script>
	var sourceData = {};
	$(function() {
		loadData();
	});
	
	function loadData() {
		$Y.loading.show('正在为您加载数据...');
		var url = appPath + 'easyhealth/usercenter/getRegRecords';
		var now = new Date();
		var timeTemp = now.getTime();
		var datas = $('#voForm').serializeArray();
		$.ajax({
			url: url + '?timeTemp=' + timeTemp,
			data: datas,
			type: "post",
			dataType: "json", 
			global: false,
			cache: false,
			timeout: 30000,
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				$Y.loading.hide();
				showNoRecord();
			},
			success: function(data) {
				console.log(data);
				if (data.status == 'OK' && data.message && data.message.records.length > 0) {
					sourceData = data.message.records;
					formatData(sourceData);
					$Y.loading.hide();
				} else {
					$Y.loading.hide();
					showNoRecord();
				}
			}
		})
	}
	
	function showOrderInfo(orderNo){
		$("#orderNo").val(orderNo);
		$("#userId").val('${commonParams.userId}')
		$("#voForm").attr("action" , appPath + "mobileApp/register/infos/showOrderInfo");
		$("#voForm").submit();
	}

    function formatData(data) {
        var sHtml = '';
        var statusLabel = '';

        sHtml += '<ul class="yx-list recordList">';

        $.each(data, function (i, item) {
            // 标签
            if (item.regStatus == 0) {
                sHtml += '<li class="lock';
            } else if (item.regStatus == 1) {
                sHtml += '<li class="ok';
            } else if (item.regStatus == 3) {
                sHtml += '<li class="timeOut';
            } else if (item.regStatus == 2 || item.regStatus == 7) {
                sHtml += '<li class="cancel';
            } else if (item.regStatus == 5 || item.regStatus == 6 || item.regStatus == 8 || item.regStatus == 9) {
                sHtml += '<li class="fail';
            } else if (item.regStatus == 25) {
                sHtml += '<li class="fail';
            } else {
                sHtml += '<li class="fail';
            }
            sHtml += ' flex arrow boxTable" onclick="showOrderInfo(\'' + item.orderNo + '\')">';

            // 状态
            if (item.regStatus == 0 && item.payStatus == 1) {
                var nowTime=new Date().getTime();
                if(nowTime > item.payTimeoutTime){
                    statusLabel = "挂号取消";
                }else{
                    statusLabel = "待缴费";
                }
            } else if (item.regStatus == 1) {
                if (item.payStatus == 1) {
                    if(item.treatFee == 0 && item.regFee == 0){
                        statusLabel = "挂号成功";
                    }else{
                        statusLabel = "待缴费";
                    }
                } else if (item.payStatus == 2) {
                    statusLabel = "挂号成功";
                }else if (item.payStatus == 10) {
                    statusLabel = "待缴检查费";
                }else if (item.payStatus == 11) {
                    statusLabel = "挂号失败";
                }
            } else if (item.regStatus == 3) {
                statusLabel = "挂号取消";
            } else if (item.regStatus == 2) {
                if (item.payStatus == 3) {
                    statusLabel = "挂号取消";
                } else if (item.payStatus == 2 || item.payStatus == 5) {
                    statusLabel = "挂号取消";
                } else {
                    statusLabel = "挂号取消";
                }
            } else if (item.regStatus == 4) {
                if (item.payStatus == 3) {
                    statusLabel = "挂号取消";
                } else if (item.payStatus == 2 || item.payStatus == 5) {
                    statusLabel = "挂号取消";
                } else {
                    statusLabel = "挂号取消";
                }
            } else if (item.regStatus == 5) {
                statusLabel = "挂号异常";
            } else if (item.regStatus == 6) {
                statusLabel = "挂号异常";
            } else if (item.regStatus == 7 || item.regStatus == 10) {
                statusLabel = "挂号异常";
            } else if (item.regStatus == 8) {
                if (item.payStatus == 3) {
                    statusLabel = "挂号异常";
                } else if (item.payStatus == 2 || item.payStatus == 5) {
                    statusLabel = "挂号异常";
                } else if (item.payStatus == 1) {
                    statusLabel = "挂号异常";
                } else {
                    statusLabel = "挂号异常";
                }
            } else if (item.regStatus == 9) {
                statusLabel = "挂号成功";
            } else if (item.regStatus == 11) {
                statusLabel = "挂号异常";
            } else if (item.regStatus == 12) {
                if (item.payStatus == 3) {
                    statusLabel = "挂号失败";
                } else if (item.payStatus == 2 || item.payStatus == 5) {
                    statusLabel = "挂号失败";
                } else {
                    statusLabel = "挂号失败";
                }
            } else if (item.regStatus == 13) {
                if (item.payStatus == 3) {
                    statusLabel = "挂号取消";
                } else if (item.payStatus == 2) {
                    statusLabel = "挂号成功";
                } else if (item.payStatus == 1) {
                    statusLabel = "挂号异常";
                } else {
                    statusLabel = "挂号异常";
                }
            } else if (item.regStatus == 14) {
                if (item.payStatus == 3) {
                    statusLabel = "挂号异常";
                } else if (item.payStatus == 2 || item.payStatus == 5) {
                    statusLabel = "挂号异常";
                } else {
                    statusLabel = "挂号异常";
                }
            } else if (item.regStatus == 15) {
                if (item.payStatus == 3) {
                    statusLabel = "挂号异常";
                } else if (item.payStatus == 2 || item.payStatus == 5) {
                    statusLabel = "挂号异常";
                } else {
                    statusLabel = "挂号异常";
                }
            } else if (item.regStatus == 22 && item.payStatus == 3) {
                statusLabel = "挂号取消";
            } else if (item.regStatus == 20) {
                statusLabel = "挂号取消";
            } else if (item.regStatus == 21) {
                statusLabel = "挂号异常";
            }else if (item.regStatus == 41) {
                statusLabel = "挂号中";
            }
            else if (item.regStatus == 25) {
                if (item.payStatus == 1) {
                    statusLabel = "预约中";
                } else if (item.payStatus == 2) {
                    statusLabel = "已预约";
				} else if (item.payStatus == 3) {
                    statusLabel = "挂号取消";
				}
			}
            sHtml += '	<div class="flexItem">';
            sHtml += '		<div class="name fontSize110">' + item.hospitalName + '</div>';
            sHtml += '		<div class="mate">' + item.encryptedPatientName + '(' + item.cardNo + ') </div>';
            // sHtml += '		<div class="mate">' + item.hospitalName +'</div>';
            // sHtml += '		<div class="mate">' + Number((item.realRegFee + item.realTreatFee) / 100).toFixed(2) + '元</div>';
            sHtml += '		<div class="mate color999">' + ((item.registerDate.length > 10) ? item.registerDate.substring(0, 10) : item.registerDate) + '</div>';
            sHtml += '	</div>';
            sHtml += '	<div class="flexItem w120 textRight vertical states" style="margin-top:18px;">' + statusLabel + '&nbsp;&nbsp;&nbsp;</div>';
            sHtml += '</li>';
        });

        sHtml += '</ul>';

        $('#records').html('');
        $('#records').append(sHtml);
    }
	
	function showNoRecord() {
		var sHtml = '';
		sHtml += '<div id="success">';
	    sHtml += '	<div class="noticeEmpty"></div>';
	    sHtml += '	<div class="p color666">没有任何挂号记录</div>';
	    sHtml += '</div>';
		$('#records').html('');
		$('#records').html(sHtml);
	}
	
	function filterRecord(obj) {
		$(obj).siblings('.text').text($(obj).find("option:selected").text());
		
		if (sourceData.length > 0) {
			var hospitalValue = $('#hospitalFilter').val();
			var dateValue = $('#dateFilter').val();
			var datas = filterData(hospitalValue, dateValue);
			if (datas.length > 0) {
				formatData(datas);
			} else {
				showNoRecord();
			} 
		} else {
			showNoRecord();
		}
	}
	
	function filterData(hospVal, dateVal) {
		var resultData = [];
		
		if (hospVal == '0' && dateVal == '0') {
			resultData = sourceData;
		} else {
			if (hospVal == '0') {
				resultData = filterByDate(dateVal);
			} else if (dateVal == '0') {
				resultData = filterByHosp(hospVal);
			} else {
				var tempDate = new Date();
				var endDate = tempDate.Format('yyyy-MM-dd');
				var beginDate = getBeginDate(tempDate, dateVal);
				
				$.each(sourceData, function(i, item) {
					var regDate = new Date(item.registerTime).Format('yyyy-MM-dd');
					if (regDate >= beginDate && regDate <= endDate &&　item.hospitalCode == hospVal) {
						resultData.push(item);
					}
				});
			}
		}
		
		return resultData;
	}
	
	function filterByHosp(value) {
		var resultData = [];
		$.each(sourceData, function(i, item) {
			if (item.hospitalCode == value) {
				resultData.push(item);
			}
		});
		
		return resultData;
	}
	
	function filterByDate(value) {
		var resultData = [];
		var tempDate = new Date();
		var endDate = tempDate.Format('yyyy-MM-dd');
		var beginDate = getBeginDate(tempDate, value);
		$.each(sourceData, function(i, item) {
			var regDate = new Date(item.registerTime).Format('yyyy-MM-dd');
			if (regDate >= beginDate && regDate <= endDate) {
				resultData.push(item);
			}
		});
		
		return resultData;
	}
	
	function getBeginDate(tempDate, dateType) {
		var beginDate = '';
		var tDate = new Date(tempDate);
        /*
    	1今天
    	2近3天
    	3近7天
    	4近30天
        */
        if (dateType == 1) {
        	beginDate = tDate.Format('yyyy-MM-dd');
        } else if (dateType == 2) {
        	tempDate = tDate.setDate(tempDate.getDate() - 2);
        	beginDate = tDate.Format('yyyy-MM-dd');
        } else if (dateType == 3) {
        	tempDate = tDate.setDate(tempDate.getDate() - 7);
        	beginDate = tDate.Format('yyyy-MM-dd');
        } else {
        	tempDate = tDate.setMonth(tempDate.getMonth() - 1);
        	beginDate = tDate.Format('yyyy-MM-dd');
        }
		return beginDate;
	}
	
	Date.prototype.Format = function(fmt) { //author: meizz 
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
	
</script>