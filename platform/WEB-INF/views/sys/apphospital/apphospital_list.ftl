<html>
<head>
	<#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/apphospital/sys.apphospital_list.js"></script>
    
    <title>APP医院</title>
</head>
<body>
<input type="hidden" name="parentAppId" id="parentAppId" value="${parentAppId}" />
<input type="hidden" name="currentHospitalId" id="currentHospitalId" value="${currentHospitalId}" />
<input type="hidden" name="platformsId" id="platformsId" value="${platformsId}" />

	<div id="content">

    <div class="container-fluid">

        <div class="space10"></div>
        <div class="row-fluid">
            <div class="space40"></div>
            <div class="row-fluid">

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
                                        <label class="checkboxTwoAll inline">
                                            <input type="checkbox" name="all">
                                        </label>
									</th>
	                                <th>医院全称</th>
	                                <th>医院区域</th>
	                                <th width="30">状态</th>
	                            </tr>
                            </thead>
                            <tbody id="hospital_tab">
                            	<#if hospitals?exists>
	                                <#list hospitals.list as hospital>
		                                <tr>
		                                    <td>
                                                <label class="checkboxTwo inline"><input name="chkHospitals" type="checkbox" value="${hospital.id}"></label>
		                                   </td>
		                                    <td style="display: none;">${hospital.id}</td>
		                                    <td style="display: none;">${hospital.status}</td>

		                                    <td>${hospital.name}</td>
		                                    <td>
		                                    	<#if areaCodeMap?exists>
			                						<#list areaCodeMap?keys as key>
			                							<#if key == hospital.areaCode>
			                            					${areaCodeMap[key]}
			                            				</#if>
			                            			</#list>
			                            		</#if>
		                                    </td>
		                                    <td>${hospital.cnStatus}</td>

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

        <div class="footer-tool">
            <div class="row-fluid">
                <div class="pull-right">
                    <button type="button" class="btn btn-save" onclick="$hospital.save();">添加</button>
                    <button type="button" class="btn btn-save" onclick="$hospital.close();">关闭</button>
                </div>
            </div>
        </div>

    </div>
</div>


</body>
</html>

