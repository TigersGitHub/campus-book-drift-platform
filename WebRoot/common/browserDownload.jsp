<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%  String path = request.getContextPath(); %>

<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/common/meta.jsp" %>
		<%@ include file="/common/css.jsp" %>
		<%@ include file="/common/js.jsp" %>
		
		<title>浏览器版本过低 - 书角 SHUJIAO</title>		
		<link rel="stylesheet" type="text/css" href="<%=path %>/common/css/error.css" />
	</head>
	
	<body>
		<section class="container">
			<header>
				<img src="<%=path %>/common/images/logo_emboss.png" alt="书角 SHUJIAO" />
			</header>
			
			<section class="err-content">
				<dl>
					<a href="https://support.microsoft.com/zh-cn/help/18520/download-internet-explorer-11-offline-installer" target="_blank">
						<dt><img src="<%=path %>/common/images/ie.png" alt="IE" /></dt>
						<dd class="h4">Microsoft IE 9.0+</dd>
					</a>
				</dl>
				<dl>
					<a href="http://www.google.cn/chrome/browser/desktop/index.html" target="_blank">
						<dt><img src="<%=path %>/common/images/chrome.png" alt="Chrome" /></dt>
						<dd class="h4">Google Chrome</dd>
					</a>
				</dl>
				<dl>
					<a href="http://www.firefox.com.cn/download/" target="_blank">
						<dt><img src="<%=path %>/common/images/firefox.png" alt="Firefox" /></dt>
						<dd class="h4">Mozilla Firefox</dd>
					</a>
				</dl>
				<dl>
					<a href="https://support.apple.com/zh-cn/safari" target="_blank">
						<dt><img src="<%=path %>/common/images/safari.png" alt="Safari" /></dt>
						<dd class="h4">Apple Safari</dd>
					</a>
				</dl>
				<h1>小主的浏览器版本有些旧了</h1>
				<h1>点击上面的图标去获取最新版本吧~</h1>
			</section>
			
			<footer>
				<p>2017 &copy; 书角网</p>
			</footer>
		</section>
	</body>
</html>
