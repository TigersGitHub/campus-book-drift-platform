$(function () {
	var currpage = 1;
	var totalpage = 1;
	
	//解析并加载
	function loadcontent(rel) {
		var data = eval(rel);
		if (data.length != 0) {
			$("#comment-list").html("");
		} else {
			$("#comment-list").html("<h4 class='ordTab-msg'>没有找到相关订单~</h4>");
		}
		for (var i = 0; i < data.length; i++) {
			var str = "<div class='comment-detail'><div class='col-md-4'><label>时间：</label><h5>" + data[i].COM_TIME + 
				"</h5></div><div class='col-md-4'><label>来自：</label><h5>" + data[i].COM_USERNAME + "(" + data[i].COM_USERID + 
				")</h5></div><div class='col-md-4'><label>评价：</label><h5>" + data[i].COM_TYPE + "</h5></div>" +
				"<div class='col-md-12'><label>图书：</label><h5>" + data[i].COM_BOOKINFO + "</h5></div><div class='col-md-12'>" +
				"<label>内容：</label><h5>" + data[i].COM_COMMENT + "</h5></div></div>";
			$("#comment-list").append(str);
		}
	}
	
	function load() {
		$.ajax({
			url: "../Order.do",
	        data: "act=loadcomment",
	        type: "POST",
	        success: function (rel) {
	        	loadcontent(rel);
	        }
		});
		loadPageControl();
	}
	
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../Order.do",
	        data: "act=commenttotalpage",
	        type: "POST",
	        success: function (rel) {
	        	//加载页码
	        	var total = parseInt(rel);
	        	if (total == 0) {
	        		currpage = total;
	        	}
	        	totalpage = total;
	        	$("#curr-page").html(currpage);
	        	$("#total-page").html(totalpage);
	        	
	        	//是否只有一页
	    		if (currpage == totalpage) {
	    			$("#next-page").attr("disabled", "disabled");
	    		} else {
	    			$("#next-page").removeAttr("disabled");
	    		}
	        }
		});
	}
	
	//向前翻页
	$("#previous-page").click(function () {
		//列表内容加载
		if (currpage > 1) {
			currpage--;
			load();
			$("#previous-page").removeAttr("disabled");
			$("#next-page").removeAttr("disabled");
		}
		
		//是否为第一页
		if (currpage == 1) {
			$("#previous-page").attr("disabled", "disabled");
		}
		
		//加载页码
    	$("#curr-page").html(currpage);
    	$("#total-page").html(totalpage);
	});
	
	//向后翻页
	$("#next-page").click(function () {
		//列表内容加载
		if (currpage < totalpage) {
			currpage++;
			load();
			$("#previous-page").removeAttr("disabled");
			$("#next-page").removeAttr("disabled");
		}
		
		//是否为最后一页
		if (currpage == totalpage) {
			$("#next-page").attr("disabled", "disabled");
		}
		
		//加载页码
    	$("#curr-page").html(currpage);
    	$("#total-page").html(totalpage);
	});
	
	load();
	$.ajax({
		url: "../UserCenter.do",
		data: "act=countuser",
		type: "POST",
		success: function (rel) {
			var data = eval(rel);
			for (var i = 0; i < data.length; i++) {
				if (data[i].STATUS == 'ALL') {
					$("#allorder-num").text(data[i].ORDCOUNT);
				} else if (data[i].STATUS == 'CURRENT') {
					$("#currorder-num").text(data[i].ORDCOUNT);
				} else if (data[i].STATUS == 'FAVORITE') {
					$("#fav-num").text(data[i].ORDCOUNT);
				}
			}
		}
	});

});
