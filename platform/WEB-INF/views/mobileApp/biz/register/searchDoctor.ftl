<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <title>搜索医生</title>
</head>
<body style="background-color: #fff">
<div id="body">
    <div id="ks-search" class="flex-wrap row-flex">
       <div class="iconBox"><i class="icon-search"></i></div>
        <div class="search_input flexWidth1">
            <input type="text" class="yx-input" id="searchKeyword" oninput="searchDoctors(this.value)" placeholder="请输入关键字" autocomplete="off"/>
        </div>
        <div id="search_btn"  onclick="searchDoctorsButton()">医生搜索</div>
    </div>
    <div class="section" style="overflow: visible">
        <ul class="search-list" id="searchList">
        </ul>
    </div>
</div>
<form id="paramsForm" method="post">
<input type="hidden" id="userId" name="userId" value="${commonParams.userId}" />
<input type="hidden" id="openId" name="openId" value="${commonParams.openId}">
<input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}">
<input type="hidden" id="appId" name="appId" value="${commonParams.appId}">
<input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}">
<input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}">
<input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}" />
<input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}" />
<input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}" />


<input type="hidden" id="searchStr" name="searchStr">
<input type="hidden" id="deptCode" name="deptCode">
<input type="hidden" id="doctorCode" name="doctorCode">

<input type="hidden" id="isSearchDoctor" name="isSearchDoctor" value="1" />

<input type="hidden" id="regType" name="regType" value="${commonParams.regType}" />
<input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}" />
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
</body>
</html>
<script type="text/javascript">
$(function(){
    $("#searchKeyword").focus();
})

function searchDoctorsButton(){
    var searchStr = $("#searchKeyword").val();
    searchDoctors(searchStr , 'btn');
}

function searchDoctors(searchStr , type){
    if(searchStr == ""){
        return;
    }else{
        if(!type || type != 'btn'){
            //var reg = /^[0-9]+|[\u4E00-\u9FA5]+|[a-z]+|[A-Z]+$/; 
            var reg = /^[0-9]+|[\u4E00-\u9FA5]+$/; 
            if(!reg.test(searchStr)){
                return false;
            }
        }
        $("#searchStr").val(searchStr);
        var url = "${basePath}mobileApp/register/doctor/searchDoctors";
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
                var listDom = $("#searchList");
                var htmlStr = "";
                var doctors = data.message.doctors;
                if(doctors.length > 0){
                    for(var i = 0 ; i < doctors.length; i++){
                        var doctorInfoArray = doctors[i].split("#");
                        var doctorCode = "";
                        var deptCode = "";
                        var doctorName = "";
                        var deptName = "";
                        if(doctorInfoArray.length == 7){
                            doctorName = doctorInfoArray[0];
                            deptName = doctorInfoArray[1].split("-")[1];
                            doctorCode = doctorInfoArray[5];
                            deptCode = doctorInfoArray[6];
                        }
                        
                        htmlStr += "<li onclick='toRegSourceInfo(\"" + doctorCode +"\",\"" + deptCode  + "\")'>";
                        htmlStr += "<span class='title'>" + doctorName + "</span>&nbsp"
                        if(deptName != null && deptName != "null" && deptName != ""){
                            htmlStr += "<span class='label skinBgColor'>" + deptName + "</span>"
                        }
                        htmlStr += "</li>";
                    }
                }else{
                    htmlStr += "没有搜到该医生，请重新输入搜索值";
                }
                $(listDom).html(htmlStr);
           },  
           error : function(data) {  
                $Y.loading.hide();
           }  
        });  
    }
}

function toRegSourceInfo(doctorCode ,deptCode){
    $("#deptCode").val(deptCode);
    $("#doctorCode").val(doctorCode);
    $("#paramsForm").attr("action" ,"${basePath}mobileApp/register/doctor/index");
    $("#paramsForm").submit();
}
</script>