$(function () {		
	//金额格式化
	function priceformat(price) {
		return parseFloat(price).toFixed(2);
	}
	
	//加载推荐列表
	function reccontent(rel) {
		var data  = eval(rel);
    	var str = "";
    	for (var i = 0; i < data.length; i++) {
    		str = "<div class='box'><div class='box-img'><img src='../" +
        				((data[i].REC_IMAGE != null)?data[i].REC_IMAGE:"images/defbook.jpg") + "' alt='" + data[i].REC_NAME_CH +
	        		"' /></div><div class='box-content'><table><tr><td><h4 class='title'><del>¥" + priceformat(data[i].REC_PRICE) + 
	        		"</del>&nbsp;&nbsp;¥" + priceformat(data[i].REC_SELLPRICE) + "</h4></td></tr><tr class='des-tr'><td><p class='description'>" + 
	        		data[i].REC_NAME_CH + "<br />" + data[i].REC_PRESS + "</p></td></tr><tr><td class='social-links'>" +
    				"<a href='../LoadBookList.do?act=recjump&recid=" + data[i].REC_ID + "' target='_blank'>查看</a>" + 
    				"</td></tr></table></div></div>";
    		$("#rec-floor").append(str);
    	}
	}
	
	//查询推荐列表
	$.ajax({
		url: "../LoadBookList.do",
		data: "act=recbookbytype",
		type: "post",
		success: function (rel) {
			reccontent(rel);
			var data = eval(rel);
			if (data.length < 3) {
				var addon = 3 - data.length;
				$.ajax({
					url: "../LoadBookList.do",
					data: "act=recbookaddon&addon=" + addon,
					type: "post",
					success: function (rel) {
						reccontent(rel);
					}
				});
			}
		}
	});
	
	//加载图书详情
	$.ajax({
		url: "../LoadBookList.do",
		data: "act=getUserid",
		type: "post",
		success: function (rel) {
			var userid = rel;
			$.ajax({
				url: "../LoadBookList.do",
				data: "act=detail",
				type: "post",
				success: function (rel) {
					var data = eval(rel);
					var str = "";
					$("#book-name").text(data[0].BOOK_NAME_CH);
					$("#book-name-en span").text(data[0].BOOK_NAME_EN);
					$("#book-author span").text(data[0].BOOK_AUTHOR_CH);
					$("#book-author-en span").text(data[0].BOOK_AUTHOR_EN);
					$("#book-sellprice span").text(priceformat(data[0].BOOK_SELLPRICE));
					$("#book-price span").text(priceformat(data[0].BOOK_PRICE));
					if (data[0].BOOK_SELLER == userid) {
						str += "<button class='btn btn-success disabled'>本人发布</button>&nbsp;&nbsp;";
					} else if (data[0].BOOK_ISEXIST == "Y") {
						str += "<button data-id='" + data[0].BOOK_ID + "' class='btn btn-success' onclick='order(this)'>立即购买</button>&nbsp;&nbsp;";
					} else if (data[0].BOOK_ISEXIST == "N") {
						str += "<button class='btn btn-success disabled'>&nbsp;已售出&nbsp;</button>&nbsp;&nbsp;";
					}
					if (data[0].FAVORITE != "T") {
						str += "<button type='button' id='" + data[0].BOOK_ID + "' class='btn btn-secondary' onclick='collect(this)'>&nbsp;收藏&nbsp;</button>";
					} else {
						str += "<button type='button' class='btn btn-secondary' disabled>已收藏</button>";
					}
					str += "<a class='btn btn-secondary-outline disabled'>浏览量 " + data[0].BOOK_CLICK + "</a>";
					$("#btn-grp").html(str);
					$("#book-isbn").text(data[0].BOOK_ISBN);
					$("#book-type").text(data[0].BOOK_TYPE);
					$("#book-language").text(data[0].BOOK_LANGUAGE);
					$("#book-press").text(data[0].BOOK_PRESS);
					$("#book-pressdate").text(data[0].BOOK_PRESSDATE);
					$("#book-version").text(data[0].BOOK_VERSION);
					$("#book-format").text(data[0].BOOK_FORMAT);
					$("#book-page").text(data[0].BOOK_PAGE);
					$("#book-cover").text(data[0].BOOK_COVER);
					$("#book-detail").text(data[0].BOOK_DETAIL);
					if (data[0].BOOK_IMAGE != null) {
						$("#book-image").attr("src", "../" + data[0].BOOK_IMAGE);
					}
				}
			});
		}
	});
});
