$(function(){
	$("textarea").each(function(){
		var obj = $("#" + this.id.substring(0 , this.id.indexOf("_temp")));
		if(obj){
			var val = $(obj).val();
			$(this).val(val);
		}
	});
});

var ruleJS = {
	//发布规则
	publishRule:function(hospitalId){
		if(confirm("确定要发布该医院的规则配置吗?")){  
			var url = $("#basePath").val() + "sys/ruleIndex/publishRule?hospitalId=" + hospitalId;
			jQuery.ajax( {  
	        	type : 'POST',  
	        	url : url,  
	        	dataType : 'json',  
	        	timeout:120000,
	        	success : function(data) {  
	        		alert("发布成功!");
	        		$("#" + hospitalId + "_publishTime").html(data.message.publishTime);
	        		$("#" + hospitalId + "_publishstatus").html(data.message.publishstatus);
	        		$("#" + hospitalId + "_lastHandler").html(data.message.lastHandler);
	        	},  
	        	error : function(data) {  
	        		alert("发布失败!");  
	        	}  
	        });  
		}
	},
	//输入校验
	validate:function(ruleType)
	{
		//挂号规则输入校验
		if(ruleType=='RuleRegister')
		{
			return ruleJS.validateRuleRegister();
		}
		else
		{
			//其他规则不需要校验
			return true;
		}
	},
	//挂号规则输入校验
	validateRuleRegister:function()
	{
		var regMaximumSameDoctor=parseInt($('#regMaximumSameDoctor').val()!=''?$('#regMaximumSameDoctor').val():"0");
		var regMaximumInDay=parseInt($('#regMaximumInDay').val()!=''?$('#regMaximumInDay').val():"0");
		var regMaximumInWeek=parseInt($('#regMaximumInWeek').val()!=''?$('#regMaximumInWeek').val():"0");
		var regMaximumInMonth=parseInt($('#regMaximumInMonth').val()!=''?$('#regMaximumInMonth').val():"0");
		if(regMaximumInMonth>=regMaximumInWeek&&regMaximumInWeek>=regMaximumInDay&&regMaximumInDay>=regMaximumSameDoctor)
		{
			return true;
		}else
		{
			return false;
		}
	},
	/*
	 * 规则编辑
	 */
	ruleEdit:function(hospitalId , ruleType){
		if(!ruleType){
			ruleType = "ruleEdit";
		}
		
		if($("#ruleSelect")){
			 $("#ruleSelect option[value='" +  ruleType + "']").attr("selected","selected");
		}
		
		window.location = $("#basePath").val() + "sys/ruleIndex/toEdit?hospitalId=" + hospitalId + "&ruleType=" + ruleType;
	},

	//保存规则
	saveRule:function(formId , ruleType){
		//console.info($('input[name="bindCardSuc"]').val());
		//console.info($('#' + formId).serializeArray());
		if(ruleType){
			var isPass = ruleJS.validate(ruleType);
			if(!isPass)
			{
				alert("请确保：每人每月挂号次数>=每人每周挂号次数>=每人每天允许挂号次数>=每人每天允许挂同一医生次数");
				return false;
			}
			$("#" + formId).find("textarea").each(function(){
				console.log(this.id);
				$("#" + this.id.substring(0 , this.id.indexOf("_temp"))).val($(this).val());
			});
			var savePath = ruleType.substring(0,1).toLowerCase();
			savePath += ruleType.substring(1,ruleType.length);
			var url = $("#basePath").val() + "sys/" +  savePath + "/save" + ruleType;
			var datas = $('#' + formId).serializeArray();  
	        jQuery.ajax( {  
	        	type : 'POST',  
	        	url : url,  
	        	data : datas,  
	        	dataType : 'json',  
	        	timeout:120000,
	        	success : function(data) {  
	        		alert("保存成功!");
	        		$("#id").val(data.message.entityId);
	        	},  
	        	error : function(data) {  
	        		alert("保存失败!");  
	        	}  
	        });  
		}else{
			alert("缺少参数:ruleType!");  
		}
	}
};