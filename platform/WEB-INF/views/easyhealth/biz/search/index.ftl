<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <title>搜索</title>
    <style type="text/css">
    	
/** 水平伸缩容器**/
.row-flex{
  -moz-box-orient: horizontal;
  -webkit-box-orient: horizontal;
  -moz-box-direction: normal;
  -webkit-box-direction: normal;
  -moz-box-lines: multiple;
  -webkit-box-lines: multiple;
  -ms-flex-flow: row wrap;
  -webkit-flex-flow: row wrap;
  flex-flow: row wrap;
}


/** 伸缩容器**/
.flex-wrap{
  /** 各种版本兼容**/
  display: -webkit-box;
  display: -moz-box;
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex;
}
.flexWidth1{
  -webkit-box-flex: 1;
  -moz-box-flex: 1;
  -ms-flex: 1;
  -webkit-flex:1;
  flex:1;
}
#ks-search #search_btn{
  
    position: static;
    background: none;
    color: #37b494;
    border: none;
    font-size: 16px;
    text-align:right;
    display:block;
    margin:0;
    padding:10px;
    line-height:1
 
}
#ks-search {
    padding: 0;
    padding-top: 5px;
    border-bottom: solid 1px #efefef;
    position: relative;
}
.iconBox{ 
	width: 25px;
	padding-left: 10px;
	padding-top: 12px;
}
#ks-search .icon-search{ position: static;display:inline-block;line-height:40px;}
#ks-search .search_input{
  padding:0;
  margin:0
}
#ks-search .yx-input{
 color:#666;
 font-size:14px;
 padding: 10px 0;
 height:auto;
}
    </style>
</head>
<body style="background-color: #fff">
<div id="body">
<div style="height:15px;background-color: #eee;"></div>
    <div id="ks-search" class="flex-wrap row-flex">
        <div class="iconBox"><i class="icon-search"></i></div>
        <div class="search_input flexWidth1">
            <input type="text" class="yx-input" id="searchKeyword" oninput="doSearch(this.value)" placeholder="请输入关键字" autocomplete="off"/>
        </div>
        <div id="search_btn" onclick="search()"><#if commonParams.searchType == "hospital">医院搜索</#if><#if commonParams.searchType == "dept">科室搜索</#if><#if commonParams.searchType == "doctor">医生搜索</#if></div>
    </div>
    <div class="section" style="overflow: visible">
        <ul class="search-list" id="searchList">
        </ul>
    </div>
