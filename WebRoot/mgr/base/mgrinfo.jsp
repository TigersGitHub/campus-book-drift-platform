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
		
        <title>员工信息管理 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/mgrinfo.js"></script>
        <style type="text/css">
        	.col-control {
        		min-width: 236px;
        	}
        </style>
    </head>
    
    <body>
    	<div class="modal fade" id="add-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">添加员工</h4>
					</div>
					<div class="modal-body">
						<form id="form-addemp" class="form-inline" action="<%=path %>/MgrContact.do?act=addemp" method="post">
							<label for="uname">　　姓名</label>
							<input id="name" name="uname" type="text" class="form-control" placeholder="姓名" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="usex">　　性别</label>
							<select id="sex" name="usex" class="form-control form-inline-dropdown" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">请选择性别</option>
								<option value="M">男</option>
								<option value="F">女</option>
							</select>
							<label for="upw">　　密码</label>
							<input id="pw" name="upw" type="password" class="form-control" placeholder="密码" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="upw2">确认密码</label>
							<input id="pw2" name="upw2" type="password" class="form-control" placeholder="确认密码" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="uemail">电子邮箱</label>
							<input id="email" name="uemail" type="email" class="form-control" placeholder="电子邮箱" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="utel">联系电话</label>
							<input id="tel" name="utel" type="tel" class="form-control" placeholder="联系电话" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="uage">　　年龄</label>
							<input id="age" name="uage" type="number" min="18" onkeydown="return false;" class="form-control" placeholder="年龄" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="uhometown">　　家乡</label>
							<input id="hometown" name="uhometown" type="text" class="form-control" placeholder="家乡" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="unote">　　备注</label>
							<input id="note" name="unote" type="text" class="form-control" placeholder="备注" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="saveemp" type="button" class="btn btn-success">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    
		<div class="card list-tool">
			<div class="card-block">
				<button class="btn btn-success" data-toggle="modal" data-target="#add-dialog">+&nbsp;添加员工</button>
				<button class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				<form class="form-inline pull-right">
					<input type="text" id="suid" class="form-control" placeholder="员工账号..." style="width: 106px;" />
               		<input type="text" id="suname" class="form-control" placeholder="员工姓名..." style="width: 106px;" />
               		<input type="date" id="stime" class="form-control" style="width: 152px; height: 38px;" />&nbsp;~
               		<input type="date" id="etime" class="form-control" style="width: 152px; height: 38px;" />
	        		<button type="button" id="search" class="btn btn-primary" type="button">搜索</button>
				</form>
			</div>
		</div>
		
		<div class="card list-content">
			<div class="card-block">
				<table class="table table-hover table-striped">
					<thead class="thead-default">
						<tr>
							<th width="12%">工号</th>
							<th width="12%">姓名</th>
							<th width="19%">联系电话</th>
							<th width="23%">电子邮箱</th>
							<th width="18%">交易权限</th>
							<th width="16%" class="col-control">操作</th>
						</tr>
					</thead>
					
					<tbody id="emplist">

					</tbody>
				</table>
			</div>
		</div>
    </body>
</html>
