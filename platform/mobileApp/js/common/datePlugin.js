//时间
(function($) {
	var Time = {};
	function getToday() {
		var myDate = new Date();
		var Y = myDate.getFullYear();
		var M = myDate.getMonth();
		var D = myDate.getDate();
		var date = Y + '-' + M + '-' + D;
		Time.Y = Y;
		Time.M = M;
		Time.D = D;
		//   console.log(Time);
	}
	getToday();

	//获取月份的天数
	Time.getDaysInMonth = function(year, month) {
		return 32 - new Date(year, month, 32).getDate();
	}

	//获取月份中的第一天是所在星期的第几天
	// month：(0--11) 月份从0开始
	// return (0-6) 0：星期日 1：星期一 ...
	Time.getFirstDayOfMonth = function(year, month, day) {
		var day = day || 1;
		return new Date(year, month, day).getDay();
	};
	window.myDate = Time;

	
	//计算日历显示的高度  add by yuce
	var showDays = 7;
	var showDaysDom = $("#showDays");
	
	if(showDaysDom){
		showDays = $(showDaysDom).val();
	}
	var height = 90 * ( 1+ Math.ceil((showDays - 4) / 5));
	//alert("showDays :" + showDays +  "     height :" + height )
	
	Time.Run = function() {
		var my_width = $(window).width() / 5;
		my_width++;
		var html = '';
		var p = Time.D;
		var week = Time.getFirstDayOfMonth(Time.Y, Time.M, Time.D);
		for ( var i = 1; i <= showDays; i++) {
			if (p > Time.getDaysInMonth(Time.Y, Time.M)) {
				p = 1;
			}
			if (week > 6) {
				week = 0;
			}
			var w = '';
			switch (week) {
				case 0:
					w += '日';
					break;
				case 1:
					w += '一';
					break;
				case 2:
					w += '二';
					break;
				case 3:
					w += '三';
					break;
				case 4:
					w += '四';
					break;
				case 5:
					w += '五';
					break;
				case 6:
					w += '六';
					break;
			}

			if (p == Time.D) {
				html += '<div class="d-grid noHook" style="width:'
						+ my_width
						+ 'px"> <div class="d-grid-content"> <span class="week">'
						+ w
						+ '</span><span class="date">今</span></div><div class="border"></div><div class="right-border"></div><div class="border-arrow"></div> </div>';
			} else if (i == 5) {
				html += '<div class="d-grid" style="width:'
						+ (my_width - 1)
						+ 'px" onclick="$Time.toggle(this)" > <div class="d-grid-content"><div class="d-title"><i class="icon-arrow-show"></i><br/><span>展开</span></div></div><div class="border"></div><div class="right-border" style="border: none"></div><div class="border-arrow"></div> </div>';
				html += '<div class="d-grid goHook" style="width:'
						+ my_width
						+ 'px"> <div class="d-grid-content"><span class="week">'
						+ w
						+ '</span><span class="date">'
						+ p
						+ '</span></div><div class="border"></div><div class="right-border"></div><div class="border-arrow"></div> </div>';
			} else {
				if (i == 9 || i == 14) {
					html += '<div class="d-grid goHook" style="width:'
							+ (my_width - 1)
							+ 'px;"> <div class="d-grid-content"> <span class="week">'
							+ w
							+ '</span><span class="date">'
							+ p
							+ '</span></div><div class="border"></div><div class="right-border" style="border: none"></div><div class="border-arrow"></div> </div>';
				} else {
					html += '<div class="d-grid goHook" style="width:'
							+ my_width
							+ 'px"> <div class="d-grid-content"> <span class="week">'
							+ w
							+ '</span><span class="date">'
							+ p
							+ '</span></div><div class="border"></div><div class="right-border" ></div><div class="border-arrow"></div> </div>';
				}
			}
			p++;
			week++;
		}
		$('#select-date').html(html);
		Time.toggle = function(obj) {
			var index = $('.d-grid.active').index();
			var obj = $(obj);
			var t = obj.find('.d-title');
			if (t.hasClass('up')) {
				t.removeClass('up');
				t.find('span').html('展开');
				$('#select-date').removeClass('show');
				$('#select-date').css({height:90});
				//                   $('#select-date').animate({height:89},200)
				if (index > 3) {
					$('.d-grid.active .border-arrow').hide();
				}
			} else {
				t.addClass('up');
				t.find('span').html('收起')
				$('#select-date').addClass('show');
				$('#select-date').css({height:height});
				//                    $('#select-date').animate({height:268},200)
				$('.d-grid.active .border-arrow').show();

			}
		}
		Time.goHook = function() {
			if (!$(this).hasClass('noNum')) {
				$('.d-grid.goHook').removeClass('active');
				$('.d-grid.goHook .border-arrow').removeAttr('style')
				$(this).addClass('active')
				
				var hookDate;
				var hookDays = $(this).find(".date").text();
				//大于今天的日期  可判断为本月的日期
				if(hookDays > Time.D){
					hookDate = Time.Y + "-" + (Time.M + 1) + "-" + hookDays;
				}
				//小于今天的日期  可判断为下个月的日期
				if(hookDays < Time.D){
					//判断本月是否为12月 若是 则年要加1
					if(Time.M == 11){
						hookDate = (Time.Y + 1) + "-01-" + hookDays;
					}else{
						hookDate = Time.Y + "-" + (Time.M + 2) + "-" + hookDays;
					}
				}
				//alert("hookDate : "  + hookDate)
				loadDoctorList(hookDate);
			}
		}
		$('.goHook').on('click', Time.goHook);
	}

	Time.Run();
	window.$Time = Time;
	
	//加载今天的号源信息
	loadDoctorList(Time.Y + "-" + Time.M + "-" + Time.D);

}(window.jQuery))

