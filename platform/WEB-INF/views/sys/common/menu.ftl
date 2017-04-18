<html>
<head>
<#include "./sys/common/common.ftl">
</head>
<body>
<!--sidebar-menu str-->
<div id="sidebar" style="height:530px;overflow:auto;">
    <ul>
   
		<@p.hasPermission value="yygl">
        	<li class="active"><a href="${basePath}sys/hospital/list" target="rightBottomFrame"><i class="icons-siderbar icons-hopital"></i><i class="caret"></i><span>医院管理</span></a> </li>
        </@p.hasPermission>
        
        <@p.hasPermission value="apphospital">
			<li><a href="${basePath}sys/apphospital/list" target="rightBottomFrame"><i class="icons-siderbar icons-hopital"></i><i class="caret"></i><span>App医院</span></a> </li>
		</@p.hasPermission>
        
        <@p.hasPermission value="gzbz">
			<li><a href="${basePath}sys/ruleIndex/hospitalList" target="rightBottomFrame"><i class="icons-siderbar icons-rules"></i><i class="caret"></i><span>规则配置</span></a></li>
        </@p.hasPermission>
		<@p.hasPermission value="xxgl">
			<li><a href="${basePath}message/reply?method=list" target="rightBottomFrame"><i class="icons-siderbar icons-nes"></i><i class="caret"></i><span>消息管理</span></a></li>
        </@p.hasPermission>
        <@p.hasPermission value="ghgl">
       		<li><a href="${basePath}sys/user/list" target="rightBottomFrame"><i class="icons-siderbar icons-account"></i><i class="caret"></i><span>账户管理</span></a></li>
        </@p.hasPermission>
		<@p.hasPermission value="jsgl">
			<li><a href="${basePath}sys/role/list" target="rightBottomFrame"><i class="icons-siderbar icons-role"></i><i class="caret"></i><span>角色管理</span></a></li>
        </@p.hasPermission>
		<@p.hasPermission value="doctorManager">
            <li><a href="http://webcdn.yunyichina.cn/hms/dist/list-hospital.html?username=test&account=${loginedUser.userName}" target="rightBottomFrame"><i class="icons-siderbar icons-role"></i><i class="caret"></i><span>职工医保管理</span></a></li>
		</@p.hasPermission>
		<@p.hasPermission value="zygl">
        	<li><a href="${basePath}sys/resource/list" target="rightBottomFrame"><i class="icons-siderbar icons-access"></i><i class="caret"></i><span>资源管理</span></a></li>
        </@p.hasPermission>
		<@p.hasPermission value="gzjggl">
        	<li><a href="${basePath}sys/organization/list" target="rightBottomFrame"><i class="icons-siderbar icons-account"></i><i class="caret"></i><span>组织/机构管理</span></a></li>
	    </@p.hasPermission>
		<@p.hasPermission value="xxmb">
	    	<li><a href="${basePath}msgpush/hospital/hospitalList" target="rightBottomFrame"><i class="icons-siderbar icons-temp"></i><i class="caret"></i><span>消息模板</span></a></li>
	   	</@p.hasPermission>

		<@p.hasPermission value="ddgl">
	   		<li><a href="${basePath}order/orderHospitalList" target="rightBottomFrame"><i class="icons-siderbar icons-temp"></i><i class="caret"></i><span>订单管理</span></a></li>
		</@p.hasPermission>
		<@p.hasPermission value="cacheManage">
       		<li><a href="${basePath}sys/cacheManage/cacheManageHospitalList" target="rightBottomFrame"><i class="icons-siderbar icons-temp"></i><i class="caret"></i><span>缓存管理</span></a></li>
       	</@p.hasPermission>
		<@p.hasPermission value="meterial">
       		<li><a href="${basePath}message/meterial?method=list" target="rightBottomFrame"><i class="icons-siderbar icons-nes"></i><i class="caret"></i><span>素材管理</span></a></li>
		</@p.hasPermission>
		<@p.hasPermission value="customservice">
		<li><a href="${basePath}/sys/customService/list" target="rightBottomFrame"><i class="icons-siderbar icons-nes"></i><i class="caret"></i><span>客服中心</span></a></li>
		</@p.hasPermission>
		<@p.hasPermission value="statistics">
       		<li><a href="${basePath}statistics/index" target="view_window" target="rightBottomFrame"><i class="icons-siderbar icons-nes"></i><i class="caret"></i><span>后台管理</span></a></li>
		</@p.hasPermission>
		<@p.hasPermission value="lookuplogs">
            <li><a href="${basePath}sys/user/lookuplogs" target="rightBottomFrame"><i class="icons-siderbar icons-nes"></i><i class="caret"></i><span>查看日志</span></a></li>
        </@p.hasPermission>
        <@p.hasPermission value="exceptionOrderList">
            <li><a href="${basePath}order/getExceptionOrderList" target="rightBottomFrame"><i class="icons-siderbar icons-nes"></i><i class="caret"></i><span>异常单处理</span></a></li>
        </@p.hasPermission>
	</ul>
</div>
<!--sidebar-menu end-->

<script type="text/javascript">
	$(function(){
		$('#sidebar ul li').click(function() {
			$('#sidebar ul li.active').removeClass('active');
			$(this).addClass('active');
		});
	});
</script>
</body>
</html>