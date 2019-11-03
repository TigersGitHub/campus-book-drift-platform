$(function () {	
	var currpage = 1;
	var totalpage = 1;
	var scollege = 0;
	var suid = "";
	var suname = "";
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		$("#emplist").html(str);
		for (var i = 0; i < data.length; i++) {				
			str = "<tr><th scope='row'>" + data[i].U_ID + "</th><td>" + data[i].U_NAME + "</td>" +
					"<td>" + ((data[i].U_SEX == "M")?'男':'女') + "</td><td>" + data[i].U_COLLEGENAME + "</td>" +
					"<td>" + data[i].U_MOBILE + "</td><td>" + data[i].U_EMAIL + "</td><td>" + data[i].U_SCORE + "</td>" +
					"<td class='col-control'><a href='../../UserCommon.do?act=jump&tab=user&userid=" + data[i].U_ID + 
					"' class='btn btn-info'>详细</a>";
			if (data[i].U_ENABLE == "T") {
				str += "<a href='../../UserCommon.do?act=disable&userid=" + data[i].U_ID + "' class='btn btn-danger'>禁用</a>";
			} else {
				str += "<a href='../../UserCommon.do?act=enable&userid=" + data[i].U_ID + "' class='btn btn-success'>启用</a>";					
			}
			str += "</td></tr>";
			$("#emplist").append(str);
		}
	}
	
	//加载列表
	function load() {
		$.ajax({
			url: "../../UserCommon.do",
			type: "post",
			data: "act=load&tab=user&scollege=" + scollege + "&suid=" + suid + "&suname=" + suname + "&page=" + currpage,
			success: function (rel) {
				loadcontent(rel);
			}
		});
		loadPageControl();
	}

	//初始化
	load();
	$.ajax({
		url: "../../Reg.do",
		data: "act=loaddept&parentid=0",
		type: "post",
		success: function (rel) {
			var data = eval(rel);
			var str = "";
			for (var i = 0; i < data.length; i++) {
				str = "<option value='" + data[i].DEPT_ID + "'>" + data[i].DEPT_NAME + "</option>";
				$("#scollege").append(str);
			}
		}
	});
	
	//搜索
	$("#search").click(function () {
		currpage = 1;
		scollege = $("#scollege").val();
		suid = $("#suid").val();
		suname = $("#suname").val();
		load();
	});	
	
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../../UserCommon.do",
	        data: "act=usertotalpage&scollege=" + scollege + "&suid=" + suid + "&suname=" + suname,
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
