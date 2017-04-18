<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>${commonParams.hospitalName}</title>
    <script src="${basePath}mobileApp/js/common/iscroll.js" type="text/javascript"></script>
	<style type="text/css">
        #copyright{display: block}
        .section{overflow: auto}
        #ks-list.static{
            position: relative;
            overflow: auto;

        }
        #ks-list.static .ks-list-right.onlyOne,#ks-list.static #right-list-main,#ks-list.static .scroller{
            position: static;overflow: auto
        }
        #right-list-main li:last-child{
            border: none;
        }
        
        .search-view{ position: relative; height: auto; text-align: left;}
        .typeWord{width: 80px; height:38px; line-height: 38px;  color: #11ba98; float: left; position: relative;}
        .typeWord-option{padding-left:4px;background-color:#FFF; width: 80px; height: 38px; outline: none; float:left; border: 0; color: #11ba98; text-align: center; }
        .typeWord .arrow-down{ width: 10px; height: 10px; background: url("../images/arrow_down-ke.png") no-repeat scroll 100% 0; background-size: 10px;vertical-align: middle; display: inline-block;
            position: absolute;; right: 0;  top: 18px;;;
        }
        .s-inputView{ margin-left: 95px;}
        .s-inputView .icon-search{ margin-right: 10px; float: right; margin-top: 12px;}
    </style>
</head>
<body style="margin: 0;padding: 0;">
<div id="mark"></div>
<div id="body" style="margin: 0;padding: 0;">
    <#if isHasSearChDoctor == 1> 
     <div class="section">
        <div class="search-view">
            <div class="typeWord">
                <select name="searchCode" id="searchCode" class="typeWord-option">
                    <#if commonParams.regType == 2>
                    <option value="1" selected="selected">搜医生</option>
                    </#if>
                    <option value="2">搜科室</option>
                </select>
                <i class="arrow-down"></i>
            </div>
            <div class="s-inputView" onclick="goSearch()">请输入关键字
                <i class="icon-search"></i>
            </div>
        </div>
    </div>
    </#if>
    <div class="keyword-bar">
          曾挂号医生：
        <#list hadRegDoctors?reverse as hadRegDoctor>
            <span id="${hadRegDoctor.deptCode}:${hadRegDoctor.doctorCode}:${hadRegDoctor.deptName}" onclick="goDoctorRegSource(this)">${hadRegDoctor.doctorName}</span>
        </#list>
    </div>
    <div class="section" style="margin-bottom: 0">
        <div id="ks-list" class="static">
            <div class="ks-list-right onlyOne">
               <div id="right-list-main">
			   <div class="scroller">
                   <ul style="display: block">
                   <#list depts as domain>
                       <li id="${domain.deptCode}" name="${domain.deptName}" value="${domain.tcxh}|${domain.fydw}|${domain.fyzje}" onclick="toRegSourceInfo(this)">${domain.deptName}</li>
                   </#list>
                   </ul>
				      </div>
               </div>
               <!-- <div id="right-ks_arrow"></div> -->
            </div>
        </div>
    </div>
</div>

<form id="paramsForm" method="post">
<input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
<input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}" />
<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}" />
<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />
<input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}" />
<input type="hidden" id="deptCode" name="deptCode" value="${commonParams.deptCode}">
<input type="hidden" id="deptName" name="deptName" value="${commonParams.deptName}">
<input type="hidden" id="doctorCode" name="doctorCode" value="${commonParams.doctorCode}">
<input type="hidden" id="regType" name="regType" value="${commonParams.regType}" />
<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}" />
<input type="hidden" id="searchType" name="searchType"/>
<input type="hidden" id="tcInfo" name="tcInfo" value="${commonParams.tcInfo}" />
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>
<script type="text/javascript">
	var isIOS = /Mac\s+OS/.test(navigator.userAgent); //是否苹果
	var isAndroid = /Android/.test(navigator.userAgent); //是否安卓
    //禁用滑动
   // window.addEventListener('touchmove',function(e){e.preventDefault()},false)
	//滚动初始化
    var myScroll;
    function loaded () {
	var isAlipay = /Alipay/.test(navigator.userAgent); //是否是支付宝
	if(isAndroid && isAlipay){
		myScroll = new IScroll('#right-list-main', { mouseWheel: true,click:true  });
	}else{
		myScroll = new IScroll('#right-list-main', { mouseWheel: true });
	}


    }
    //初始化高度 必须要
    $(function(){
       var b_height =  $('.keyword-bar').height() || 0;
        var ksHeight = window.innerHeight -73-53-b_height+10;
        //$('#ks-list').height(ksHeight);
		//loaded();
		setTimeout(function(){
            $('#mark').hide();
        },250)
    })

    //点击右边白色区分类时 反色效果
    $(document).on('click','#right-list-main li',function(){
        var o = $(this);
        o.addClass('hover')
        setTimeout(function(){
            o.removeClass('hover')
        },250)
    })
    
    function goDoctorRegSource(domObj){
        var domId = domObj.id;
        if(domId){
            var deptCode = domId.split(":")[0];
            var doctorCode = domId.split(":")[1];
            //2015年8月15日 12:35:54 周鉴斌注释 科室名称为空 deptName 为找到deptName定义
            var deptName =  domId.split(":")[2];
            $("#deptCode").val(deptCode);
            $("#deptName").val(deptName);
            $("#doctorCode").val(doctorCode);
            // 修复bug54 点击曾挂号医生，页面出现其他医生。
            $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/index?isSearchDoctor=1");
            $("#paramsForm").submit();
        }
    }
    
    function toRegSourceInfo(domObj){
        //alert($(domObj).attr("id"));
        $("#deptCode").val($(domObj).attr("id"));
        $("#deptName").val($(domObj).attr("name"));
        $("#tcInfo").val($(domObj).attr("value"));
        $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/index");
        $("#paramsForm").submit();
    }
    
    function goSearchDoctor(){
        $("#doctorCode").val("");
        $("#doctorName").val("");
        $("#searchType").val("doctor");
        $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/searchIndex");
        $("#paramsForm").submit();
    }
    
    function goSearchDept(){
        $("#deptCode").val("");
        $("#deptName").val("");
        $("#searchType").val("dept");
        $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/searchIndex");
        $("#paramsForm").submit();
    }
    
    function goSearch(){
        var searchCode = $("#searchCode").val();
        if(searchCode && searchCode == "1"){
            goSearchDoctor();
        }else if(searchCode && searchCode == "2"){
            goSearchDept();
        }
    }
    
    function doRefresh()
	{
		window.location.href="${basePath}mobileApp/register/refreshDepts?branchHospitalId=${commonParams.branchHospitalId}&branchHospitalCode=${commonParams.branchHospitalCode}"+
		"&appId=${commonParams.appId}&openId=${commonParams.openId}&appCode=${commonParams.appCode}&areaCode=${commonParams.appCode}"+
		"&regType=${commonParams.regType}&hospitalId=${commonParams.hospitalId}&hospitalCode=${commonParams.hospitalCode}&userId=${commonParams.userId}";
	}
	
	function doGoBack()
	{
		window.location.href="${basePath}mobileApp/register/hospitalList?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&regType=${commonParams.regType}";
	}
</script>