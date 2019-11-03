<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String online = (String)request.getSession().getAttribute("online");
	String path = request.getContextPath(); 
%>

<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/common/meta.jsp" %>
		<%@ include file="/common/css.jsp" %>
		<%@ include file="/common/js.jsp" %>		
		<% if (online != "true") { %>
		<script type="text/javascript">
			autologin();
		</script>
		<% } %>

		<title>关于我们 - 书角 SHUJIAO</title>
		<link href="css/index.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			$(function () {
				$.ajax({
			        url: "../files/aboutUs.txt",
			        dataType: 'text',
			        success: function(data) {
			        	$("#about-aboutUs").text(data);
			        }
				});
			});			
		</script>
    </head>

    <body>    
		<%@ include file="/common/header.jsp" %>

        <div class="container" id="container-index">
        	<aside class="article-aside">
        		<img src="<%=path %>/images/articleleft.jpg" alt="Aside" />
        		<ul id="about-list">
        			<li><a href="introduction.jsp">走近书角</a></li>
        			<li><a href="agreement.jsp">服务协议</a></li>
        			<li><a href="legalnotice.jsp">法律声明</a></li>
        			<li><a class="active" href="index.jsp">关于我们</a></li>
        			<li><a href="contactus.jsp">联系我们</a></li>
        		</ul>
        	</aside>
        	
        	<article class="article">
        		<header class="article-header">
        			<div class="article-title">关于我们</div>
        			<div class="article-title-en">/About Us</div>
        		</header>
        		
        		<section>
        			<pre id="about-aboutUs"></pre>
        		</section>
        	</article>
        </div>
        
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>

