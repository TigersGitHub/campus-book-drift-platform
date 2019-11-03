<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!-- 引入jQuery -->
<script type="text/javascript">
	if (typeof jQuery == "undefined") {
		document.write("<script type='text/javascript' src='${localctx}/js/jquery-3.1.1.min.js'>" + "</sc" + "ript>");
	}
</script>
<script type="text/javascript" src="${localctx}/js/jquery.json-2.2.js"></script>
<script type="text/javascript" src="${localctx}/js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="${localctx}/js/jquery.cookie.js"></script>

<!-- 执行自动登录 -->
<script type="text/javascript">
	function autologin() {
		$.ajax({
			url: "${localctx}/AutoLogin.do",
			type: "post",
			success: function (rel) {
				if (rel == "A" || rel == "U") {
					window.location.reload();
				}
			}
		});
	}
	function mgrautologin() {
		$.ajax({
			url: "${localctx}/AutoLogin.do",
			type: "post",
			success: function (rel) {
				if (rel == "A") {
					window.location.reload();
				} else {
					window.location.href = "${localctx}/common/404.jsp";
				}
			}
		});
	}
</script>

<!-- 引入百度统计代码 -->
<script type="text/javascript">
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "https://hm.baidu.com/hm.js?0c9b0664444bba0080e5ef9195c0e4a9";
		var s = document.getElementsByTagName("script")[0]; 
		s.parentNode.insertBefore(hm, s);
	})();
</script>

<!-- 引入新浪IP归属地接口 -->
<script type="text/javascript">
    $(function () {
    	$.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js")
    	.done(function() {
    		$("#userposition").append(remote_ip_info["city"]);
    	})
    	.fail(function() {
    		$("#userposition").append("济南");
    	});
    });
</script>

<!-- 引入Tether 1.3.3（Require by Bootstrap 4 Tooltips） -->
<script type="text/javascript" src="${localctx}/js/tether.min.js"></script>

<!-- 引入Bootstrap 4.0.0 -->
<script type="text/javascript" src="${localctx}/js/bootstrap.min.js"></script>

<!-- 引入FusionCharts Suite XT -->
<script type="text/javascript" src="${localctx}/js/fusioncharts.js"></script>
<script type="text/javascript" src="${localctx}/js/fusioncharts.charts.js"></script>

<!-- 引入项目公共JS -->
<script src="${localctx}/js/public.js" type="text/javascript"></script>

<!-- 获取本地日期时间 -->
<script type="text/javascript">
	function getCurrDateTime() {
		var date = new Date();
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    var hour = date.getHours();
	    var minute = date.getMinutes();
	    var second = date.getSeconds();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    if (hour >= 0 && hour <= 9) {
	    	hour = "0" + hour;
	    }
	    if (minute >= 0 && minute <= 9) {
	    	minute = "0" + minute;
	    }
	    if (second >= 0 && second <= 9) {
	    	second = "0" + second;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
	            + " " + hour + seperator2 + minute + seperator2 + second;
		$("#datetimebox").val(currentdate);
		$("#datetimebox").text(currentdate);
	    return currentdate;
	}
	setInterval("getCurrDateTime()", 1000);
</script>

<!-- 重写console方法 -->
<script type="text/javascript">
	var console = console || {};
	console.info = console.info || function(msg){};
	console.error = console.error || function(msg){};
	console.log = console.log || function(msg){};
	console.warn = console.warn || function(msg){};
	console.assert = console.assert || function(msg){};
	console.dir = console.dir || function(msg){};
	console.clear = console.clear || function(msg){};
	console.profile = console.profile || function(msg){};
	console.profileEnd = console.profileEnd || function(msg){};
</script>

<!-- 检测浏览器支持情况 -->
<script type="text/javascript">
	var allParam = allParam || new Object();

	//console.info("本地项目路径：${localctx}");
	
	$(document).ready(function() {
	    //检测浏览器是否支持并提示
		if ($.browser.opera && allParam.browsertip == null) { 
			allParam.browsertip = true;
			alert("系统在您的浏览器上可能无法正常运行，建议更换IE、谷歌、火狐或其他采用以上内核的浏览器"); 
		} 
		//检测浏览器版本，如不符合，跳转到提示页面
	    var browserIsOk = false;
	    if($.browser.msie) {
			//IE
	    	var version = $.browser.version;
	    	if(version !== "" && version != null){
	    		version = parseInt(version);
	    	}
			if(version > 8){
				browserIsOk = true;
			}
	    } else if ($.browser.WebKit) {
			//Safari、Chrome等
			browserIsOk = true;
	    } else if ($.browser.mozilla){
			//firefox
			browserIsOk = true;
	    } else if ($.browser.chrome) {
	    	//chrome
			browserIsOk = true;
	    } else if($.browser.safari) {
			//Safari
			browserIsOk = true;
		}
		if(browserIsOk === false) {
			var url = "/common/browserDownload.jsp";
			window.location.href = sys_ctx + url;
		}
	    //监测是否支持Cookie，并提示
	   	$.cookie("opentime", new Date().getTime());
		if (top.window === window && $.cookie("opentime") == null) {
			alert("您的浏览器不支持/禁用Cookie，请您更换浏览器/启用Cookie后再试");
		}
	});
	/* //屏蔽按键
	document.onkeydown = function(event){
		if ((event.keyCode==8)  ){             //屏蔽退格删除键
			event.keyCode=0;
			event.returnValue=false;
		}
	}; */	
</script>
