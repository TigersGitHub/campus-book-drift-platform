$(function () {
	//金额格式化
	function priceformat(price) {
		return parseFloat(price).toFixed(2);
	}
	
	//图书搜索
	$("#search-form").keydown(function (e) {
		//回车键监听
		var e = e || event,
		keycode = e.which || e.keyCode;
		if (keycode == 13) {
			$("#searchbyname_homepage").trigger("click");
		}
	});
	$("#searchbyname_homepage").click(function () {
		var key = $("#key").val();
		var datas = "";
		if (key.length == 0) {
			datas = "act=loadall";
		} else {
			datas = "act=searchbyname";
		}
		$("#search-form").attr("action", "LoadBookList.do?" + datas)
		$("#search-form").submit();
	});
	
	//个人订单统计加载
	$.ajax({
		url: "LoadBookList.do",
        data: "act=countprivateorder",
        type: "POST",
        success: function (rel) {
        	var data  = eval(rel);
        	for (var i = 0; i < data.length; i++) {
        		if (data[i].STATUS == '1') {
        			$("#data1").text(data[i].ORDCOUNT);
        		} else if (data[i].STATUS == '3') {
        			$("#data2").text(data[i].ORDCOUNT);
        		} else if (data[i].STATUS == '4') {
        			$("#data3").text(data[i].ORDCOUNT);
        		}
        	}
        }
	});
	
	/* 最新上架加载 */
	$.ajax({
		url: "LoadBookList.do",
        data: "act=latestbook",
        type: "POST",
        success: function (rel) {
        	var data  = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {
        		str = "<div class='box'><div class='box-img'><img src='" +
        				((data[i].BOOK_IMAGE != null)?data[i].BOOK_IMAGE:"images/defbook.jpg") + "' alt='" + data[i].BOOK_NAME_CH +
		        		"' /></div><div class='box-content'><table><tr><td><h4 class='title'>" + ((data[i].BOOK_ISSELL == 'Y')
        				?"<del>¥" + priceformat(data[i].BOOK_PRICE) + "</del>&nbsp;&nbsp;¥" + priceformat(data[i].BOOK_SELLPRICE)
						:"在漂") + "</h4></td></tr><tr class='des-tr'><td><p class='description'>" + data[i].BOOK_NAME_CH + 
						"<br />" + data[i].BOOK_PRESS + "</p></td></tr><tr><td class='social-links'>" +
        				"<a href='LoadBookList.do?act=jump&bookid=" + data[i].BOOK_ID + "' target='_blank'>查看</a>" + 
        				((data[i].FAVORITE != 'T')?"<a id='" + data[i].BOOK_ID + "' style='cursor:pointer;' onclick='collect(this)'>收藏</a>"
						:"<a>已收藏</a>") + "</td></tr></table></div></div>";
        		$("#first-floor").append(str);
        	}        		
        }
	});
	
	/* 热门漂流加载 */
	$.ajax({
		url: "LoadBookList.do",
        data: "act=hotdrift",
        type: "POST",
        success: function (rel) {
        	var data  = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {
        		str = "<div class='box'><div class='box-img'><img src='" +
        				((data[i].BOOK_IMAGE != null)?data[i].BOOK_IMAGE:"images/defbook.jpg") + "' alt='" + data[i].BOOK_NAME_CH +
		        		"' /></div><div class='box-content'><table><tr><td><h4 class='title'>在漂</h4></td></tr>" +
		        		"<tr class='des-tr'><td><p class='description'>" + data[i].BOOK_NAME_CH + "<br />" + data[i].BOOK_PRESS + 
		        		"</p></td></tr><tr><td class='social-links'><a href='LoadBookList.do?act=jump&bookid=" + data[i].BOOK_ID + 
		        		"' target='_blank'>查看</a>" + ((data[i].FAVORITE != 'T')?"<a id='" + data[i].BOOK_ID + 
        				"' style='cursor:pointer;' onclick='collect(this)'>收藏</a>":"<a>已收藏</a>") + "</td></tr></table></div></div>";
        		$("#second-floor").append(str);
        	}	
        }
	});
	
	/* 热门二手加载 */
	$.ajax({
		url: "LoadBookList.do",
        data: "act=hotsell",
        type: "POST",
        success: function (rel) {
        	var data  = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {
        		str = "<div class='box'><div class='box-img'><img src='" +
        				((data[i].BOOK_IMAGE != null)?data[i].BOOK_IMAGE:"images/defbook.jpg") + "' alt='" + data[i].BOOK_NAME_CH +
		        		"' /></div><div class='box-content'><table><tr><td><h4 class='title'><del>¥" + priceformat(data[i].BOOK_PRICE) + 
		        		"</del>&nbsp;&nbsp;¥" + priceformat(data[i].BOOK_SELLPRICE) + "</h4></td></tr><tr class='des-tr'><td><p class='description'>" + 
		        		data[i].BOOK_NAME_CH + "<br />" + data[i].BOOK_PRESS + "</p></td></tr><tr><td class='social-links'>" +
        				"<a href='LoadBookList.do?act=jump&bookid=" + data[i].BOOK_ID + "' target='_blank'>查看</a>" + 
        				((data[i].FAVORITE != 'T')?"<a id='" + data[i].BOOK_ID + "' style='cursor:pointer;' onclick='collect(this)'>收藏</a>"
						:"<a>已收藏</a>") + "</td></tr></table></div></div>";
        		$("#third-floor").append(str);
        	}
        }
	});
	
	/* 好书推荐 */
	$.ajax({
		url: "LoadBookList.do",
        data: "act=recbook",
        type: "POST",
        success: function (rel) {
        	var data  = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {
        		str = "<div class='box'><div class='box-img'><img src='" +
        				((data[i].REC_IMAGE != null)?data[i].REC_IMAGE:"images/defbook.jpg") + "' alt='" + data[i].REC_NAME_CH +
		        		"' /></div><div class='box-content'><table><tr><td><h4 class='title'><del>¥" + priceformat(data[i].REC_PRICE) + 
		        		"</del>&nbsp;&nbsp;¥" + priceformat(data[i].REC_SELLPRICE) + "</h4></td></tr><tr class='des-tr'><td><p class='description'>" + 
		        		data[i].REC_NAME_CH + "<br />" + data[i].REC_PRESS + "</p></td></tr><tr><td class='social-links'>" +
        				"<a href='LoadBookList.do?act=recjump&recid=" + data[i].REC_ID + "' target='_blank'>查看</a>" + 
        				"</td></tr></table></div></div>";
        		$("#rec-floor").append(str);
        	}
        }
	});
	
	/* 主页图书分类nav加载 */
	$.ajax({
        url: "LoadInfo.do",
        data: "act=btype",
        type: "POST",
        success: function (rel) {
        	var list = $("#list-btype");
        	var data = eval(rel);
        	var str = "";
        	list.html("");
        	for (var i = 0; i < data.length; i += 2) {
        		str = "<li class='nav-item'><a class='nav-link' href='LoadBookList.do?act=loadbytype&type=" + (i + 1) + "'>" 
		        		+ data[i].TYP_NAME + "</a> <a class='nav-link' href='LoadBookList.do?act=loadbytype&type=" + (i + 2) + "'>" 
		        		+ data[i+1].TYP_NAME + "</a></li>";
        		list.append(str);
        	}
        }
	});
	
	/* 主页轮播URL加载 */
	$.ajax({
        url: "LoadInfo.do",
        data: "act=carousel",
        type: "POST",
        success: function (rel) {
        	var points = $(".carousel-indicators");
        	var images = $(".carousel-inner");
        	var data = eval(rel);
        	var str = "";
        	points.html("");
        	images.html("");
        	for (var i = 0; i < data.length; i++) {
        		if (i == 0) {
        			str = "<li data-target='#carousel-generic' data-slide-to='0' class='active'></li>";
        			points.append(str);
        			str = "<div class='carousel-item active'>";
        			if (data[i].CSL_TARGET != null) {
        				str += "<a target='_blank' href='" + data[i].CSL_TARGET + "'>";
        			}
        			str += "<img src='" + data[i].CSL_SRC + "' alt='" + data[i].CSL_NOTE + "' />";
        			if (data[i].CSL_TARGET != null) {
        				str += "</a>";
        			}
        			str += "</div>";
        			images.append(str);
        		} else {
        			str = "<li data-target='#carousel-generic' data-slide-to='" + i + "'></li>";
            		points.append(str);
            		str = "<div class='carousel-item'>";
            		if (data[i].CSL_TARGET != null) {
        				str += "<a href='" + data[i].CSL_TARGET + "'>";
        			}
        			str += "<img src='" + data[i].CSL_SRC + "' alt='" + data[i].CSL_NOTE + "' ";
        			if (data[i].CSL_TARGET != null) {
        				str += "</a>";
        			}
            		str += "</div>";
        			images.append(str);
        		}
        	}
        }
	});
	
	/* 新闻公告栏目加载 */
	$.ajax({
        url: "LoadInfo.do",
        data: "act=latestnotice",
        type: "POST",
        success: function (rel) {		
        	var list = $("#notice-list");
        	var data = eval(rel);
        	var type = "";
        	var str = "";
        	for (var i = 0; i < data.length; i++) {
        		if (data[i].NTC_TYPE == "N") {
        			type = "新闻";
        		}
        		if (data[i].NTC_TYPE == "A") {
        			type = "公告";
        		}
        		str = "<li><a href='LoadInfo.do?act=noticejump&no=" + data[i].NTC_ID + "'>[" + type + "] " + data[i].NTC_TITLE + "</a></li>";
        		list.append(str);
        	}
        }
	});
});
