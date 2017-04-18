<html>
<head>
    <#include "/sys/common/common.ftl">
    <script type="text/javascript" src="${basePath}js/sys/order/sys.order.js"></script>
    <title>异常订单处理</title>
</head>
<body>
    <div id="content">
    <#include "./sys/common/hospital_setting.ftl">
    <#setting datetime_format="yyyy-MM-dd HH:mm"/>
    <div class="container-fluid">
        <div class="space10"></div>
        <div class="row-fluid">
            <div class="space10"></div>
            <div class="widget-box orderBox">
                <div class="space10"></div>
                <div class="widget-content">
                <form class="form-horizontal" method="post" action="${basePath}order/getExceptionOrderList" accept-charset="utf-8">
                    <input type="hidden" name="hospitalId" value="${hospitalId}" />
                    <div class="row-fluid">
                        <div class="control-group">
                            <label class="control-label">订单号</label>
                            <div class="controls">
                                <input type="text" name="orderNo"  value="${orderNo}" class="span10 input39" /> 
                            </div>
                        </div>
                    </div>
                    <div class="space20"></div>
                    <div class="btn-box">
                      <button class="btn btn btn-save w330">查询</button>
                        <div class="space20"></div>
                    </div>
                </form>
                <div class="space10"></div>
                <div class="row-fluid">
                    <div class="orderTable">
                        <table class="table table-bordered table-textCenter table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="100">操作</th>
                                    <th width="100">订单类型</th>
                                    <th width="180">表名</th>
                                    <th width="100">业务状态</th>
                                    <th width="100">是否医保</th>
                                    <th width="180">退款流水号</th>
                                    <th width="180">退款单据号</th>
                                    <th width="100">支付状态</th>
                                    <th width="150">就诊卡号</th>
                                    <th width="180">医院订单号</th>
                                    <th width="180">医院确认收据号</th>
                                    <th width="230">收单机构订单号</th>
                                    <th width="180">自费金额</th>
                                    <th width="180">总金额</th>
                                    <th width="180">支付订单号</th>
                                    <th width="180">退费订单号</th>
                                    <th width="150">订单生成时间</th>
                                    <th width="150">订单退费时间</th>
                                    <th width="100">患者姓名</th>
                                    <th width="100">患者手机</th>
                                    <th width="180">备注</th>
                                    <#--<th width="200">操作</th>-->
                                </tr>
                            </thead>
                            <tbody>
                                        <tr>
                                            <td>
                                                <a href="javascript:void(0);" onclick="refund()">退费</a> 
                                            </td>
                                            <td>
                                                <#if orderView.orderType == 1>挂号缴费</#if>
                                                <#if orderView.orderType == 2>门诊缴费</#if>
                                                <#if orderView.orderType == 3>住院押金补缴</#if>
                                            </td>
                                            <td>${orderView.tableName}</td>
                                            <td>
                                                <#if orderView.orderType == 1>
                                                    <#if registerStuats?exists>
                                                        <#list registerStuats?keys as key>
                                                            <#if orderView.bizStatus == key>${registerStuats[key]}</#if>
                                                        </#list>
                                                    </#if>
                                                </#if>
                                                <#if orderView.orderType == 2>
                                                    <#if clinicStuats?exists>
                                                        <#list clinicStuats?keys as key>
                                                            <#if orderView.bizStatus == key>${clinicStuats[key]}</#if>
                                                        </#list>
                                                    </#if>
                                                </#if>
                                            </td>
                                            <td><#if orderView.isInsurance == 0>非医保</#if>
                                                <#if orderView.isInsurance == 1>医保</#if></td>
                                            <td>${orderView.cancelSerialNo}</td>
                                            <td>${orderView.cancelBillNo}</td>
                                            <td>
                                                <#if orderView.payStatus == 1>未支付</#if>
                                                <#if orderView.payStatus == 4>支付中</#if>
                                                <#if orderView.payStatus == 2>已支付</#if>
                                                <#if orderView.payStatus == 5>退费中</#if>
                                                <#if orderView.payStatus == 3>已退费</#if>
                                            </td>
                                            <td>${orderView.cardNo}</td>
                                            <td>${orderView.hisOrdNo}</td>
                                            <td>${orderView.receiptNum}</td>
                                            <td>${orderView.agtOrdNum}</td>
                                            <td>${orderView.payFee}</td>
                                            <td>${orderView.totalFee}</td>
                                            <td>${orderView.orderNo}</td>
                                            <td>${orderView.refundOrderNo}</td>
                                            <td>${orderView.createTime}</td>
                                            <td>${orderView.refundTime}</td>
                                            <td>${orderView.patientName}</td>
                                            <td>${orderView.patientMobile}</td>
                                            <td>${orderView.title}</td>
                                            <#--<td>-->
                                                 <#--<a href="javascript:void(0);">退费</a>-->
                                                 <#--<a href="javascript:void(0);">状态修改</a>-->
                                                 <#--<a href="javascript:queryLog(this,'${orderView.id}','${orderView.orderType}','${orderView.tableName}');">查看</a>-->
                                            <#--</td>-->
                                        </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <form id="handleForm" class="form-horizontal" method="post" action="${basePath}order/handleExceptionStatus" accept-charset="utf-8">
                    <input type="hidden" id="orderNo" name="orderNo" value='${orderNo}' />
                    <input type="hidden" id="orderType" name="orderType" value='${orderView.orderType}' />
                    <div class="space20"></div>
                    <div class="row-fluid">
                        <table width="1000"><tr>
                            <td width="110">
                                <label class="control-label">订单号：</label>
                            </td>
                            <td width="150">${orderNo}
                            </td>
                            <td width="110">
                                <label class="control-label">订单类型：
                                </label>
                            </td>
                            <td width="150">
                                <#if orderView.orderType == 1>挂号缴费</#if>
                                    <#if orderView.orderType == 2>门诊缴费</#if>
                                    <#if orderView.orderType == 3>住院押金补缴</#if> 
                            </td>
                            </tr>
                            <tr>
                                <td width="110">
                                    <label class="control-label">订单状态
                                    </label>
                                </td>
                                <td width="150">
                                    <select name="orderStatus" id="orderStatus">
                                        <option value="1">未支付</option>
                                        <option value="2">已支付</option>
                                        <option value="3">已退费</option>
                                        <option value="4">支付中</option>
                                        <option value="5">退费中</option>
                                    </select>
                                </td>
                                <td width="110">
                                    <label class="control-label">业务状态
                                    </label>
                                </td>
                                <td width="150">
                                    <input type="text" name="busStatus"  value="${busStatus}" class="span10 input39" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <div class="btn-box">
                                    <button onclick="updateStatus()">更新订单状态</button>
                                    <div class="space20"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    挂号状态：0.预约中  1.已预约  2.已取消-用户取消  3.已取消-支付超过规定时长  4.已取消-停诊取消  5.预约异常(his锁号异常) 6.第3方支付异常 7.第3方支付成功后 his确认异常  8.取消挂号异常  10.第3方退费异常 12.挂号失败 <br>
                    门诊状态：0.待缴费  1.已缴费  2.第三方缴费失败(要查询第三方接口，看有没有缴费)  3.第三方缴费成功，写入His异常  4.缴费关闭  5.退费异常  6.第三方缴费成功，写入His失败  7.业务异常 需要人工处理  8.业务异常 需要到医院窗口处理  20.窗口退费成功  21.窗口退费异常
                                </td>
                            </tr>
                            </table>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<form id="recordForm" method="post" accept-charset="utf-8">
    <input type="hidden" id="orderNo" name="orderNo" value='${orderNo}' />
    <input type="hidden" id="orderType" name="orderType" value='${orderView.orderType}' />
