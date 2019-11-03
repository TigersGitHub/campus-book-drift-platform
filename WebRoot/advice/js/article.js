$(function () {	        	
	$.ajax({
        url: "../LoadInfo.do",
        data: "act=advicecontent",
        type: "POST",
        success: function (rel) {
        	if (rel == "back") {
        		window.location.href = "index.jsp";
        	} else {
        		var data = eval(rel);
            	document.title = data[0].ADV_TITLE + " " + document.title; 
            	$("#article-text-title").html(data[0].ADV_TITLE);
            	$("#article-text-author").html(data[0].AUTHOR);
            	$("#article-text-time").html(data[0].ADDTIME);
            	$("#article-text-content").html(data[0].ADV_CONTENT);
	        	if (data[0].ADV_REAUTHOR != null) {
            		$.ajax({
    	                url: "../LoadInfo.do",
    	                data: "act=advicereply&advid=" + data[0].ADV_ID,
    	                type: "POST",
    	                success: function (rel) {
    	                	var data = eval(rel);
							var str = "<div class='reply'>" + data[0].REAUTHOR + "回复："
										+ "<span class='pull-right'>" + data[0].RETIME + "</span><br />"
										+ "<p>" + data[0].REPLY + "</p></div>";
							$("#article-text-content").append(str);
    	                }
            		});
            	}
        	}	                	
        }
	});
});
