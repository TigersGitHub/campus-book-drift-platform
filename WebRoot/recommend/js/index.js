$(function () {
	var currpage = 1;
	var totalpage = 1;
	var minprice = "";
	var maxprice = "";
	var bname = "";
	var btype = 0;

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
        				((data[i].REC_IMAGE != null)?data[i].REC_IMAGE:"images/defbook.jpg") + "' alt='" + data[i].REC_NAME_CH +
		        		"' /></div><div class='box-content'><table><tr><td><h4 class='title'><del>¥" + priceformat(data[i].REC_PRICE) + 
		        		"</del>&nbsp;&nbsp;¥" + priceformat(data[i].REC_SELLPRICE) + "</h4></td></tr><tr class='des-tr'><td><p class='description'>" + 
		        		data[i].REC_NAME_CH + "<br />" + data[i].REC_PRESS + "</p></td></tr><tr><td class='social-links'>" +
						"<a href='../LoadBookList.do?act=recjump&recid=" + data[i].REC_ID + "' target='_blank'>查看</a>" + 
						"</td></tr></table></div></div>";
				$("#book-list").append(str);
			}
		} else {
			var str = "<h3>没有找到符合条件的图书(⊙o⊙)~</h3>";
			$("#book-list").html(str);
		}
	}
	
	//加载列表	
	function load() {
		$.ajax({
			url: "../LoadBookList.do",
			data: "act=searchrec&bname=" + bname + "&btype=" + btype + "&minprice=" + minprice + "&maxprice=" + maxprice + "&page=" + currpage,
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
		minprice = $.trim($("#ssellprice-min").val());
		maxprice = $.trim($("#ssellprice-max").val());
		bname = $.trim($("#sname").val());
		issell = $("#sissell").val();
		btype = $("#stype").val();
		load();
	});
    
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../LoadBookList.do",
	        data: "act=rectotalpage&bname=" + bname + "&btype=" + btype + "&minprice=" + minprice + "&maxprice=" + maxprice,
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
	minprice = $.trim($("#ssellprice-min").val());
	maxprice = $.trim($("#ssellprice-max").val());
	bname = $.trim($("#sname").val());
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
});