</form>
<#include "./sys/common/footer.ftl">
<script type="text/javascript">
    var basePath = '${basePath}';
    /*选中 变色*/
    function clickHit(obj){
        var bl = jQuery(obj).attr("class");
        jQuery(obj).parent().find("tr").removeClass("hit-class");
        if(bl){
            jQuery(obj).removeClass('hit-class');
        }else{
            jQuery(obj).addClass('hit-class');
        }
    }
    
    function refund(){
        if(confirm('确定'+$("#orderNo").val()+"需要退费吗?")){
            var url = basePath + "order/handleExceptionOrder";
            var datas = $("#recordForm").serializeArray();
            $.ajax({  
                type : 'POST',  
                url : url,  
                data : datas,  
                dataType : 'json',  
                timeout:120000,
                error: function (data) {
                    alert("请求异常，请检查网络是否畅通，如有问题请联系国庆解决。");
                },
                success : function(data) { 
                    if(data.status == 'OK'){
                        alert("退费成功. 返回内容："+data.message);
                    } else {
                        alert("退费失败. 具体原因："+data.message);
                    }
                }
            }); 
        
        }
    }
    
    function updateStatus(){
        if(confirm('确定'+$("#orderNo").val()+"需要改状态吗?")){
            var url = basePath + "order/handleExceptionStatus";
            var datas = $("#handleForm").serializeArray();
            $.ajax({  
                type : 'POST',  
                url : url,  
                data : datas,  
                dataType : 'json',  
                timeout:120000,
                error: function (data) {
                    alert("请求异常，请检查网络是否畅通，如有问题请联系国庆解决。");
                },
                success : function(data) { 
                    if(data.status == 'OK'){
                        alert("修改状态成功. 返回内容："+data.message);
                    } else {
                        alert("修改状态失败. 具体原因："+data.message);
                    }
                }
            }); 
        
        }
    }
</script>
</body>
</html>

