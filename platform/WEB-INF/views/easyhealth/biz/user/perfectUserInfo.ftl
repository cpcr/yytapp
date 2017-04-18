<html>
<head>
    <#include "/easyhealth/common/common.ftl">
    <script type="text/javascript" src="${basePath}mobileApp/js/biz/medicalcard/idCardUtils.js"></script>
    <title>完善资料</title>
</head>
<body  style="background-color: #eeeeee;">
<div id="body">
	<form id="paramsForm" method="post" action="" accept-charset="utf-8">
		<input type="hidden" id="forward" name="forward" value="${forward}">
		<input type="hidden" id="openId" name="openId" value="${sessionUser.id}">
		
		<div class="familyInfo">
        <div class="box-tips icontips"><i class="iconfont">&#xe60d;</i>为了方便使用医院服务，请先完善资料。姓名、证件号一旦填写无法修改，请确认您的信息真实无误。</div>
        <div class="space15"></div>
        <ul class="yx-list">
            <li class="flex">
                <div class="flexItem"><input type="text" name="name" id="name"  class="yx-input textLeft" placeholder="姓名"/></div>
            </li>

            <li class="flex">
                <div class="flexItem"><input type="text" name="mobile" id="mobile"  class="yx-input textLeft" placeholder="手机号码"/></div>
            </li>

            <li class="flex">
                <div class="flexItem"><input type="text" name="cardNo" id="cardNo" class="yx-input textLeft" placeholder="证件"/></div>
                <div id="yx-select-card-id" >
                    <span class="view">中国大陆身份证<i class="iconfont">&#xe600;</i></span>
                    <select name="cardType" id="yx-select-card-id-val">
                        <option value="1" selected>中国大陆身份证</option>
                        <option value="2">港澳居民身份证</option>
                        <option value="3">台湾居民身份证</option>
                    </select>
                </div>

            </li>
            
          	<li class="flex" needHideIndex="0" style="display: none;">
                <div class="">出生日期</div>
                <div class="flexItem color666 textRight">
                    <input class="yx-input nb js-date" name="birthDay" id="birthDay" type="text" placeholder="请选择" />
                </div>
            </li>

            <li class="flex" needHideIndex="0" style="display: none;">
                <div class="flexItem">性别</div>
                <div class="sex-bar textRight">
                    <label><span>男</span><input type="radio" value="1" name="sex"/></label>
                    <label><span>女</span><input type="radio" value="0" name="sex"/></label>
                </div>
            </li>
            
            <#-- <li class="flex">
                <div class="">地址</div>
                <input type="text" name="address" id="address" class="yx-input textRight flexItem" placeholder="请输入"/>
            </li> -->
            
            <li class="flex">
                <div class="">省份</div>
                <div class="flexItem color666 textRight">
                    <label><span class="text">广东省</span>
                        <select name="province" class="select-screen-box" onchange="loadCity(this);">
                        </select>
                        <i class="iconfont">&#xe600;</i>
                    </label>
                </div>
            </li>
            <li class="flex">
                <div class="">城市</div>
                <div class="flexItem color666 textRight">
                    <label><span class="text"></span>
                        <select name="city" class="select-screen-box" onchange="loadArea(this);">
                        </select>
                        <i class="iconfont">&#xe600;</i>
                    </label>
                </div>
            </li>
            <li class="flex">
                <div class="">区域</div>
                <div class="flexItem color666 textRight">
                    <label><span class="text"></span>
                        <select name="area" class="select-screen-box" onchange="selectScreening(this);">
                        </select>
                        <i class="iconfont">&#xe600;</i>
                    </label>
                </div>
            </li>
            
        </ul>
        <div class="btn-w">
            <div class="btn btn-ok btn-block" onclick="perfectUserInfo();">完善资料</div>
        </div>
        <!-- <div class="textCenter"><a href="#" class="skinColor unline">跳过</a></div> -->
    </div>
	</form>
</div>
<script type="text/javascript" src="${basePath}easyhealth/js/common/yxCalendar.js?v=7"></script>
<script type="text/javascript" src="${basePath}easyhealth/js/common/city.min.js"></script>
<script src="${basePath}easyhealth/js/biz/user/eh.register.js?v=1.139" type="text/javascript"></script>
<script type="text/javascript">
		//选择时间 出现时间控件
    new yxCalendar({
        dom:'.js-date'
    })

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

				loadProvince($("select[name='province']"));

    })
    function selceted_show(dom,selectIndex){
        var mySelect  = $(dom);
        var mySelectHtml = mySelect.find('option').eq(selectIndex).html();
        var mySelectVal = mySelect.find('option').eq(selectIndex).attr('value');
        $('#yx-select-card-id .view').html(mySelectHtml+'<i class="iconfont">&#xe600;</i>')
    }
    
    function doRefresh() {
	    	$('#paramsForm').attr('action', '${basePath}easyhealth/user/toPerfectUserInfo');
	    	$('#paramsForm').submit();
    }
    
    function doGoBack() {
	    	var forward = $('#forward').val();
	    	if (forward && forward.indexOf('registerInfo') != -1) {
	    		$('#paramsForm').attr('action', '${basePath}mobileApp/register/doctorTime/index');
	    		//$('#paramsForm').attr('action', '${basePath}' + forward);
	    		$('#paramsForm').submit();
	    	} else {
		    		if(IS.isMacOS){
								try {
				              window.appCloseView(true);
				  			} catch (e) {
				            //alert('IOS的方法出错');
				        }
						}else if(IS.isAndroid){
		          	try {
		              window.yx129.appCloseView(true);
		          	} catch (e) {
		           			//alert('Android的方法出错');
		          	}
		       	}else{
		       			go(appPath + 'easyhealth/userCenterIndex');
		        }
	    	}
    }
    
    
	  function loadProvince(sel) {
			var provinces = dsy.get('0');
			var selector = $(sel);
			for(var i = 0; i < provinces.length; i++) {
				// console.log(provinces[i]);
				if ("广东省" == provinces[i]) {
					selector.append('<option value="'+ i +'" selected>'+ provinces[i] +'</option>');
				} else {
					selector.append('<option value="'+ i +'">'+ provinces[i] +'</option>');
				}
			}
			
			selector.change();
		}
		
		function loadCity(sel) {
			var citys = dsy.get('0_' + $(sel).val());
			var selector = $('select[name="city"]');
			selector.html('');
			for(var i = 0; i < citys.length; i++) {
				// console.log(citys[i]);
				
				if ("深圳市" == citys[i]) {
					selector.append('<option value="'+ i +'" selected>'+ citys[i] +'</option>');
				} else {
					selector.append('<option value="'+ i +'">'+ citys[i] +'</option>');
				}
			}
			
			if (!sel.selectedIndex) {
				sel.selectedIndex = 0;
			}
			
			selectScreening(sel);
			//selectScreening(selector[0]);
			selector.change();
		}
		
		function loadArea(sel) {
			var areas = dsy.get('0_' + $("select[name='province']").val() + '_' + $(sel).val());
			var selector = $('select[name="area"]');
			selector.html('');
			
			for(var i = 0; i < areas.length; i++) {
				// console.log(areas[i]);
				selector.append('<option value="'+ i +'">'+ areas[i] +'</option>');
			}
			
			if (!sel.selectedIndex) {
				sel.selectedIndex = 0;
			}
			
			selectScreening(sel);
			selectScreening(selector[0]);
		}
		
		function selectScreening(obj){
        var option = obj.children[obj.selectedIndex];
        if (option) {
	        var html = option.innerHTML;
	        obj.previousElementSibling.innerHTML = html
				}
    }
</script>
</body>
</html>
