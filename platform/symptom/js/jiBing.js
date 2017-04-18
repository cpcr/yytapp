function addDisease(){
	location.href = appPath + "smartTriage/addDisease";
}
function editDisease(id){
	location.href = appPath + "smartTriage/updateDisease?id=" + id;
}


function save(){
	var disease = jQuery("#diseaseForm");
	var id = jQuery.trim(jQuery(disease).find(":hidden[name=id]").val());
	var name = jQuery.trim(jQuery(disease).find(":text[name=name]").val());
	var dummary = jQuery.trim(jQuery(disease).find("textarea[name=dummary]").val());
	var option = jQuery("#checkedSelect option");
	if(name == ''){
		alert("疾病名称不能为空");
		return;
	}
	var symptoms = "";
	if(option.length > 0){
		option.each(function(idx, item){
			symptoms += jQuery(item).attr("value") + ",";
		});
		symptoms = symptoms.substring(0, symptoms.length - 1);
	}
//	alert("symptomCause:" + symptomCause + "--diagnosisDetail:" + diagnosisDetail + "--symptoms:" + symptoms);
	
	var reqUrl = appPath + "smartTriage/saveDisease?symptoms=" + symptoms;
	var datas = {id:id,name:name,dummary:dummary};
	jQuery.ajax({  
		type : 'POST',  
		url  : reqUrl,  
		data : datas,  
		dataType : 'json',  
		success  : function(data) { 
			if(data.status){
				location.href = appPath + "smartTriage/diseaseBack";
			}else{
				alert(data.message);
			}
		}
	});
}


function selectAdd(){
	var option = jQuery("#uncheckedSelect option:selected");
	jQuery("#checkedSelect").append(option);
}

function selectRemove(){
	var option = jQuery("#checkedSelect option:selected");
	jQuery("#uncheckedSelect").append(option);
	
}