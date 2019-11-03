<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String online = (String)request.getSession().getAttribute("online");
	String path = request.getContextPath(); 
	if (online == "true") {
		if (request.getSession(false).getAttribute("sign").equals("A") != true) {
			response.sendRedirect(path + "/common/404.jsp");
		}
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/common/meta.jsp" %>
		<%@ include file="/common/css.jsp" %>
		<%@ include file="/common/js.jsp" %>		
		<% if (online != "true") { %>
		<script type="text/javascript">
			mgrautologin();
		</script>
		<% } %>
		
        <title>评价信息查询 - 书角 SHUJIAO</title>
        <link href="css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/comview.js"></script>
        <style type="text/css">
        	.ordTab-msg {
				text-align: center;
				padding: 150px 0;
				margin: 0;
			}
			
			.list-content {
				padding-bottom: 16px;
			}
			
			#ordview-list {
				padding-bottom: 0;
			}
			
			.comment-detail {
				padding: 16px 8px;
				border-top: 2px dashed rgb(222, 222, 222);
				height: 120px;
			}
			
			.comment-detail:first-child {
				border-top: none;
				padding-top: 0;
				height: 104px;
			}
			
			.order-btngroup {
				position: relative;
			}
			
			.order-btngroup div {
				position: absolute;
				top: -16px;
				left: -10px;
				width: 100%;
				text-align: center;
			}
			
			#orddetail-dialog h5,
			#ordview-list h5 {
			    font-weight: bold;
			    display: inline;
			}
        </style>
    </head>
    
    <body>
		<div class="card list-tool">
			<div class="card-block">
				<form class="form-inline">
					<select id="stype" name="stype" class="form-control">
						<option value="0">评价类型</option>
						<option value="G">好评</option>
						<option value="B">差评</option>
					</select>
					<input type="text" id="sordid" name="sordid" class="form-control view-searchbox" placeholder="订单编号" />
					<input type="date" id="sstarttime" name="sstarttime" class="form-control view-searchbox" /> ~
					<input type="date" id="sendtime" name="sendtime" class="form-control view-searchbox" />
					<span class="pull-right">
						<button type="button" id="search" class="btn btn-primary">搜索</button>
						<button type="reset" class="btn btn-secondary">重置</button>
					</span>
				</form>		
			</div>
		</div>
		
		<div class="card list-content">
			<div class="card-block" id="ordview-list">
				<h4 class="ordTab-msg">评价信息加载中，请稍候...</h4>
			</div>
		
			<div class="page-control">
				<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
				<span class="pagenum" id="curr-page"></span>
				<span class="pagenum">/</span>
				<span class="pagenum" id="total-page"></span>
				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
			</div>
		</div>
    </body>
</html>
