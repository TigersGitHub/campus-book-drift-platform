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
		
        <title>图书分类字典 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/booktype.js"></script>
    </head>
    
    <body>
		
		<div class="card list-tool">
			<div class="card-block">
			<!-- 
				<form id="form-dctadd" class="form-inline" action="../../DctCommon.do?act=add&dct=btype" method="post">
					<label for="btypename">&nbsp;名称&nbsp;</label>
					<input id="btypename" name="btypename" type="text" class="form-control" placeholder="节点名称" />
					<label for="note">&nbsp;备注&nbsp;</label>
					<input id="note" name="note" type="text" class="form-control" placeholder="备注" />
					<button class="btn btn-success" id="save">新增</button>
				</form>
			-->
				<button class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				
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
				<div class="alert alert-danger alert-dismissible fade in" role="alert">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<strong>注意！</strong>该字典不允许新增、删除节点，节点编辑操作将影响首页及商品购买等诸多功能，请谨慎！
				</div>
			
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