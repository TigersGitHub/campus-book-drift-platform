$(function () {
	var currpage = 1;
	var totalpage = 1;
	var bname = "";
	var btype = 0;
	var issell = 0;
	
	//金额格式化
	function priceformat(price) {
		return parseFloat(price).toFixed(2);
	}
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		if (data.length > 0) {
			var str = "";
			$("#book-list").html(str);
			for (var i = 0; i < data.length; i++) {
				str = "<div class='box'><div class='box-img'><img src='../" +
        				((data[i].BOOK_IMAGE != null)?data[i].BOOK_IMAGE:"images/defbook.jpg") + "' alt='" + data[i].BOOK_NAME_CH +
			    		"' /></div><div class='box-content'><table><tr><td><h4 class='title'>" + ((data[i].BOOK_ISSELL == 'Y')
						?"<del>¥" + priceformat(data[i].BOOK_PRICE) + "</del>&nbsp;&nbsp;¥" + priceformat(data[i].BOOK_SELLPRICE)
						:"在漂") + "</h4></td></tr><tr class='des-tr'><td><p class='description'>" + data[i].BOOK_NAME_CH + 
						"<br />" + data[i].BOOK_PRESS + "</p></td></tr><tr><td class='social-links'>" +
						"<a href='../LoadBookList.do?act=jump&bookid=" + data[i].BOOK_ID + "' target='_blank'>查看</a>" + 
						((data[i].FAVORITE != 'T')?"<a id='" + data[i].FAV_ID + "' onclick='removecollect(this)'>删除</a>"
						:"<a>已收藏</a>") + "</td></tr></table></div></div>";
				$("#book-list").append(str);
			}
		} else {
			var str = "<h3>没有收藏任何图书，快去逛逛吧(~￣▽￣)~！<a href='../books'>去逛逛~</a></h3>";
			$("#book-list").html(str);
		}
	}
	
	//加载列表	
	function load() {
		$.ajax({
			url: "../UserCenter.do",
			data: "act=load&bname=" + bname + "&btype=" + btype + "&issell=" + issell + "&page=" + currpage,
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
		btype = $("#stype").val();
		load();
	});
	
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../UserCenter.do",
	        data: "act=favtotalpage&bname=" + bname + "&btype=" + btype + "&issell=" + issell,
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
	bname = $.trim($("#sname").val());
	issell = $("#sissell").val();
	btype = $("#stype").val();
	load();
	$.ajax({
		url: "../LoadInfo.do",
        data: "act=btype",
        type: "POST",
        success: function (rel) {
        	var btype = $("#stype");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].TYP_ID + "'>" + data[i].TYP_NAME + "</option>";
        		btype.append(str);
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
