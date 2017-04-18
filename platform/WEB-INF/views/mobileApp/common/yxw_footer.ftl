<#assign oscache=JspTaglibs["/WEB-INF/tlds/oscache.tld"]/>
<oscache:cache time="36000" scope="application">
<script type="text/javascript" src="${basePath}js/sdk/yxw.js"></script>
<script type="text/javascript"> 
	/*************隐藏右上角菜单栏***************/
	yxw.init(function(data) {
		  if (data.success) {
		    yxw.hideOptionMenu();
		  }
		},'${pageContext.request.contextPath}');
		
  	/**
	 * Mozilla/5.0 (iPhone; CPU iPhone OS 8_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B411 MicroMessenger/6.0 NetType/WIFI
	 */
	
	var ua = navigator.userAgent;
	var ua_Lower = ua.toLowerCase();
	//micromessenger
	//alert(ua);
	//alert(ua_Lower.indexOf('micromessenger'));
	if (ua_Lower.indexOf('micromessenger') < 0) {
		//location.href='/error.html';
	}
	
	function onBridgeReady(){
   		//WeixinJSBridge.call('hideOptionMenu');//隐藏分享按钮，需要显示请把hideOptionMenu换成showOptionMenu
   		WeixinJSBridge.call('hideToolbar');//隐藏底部导航栏，需要显示，请把hideToolbar换成showToolbar
	}
	
	if (typeof WeixinJSBridge == "undefined"){
	    if( document.addEventListener ){
	        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
	    }else if (document.attachEvent){
	        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
	        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	    }
	}else{
	    onBridgeReady();
	}
</script>
</oscache:cache>
<div id="copyright">${footLogo}</div>