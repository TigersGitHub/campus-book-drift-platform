$(function () {
	//金额格式化
	function priceformat(price) {
		return parseFloat(price).toFixed(2);
	}
	
	//买家评价
	function commentEnable() {
        var comment = $("#comment");
        if (comment.val() == "") {
        	comment.attr("data-content", "评价不能为空，请检查");
        	comment.popover("show");
            return false;
        } else {
        	comment.attr("data-content", "评价输入正确");
        	comment.popover("hide");
            return true;
        }
    }
	$("#comment").blur(function () {
		commentEnable();
	});
	
	$("#cusComment").click(function () {
		if (!commentEnable()) {
			$("#comment").attr("data-content", "评价不能为空，请检查");
			$("#comment").popover("show");
            return false;
		} else {
			$("#comment-form").submit();
		}
	});
	
	//解析并加载
	function loadcontent(rel, obj) {
		var data = eval(rel);
		var str = "";
		if (data.length != 0) {
			obj.html("");
		} else {
			obj.html("<h4 class='ordTab-msg'>没有找到相关订单~</h4>");
		}
		for (var i = 0; i < data.length; i++) {
			str = "<div class='order-detail'><div class='col-md-5'><label>订单编号：</label><h5>" + data[i].ORD_ID + "</h5></div>" +
					"<div class='col-md-4'><label>下单时间：</label><h5>" + data[i].ORD_TIME + "</h5></div><div class='col-md-3'>" +
					"<label>订单金额：</label><h5>¥" + priceformat(data[i].ORD_PRICE) + "</h5></div><div class='col-md-5'><label>联系电话：</label>" +
					"<h5>" + data[i].ORD_TEL + "</h5></div><div class='col-md-4'><label>　收货人：</label><h5>" + data[i].ORD_NAME + 
					"</h5></div><div class='col-md-3'><label>订单状态：</label><h5>" + data[i].ORD_STATUSNAME + 
					"</h5></div><div class='col-md-12'><label>图书名称：</label><h5>" + data[i].ORD_TITLE + 
					"</h5></div><div class='col-md-9'><label>收货地址：</label><h5>" + data[i].ORD_ADDRESS + 
					"</h5></div><div class='col-md-3 order-btngroup'><div>";
			if ("" + data[i].ORD_STATUS == "1") {
				str += "<button type='button' class='btn btn-secondary' data-toggle='modal' onclick='cancelLoad(this)' data-id='" + 
						data[i].ORD_ID + "' data-target='#ordcancel-dialog'>取消</button>&nbsp;" +
					"<button type='button' class='btn btn-primary' data-toggle='modal' onclick='detailLoad(this)' data-id='" + 
						data[i].ORD_ID + "' data-target='#orddetail-dialog'>详情</button>&nbsp;" +
					"<a href='../books/checkout.jsp?orderid=" + data[i].ORD_ID + "' class='btn btn-success'>支付</a>";
			} else if ("" + data[i].ORD_STATUS == "2") {
				str += "<button type='button' class='btn btn-secondary' data-toggle='modal' onclick='cancelLoad(this)' data-id='" + 
						data[i].ORD_ID + "' data-target='#ordcancel-dialog'>取消</button>&nbsp;" +
					"<button type='button' class='btn btn-primary' data-toggle='modal' onclick='detailLoad(this)' data-id='" + 
						data[i].ORD_ID + "' data-target='#orddetail-dialog'>详情</button>&nbsp;";
			} else if ("" + data[i].ORD_STATUS == "3") {
				str += "<button type='button' class='btn btn-primary' data-toggle='modal' onclick='detailLoad(this)' data-id='" + 
						data[i].ORD_ID + "' data-target='#orddetail-dialog'>详情</button>&nbsp;" +
					"<button type='button' class='btn btn-info' data-toggle='modal' onclick='acceptLoad(this)' data-id='" + 
						data[i].ORD_ID + "' data-target='#ordaccept-dialog'>确认收货</button>&nbsp;";
			} else if ("" + data[i].ORD_STATUS == "4") {
				str += "<button type='button' class='btn btn-primary' data-toggle='modal' onclick='detailLoad(this)' data-id='" + 
					data[i].ORD_ID + "' data-target='#orddetail-dialog'>详情</button>&nbsp;";
				if ("" + data[i].ORD_CUSCOM == "F") {
					str += "<button type='button' class='btn btn-info' data-toggle='modal' onclick='commentLoad(this)' data-id='" + 
						data[i].ORD_ID + "' data-target='#ordcomment-dialog'>评价</button>&nbsp;";
				} else if ("" + data[i].ORD_SELCOM == "F") {
					str += "<button type='button' class='btn btn-info' disabled='disabled'>等待卖方评价</button>&nbsp;";
				}
			}
			str += "</div></div></div>";
			obj.append(str);
		}
	}
	
	//查询订单信息
	function load() {
		$.ajax({
			url: "../Order.do",
	        data: "act=loadorderbystatus&status=1",
	        type: "POST",
	        success: function (rel) {
	        	loadcontent(rel, $("#beforepay"));
	        }
		});
		$.ajax({
			url: "../Order.do",
	        data: "act=loadorderbystatus&status=2",
	        type: "POST",
	        success: function (rel) {
	    		loadcontent(rel, $("#beforesign"));
	        }
		});
		$.ajax({
			url: "../Order.do",
	        data: "act=loadorderbystatus&status=4",
	        type: "POST",
	        success: function (rel) {
	    		loadcontent(rel, $("#beforecom"));
	        }
		});		
	}

	//初始化
	load();
	$.ajax({
		url: "../LoadBookList.do",
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
