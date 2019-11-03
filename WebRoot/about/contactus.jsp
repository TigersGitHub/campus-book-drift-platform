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

		<title>联系我们 - 书角 SHUJIAO</title>
		<link href="css/index.css" rel="stylesheet" type="text/css" />  
		<style type="text/css">
			#map {
				width: 66%;
				margin: 12px 21px;
				padding: 3px;
				border: 1px solid rgb(222, 222, 222);
				border-radius: 6px;
			}
		</style> 
		<script type="text/javascript">
			$(function () {
				$.ajax({
			        url: "../files/contactUs.txt",
			        dataType: 'text',
			        success: function(data) {
			        	$("#about-contactUs").text(data);
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
        			<li><a href="index.jsp">关于我们</a></li>
        			<li><a class="active" href="contactus.jsp">联系我们</a></li>
        		</ul>
        	</aside>
        	
        	<article class="article">
        		<header class="article-header">
        			<div class="article-title">联系我们</div>
        			<div class="article-title-en">/Contact Us</div>
        		</header>
        		        		
        		<section>
        			<a href="http://map.baidu.com/?newmap=1&ie=utf-8&s=s%26wd%3D%E6%B5%8E%E5%8D%97%E5%A4%A7%E5%AD%A6%E8%A5%BF%E6%A0%A1%E5%8C%BA-%E7%AC%AC12%E6%95%99%E5%AD%A6%E6%A5%BC" target="_blank">
        				<img id="map" src="../images/contactus.png" />
       				</a>
        			<pre id="about-contactUs"></pre>
        		</section>
        	</article>
        </div>
        
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>

