$(function () {		
	var currpage = 1;
	var totalpage = 1;
	var starttime = "";
	var endtime = "";
	var title = "";
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		$("#emplist").html(str);
		for (var i = 0; i < data.length; i++) {
			str = "<tr><th scope='row'>" + data[i].HELP_ID + "</th><td>" + data[i].HELP_TITLE + "</td><td>" + data[i].HELP_CONTENT + 
					"</td><td>" + data[i].HELP_AUTHOR + "</td><td>" + data[i].HELP_ADDTIME + "</td><td class='col-control'>" +
					"<button class='btn btn-success' data-toggle='modal' data-target='#edit-dialog' data-id='" + data[i].HELP_ID + 
					"' onclick='editload(this);'>编辑</button><button data-id='" + data[i].HELP_ID + "' data-title='" + 
					data[i].HELP_TITLE + "' data-toggle='modal' data-target='#del-dialog' class='btn btn-danger' " +
					"onclick='delload(this);'>删除</button></td></tr>";
			$("#emplist").append(str);
		}
	}
	
	//加载列表	
	function load() {
		$.ajax({
			url: "../../Article.do",
			data: "act=load&tab=help&title=" + title + "&starttime=" + starttime + "&endtime=" + endtime + "&page=" + currpage,
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
	        data: "act=helptotalpage&title=" + title + "&starttime=" + starttime + "&endtime=" + endtime,
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
	
	//添加框内容验证
	function addContentEnable() {
		var content = $("#article-content");
		if ($.trim(content.val()).length == 0) {
			content.attr("data-content", "内容不能为空，请检查");
			content.popover("show");
            return false;
        } else {
        	content.attr("data-content", "内容输入正确");
        	content.popover("hide");
        	return true;
        }
	}
	
	//编辑框标题验证
	function editTitleEnable() {
		var title = $("#article-title-edit");
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
	
	//编辑框内容验证
	function editContentEnable() {
		var content = $("#article-content-edit");
		if ($.trim(content.val()).length == 0) {
			content.attr("data-content", "内容不能为空，请检查");
			content.popover("show");
            return false;
        } else {
        	content.attr("data-content", "内容输入正确");
        	content.popover("hide");
        	return true;
        }
	}

	//添加框提交
	$("#savearticle").click(function () {
		if (!addTitleEnable()) {
			$("#article-title").focus();
		} else if (!addContentEnable()) {
			$("#article-content").focus();
		} else {
			$("#form-addarticle").submit();
        }
	});
	    	
	//编辑框提交
	$("#edit-savearticle").click(function () {
		if (!editContentEnable()) {
			$("#article-title-edit").focus();
		} else if (!editContentEnable()) {
			$("#article-content-edit").focus();
		} else {
    		$("#form-editarticle").submit();
        }
	});
	
	load();
});
