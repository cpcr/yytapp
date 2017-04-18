<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
    <title>${commonParams.hospitalName}</title>
    <script src="${basePath}mobileApp/js/common/iscroll.js" type="text/javascript"></script>
	<style type="text/css"> 
			html,body{height: 100%;overflow: hidden;}
		.scroller::-webkit-scrollbar{
			display: none;
		}

		.scroller {
			position: absolute;
			z-index: 1;
			-webkit-tap-highlight-color: rgba(0,0,0,0);
			overflow:auto;/* winphone8和android4+ */
			-webkit-overflow-scrolling: touch; /* ios5+ */
			height: 100%;
			width: 100%;
			-webkit-transform: translateZ(0);
			-moz-transform: translateZ(0);
			-ms-transform: translateZ(0);
			-o-transform: translateZ(0);
			transform: translateZ(0);
			-webkit-text-size-adjust: none;
			-moz-text-size-adjust: none;
			-ms-text-size-adjust: none;
			-o-text-size-adjust: none;
			text-size-adjust: none;
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
<div id="body" style="margin: 0;padding: 0;">
    <#if isHasSearChDoctor == 1> 
     <div class="section">
        <div class="search-view">
            <div class="typeWord">
                <select name="searchCode" id="searchCode" class="typeWord-option" >
                    <#if commonParams.regType == 2>
                    <option value="1" selected="selected">搜医生</option>
                    </#if>
                    <option value="2" >搜科室</option>
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
        <span id="${hadRegDoctor.deptCode}:${hadRegDoctor.doctorCode}" onclick="goDoctorRegSource(this)">${hadRegDoctor.doctorName}</span>
        </#list>
    </div>
    <div class="section" style="margin-bottom: 0">
        <div id="ks-list">
            <div class="ks-list-left">
                <div id="ks-left-list">
					   <div class="scroller">
                    <ul>
                        <#list depts as dept>
                            <li id="${dept.deptCode}"  onclick="select_ks(this)" <#if dept_index == 0>class="active"</#if>>${dept.deptName}</li>
                        </#list>
                    </ul>
					</div>
                </div>
                <div id="left-ks_arrow"></div>
            </div>
            <div class="ks-list-right">
               <div id="right-list-main" >
			   	   <div class="scroller">
                   <ul style="display: block" id="subDeptList">
                   <#list subDepts as subDept>
                       <li id="${subDept.deptCode}" name="${subDept.deptName}" value="${subDept.tcxh}|${subDept.fydw}|${subDept.fyzje}" onclick="toRegSourceInfo(this)">${subDept.deptName}</li>
                   </#list>
                   </ul>
				   </div>
               </div>
                <div id="right-ks_arrow"></div>
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
    document.addEventListener('touchmove', function (e) {
        if(e.target.nodeName == "BODY"){
            e.preventDefault();
            return false
        }
    }, false);


    //初始化高度 必须要
    $(function(){
        var b_height =  $('.keyword-bar').height() || 0;
        var ksHeight = window.innerHeight -73-53-b_height+10;
        $('#ks-list').height(ksHeight);

    })

    //选择科室一级分类事件
    function select_ks(obj){
        var obj = $(obj);
        var index = obj.index();
        $('#ks-left-list li').removeClass('active');
        obj.addClass('active');
        var deptCode = $(obj).attr("id");
        $("#deptCode").val(deptCode);
        var url = "${basePath}mobileApp/register/querySubDepts";
        var datas = $("#paramsForm").serializeArray();
        $Y.loading.show();
        jQuery.ajax( {  
           type : 'POST',  
           url : url,  
           data : datas,  
           dataType : 'json',  
           timeout:120000,
           success : function(data) { 
               $Y.loading.hide();
               var subDepts = data.message.subDepts; 
               if(subDepts){
                    var node = $("#subDeptList");
                    var htmlStr = "";
                    for(var i = 0 ; i < data.message.subDepts.length ; i++){
                        var tcxh = subDepts[i].tcxh==null?'':subDepts[i].tcxh;
                        var fydw = subDepts[i].moneys==null?'':subDepts[i].moneys[0].fydw;
                        var fyje = subDepts[i].fyzje==null?'':subDepts[i].fyzje;
                        htmlStr += "<li id='" + subDepts[i].deptCode + "'  name='" + subDepts[i].deptName + "' value='" + tcxh + "|" + fydw + "|" + fyje + "' onclick='toRegSourceInfo(this)'>" + subDepts[i].deptName + "</li>"
                    }
                    node.html(htmlStr);
				     $('#right-list-main .scroller')[0].scrollTop=0;
					
               }
           },  
           error : function(data) {  
                $Y.loading.hide();
                alert("网络异常,加载二级科室失败,请您重新操作!")  
           }  
        });  
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
        $("#searchType").val("doctor");
        $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/searchIndex");
        $("#paramsForm").submit();
    }
    
    function goSearchDept(){
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

    //点击右边白色区分类时 反色效果
    $(document).on('click','#right-list-main li,.keyword-bar span',function(){
        var o = $(this);
       o.addClass('hover')
        setTimeout(function(){
            o.removeClass('hover')
        },250)
    });
    
    function goDoctorRegSource(domObj){
        var domId = domObj.id;
        if(domId){
            var deptCode = domId.split(":")[0];
            var doctorCode = domId.split(":")[1];
            
            $("#deptCode").val(deptCode);
            $("#doctorCode").val(doctorCode);
            $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/index?isSearchDoctor=1");
            $("#paramsForm").submit();
        }
    }
    
	function doRefresh()
	{
		var freshFrom=$("<form></form>");
		freshFrom.append($('<input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />'));
		freshFrom.append($('<input type="hidden" name="branchHospitalId" value="${commonParams.branchHospitalId}"/>'));
		freshFrom.append($('<input type="hidden" name="branchHospitalCode" value="${commonParams.branchHospitalCode}"/>'));
		freshFrom.append($('<input type="hidden" name="branchHospitalName" value="${commonParams.branchHospitalName}"/>'));
		freshFrom.append($('<input type="hidden" name="appId" value="${commonParams.appId}"/>'));
		freshFrom.append($('<input type="hidden" name="openId" value="${commonParams.openId}"/>'));
		freshFrom.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}"/>'));
		freshFrom.append($('<input type="hidden" name="areaCode" value="${commonParams.areaCode}"/>'));
		freshFrom.append($('<input type="hidden" name="regType" value="${commonParams.regType}"/>'));
		freshFrom.append($('<input type="hidden" name="hospitalId" value="${commonParams.hospitalId}"/>'));
		freshFrom.append($('<input type="hidden" name="hospitalCode" value="${commonParams.hospitalCode}"/>'));
		freshFrom.append($('<input type="hidden" name="hospitalName" value="${commonParams.hospitalName}"/>'));
		freshFrom.appendTo("body");
		freshFrom.css('display','none');
		freshFrom.attr("method","post");
		freshFrom.attr("action","${basePath}mobileApp/register/refreshDepts");
		freshFrom.submit();
	}
	
	function doGoBack()
	{
		window.location.href="${basePath}mobileApp/register/hospitalList?openId=${sessionUser.id}&appCode=easyHealth&areaCode=ShenZheng&regType=${commonParams.regType}";
	}
</script>