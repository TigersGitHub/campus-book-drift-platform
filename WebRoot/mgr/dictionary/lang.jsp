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
		
        <title>图书语种字典 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/lang.js"></script>
    </head>
    
    <body>
		<div class="card list-tool">
			<div class="card-block">
				<form id="form-dctadd" class="form-inline" action="../../DctCommon.do?act=add&dct=lang" method="post">
					<label for="langname">&nbsp;名称&nbsp;</label>
					<input id="langname" name="langname" type="text" class="form-control" placeholder="节点名称" />
					<label for="note">&nbsp;备注&nbsp;</label>
					<input id="note" name="note" type="text" class="form-control" placeholder="备注" />
					<button class="btn btn-success" id="save">新增</button>
				</form>		
						
				<span class="input-group pull-right">
                	<input type="text" id="key" class="form-control" placeholder="输入节点名称..." />
		    		<span class="input-group-btn">
			        	<button type="button" id="search" class="btn btn-primary" type="button">&nbsp;&nbsp;搜索&nbsp;&nbsp;</button>
			    	</span>
                </span>
			</div>
		</div>
    
		<div class="card dct-editor list-content">
			<div class="card-block">
				<table class="table table-hover table-striped overhid">
					<thead class="thead-default">
						<tr>
							<th width="12%">编号</th>
							<th width="20%">名称</th>
							<th>备注</th>
							<th width="16%" class="col-control">操作</th>
						</tr>
					</thead>
					
					<tbody id="dctlist">
					
					</tbody>
				</table>
			</div>
		</div>
    </body>
</html>