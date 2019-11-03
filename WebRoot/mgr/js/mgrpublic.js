$(function () {
	/* iframe高度自适应 */
	function changeFrameHeight() {
		var ifm = document.getElementById("iframe-mgr"); 
		ifm.height = document.documentElement.clientHeight - 54 - 28;
	}
	
	document.getElementById("iframe-mgr").onload = function () {
		changeFrameHeight();  
	};
	
	window.onresize = function () {  
	     changeFrameHeight();  
	};
	
	/* 左边栏点选切换 */
	$(".nav-second>li").click(function () {
		$(".nav-second>li").removeClass("active");
		$(this).addClass("active");
	});
});
