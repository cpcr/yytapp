<!DOCTYPE html>
<html>
<head>
<#include "/easyhealth/common/common.ftl">
<title>绑定就诊卡</title>
</head>
<style>
	.bindMask {
		position: fixed;
		left: 0px;
		top: 0px;
		right: 0px;
		bottom: 0px;
		background: #fff;
		opacity: 0;
	}
</style>
<body ontouchmove="$Y.hover.TouchMove(event)" style="background-color: rgb(238, 238, 238);">
<div id="body">
	<div class="familyInfo">
        <div class="box-tips icontips"><i class="iconfont"></i>为了方便使用医院服务，请先完善资料。</div>
        <div class="space15"></div>
        <ul class="yx-list">
            <li class="flex">
                <div class="flexItem">姓名</div>
                <div class="flexItem textRight ">${entity.encryptedName}</div>
            </li>
            <#if entity.ownership != 3>
            <li class="flex">
                <div class="flexItem ">证件类型</div>
                <div id="yx-select-card-id ">
                    <span class="view">&nbsp;&nbsp;${entity.idTypeLabel}&nbsp;&nbsp;</span>
                </div>
            </li>
            <li class="flex">
                <div class="flexItem ">证件号码</div>
                <div class="flexItem textRight ">${entity.encryptedIdNo}</div>
            </li>
            </#if>
            <#if entity.ownership == 3>
            <li class="flex">
                <div class="flexItem ">出生日期</div>
                <div class="flexItem textRight ">${entity.birth}</div>
            </li>
            <li class="flex">
                <div class="flexItem ">性别</div>
                <div class="flexItem textRight ">${entity.sexLabel}</div>
            </li>
            </#if>
            <#if entity.ownership != 3>
            <li class="flex">
                <div class="flexItem ">手机号码</div>
                <div class="flexItem textRight ">${entity.encryptedMobile}</div>
            </li>
            </#if>
            <li class="flex">
                <div class="flexItem ">地址</div>
                <div class="flexItem textRight ">${entity.address}</div>
            </li>
            
            <#if entity.ownership == 3>
            <li class="flex">
                <div class="flexItem ">监护人姓名</div>
                <div class="flexItem  textRight">${entity.encryptedGuardName}</div>
            </li>
        	<li class="flex">
                <div class="flexItem ">监护人证件类型</div>
                <div class="flexItem  textRight">${entity.guardIdTypeLabel}</div>
            </li>
            <li class="flex">
                <div class="flexItem ">监护人证件号码</div>
                <div class="flexItem  textRight">${entity.encryptedGuardIdNo}</div>
            </li>
            <li class="flex">
                <div class="flexItem ">监护人手机号码</div>
                <div class="flexItem  textRight">${entity.encryptedGuardMobile}</div>
            </li> 
            </#if>
            
            <li class="flex">
                <div class="flexItem">就诊卡类型</div>
                <div id="yx-select-card-id" class="patCardType" >
                    <span class="view"><i class="iconfont">&#xe600;</i></span>
                    <select name="" id="yx-select-card-id-val">
                        <#list rule.cardType?split(",") as item>
                        <option value="${item}">
                        	<#switch item>
                        		<#case 1>就诊卡<#break>
                        		<#case 2>社保卡<#break>
                        		<#case 3>医保卡<#break>
                        		<#case 4>健康卡<#break>
                        		<#case 5>身份证<#break>
                        		<#case 6>市民卡<#break>
                        		<#case 7>患者唯一标识<#break>
                        		<#case 8>临时诊疗卡<#break>
                        		<#default>
                        	</#switch>
                        </option>
                        </#list>>
                    </select>
                </div>
            </li>
            <li class="flex">
                <div class="">就诊卡号</div>
                <div class="flexItem color666 textRight">
                	<input type="text" class="yx-input" id="patCardNo" placeholder="请输入">
                </div>
            </li>
        </ul>
        <div class="btn-w">
            <div class="btn btn-ok btn-block" onclick="bindCard();">绑定</div>
        </div>
    </div>
</div>
<form id="voForm" method="post" action="">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
	<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
	<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
	<input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
	<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}">
	<input type="hidden" id="syncType" name="syncType" value="${commonParams.syncType}">
	<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
	<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}">
	<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}">
	<input type="hidden" id="branchCode" name="branchCode" value="${commonParams.branchHospitalCode}">
	<input type="hidden" id="branchId" name="branchId" value="${commonParams.branchHospitalId}">
	<input type="hidden" id="branchName" name="branchName" value="${commonParams.branchHospitalName}">
	<input type="hidden" id="familyId" name="familyId" value="${commonParams.familyId}">
	<input type="hidden" id="cardNo" name="cardNo" value="">
	<input type="hidden" id="cardType" name="cardType" value="">
