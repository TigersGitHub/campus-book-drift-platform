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
		
        <title>用户信息管理 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/userinfo.js"></script>
    </head>
    
    <body>
		<div class="card list-tool">
			<div class="card-block">
				<form class="form-inline">
					<button class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				</form>
				<form class="form-inline pull-right">
					<select id="scollege" class="form-control">
						<option value="0">全部院校</option>
					</select>
					<input type="text" id="suid" class="form-control" placeholder="全部或部分账号..." />
               		<input type="text" id="suname" class="form-control" placeholder="全部或部分用户名..." />
	        		<button type="button" id="search" class="btn btn-primary" type="button">搜索</button>
				</form>
			</div>
		</div>
		
		<div class="card list-content">
			<div class="card-block">
				<table class="table table-hover table-striped overhid">
					<thead class="thead-default">
						<tr>
							<th width="8%">账号</th>
							<th width="10%">用户名</th>
							<th width="8%">性别</th>
							<th width="14%">学校</th>
							<th width="18%">联系电话</th>
							<th width="18%">电子邮箱</th>
							<th width="8%">漂流值</th>
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