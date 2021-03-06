<html>
<head>
	<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/hospital/sys.hospital.js"></script>
    
    <title>医院管理</title>
</head>
<body>
	<div id="content">
	<!--医院及系统设置-->
	 <div id="content-top">
        <div class="container-fluid">
            <div class="box">
                <!--settings str-->
                <div id="settings">
                    <div class="set-msg dropdown">
                        <a class="dropdown-toggle" href="javascript:void(0);" data-toggle="dropdown" >
                            <span class="text">当前账户：${loginedUser.userName}</span>
                            <i class="icons_settings icons-set"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a onclick="toModifyPwd();"><span class="text">修改密码</span><i class="icons_settings icons-password"></i></a></li>
                            <li><a onclick="logout();"><span class="text">退出登录</span><i class="icons_settings icons-loginout"></i></a></li>
                        </ul>
                    </div>
                </div>
                <!--settings end-->
            </div>
        </div>
    </div>
	
	
	
    <div id="content-header">
        <div class="widget-title"><h3 class="title">医院管理</h3></div>
    </div>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
            <div class="space40"></div>
            <div class="row-fluid"> 
                <div class="pull-left">
                	<@p.hasPermission value="hospitalManageAdd">
                    	<button type="button" class="btn btn-ok" onclick="$hospital.toAdd();">新增</button>
                    </@p.hasPermission>
                    <!--<button type="button" class="btn btn-ok" onclick="$hospital.updateBulkStatus('1');">启用</button>
                    <button type="button" class="btn btn-ok" onclick="$hospital.updateBulkStatus('0');">禁用</button>-->
                </div>
                <div class="pull-right" id="search">
                	<form method="post" action="" accept-charset="utf-8">
                		<#if hospitals?exists>
	                		<input type="hidden" name="pageNum" value="${hospitals.pageNum}" />
	            			<input type="hidden" name="pageSize" value="${hospitals.pageSize}" />
	            			<input type="hidden" name="pages" value="${hospitals.pages}" />
	            			<input type="hidden" name="total" value="${hospitals.total}" />
            			</#if>
	                    <input type="text" name="search"  value="${search}" placeholder="请输入医院名称、医院编码、联系人"/>
                	</from>
                    <button class="tip-bottom" type="submit">
                        <i class="icon-search icon-white"></i>
                    </button>
                </div>
            </div>
            <div class="widget-box">
                <div class="space10"></div>
                <div class="widget-content form-check">
                    <div class="row-fluid">
                        <table class="table table-bordered table-textCenter table-striped table-hover">
                            <thead>
                            	<tr>
                                	<th width="50">
										<!--<label class="checkboxTwoAll inline">
                                        	<input type="checkbox" name="all">
                                    	</label>-->
									</th>
	                                <th width="30" >医院编码</th>
	                                <th>医院全称</th>
	                                <th>类型</th>
	                                <th>医院区域</th>
	                                <th width="100">联系人</th>
	                                <th width="120" >联系人电话</th>
	                                <th style="display: none;">注册日期</th>
	                                <th width="30">状态</th>
	                                <th>管理</th>
	                            </tr>
                            </thead>
                            <tbody id="hospital_tab">
                            	<#if hospitals?exists>
	                                <#list hospitals.list as hospital>
		                                <tr>
		                                    <td>
		                                    	${hospital_index + 1}
		                                    	<!--<label class="checkboxTwo inline"><input name="chkHospitals" type="checkbox" value="${hospital.id}"></label>-->
		                                    </td>
		                                    <td style="display: none;">${hospital.id}</td>
		                                    <td style="display: none;">${hospital.status}</td>
		                                    <td >${hospital.code}</td>
		                                    <td>${hospital.name}</td>
		                                    <td>
		                                    	<#if hospital.svcType?exists>
			                						<#if hospital.svcType=="1">
			                            				医院
			                            			<#elseif hospital.svcType=="2">
			                            				平台
			                            		    <#else>
			                            		    	未知
			                            			</#if>
			                            		<#else>
			                            		 	未知
			                            		</#if>
		                                    </td>
		                                    <td>
		                                    	<#if areaCodeMap?exists>
			                						<#list areaCodeMap?keys as key>
			                							<#if key == hospital.areaCode>
			                            					${areaCodeMap[key]}
			                            				</#if>
			                            			</#list>
			                            		</#if>
		                                    </td>
		                                    <td>${hospital.contactName}</td>
		                                    <td >${hospital.contactTel}</td>
		                                    <td style="display: none;">${hospital.ct?date}</td>
		                                    <td>${hospital.cnStatus}</td>
		                                    <td>
		                                    	<@p.hasPermission value="hospitalManageEdit">
		                                        	<a href="javascript:;" onclick="$hospital.toEdit(this)">编辑</a>|
		                                        </@p.hasPermission>
												<@p.hasPermission value="hospitalManageUpdateStatus">
		                                        <#if hospital.status == 1>
		                                        	<a class="red" href="javascript:void(0);" onclick="$hospital.updateStatus(this, $hospital.hospital_invalid_status)">禁用</a>|
			                                    <#else>
			                                        <a href="javascript:void(0);" onclick="$hospital.updateStatus(this, $hospital.hospital_valid_status)">启用</a>|
		                                        </#if>
												</@p.hasPermission>
												<@p.hasPermission value="hospitalManageWhiteListConfig">
		                                        	<a href="javascript:void(0);" onclick="goWhiteListConfig('${hospital.id}' ,'${hospital.code}')">白名单</a>|
		                                        </@p.hasPermission>
												<@p.hasPermission value="hospitalManageExtension">
		                                        	<a href="javascript:void(0);" onclick="goExtension('${hospital.id}' ,'${hospital.code}')">推广支持</a>
												</@p.hasPermission>
		                                    </td>
		                                </tr>
									</#list>
								<#else>
									<td colspan="10">暂无医院数据</td>
								</#if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="pagination pagination-centered">
            <#if hospitals?exists>
            <ul>
                <li><a href="javascript:;" onclick="$hospital.changePage(${hospitals.prePage});">上一页</a></li>
                <#if hospitals.pages != 0>
	                <#list 1..hospitals.pages as p>
	                	<#if pageNum == p>
	                		<li class="disabled"><span>${p}</span></li>
	                	<#else>
	                    	<li><a href="javascript:;" onclick="$hospital.changePage(${p});">${p}</a></li>
	                  	</#if>
	                </#list>
                </#if>
                <li><a href="javascript:;" onclick="$hospital.changePage(${hospitals.nextPage});">下一页</a></li>
            </ul>
            <div class="pageGoto">
                <span>转到第</span> <input type="text" id="skipPage" class="goto_input"/> <span>页</span>
                <a href="javascript:;" class="goto" onclick="$hospital.changePage($('#skipPage').val());">跳转</a>
            </div>
            </#if>
        </div>
    </div>
</div>
<!--content end-->
<!-- 版权声明 -->
<#include "./sys/common/footer.ftl">

</body>
</html>