/**
 * 加载该科室的号源信息
 * @param hookDate
 */
function loadDoctorList(hookDate){
	if($("#dateStr")){
		$("#dateStr").val(hookDate);
	}
	//加载当天的号源信息
	var url =  appPath + "mobileApp/register/doctor/queryDoctorList";
    var datas = $("#paramsForm").serializeArray();  
	if(doctorList){
		$Y.loading.show();
        jQuery.ajax( {  
           type : 'POST',  
           url : url,  
           data : datas,  
           dataType : 'json',  
           timeout:120000,
           success : function(data) { 
               $Y.loading.hide();
               var doctors = data.message.doctors; 
               if(doctors){
            	    var doctorList = $("#doctorList");
                    var htmlStr = "";
                    for(var i = 0 ; i < data.message.doctors.length ; i++){
                        htmlStr += "<li onclick='goDoctorTimeList(this)'>";
                        htmlStr += "    <div class='pic'><img src='" + appPath + "/mobileApp/images/touxiang.png'  width='65' height='65'/></div>";
                        htmlStr += "    <div class='info'>"
                        htmlStr += "         <div class='name'>" + doctors[i].doctorName  + "</div>"
                        htmlStr += "         <div> " + doctors[i].doctorTitle + "</div>"
                        htmlStr += "         <div>剩余<span class='skinColor fontSize120'>" + 100 + "</span>个号</div>"
                        htmlStr += "	</div>";
                        htmlStr += "    <div class='li-right'>";
                        htmlStr += "    	<i class='icon-arrow'></i>";
                        htmlStr += "    </div>";
                        htmlStr += "</li>"
                    }
                    doctorList.html(htmlStr)
               }
           },  
           error : function(data) {  
                $Y.loading.hide();
                alert("网络异常,加载号源信息失败,请您重新操作!")  
           }  
        });  
	}
}

/**
 * 分时号源查询
 * @returns
 */
function goDoctorTimeList(){
	
}
