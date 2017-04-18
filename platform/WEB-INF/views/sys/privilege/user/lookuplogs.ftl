<html>
<head>
<#include "./sys/common/common.ftl">
<script type="text/javascript">
    $(function () {
        getHospitals();
        
        var myDate = new Date();
        var value = myDate.getFullYear()+"-"+(myDate.getMonth()>9?(myDate.getMonth()+1):'0' + (myDate.getMonth()+1))+"-"+(myDate.getDate()>9?myDate.getDate():'0' + myDate.getDate());
        $('#beginTime').val(value+" 00:00:00");
        $('#endTime').val(value+" 23:59:59");
    });
    
    function getHospitals() {
        var url = path + "/sys/user/getSysHospitals";
        $.ajax({
            type : 'POST',  
            url : url,  
            data : "",  
            dataType : 'json',  
            timeout:120000,
            error: function(data) {
                alert("ajax报错");
            },
            success: function(data) {
                if (data.status == 'OK' && data.message) {
                    var obj = data.message.entityList;
                    if(obj) {
                        $("#hospital").empty();
                        for(var i=0;i<obj.length;i++) {
                            if(i==0) {
                                $("#hospital").append("<option selected='selected' value='"+obj[i].hospitalCode+"'>"+obj[i].hospitalName+"</option>");
                                getBranchs();
                            } else {
                                $("#hospital").append("<option value='"+obj[i].hospitalCode+"'>"+obj[i].hospitalName+"</option>");
                            }
                        }
                    }
                }
            }
        });
    }
    
    function getBranchs() {
        var hospital = $('#hospital').val();
        if(hospital=="") {
            return;
        }
        var url = path + "/sys/user/getSysBranchs?hospitalCode=" + hospital;
        $.ajax({
            type : 'POST',  
            url : url,  
            data : "",  
            dataType : 'json',  
            timeout:120000,
            error: function(data) {
                alert("ajax报错");
            },
            success: function(data) {
                if (data.status == 'OK' && data.message) {
                    var obj = data.message.branchs;
                    if(obj) {
                        $("#branch").empty();
                        for(var i=0;i<obj.length;i++) {
                            if(i==0) {
                                $("#branch").append("<option selected='selected' value='"+obj[i].code+"'>"+obj[i].name+"</option>");
                            } else {
                                $("#branch").append("<option value='"+obj[i].code+"'>"+obj[i].name+"</option>");
                            }
                        }
                    }
                }
            }
        });
    }
    
    function doSearch() {
        var hospital = $('#hospital').val();
        var branch = $('#branch').val();
        var beginTime = $('#beginTime').val();
        var endTime = $('#endTime').val();
        var isError = $('#isError').val();
        var keywords = $('#keywords').val();
        var url = path + "/sys/user/getSysLogs?hospitalCode="+hospital+"&branchHospitalCode="+branch;
        $.ajax({
            type : 'POST',  
            url : url,  
            data : {'beginTime':beginTime,'endTime':endTime,'keywords':keywords,'isError':isError},  
            dataType : 'json',  
            timeout:120000,
            error: function(data) {
                alert("ajax报错");
            },
            success: function(data) {
                if (data.status == 'OK' && data.message) {
                    var obj = data.message.contents;
                    $("#textContent").html(obj);
                }
            }
        });
    }
</script>
</head>
<body>
<!--content str-->
    <#include "./sys/common/hospital_setting.ftl">
    <!--医院及系统设置 end-->
    <div id="content-header">
        <div class="widget-title"><h3 class="title">查看日志</h3></div>
    </div>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
            <div class="space40"></div>
            <div class="row-fluid">
                <div class="pull-left">
                                        医院：
                    <select id="hospital" onchange="getBranchs()">
                        <option value="" code="" selected="selected" >选择医院</option>
                    </select>
                                        分院：
                    <select id="branch">
                        <option value="" code="" selected="selected" >选择分院</option>
                    </select>
                    
                    <br>
                                        起止时间：
                    <input class="span4" type="text" placeholder="YYYY-MM-DD HH:mm:ss" name="beginTime" id="beginTime"/>
                                        至
                    <input class="span4" type="text" placeholder="YYYY-MM-DD HH:mm:ss" name="endTime" id="endTime"/>
                    <br>                    
                                        关键字：
                    <input class="span4" type="text" value="" name="keywords" id="keywords"/>
                                        只查Error：
                    <select id="isError">
                        <option value="0" selected="selected" >否</option>
                        <option value="1" >是</option>
                    </select>
                    
                    <button type="button" class="btn btn-ok" onclick="doSearch();">查询</button>
                </div>
            </div>
            <div class="widget-box">
                <div class="space10"></div>

                <div class="tab_content textArea">
                   <div class="no_extra">
                       <div class="edit_area clearfix" id="textContent" contenteditable="true" style="overflow-y: auto; overflow-x: hidden;">
                       </div>
                   </div>
                </div>
            </div>
        </div>
        
    </div>
</div>
<!--content end-->
<!-- 版权声明 -->
<#include "./sys/common/footer.ftl">
</body>
</html>

