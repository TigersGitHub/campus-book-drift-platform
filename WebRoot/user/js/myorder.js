$(function () {
	var currpage = 1;
	var totalpage = 1;
	var bname = "";
	var starttime = "";
	var endtime = "";
	var issell = 0;
	
	//金额格式化
	function priceformat(price) {
		return parseFloat(price).toFixed(2);
	}
	
	//解析并加载
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		if (data.length != 0) {
			$("#pastorder-list").html("");
		} else {
			$("#pastorder-list").html("<h4 class='ordTab-msg'>没有找到相关订单~</h4>");
		}
		for (var i = 0; i < data.length; i++) {
			str = "<div class='order-detail'><div class='col-md-5'><label>订单编号：</label><h5>" + data[i].ORD_ID + "</h5></div>" +
					"<div class='col-md-4'><label>下单时间：</label><h5>" + data[i].ORD_TIME + "</h5></div><div class='col-md-3'>" +
					"<label>订单金额：</label><h5>¥" + priceformat(data[i].ORD_PRICE) + "</h5></div><div class='col-md-5'><label>联系电话：</label>" +
					"<h5>" + data[i].ORD_TEL + "</h5></div><div class='col-md-4'><label>　收货人：</label><h5>沈宏泰</h5></div>" +
					"<div class='col-md-3'><label>订单状态：</label><h5>" + data[i].ORD_STATUSNAME + "</h5></div><div class='col-md-12'>" +
					"<label>图书名称：</label><h5>" + data[i].ORD_TITLE + "</h5></div><div class='col-md-9'><label>收货地址：</label>" +
					"<h5>" + data[i].ORD_ADDRESS + "</h5></div><div class='col-md-3 order-btngroup'><div>" +
					"<button type='button' class='btn btn-primary' data-toggle='modal' onclick='detailLoad(this)' data-id='" + 
					data[i].ORD_ID + "' data-target='#orddetail-dialog'>详情</button></div></div></div>";
			$("#pastorder-list").append(str);
		}
	}
	
	//查询列表数据
	function load() {
		$.ajax({
			url: "../Order.do",
			data: "act=pastorder&bname=" + bname + "&starttime=" + starttime + "&endtime=" + endtime + "&issell=" + issell + "&page=" + currpage,
			type: "post",
			success: function (rel) {
				loadcontent(rel);
			}
		});
		loadPageControl();
	}	
	
	//搜索
	$("#search").click(function () {
		currpage = 1;
		bname = $.trim($("#sname").val());
		issell = $("#sissell").val();
		starttime = $("#sstarttime").val();
		endtime = $("#sendtime").val();
		load();
	});
    
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../Order.do",
	        data: "act=pastordertotalpage&bname=" + bname + "&starttime=" + starttime + "&endtime=" + endtime + "&issell=" + issell,
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
	
	//初始化
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