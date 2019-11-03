$(function () {		
	var currpage = 1;
	var totalpage = 1;
	var starttime = "";
	var endtime = "";
	var title = "";
	var type = 0;
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		$("#emplist").html(str);
		for (var i = 0; i < data.length; i++) {
			str = "<tr><th scope='row'>" + data[i].ADV_ID + "</th><td>" + data[i].ADV_TITLE + "</td><td>" + data[i].ADV_AUTHOR + 
					"</td><td>" + data[i].ADV_ADDTIME + "</td><td>" + ((data[i].ADV_RETIME != null)?data[i].ADV_RETIME:"未处理") + 
					"</td><td class='col-control'>" + ((data[i].ADV_RETIME == null)
					?"<button class='btn btn-warning' data-toggle='modal' data-target='#edit-dialog' data-id='" + data[i].ADV_ID + "' onclick='editload(this);'>审阅</button>"
					:"<button class='btn btn-info' data-toggle='modal' data-target='#disp-dialog' data-id='" + data[i].ADV_ID + "' onclick='dispload(this);'>查看</button>") +
					((data[i].ADV_ENABLE == "T")
					?"<a href='../../Article.do?act=disable&advid=" + data[i].ADV_ID + "' class='btn btn-danger'>禁用</a></td></tr>"
					:"<a href='../../Article.do?act=enable&advid=" + data[i].ADV_ID + "' class='btn btn-success'>启用</a></td></tr>");
			$("#emplist").append(str);
		}
	}
	
	//加载列表	
	function load() {
		$.ajax({
			url: "../../Article.do",
			data: "act=load&tab=advice&type=" + type + "&title=" + title + "&starttime=" + starttime + "&endtime=" + endtime + "&page=" + currpage,
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
		starttime = $.trim($("#starttime").val());
		endtime = $.trim($("#endtime").val());
		title = $.trim($("#searchbox").val());
		type = $("#stype").val();
		load();
	});
    
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../../Article.do",
	        data: "act=advtotalpage&type=" + type + "&title=" + title + "&starttime=" + starttime + "&endtime=" + endtime,
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
	
	//添加框标题验证
	function addTitleEnable() {
		var title = $("#article-title");
		if ($.trim(title.val()).length == 0) {
			title.attr("data-content", "标题不能为空，请检查");
			title.popover("show");
            return false;
        } else {
        	title.attr("data-content", "标题输入正确");
        	title.popover("hide");
			return true;
        }
	}
	
	//审阅内容验证
	function replyEnable() {
		var content = $("#article-reply");
		if ($.trim(content.val()).length == 0) {
			content.attr("data-content", "回复不能为空，请检查");
			content.popover("show");
            return false;
        } else {
        	content.attr("data-content", "回复输入正确");
        	content.popover("hide");
        	return true;
        }
	}	
	    	
	//编辑框提交
	$("#edit-savearticle").click(function () {
		if (!replyEnable()) {
			$("#article-reply").focus();
		} else {
    		$("#form-editarticle").submit();
        }
	});
	
	load();
});
