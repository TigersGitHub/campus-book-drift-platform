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
		
        <title>意见建议 - 书角 SHUJIAO</title>
        <script src="js/index.js" type="text/javascript"></script>
        <link href="css/index.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
		<div class="modal fade" id="createAdvice" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="createAdviceTitle">建言献策</h4>
					</div>
					<div class="modal-body">
						<input type="text" class="form-control" id="advice-title" placeholder="意见建议标题" 
                           data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						<textarea class="form-control" id="advice-content" placeholder="请在此不吝写下您的意见建议^_^..."
                           data-container="body" data-toggle="popover" data-placement="right" data-content=""></textarea>
					</div>
					<div class="modal-footer">
						<button id="advice-submit" type="button" class="btn btn-success">&nbsp;&nbsp;提交&nbsp;&nbsp;</button>
					</div>
				</div>
			</div>
		</div>
    
		<%@ include file="/common/header.jsp" %>

        <div class="container" id="container-index">
        	<aside class="article-aside">
        		<img src="<%=path %>/images/articleleft.jpg" alt="Aside" />
        	</aside>
        	
        	<article class="article">
        		<header class="article-header">
        			<div class="article-title">意见建议</div>
        			<div class="article-title-en">/Suggestions and Feedback</div>
        			<div class="page-control"> 
        				<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
        				<span class="pagenum" id="curr-page"></span>
        				<span class="pagenum">/</span>
        				<span class="pagenum" id="total-page"></span>
        				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
        			</div>
       				<span class="pull-right">
       					<% if (online == "true") { %>
	       					<button class="btn btn-success" data-toggle="modal" data-target="#createAdvice">建言献策</button>
       					<% } %>
       					&nbsp;&nbsp;
       				</span>
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