</form>

<input type="hidden" id="forward" name="forward" value="${commonParams.forward}">

<#include "/easyhealth/common/footer.ftl">
</body>
</html>
<script>
	var enableShellButtonEvent = true;
	function bindCard() {
		enableShellButtonEvent = false;
		var patCardNo = $('#patCardNo').val();
		if (!patCardNo) {
			$Y.tips('请输入您的就诊卡号');
			enableShellButtonEvent = true;
			return false;
		}
		
		$Y.loading.show('正在为您绑定就诊卡...');
		$('#cardNo').val(patCardNo);
		$('#cardType').val($('#yx-select-card-id-val').val());
		var datas = $('#voForm').serializeArray();
		console.log(datas);
		
		$.ajax({
			type: "POST",
			url: "${basePath}easyhealth/usercenter/medicalcard/bindCard",
			data: datas,
			cache: false, 
			dataType: "json", 
			timeout: 7900,
			error: function(data) {
				$Y.loading.hide();
				myBox = new $Y.confirm({
			    	title:"",
			        content:"<div style='text-align: center;'>绑卡失败</div>",
			        ok:{title:"确定",
			        	click:function(){ 
			            	myBox.close();
			            }
			        }
				});
				enableShellButtonEvent = true;
				return;
			},
			success: function(data) {
				$Y.loading.hide();
				console.log(data);
				enableShellButtonEvent = true;
				if (data.status == 'OK' && data.message && data.message.isSuccess == '0') {
					var forward = $('#forward').val();
					if (forward) {
						$('#voForm').attr('action', forward);
						$('#voForm').submit();
					} else {
						// 成功， 弹框提示。 完成后调用壳的方法关闭页面，会自动刷新页面
						myBox = new $Y.confirm({
					    	title:"",
					        content:"<div style='text-align: center;'>绑定成功</div>",
					        ok:{title:"我知道了",
					        	click:function(){ 
					        		// 调用壳的方法关闭
					        		closeAppWindow();
					            	myBox.close();
					            }
					        }
					    });
					}
					
					return;
				} else {
					// 失败，弹框提示
					myBox = new $Y.confirm({
				    	title:"",
				        content:"<div style='text-align: center;'>" + data.message.msgInfo?data.message.msgInfo:"绑卡失败" + "</div>",
				        ok:{title:"确定",
				        	click:function(){ 
				            	myBox.close();
				            }
				        }
				    });
					return;
				}
			}
		});
	}
	
	function closeAppWindow() {
		console.log('关闭页面');
		if(IS.isMacOS){
			try {
              window.appCloseView(true);
  			} catch (e) {
            //  alert('IOS的方法出错');
          	}
		}else if(IS.isAndroid){
          	try {
              yyc.appCloseView();
          	} catch (e) {
           	//   alert('Android的方法出错');
          	}
       	}else{
       		go(appPath + 'easyhealth/userCenterIndex');
        }
	}
	
	$(function(){
        var mySelect = $('#yx-select-card-id-val');
        _getIndex = function(){
            var selectIndex = mySelect[0].selectedIndex;
            selceted_show(mySelect,selectIndex)
            
            if (selectIndex == 0) {
            	$('.yx-list li[needHideIndex="0"]').hide();
            } else {
            	$('.yx-list li[needHideIndex="0"]').show();
            }
        }
        
        _getIndex();
        mySelect.on('change',function(){
            var selectIndex = mySelect[0].selectedIndex;
            _getIndex(mySelect,selectIndex)
        })
    })
    
    function selceted_show(dom,selectIndex){
        var mySelect  = $(dom);
        var mySelectHtml = mySelect.find('option').eq(selectIndex).html();
        // var mySelectVal = mySelect.find('option').eq(selectIndex).attr('value');
        $('.patCardType span').html(mySelectHtml+'<i class="iconfont">&#xe600;</i>')
    }
    
    // 刷新方法
	function doRefresh() {
		if (enableShellButtonEvent) {
			$('#voForm').attr('action', '${basePath}easyhealth/usercenter/medicalcard/index');
			$('#voForm').submit();
		}
	}
	
	// 返回方法
	function doGoBack() {
		if (enableShellButtonEvent) {
			var forward = $('#forward').val();
			var url = '${basePath}easyhealth/usercenter/syncCard/index';
			if (forward) {
				url = forward;
			}
			
			$('#voForm').attr('action', url);
			$('#voForm').submit();
		}
	}
</script>