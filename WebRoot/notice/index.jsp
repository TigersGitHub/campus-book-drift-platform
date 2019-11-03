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
		
        <title>新闻公告 - 书角 SHUJIAO</title>
        <script src="js/index.js" type="text/javascript"></script>
    </head>

    <body>
    	<%@ include file="/common/header.jsp" %>

        <div class="container" id="container-index">
        	<aside class="article-aside">
        		<img src="<%=path %>/images/articleleft.jpg" alt="Aside" />
        	</aside>
        	
        	<article class="article">
        		<header class="article-header">
        			<div class="article-title">新闻公告</div>
        			<div class="article-title-en">/News and Announcements</div>
        			<div class="page-control">
        				<select class="form-control" id="article-type">
        					<option value="0">全部</option>
        					<option value="N">新闻</option>
        					<option value="A">公告</option>
        				</select>
        				<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
        				<span class="pagenum" id="curr-page"></span>
        				<span class="pagenum">/</span>
        				<span class="pagenum" id="total-page"></span>
        				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
        			</div>
        		</header>
        		
        		<section>
        			<ul class="article-list" id="notice-list">
        				
        			</ul>
        		</section>
        	</article>
        </div>
        
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
