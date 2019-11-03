<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%  String path = request.getContextPath(); %>

<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/common/meta.jsp" %>
		<%@ include file="/common/css.jsp" %>
		<%@ include file="/common/js.jsp" %>
		
		<title>页面不存在 - 书角 SHUJIAO</title>		
		<link rel="stylesheet" type="text/css" href="<%=path %>/common/css/error.css" />
        
        <script type="text/javascript">
	        $(function () {
	        	var s = $("#second");
	        	var count = 5;	
	        	
	        	setInterval(function () {
	        		if (--count == 0) {
	        			window.location.href = "<%=path %>/";
	        		} else {
	        			$("#second").html(count);
	        		}
	        	}, 1000);
	        });
        </script>
	</head>
	
	<body>
		<section class="container">
			<header>
				<img src="<%=path %>/common/images/logo_emboss.png" alt="书角 SHUJIAO" />
			</header>
			
			<section class="err-content">
				<img src="<%=path %>/common/images/404.png" alt="404" />
				<h1>木有找到亲要访问的页面哦⊙﹏⊙</h1>
				<a href="<%=path %>/" class="btn btn-primary btn-lg">返回首页（<span id="second">5</span>秒后自动返回）</a>
			</section>
			
			<footer>
				<p>2017 &copy; 书角网</p>
			</footer>
		</section>
	</body>
</html>
