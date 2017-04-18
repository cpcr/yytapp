
<html>
<head>
<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/json_utils.js"></script>
    <title>编辑规则配置</title>
    <style>

    	.s_tartR_equest,.s_tartR_equest font{color:yellow}
    	.e_ndR_equest,.e_ndR_equest font{color:yellow}
    	.d_atet_ime,.d_atet_ime font{color:#00CCFF}
    	.er_rorT_ext,.er_rorT_ext font{color:red}
    	.dakuohao,.dakuohao font{color: #FFCC00}
    	.l_ogF_ile,.l_ogF_ile font{color:#CC9933}
    	.key_word1{color:#33FF33}
    	.key_word2{color:#99FF99}
    	
    </style>
</head>
<body>
<!--sidebar-menu end-->
<!--content str-->

    <div class="container-fluid">

        <div class="row-fluid">
            <div class="widget-box bangKa">
                <div class="space10"></div>
                <form class="form-horizontal evenBg" id="logViewForm"  onsubmit="return false;" >
                    <div class="widget-content">
                        <div class="row-fluid"> 
                            

                            <div class="control-group">
                                <label class="control-label" style=" padding-top: 0px;">命令</label>
                                <div class="line">
                                    <input type="text" name="cmd" id="cmd" style="width:80%" value2="test" value="tail -n 2000 yunyi.log | grep -A 20 -B 3 -i -n 20"/>
                                </div>
                            </div>
                            
                            <div class="control-group" style="height:500px;over-flow:y">
                                <label class="control-label" style=" padding-top: 0px;">结果</label>
                                <div class="line" id="divLog" style="background-color:#6B8E23;height:100%;overflow:auto;color1:white">
                                	<textarea type="text" name="resultText" id="resultText" value="" style="width:80%;height:500px;display:none"></textarea>
                                </div>
                            </div>
 
                            <div class="control-group">
                                <label class="control-label" style=" padding-top: 0px;">预设关键字</label>
                                <div class="line">
                                    <input type="text" name="key_word1" id="key_word1" style="width:80%" value="warn|nullException"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br/><br/>
                    <div class="space20" align="center" style="text-align:center">
                    	<button class="btn btn-save" type="button" onclick="searchLog();">查询</button>
                    	<select name="selectLine" id="selectLine" onchange="selectLineChange(this)">
		                    		<option value="">全部</option>
		                    		<option value="100">100行</option>
		                    		<option value="200">200行</option>
		                    		<option value="500">500行</option>
		                    		<option value="800">800行</option>
		                    		<option value="1000">1000行</option>
		                    		<option value="1500">1500行</option>
		                    		<option value="2000">2000行</option>
		                    		<option value="3000">3000行</option>
		                    		<option value="4000">4000行</option>
		                    		<option value="5000">5000行</option>
		                    		<option value="10000">10000行</option>
		                    		<option value="20000">20000行</option>
		                    		<option value="many-file">多文件搜索</option>
		                    	</select>
		                    	<input type="hidden" name="ip" id="ip" value="" placeholder="ip地址"/>
                    
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
function searchLog() {
	if ($("#cmd").val() == "") {
		return;
	}
	
	$("#divLog").html("");
	
	//$Y.loading.show('执行查询,请等待..');
	var datas = $("#logViewForm").serializeArray();
	 $.ajax({
        type: 'POST',
        url: "${basePath}/sys/logView/grep",
        data: datas,
        dataType: 'json',
        timeout: 120000,
        success: function (data) {
            //$Y.loading.hide()
            console.log(data);
            if (data.message) {
            	var msg = data.message;
                $("#divLog").html(msg);
            } else {
				 $("#divLog").html("没有匹配的日志");
            }
        },
        error: function (data) {
           // $Y.loading.hide()
            $("#divLog").html("查询错误:"+JSON.stringify(data));
        }
    });
}

function selectLineChange(obj) {
	if ($(obj).val() == "") {
		$("#cmd").val("grep -A 20 -B 3 -i -n 20");
	}
	else if ($(obj).val() == "many-file") {
		var date = new Date(); 
		var mon = date.getMonth() + 1;
		var day = date.getDate();
		var nowDay = date.getFullYear() + "-" + (mon<10?"0"+mon:mon) + "-" +(day<10?"0"+day:day);
		$("#cmd").val("grep -A 20 -B 3 -i -n 异常单 yunyi-"+nowDay+"*.log");
		return;
	}
	else {
		$("#cmd").val("tail -n "+$(obj).val()+ " yunyi.log | grep -A 20 -B 3 -i -n 20");
	}
	
	searchLog();
}
</script>
<!--content end-->
</body>
</html>

