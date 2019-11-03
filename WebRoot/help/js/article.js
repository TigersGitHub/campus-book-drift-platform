$(function () {
	$.ajax({
        url: "../LoadInfo.do",
        data: "act=helpcontent",
        type: "POST",
        success: function (rel) {
        	if (rel == "back") {
        		window.location.href = "index.jsp";
        	} else {
        		var data = eval(rel);
            	document.title = data[0].HELP_TITLE + " " + document.title; 
            	$("#article-text-title").html(data[0].HELP_TITLE);
            	$("#article-text-author").html(data[0].AUTHOR);
            	$("#article-text-time").html(data[0].ADDTIME);
            	$("#article-text-content").html(data[0].HELP_CONTENT);
        	}	                	
        }
	});
});