</div>
<form id="paramsForm" method="post" action="${basePath}easyhealth/search/doSearch">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
    <input type="hidden" id="searchStr"  name="searchStr"  value="${commonParams.searchStr}"/>
    <input type="hidden" id="appCode"    name="appCode"    value="${commonParams.appCode}"/>
    <input type="hidden" id="areaCode"   name="areaCode"   value="${commonParams.areaCode}"/>    
    <input type="hidden" id="searchType" name="searchType" value="${commonParams.searchType}"/> 
    <input type="hidden" id="regType"    name="regType"    value="${commonParams.regType}"/>
    <input type="hidden" id="openId" name="openId" value="${sessionUser.id}">
    
    <input type="hidden" id="appId"  name="appId">
    <input type="hidden" id="hospitalId" name="hospitalId" />
    <input type="hidden" id="hospitalCode" name="hospitalCode"  />
    <input type="hidden" id="hospitalName" name="hospitalName"  />
    <input type="hidden" id="branchHospitalId" name="branchHospitalId"  />
    <input type="hidden" id="branchHospitalCode" name="branchHospitalCode"  />
    <input type="hidden" id="branchHospitalName" name="branchHospitalName"  />
    <input type="hidden" id="deptCode" name="deptCode" />
    <input type="hidden" id="deptName" name="deptName"  />
    <input type="hidden" id="doctorCode" name="doctorCode" />
    
    
    <input type="hidden" id="deptNameKey" name="deptNameKey" />
    <input type="hidden" id="doctorNameKey" name="doctorNameKey" />
    <input type="hidden" id="parentDeptCode" name="parentDeptCode" />
    <input type="hidden" id="parentDeptName" name="parentDeptName" />
    <input type="hidden" id="isSearchDoctor" name="isSearchDoctor" value="1"/>
    <!--从搜索界面跳转到医生界面的标志，用于刷新返回-->
    <input type="hidden" id="viaFlag" name="viaFlag" value="searchDoctor"/>
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>
<script type="text/javascript">
$(function(){
	var keyword=$('#searchStr').val();
	if(keyword){
		$('#searchKeyword').val(keyword);
		$('#search_btn').click();
	}
	$('#searchKeyword').focus();
});


	function doRefresh()
	{
		var freshForm=$("<form></form>");
		freshForm.append($('<input type="hidden" name="openId" value="${commonParams.openId}"/>'));
		freshForm.append($('<input type="hidden" name="appCode" value="${commonParams.appCode}"/>'));
		freshForm.append($('<input type="hidden" name="areaCode" value="${commonParams.areaCode}"/>'));
		freshForm.append($('<input type="hidden"  name="searchType" value="${commonParams.searchType}"/>'));
		freshForm.appendTo("body");
		freshForm.css('display','none');
		freshForm.attr("method","post");
		freshForm.attr("action","${basePath}easyhealth/search/index");
		freshForm.submit();
	}
	
	function doGoBack()
	{
		if(IS.isMacOS){
			try {
              window.appCloseView(true);
  			} catch (e) {
            //  alert('IOS的方法出错');
          	}
		}else if(IS.isAndroid){
          	try {
              window.yx129.appCloseView(true);
          	} catch (e) {
           	//   alert('Android的方法出错');
          	}
       	}else{
       		go(appPath + 'easyhealth/userCenterIndex');
        }
	}
	
function search(){
    var searchStr = $("#searchKeyword").val();
    $('#search_btn').css('color','#000');
    setTimeout(function(){
    	 $('#search_btn').removeAttr('style');
    },300)
    doSearch(searchStr);
}

function doSearch(searchStr){
    if(searchStr == ""){
        return;
    }else{
        var reg = /^[0-9]+|[\u4E00-\u9FA5]+$/; 
        if(!reg.test(searchStr)){
            return false;
        }
        $("#searchStr").val(searchStr);
        var searchType = "${commonParams.searchType}";
        var url = "${basePath}easyhealth/search/doSearch";
        var datas = $("#paramsForm").serializeArray(); 
        $Y.loading.show(); 
        jQuery.ajax({  
           type : 'POST',  
           url : url,  
           data : datas,  
           dataType : 'json',  
           timeout : 120000,
           success : function(data) { 
                $Y.loading.hide();
                var listDom = $("#searchList");
                var htmlStr;
                if(searchType == "hospital"){
                    htmlStr = showHospitals(data);
                }else if(searchType == "dept"){
                    htmlStr = showDepts(data);
                }else if(searchType == "doctor"){
                    htmlStr = showDoctors(data);
                }
                $(listDom).html(htmlStr);
           },  
           error : function(data) {  
                $Y.loading.hide();
           }  
        });  
    }
}

function showHospitals(data){
    var htmlStr = "";
    var entityList = data.message.entityList;
    if(entityList && entityList.length > 0){
        for(var i = 0 ; i < entityList.length; i++){
            htmlStr += "<li onclick='toHospitalInfo(\"" + entityList[i].appId +"\",\"" + entityList[i].appCode  
                + "\",\"" + entityList[i].areaCode + "\",\"" + entityList[i].hospCode 
                + "\",\"" + entityList[i].hospId + "\",\"" + entityList[i].hospName + "\")'>";
            htmlStr += "<span class='title'>" + entityList[i].hospName + "</span>&nbsp"
            htmlStr += "</li>";
        }
    }else{
         htmlStr += "没有搜到该医院,请重新输入搜索值";
    }
    return htmlStr;
}


