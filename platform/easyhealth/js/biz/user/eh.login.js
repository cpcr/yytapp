/**
 * zhoujb
 * 2015-10-06 
 */

function toModifyPwd() {
  go(appPath + 'easyhealth/user/toModifyPwd', true);
}
function toModifyMobile() {
  go(appPath + 'easyhealth/user/toModifyMobile', true);
}

function loginOut() {
  var url = appPath + "easyhealth/user/loginout";
  $.ajax({  
      type : 'POST',  
      url  : url,  
      data : {},  
      dataType : 'json',
      timeout  : 120000,
      success  : function(data) {
          if(data.status == 'OK'){
            if(IS.isMacOS){
              try
              {
                  backToLogin();

              } catch (e) {
                  // alert('IOS的方法出错');
              }
            }else if(IS.isAndroid ){
                try
                {
                    yyc.backToLogin();
  
                } catch (e) {
                    //  alert('Android的方法出错');
                }
  
            }else{
                AlipayJSBridge.call('closeWebview');
            }
          }
       }, error : function(data) {  
          myBox = new $Y.confirm({
              title:"",
              content:"<div style='text-align: center;'>网络异常,请保持您的网络通畅,稍后再试.</div>",
              ok:{title:"确定",
                  click:function(){
                      myBox.close();
                  }
              }
          });
       }  
  });
}

function loginBox(){
	var myBox = null;
	var account = jQuery.trim(jQuery("#account").val())
	var password = jQuery.trim(jQuery("#password").val());
	var appId = jQuery.trim(jQuery("#appId").val());
	
	var __src = $('#__src').val();
	if(account == ''){
		myBox = new $Y.confirm({
			title:"",
			content:"<div style='text-align: center;'>请输入登录帐号!</div>",
			ok:{title:"确定",
				click:function(){        //参数可为空，没有默认方法,不会自动关闭窗体，可用  myBox.close()来关闭  
					myBox.close();
				}
			}
		});
		return;
	}
	
	if(password == ''){
		myBox = new $Y.confirm({
			title:"",
			content:"<div style='text-align: center;'>请输入登录密码!</div>",
			ok:{title:"确定",
				click:function(){        //参数可为空，没有默认方法,不会自动关闭窗体，可用  myBox.close()来关闭  
					myBox.close();
				}
			}
		});
		return;
	}
	
	var datas = {account:account,passWord:password,appId:appId};
	var url = appPath + "easyhealth/user/login";
	$.ajax({  
        type : 'POST',  
        url  : url,  
        data : datas,  
        dataType : 'json',
        timeout  : 120000,
        success  : function(data) {

            if(data.status == 'OK'){
                if(IS.isAndroid) {//add by wwb 安卓标记是否已登录,并记录user_id
                    yyc.login(data.id);
                }
                if(IS.isMacOS){
                    try
                    {
                        appPush(data.id);
                    } catch (e) {
                        //  alert('IOS的方法出错');
                    }

                }
              if (__src) {
                go(__src,true);//登录成功跳转至来源页面
              } else {
                go(appPath + "easyhealth/index",true);//登录成功跳转至首页
              }

            }else{
            	myBox = new $Y.confirm({
        			title:"",
        			content:"<div style='text-align: center;'>" + data.message + "</div>",
        			ok:{title:"确定",
        				click:function(){
        					myBox.close();
        				}
        			}
        		});
            }
         }, error : function(data) {  
        	myBox = new $Y.confirm({
    			title:"",
    			content:"<div style='text-align: center;'>网络异常,请保持您的网络通畅,稍后再试.</div>",
    			ok:{title:"确定",
    				click:function(){
    					myBox.close();
    				}
    			}
    		});
         }  
	});
}



