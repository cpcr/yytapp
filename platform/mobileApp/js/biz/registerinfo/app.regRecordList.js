function loadData(){
	$("#cardNo").val($("#selectedCard").attr("data-no"));
	$("#branchHospitalCode").val($("#selectedCard").attr("data-branchCode"));
	$("#branchHospitalId").val($("#selectedCard").attr("data-branchId"));
	$("#hospitalId").val($("#selectedCard").attr("data-hospitalId"));
	$("#hospitalCode").val($("#selectedCard").attr("data-hospitalCode"));
	//
	var appCode = $('#appCode').val();
	
	var url =  appPath + "mobileApp/register/infos/queryByMedicalCard";
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
           var records = data.message.records; 
           var recordListDom = $("#recordList");
           console.log(records);
           if(records){
        	   var html = "";
        	   if(records.length == 0){
        		   html += "<li class='noData'><p class='color666' style='text-align: center'>3个月内无历史挂号记录. </p></li>";
        	   }else{
        		   for(var i = 0; i < records.length ; i++){
        			   if(records[i].regStatus == 0){
        				   html += "<li class='lock' "; 
        			   }else if(records[i].regStatus == 1 ){
        				   html += "<li class='ok'"; 
        			   }else if(records[i].regStatus == 3 ){
        				   html += "<li class='timeOut'";
        			   }else if(records[i].regStatus == 2 || records[i].regStatus == 7){
        				   html += "<li class='cancel'";
        			   }else if(records[i].regStatus == 5 || records[i].regStatus == 6 || records[i].regStatus == 8 || records[i].regStatus == 9 ){
        				   html += "<li class='fail'";
        			   }else{
        				   html += "<li class='fail'";
        			   }
        			   html += " onclick='showOrderInfo(\"" + records[i].orderNo + "\")'>";
        			   html += "<div class='name'>挂号:" + records[i].deptName  + "-" + records[i].doctorName + "</div>"
        			   html += "<div class='money'>" + parseFloat((records[i].realRegFee + records[i].realTreatFee) / 100).toFixed(2)   + "元</div>"
        			   if (appCode == 'easyHealth') {
        				   html += "<div class='money'>" + records[i].hospitalName + "</div>"
        			   }
        			   html += "<div class='time'>" + records[i].registerDate + "</div>"
        			   html += "<div class='status'>";
        			   if(records[i].regStatus == 0 && records[i].payStatus == 1){
        				   html += "预约中(待缴费)";
        			   }else if(records[i].regStatus == 1){
        				   if(records[i].payStatus == 1 ){
        					   html += "预约成功(未缴费)";
        				   }else if(records[i].payStatus == 2){
        					   html += "预约成功(已缴费)";
        				   }
        			   }else if(records[i].regStatus == 3){
        				   html += "取消预约(缴费超时)";
        			   }else if(records[i].regStatus == 2){
        				   if(records[i].payStatus == 3){
        					   html += "取消预约(已退费)";
        				   }else if(records[i].payStatus == 2  || records[i].payStatus == 5){
        					   html += "取消预约(处理中)";
        				   }else{
        					   html += "取消预约(未缴费)";
        				   }
        			   }else if(records[i].regStatus == 4){
        				   if(records[i].payStatus == 3){
        					   html += "停诊(已退费)";
        				   }else if(records[i].payStatus == 2  || records[i].payStatus == 5){
        					   html += "停诊(处理中)";
        				   }else{
        					   html += "停诊(未缴费)";
        				   }
        			   }else if (records[i].regStatus == 5 ){
        				   html += "网络异常(处理中)";
        			   }else if(records[i].regStatus == 6 ){ 
        				   html += "网络异常(处理中)";
        			   }else if(records[i].regStatus == 41 ){
						   html += "处理中";
					   }
        			   else if(records[i].regStatus == 7 || records[i].regStatus == 10){
        				   html += "网络异常(处理中)";
        			   }else if(records[i].regStatus == 8){
        				   if(records[i].payStatus == 3){
        					   html += "网络异常(已退费)";
        				   }else if(records[i].payStatus == 2  || records[i].payStatus == 5){
        					   html += "网络异常(处理中)";
        				   }else{
        					   html += "网络异常(未缴费)";
        				   }
        			   }else if(records[i].regStatus == 9){
        				   html += "预约成功(已缴费)";
        			   }else if(records[i].regStatus == 11){
        				   html += "网络异常(已退费)";
        			   }else if(records[i].regStatus == 12){
        				   if(records[i].payStatus == 3){
        					   html += "挂号失败(已退费)";
        				   }else if(records[i].payStatus == 2  || records[i].payStatus == 5){
        					   html += "挂号失败(处理中)";
        				   }else{
        					   html += "挂号失败(未缴费)";
        				   }
        			   }else if(records[i].regStatus == 13){
        				   if(records[i].payStatus == 3){
        					   html += "网络异常(已退费)";
        				   }else if(records[i].payStatus == 2  || records[i].payStatus == 5){
        					   html += "网络异常(处理中)";
        				   }else{
        					   html += "网络异常(未缴费)";
        				   }
        			   }else if(records[i].regStatus == 14){
        				   if(records[i].payStatus == 3){
        					   html += "网络异常(已退费)";
        				   }else if(records[i].payStatus == 2  || records[i].payStatus == 5){
        					   html += "网络异常(处理中)";
        				   }else{
        					   html += "网络异常(未缴费)";
        				   }
        			   }else if(records[i].regStatus == 15){
        				   if(records[i].payStatus == 3){
        					   html += "网络异常(已退费)";
        				   }else if(records[i].payStatus == 2  || records[i].payStatus == 5){
        					   html += "网络异常(处理中)";
        				   }else{
        					   html += "网络异常(未缴费)";
        				   }
        			   }else if(records[i].regStatus == 22 && records[i].payStatus == 3 ){
        				   html += "用户取消中(已退费)";
        			   }else if(records[i].regStatus == 20){
        				   html += "窗口退费(已退费)";
        			   }else if(records[i].regStatus == 21){
        				   html += "窗口异常(退费中)";
        			   }
        			   html += "</div>";
        			   html += "</li>";
        		   }
        	   }
           	   recordListDom.html(html);
           }else{
        	   warnMsg = new $Y.confirm({
                   content:'<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                   ok:{title: '确定'}
               })  
           }
       },  
       error : function(data) {  
            $Y.loading.hide();
            errorMsg = new $Y.confirm({
                content:'<div>网络异常,请保持您的网络通畅,稍后再试.</div>',
                ok:{title: '确定'}
            })  
       }  
    }); 
}

function showOrderInfo(orderNo){
	$("#orderNo").val(orderNo);
	$("#paramsForm").attr("action" , appPath + "mobileApp/register/infos/showOrderInfo");
	$("#paramsForm").submit();
}