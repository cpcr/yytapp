<html>
<head>
    <#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/apphospital/sys.apphospital.js"></script>
	
    <title>医院信息</title>
    <style type="text/css">
        h4.h4{margin: 10px 0}
    </style>
</head>
<body>
<#include "./sys/common/hospital_setting.ftl">
    <div id="content-header">
        <div class="widget-title"><h3 class="title">App医院信息</h3></div>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="widget-box">
                <div class="h22"></div>
                <div class="widget-content">
                    <div class="row-fluid">
                        <!--内容-->
                        <form class="form-horizontal">
                            <div class="space30"></div>
                            <input name="hospitalId" id="hospitalId" type="hidden" value="${hospitalId}" />

                            <div class="control-group">
                                <label class="control-label" >医院</label>
                                <div class="controls">
                                    <input name="name" value="${hospital.name}" type="text" class="span5" readonly/>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label" >应用平台</label>
                                <div class="controls">
                                    <select id="platforms" onchange="$hospital.getAppId(this)">

                                        <#if platformId !=null && platformId!=''>
                                                <option value="0" code="" >选择平台</option>
                                            <#else>
                                                <option value="0" code="" selected="selected" >选择平台</option>
                                        </#if>


                            			 <#list platformsMap as platform>

                                             <#if platform.id == platformId>
                                                    <option value="${platform.id}" code="${platform.code}" selected="selected">${platform.name}</option>
                                                 <#else>
                                                     <option value="${platform.id}" code="${platform.code}" >${platform.name}</option>
                                             </#if>

                            				
                            			 </#list>

                                    </select>
                                   
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label" >AppId</label>
                                <div class="controls">
                                    <input name="appid" id="appid" value="${appid}" type="text" class="span5" readonly/>
                                </div>
                            </div>

                        </form>
                        <!--内容 end-->
                    </div>
                </div>
            </div>
            <div class="space30"></div>
            <div class="pull-right">
                <button type="button" class="btn btn-ok" onclick="$hospital.toAdd();">新增</button>
            </div>
            <div class="space30"></div>
            <div class="widget-box">
                <div class="space10"></div>
                <div class="widget-content form-check">
                    <div class="row-fluid">
                        <table class="table table-bordered table-textCenter table-striped table-hover">
                            <thead>
                            <tr>
                                <th width="50">

                                </th>

                                <th>医院全称</th>
                                <th>排序值</th>
                                <th>管理</th>
                            </tr>
                            </thead>
                            <tbody id="hospital_tab">
                            <#if apphospitals?exists && apphospitals?has_content>
                                <#list apphospitals as apphospital>
                                    <tr>
                                        <td>
                                            ${apphospital_index + 1}
                                        </td>
                                        <td style="display: none;">${apphospital.id}</td>
                                        <td>${apphospital.hospitalName}</td>
                                        <td>${apphospital.sort}</td>
                                        <td>
                                            <a href="javascript:;" onclick="$hospital.sort(this)">修改排序</a>
                                            <a href="javascript:;" onclick="$hospital.toDelete(this)">删除</a>
                                        </td>
                                    </tr>
                                </#list>

                                <#else>
                                    <td colspan="10">暂无数据</td>
                            </#if>
                            </tbody>
                        </table>
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