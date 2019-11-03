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
		
        <title>用户地址管理 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	#sprov, #scity, #sdist {
        		min-width: 100px;
        	}
        </style>
        <script type="text/javascript" src="js/useradr.js"></script>
    </head>
    
    <body>
		<div class="card list-tool">
			<div class="card-block">
				<button class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				<form class="form-inline pull-right">				
                	<input type="text" id="suid" class="form-control" placeholder="全部或部分账号..." />
					<select id="sprov" class="form-control">
						<option value="0">全部</option>
					</select>
					<select id="scity" class="form-control">
						<option value="0">全部</option>
					</select>
					<select id="sdist" class="form-control">
						<option value="0">全部</option>
					</select>
                	<input type="text" id="sadr" class="form-control" placeholder="全部或部分详细地址..." />
		    		<button type="button" id="search" class="btn btn-primary" type="button">&nbsp;&nbsp;搜索&nbsp;&nbsp;</button>
			    </form>
			</div>
		</div>
		
		<div class="card list-content">
			<div class="card-block">
				<table class="table table-hover table-striped overhid">
					<thead class="thead-default">
						<tr>
							<th width="8%">用户</th>
							<th width="8%">收货人</th>
							<th width="8%">省</th>
							<th width="8%">市</th>
							<th width="8%">区</th>
							<th width="24%">详细地址</th>
							<th width="12%">联系电话</th>
							<th width="8%">邮编</th>
							<th width="16%" class="col-control">操作</th>
						</tr>
					</thead>
					
					<tbody id="emplist">
					
					</tbody>
				</table>
				
				<div class="page-control">
					<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
       				<span class="pagenum" id="curr-page"></span>
       				<span class="pagenum">/</span>
       				<span class="pagenum" id="total-page"></span>
       				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
				</div>
			</div>
		</div>
		
    </body>
</html>