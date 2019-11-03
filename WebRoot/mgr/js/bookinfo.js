$(function () {
	var currpage = 1;
	var totalpage = 1;
	var type = 0;
	var issell = 0;
	var isexist = 0;
	var isbn = "";
	var bname = "";
	
	//价格格式化
	function priceformat(price) {
		return parseFloat(price).toFixed(2);
	}
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		$("#emplist").html(str);
		for (var i = 0; i < data.length; i++) {
			str = "<tr><th scope='row'>" + data[i].BOOK_ISBN + "</th><td>" + data[i].BOOK_NAME_CH + "</td><td>" + data[i].BOOK_TYPE + 
					"</td><td>" + data[i].BOOK_ISSELL + "</td><td>¥" + priceformat(data[i].BOOK_SELLPRICE) + "</td><td>" + 
					data[i].BOOK_ISEXIST + "</td><td>" + ((data[i].ORD_STATUS == null)?"无":data[i].ORD_STATUS) + "</td>" +
					"<td class='col-control'><button class='btn btn-info' data-toggle='modal' data-target='#add-dialog' " +
					"data-id='" + data[i].BOOK_ID + "' onclick='viewload(this);'>详细</button>" + ((data[i].BOOK_ENABLE == "T")
					?"<a href='../../BookCommon.do?act=bdisable&bookid=" + data[i].BOOK_ID + "' class='btn btn-danger'>禁用</a>"
					:"<a href='../../BookCommon.do?act=benable&bookid=" + data[i].BOOK_ID + "' class='btn btn-success'>启用</a>") +
					"</td></tr>";
			$("#emplist").append(str);
		}
	}
	
	//加载列表	
	function load() {
		$.ajax({
			url: "../BookCommon.do",
			data: "act=loadbinfo&page=" + currpage + "&type=" + type + "&issell=" + issell + "&isexist=" + isexist + "&isbn=" + isbn + "&bname=" + bname,
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
		isbn = $.trim($("#sisbn").val());
		issell = $("#sissell").val();
		isexist = $("#sisexist").val();
		type = $("#stype").val();
		load();		
	});
    
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../BookCommon.do",
	        data: "act=btotalpage&page=" + currpage + "&type=" + type + "&issell=" + issell + "&isexist=" + isexist + "&isbn=" + isbn + "&bname=" + bname,
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
		url: "../LoadInfo.do",
        data: "act=btype",
        type: "POST",
        success: function (rel) {
        	var stype = $("#stype");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].TYP_ID + "'>" + data[i].TYP_NAME + "</option>";
        		stype.append(str);
        	}
        }
	});
});
