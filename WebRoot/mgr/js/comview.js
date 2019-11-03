$(function() {
	var currpage = 1;
	var totalpage = 1;
	var starttime = "";
	var endtime = "";
	var ordid = "";
	var type = 0;
	
	function priceformat(price) {
		return parseFloat(price).toFixed(2);
	}
	
	//解析并加载
	function loadcontent(rel, obj) {
		var data = eval(rel);
		var str = "";
		if (data.length != 0) {
			obj.html("");
		} else {
			obj.html("<h4 class='ordTab-msg'>没有找到相关评论~</h4>");
		}
		for (var i = 0; i < data.length; i++) {
			str = "<div class='comment-detail'><div class='col-md-4'><label>订单编号：</label><h5>" + data[i].COM_ORDER + "</h5></div>" +
					"<div class='col-md-4'><label>时间：</label><h5>" + data[i].COM_TIME + "</h5></div><div class='col-md-4'>" +
					"<label>来自：</label><h5>" + data[i].COM_USERNAME + "(" + data[i].COM_USERID + ")</h5></div>" +
					"<div class='col-md-12'><label>图书：</label><h5>" + data[i].COM_BOOKINFO + "</h5></div>" +
					"<div class='col-md-12'><label>评价：</label><h5>【" + data[i].COM_TYPE + "】" + data[i].COM_COMMENT + "</h5></div></div>";
			obj.append(str);
		}
	}
	
	//搜索
	$("#search").click(function () {
		currpage = 1;
		starttime = $.trim($("#sstarttime").val());
		endtime = $.trim($("#sendtime").val());
		ordid = $.trim($("#sordid").val());
		type = $("#stype").val();
		load();
	});
	
	//加载列表
	function load() {
		$.ajax({
			url: "../Order.do",
	        data: "act=loadcomformgr&type=" + type + "&ordid=" + ordid + "&starttime=" + starttime + "&endtime=" + endtime + "&page=" + currpage,
	        type: "POST",
	        success: function (rel) {
	        	loadcontent(rel, $("#ordview-list"));
	        }
		});
		loadPageControl();
	}
	load();
	
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../Order.do",
	        data: "act=mgrcomtotalpage&type=" + type + "&ordid=" + ordid + "&starttime=" + starttime + "&endtime=" + endtime,
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
});
