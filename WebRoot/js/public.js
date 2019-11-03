$(function () {
    var cusService = $("#cusService");
    var myShuJiao = $("#myShuJiao");
    var myShuJiaoBtn = $("#myShuJiaoBtn");
    var cusServiceBtn = $("#cusServiceBtn");
    var myShuJiaoList = $("#myShuJiaoList");
    var cusServiceList = $("#cusServiceList");

    myShuJiaoBtn.click(function () {
        window.location.href = myShuJiaoBtn.attr("href");
    });

    myShuJiaoBtn.mouseenter(function () {
        if (cusService.hasClass("open")) {
            cusService.removeClass("open");
        }
        myShuJiao.addClass("open");
    });
    
    myShuJiaoList.mouseleave(function () {
        if (myShuJiao.hasClass("open")) {
            myShuJiao.removeClass("open");
        }
    });

    cusServiceBtn.click(function () {
        window.location.href = cusServiceBtn.attr("href");
    });

    cusServiceBtn.mouseenter(function () {
        myShuJiao.removeClass("open");
        cusService.addClass("open");
    });

    cusServiceList.mouseleave(function () {
        if (cusService.hasClass("open")) {
            cusService.removeClass("open");
        }
    });
    
	//图书搜索
	$("#search-form").keydown(function (e) {
		//回车键监听
		var e = e || event,
		keycode = e.which || e.keyCode;
		if (keycode == 13) {
			$("#searchbyname").trigger("click");
		}
	});
	$("#searchbyname").click(function () {
		var key = $("#key").val();
		var datas = "";
		if (key.length == 0) {
			datas = "act=loadall";
		} else {
			datas = "act=searchbyname";
		}
		$("#search-form").attr("action", "../LoadBookList.do?" + datas);
		$("#search-form").submit();
	});
	
	//问候语生成
	var time = new Date();
	var hr = time.getHours();
	var greetstr = "";
	if (hr >= 6 && hr < 9) {
		greetstr = "早上好";
	} else if (hr >= 9 && hr < 12) {
		greetstr = "上午好";
	} else if (hr >= 12 && hr < 14) {
		greetstr = "中午好";
	} else if (hr >= 14 && hr < 18) {
		greetstr = "下午好";
	} else if (hr >= 18 && hr < 21) {
		greetstr = "晚上好";
	} else if (hr >= 21 || hr < 6) {
		greetstr = "夜深了";
	}
	$("#greeting").text(greetstr);
});