function toHospitalInfo(appId ,appCode,areaCode , hospitalCode,hospitalId,hospitalName){
    var url = "${basePath}mobileApp/register/index";
    var param = "?appId=" +appId + "&appCode=" + appCode + "&areaCode=" + areaCode + "&regType=2" + "&openId=${sessionUser.id}"
                + "&hospitalCode=" + hospitalCode + "&hospitalId=" + hospitalId;
    window.location = url + param;
}

function showDepts(data){
    var htmlStr = "";
    var entityList = data.message.entityList;
    if(entityList && entityList.length > 0){
        for(var i = 0 ; i < entityList.length; i++){
            htmlStr += "<li onclick='goSearchDeptNext(\"" + entityList[i] + "\")'>";
            htmlStr += "<span class='title'>" + entityList[i] + "</span>"
            htmlStr += "</li>";
        }
    }else{
         htmlStr += "没有搜到该科室,请重新输入搜索值";
    }
    return htmlStr;
}

function goSearchDeptNext(deptNameKey){
    $("#deptNameKey").val(deptNameKey);
    var url = "${basePath}mobileApp/register/doctor/deptInfo";
    var datas = $("#paramsForm").serializeArray(); 
    $Y.loading.show(); 
    jQuery.ajax({  
       type : 'POST',  
       url : url,  
       data : datas,  
       dataType : 'json',  
       timeout:120000,
       success : function(data) { 
           $Y.loading.hide();
           if(data.message.dept){
               var dept = data.message.dept;
               if(data.message.isGoRegInfo){
                   goDeptRegInfo(dept);
               }else{
                   geSubDepts(dept);
               }
           }
        },  
        error : function(data) {  
            $Y.loading.hide();
        }  
    });   
}

function goDeptRegInfo(dept){
   $("#paramsForm").formEdit(dept);
   $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/index");
   $("#paramsForm").submit(); 
}

function geSubDepts(dept){
    $("#paramsForm").formEdit(dept);
    $("#parentDeptCode").val(dept.deptCode);
    $("#parentDeptName").val(dept.deptName);
    $("#paramsForm").attr("action" ,"${basePath}easyhealth/search/querySubDepts");
    $("#paramsForm").submit(); 
}

function showDoctors(data){
    var htmlStr = "";
    var entityList = data.message.entityList;
    if(entityList && entityList.length > 0){
        for(var i = 0 ; i < entityList.length; i++){
            var doctorArray = entityList[i].split("#");
            htmlStr += "<li onclick='goDoctorRegInfo(\"" + entityList[i]  + "\")'>";
            htmlStr += "<span class='title'>" + doctorArray[0] + "</span>&nbsp"
            if(doctorArray[1] != null && doctorArray[1] != "null"){
                htmlStr += "<span class='label skinBgColor'>" + doctorArray[1] + "</span>"
            }
            htmlStr += "</li>";
        }
    }else{
        htmlStr += "没有搜到该医生，请重新输入搜索值";
    }
    return htmlStr;
}

function goDoctorRegInfo(doctorNameKey){
    $("#doctorNameKey").val(doctorNameKey);
    var url = "${basePath}easyhealth/search/doctorInfo";
    var datas = $("#paramsForm").serializeArray(); 

    $Y.loading.show(); 
    jQuery.ajax({  
       type : 'POST',  
       url : url,  
       data : datas,  
       dataType : 'json',  
       timeout:120000,
       success : function(data) { 
           $Y.loading.hide();
           var doctor = data.message.doctor;
           $("#paramsForm").formEdit(doctor);
           $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/index");
           $("#paramsForm").submit();
        },  
        error : function(data) {  
            $Y.loading.hide();
        }  
    });  
}


$.fn.formEdit = function(data){
    return this.each(function(){
        var elementDom;
        var elementDomName;
        if(data == null){
            this.reset(); 
            return; 
        }
        for(var i = 0; i < this.length; i++){  
            elementDom = this.elements[i];
            elementDomName = elementDom.name;
            if(data[elementDomName] == undefined){ 
                continue;
            }
            elementDom.value = data[elementDomName];
        }
    });
};
</script>