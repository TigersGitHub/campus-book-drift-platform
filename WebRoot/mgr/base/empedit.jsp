<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String online = (String)request.getSession().getAttribute("online");
	String email = (String)request.getSession().getAttribute("email");
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
		
        <title>员工信息编辑 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/empedit.js"></script>
    </head>
    
    <body>		
		<div class="card">
			<div class="card-block">
				<form id="form-emp-edit" action="../../MgrContact.do?act=edit" method="post">
					<legend>员工信息编辑</legend>
					<span class="pull-right">
						<a href="mgrinfo.jsp" class="btn btn-secondary">返回</a>	
						<% if (email.equals("admin@shujiao.club")) { %>
							<button type="button" id="form-edit-submit" class="btn btn-success">保存</button>
						<% } %>
					</span>
					<hr />
					<div class="form-group row">
						<label for="empid" class="col-sm-2 form-control-label">工号</label>
						<div class="col-sm-10">
							<span id="empid">无</span>
							<input type="hidden" name="empid" id="empid-hidden" />
						</div>
					</div>
					<div class="form-group row">
						<label for="empname" class="col-sm-2 form-control-label">姓名</label>
						<div class="col-sm-10">
							<input type="text" id="empname" name="empname" class="form-control" placeholder="请填写姓名" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div> 
					<div class="form-group row">
						<label for="empsex" class="col-sm-2 form-control-label">性别</label>
						<div class="col-sm-10">
							<select id="empsex" name="empsex" class="form-control" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="">
								<option value="0" selected>请选择性别</option>
								<option id="M" value="M">男</option>
								<option id="F" value="F">女</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label for="empage" class="col-sm-2 form-control-label">年龄</label>
						<div class="col-sm-10">
							<input type="number" id="empage" name="empage" min="18" class="form-control" placeholder="请选择年龄" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="emphome" class="col-sm-2 form-control-label">家乡</label>
						<div class="col-sm-10">
							<input type="text" id="emphome" name="emphome" class="form-control" placeholder="请填写家乡" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="empemail" class="col-sm-2 form-control-label">电子邮箱</label>
						<div class="col-sm-10">
							<input type="text" id="empemail" name="empemail" class="form-control" placeholder="请填写电子邮箱" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="emptel" class="col-sm-2 form-control-label">联系电话</label>
						<div class="col-sm-10">
							<input type="text" id="emptel" name="emptel" class="form-control" placeholder="请填写联系电话" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="empentime" class="col-sm-2 form-control-label">入职时间</label>
						<div class="col-sm-10">
							<span id="empentime">无</span>
						</div>
					</div>
					<div class="form-group row">
						<label for="empstatus" class="col-sm-2 form-control-label">账号状态</label>
						<div class="col-sm-10">
							<span id="empstatus">无</span>
						</div>
					</div>
					<div class="form-group row">
						<label for="empnote" class="col-sm-2 form-control-label">备注</label>
						<div class="col-sm-10">
							<textarea id="empnote" name="empnote" class="form-control" placeholder="备注"></textarea>
						</div>
					</div>
				</form>
			</div>
		</div>
    </body>
</html>
