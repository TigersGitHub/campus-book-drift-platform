$(function () {
	var currpage = 1;
	var totalpage = 1;
	
	//新增建议
	$("#advice-submit").click(function () {
		var title = $("#advice-title");
		var content = $("#advice-content");
		
		if (title.val().length <= 0) {
			title.attr("data-content", "标题不能为空，请检查");
			title.popover("show");
		} else {
			if (content.val().length <= 0) {
				content.attr("data-content", "内容不能为空，请检查");
				content.popover("show");
			} else {
				$.ajax({
			        url: "../UpdateInfo.do",
			        data: "act=createAdvice&title=" + title.val() + "&content=" + content.val(),
			        type: "POST",
			        success: function (rel) {
			        	if (rel == "success") {
			        		alert("感谢您的意见建议！我们会马上安排专人处理并及时反馈");
			        		window.location.reload(true);
			        	} else {
			        		alert("系统错误，请稍后再试");
			        	}
			        }
				});
			}
		}
	});
	
	//加载建议列表
	function loadList() {
		$.ajax({
	        url: "../LoadInfo.do",
	        data: "act=advicelist&type=" + $("#article-type").val() + "&page=" + currpage,
	        type: "POST",
	        success: function (rel) {
	        	var list = $("#notice-list");
	        	var data = eval(rel);
	        	var str = "";
	        	list.html("");
	        	for (var i = 0; i < data.length; i++) {
	        		if (i == data.length - 1) {
	        			str = "<li class='last-li'>";
	        		} else {
	        			str = "<li>";
	        		}
	        		str += "<a href='../LoadInfo.do?act=advicejump&no=" + data[i].ADV_ID + "'>" 
	        				+ data[i].ADV_TITLE + "</a><span>[" + data[i].ADDTIME + "]</span></li>";
	        		list.append(str);
	        	}
	        }
		});
	}
	
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../LoadInfo.do",
	        data: "act=advicetotalpage&type=" + $("#article-type").val(),
	        type: "POST",
	        success: function (rel) {
	        	//加载页码
	        	var data = eval(rel);
	        	totalpage = parseInt(data[0].TOTALPAGE);
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
	
	//切换类别
	$("#article-type").change(function () {
		loadList();
		loadPageControl();
	});
	
	//向前翻页
	$("#previous-page").click(function () {
		//列表内容加载
		if (currpage > 1) {
			currpage--;
			loadList();
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
			loadList();
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
	
	//加载文章列表第一页
	loadList();
	//初始化换页组件
	loadPageControl();
});
