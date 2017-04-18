function addSymptom(){
	location.href = appPath + "smartTriage/addSymptom";
}
/**
 * checkbox选择器
 * @param obj
 */
function isHiden(obj){
	if(jQuery(obj).is(':checked')){
		jQuery(obj).val("1");
	}else{
		jQuery(obj).val("0");
	}
}

function editSymptom(id){
	location.href = appPath + "smartTriage/updateSymptom?id=" + id;
}
function save(){
	var symptom = jQuery("#symptomForm");
	var id = jQuery.trim(jQuery(symptom).find(":hidden[name=id]").val());
	var name = jQuery.trim(jQuery(symptom).find(":text[name=name]").val());
	var part = jQuery.trim(jQuery(symptom).find("select[name=part] option:selected").val());
	var isHide = jQuery.trim(jQuery(symptom).find(":checkbox[name=isHide]").val());
	if(name == ''){
		alert("症状名称不能为空");
		return;
	}
	var reqUrl = appPath + "smartTriage/saveSymptom";
	var datas = {id:id,name:name,part:part,isHide:isHide};
	jQuery.ajax({  
		type : 'POST',  
		url  : reqUrl,  
		data : datas,  
		dataType : 'json',  
		success  : function(data) { 
			if(data.status){
				location.href = appPath + "smartTriage/symptomBack";
			}else{
				alert(data.message);
			}
		}
	});
}

function showHideSwitch(id, isHide){
	isHide = isHide == 0 ? 1 : 0;
	var datas = {id:id,isHide:isHide};
	jQuery.ajax({  
		type : 'POST',  
		url  : appPath + "smartTriage/showHideSwitch",  
		data : datas,  
		dataType : 'json',  
		success  : function(data) { 
			if(data.status){
				location.href = appPath + "smartTriage/symptomBack";
			}else{
				alert(data.message);
			}
		}
	});
}
