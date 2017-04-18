<html>
<head>
		<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/json_utils.js"></script>
    <script type="text/javascript" src="${basePath}js/sys/hospital/sys.hospital.js"></script>
    <title>功能选择</title>
</head>
<body>
	<#include "./sys/common/hospital_setting.ftl">
    <div id="content-header">
        <div class="widget-title"><h3 class="title">功能选择</h3></div>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="row-fluid">
                <div class="space10"></div>
                <div class="myStep s5">
                    <div class="myStepClick">
                        <a class="aStepClick a-s1" href="${basePath}sys/hospital/toEdit?id=${hospitalId}"></a>
                        <a class="aStepClick a-s2" href="${basePath}sys/branchHospital/toView?hospitalId=${hospitalId}"></a>
                        <a class="aStepClick a-s3" href="${basePath}sys/platformSettings/toView?hospitalId=${hospitalId}"></a>
                        <a class="aStepClick a-s4" href="${basePath}sys/paySettings/toView?hospitalId=${hospitalId}"></a>
                        <a class="aStepClick a-s5" href="${basePath}sys/optional/toView?hospitalId=${hospitalId}"></a>
                        <a class="aStepClick a-s6" href="${basePath}sys/customerMenu/toView?hospitalId=${hospitalId}"></a>
                    </div>
                </div>
            </div>
            <div class="widget-box">
                <div class="h22"></div>
                <div class="widget-content">
                    <div class="row-fluid">
                        <!--内容-->
                        <div class="f-Info">
                            <div class="f-name">
                               <div class="optionsF">可选功能</div>
                                <ul class="module-list">
                                		<#list optionals as optional>
                                				<li><a href="javascript:void(0);" onclick="$hospital.optional.addItem(this);" data-id="${optional.id}" data-conntroller="${optional.controllerPath}"><span class="text">${optional.name}</span><i class="icons-plus"></i></a></li>
                                		</#list>
                                </ul>
                            </div>
                            <div class="f-content">
                               <div class="optionsS"><span>已选择功能</span></div>
                                <ul class="optionsS-list">
                                	<!-- demo 
                                	<li><span class="text">optional.name</span><a class="green pull-right" data-id="id" data-controller="controllerPath" href="javascript:void(0);" onclick="$hospital.optional.delItem(this);">删除</a></li> -->
                                	
                                	<#list selHospitalOptionals as hospitalOptional>
                                		<script type="text/javascript">$('.module-list li a[data-id="${hospitalOptional.optional.id}"]').attr('sel', 'true').parent().hide();</script>
	                                	<li><span class="text">${hospitalOptional.optional.name}</span><a class="green pull-right" data-id="${hospitalOptional.optional.id}" data-controller="${hospitalOptional.optional.controllerPath}" href="javascript:void(0);" onclick="$hospital.optional.delItem(this);">取消</a></li>
                              		</#list>
                                </ul>
                            </div>
                        </div>
                        <!--内容 end-->
                    </div>
                </div>
            </div>
            <div class="footer-tool">
                <div class="row-fluid">
                    <button class="btn btn-remove" onclick="$hospital.back('${basePath}sys/paySettings/toView?hospitalId=${hospitalId}');">上一步</button>
                    <button class="btn btn-save" onclick="$hospital.optional.save();">下一步</button>
                </div>
            </div>

        </div>
    </div>
</div>
<!--content end-->

</body>
</html>
<script type="text/javascript">
	$hospital.id = '${hospitalId}';
</script>