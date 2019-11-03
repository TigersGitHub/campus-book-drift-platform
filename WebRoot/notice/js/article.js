$(function () {
	$.ajax({
        url: "../LoadInfo.do",
        data: "act=noticecontent",
        type: "POST",
        success: function (rel) {
        	if (rel == "back") {
        		window.location.href = "index.jsp";
        	} else {
        		var data = eval(rel);
            	var type = "";
            	if (data[0].NTC_TYPE == "A") {
            		type = "书角公告";
            	}
            	if (data[0].NTC_TYPE == "N") {
            		type = "书角新闻";
            	}
            	document.title = data[0].NTC_TITLE + " " + document.title; 
            	$("#article-text-title").html(data[0].NTC_TITLE);
            	$("#article-text-type").html(type);
            	$("#article-text-author").html(data[0].AUTHOR);
            	$("#article-text-time").html(data[0].ADDTIME);
            	$("#article-text-content").html(data[0].NTC_CONTENT);
        	}	                	
        }
	});
});
