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

        <title>- 书角 SHUJIAO</title>
        <script src="js/article.js" type="text/javascript"></script>
    </head>
    <body>
		<%@ include file="/common/header.jsp" %>
		
        <div class="container" id="container-index">
			<aside class="article-aside">
        		<img src="<%=path %>/images/articleleft.jpg" alt="Aside" />
        	</aside>
        	
        	<article class="article">
        		<header class="article-header">
        			<div class="article-title">帮助中心</div>
        			<div class="article-title-en">/Help Center</div>
        			<div class="page-control">
        				<a class="btn btn-secondary" href="index.jsp">返回列表</a>
        			</div>
        		</header>
        			
        		<section class="article-text">
        			<div id="article-text-title" class="article-text-title"></div>
        				<div class="article-text-info">
        					作者：<span id="article-text-author"></span>&nbsp;&nbsp;
        					时间：<span id="article-text-time"></span>
        				</div>
        				<div id="article-text-content" class="article-text-content"></div>
        		</section>
    		</article>
        </div>
        
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
