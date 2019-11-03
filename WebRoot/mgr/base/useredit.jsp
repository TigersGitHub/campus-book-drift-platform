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
		
        <title>用户详细信息 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/useredit.js"></script>
    </head>
    
    <body>	
    	<div class="modal fade" id="dept-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">院系专业变更</h4>
					</div>
					<div class="modal-body">
						<label for="dept1" class="sr-only">请选择学校</label>
	                    <select id="dept1" name="dept1" class="form-control"
	                            data-toggle="popover" data-placement="right" data-content="">
	                        <option value="0" selected>* 请选择</option>
	                        
	                    </select>
	                    <label for="dept2" class="sr-only">请选择院系</label>
	                    <select id="dept2" name="dept2" class="form-control"
	                            data-toggle="popover" data-placement="right" data-content="">
	                        <option value="0" selected>* 请选择</option>
	                        
	                    </select>
	                    <label for="dept3" class="sr-only">请选择专业</label>
	                    <select id="dept3" name="dept3" class="form-control" data-container="body"
	                            data-toggle="popover" data-placement="right" data-content="">
	                        <option value="0" selected>* 请选择</option>
	                        
	                    </select>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="saveDept" type="button" class="btn btn-success">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal --> 
    	
    	<!--
    	<div class="modal fade" id="del-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">确认删除</h4>
					</div>
					<div class="modal-body"><p><b>是否确认删除用户？确认删除后不可恢复</b></p></div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="sure-delete" type="button" class="btn btn-danger">删除</button>
					</div>
				</div>
			</div>
		</div> -->    
    	
		<div class="card">
			<div class="card-block">
				<form id="form-emp-edit" action="../../UserCommon.do?act=edit&tab=user" method="post">
					<legend>用户详细信息</legend>
					<span class="pull-right">
						<a href="userinfo.jsp" class="btn btn-secondary">返回</a>
						<!-- <button type="button" id="form-edit-delete" class="btn btn-danger" data-toggle="modal" 
							data-target="#del-dialog">删除</button> -->
						<button type="button" id="form-edit-submit" class="btn btn-success">保存</button>
					</span>
					<hr />
					<div class="form-group row">
						<label for="userid" class="col-sm-2 form-control-label">账号</label>
						<div class="col-sm-10">
							<span id="userid">无</span>
							<input type="hidden" name="userid" id="userid-hidden" />
						</div>
					</div>
					<div class="form-group row">
						<label for="username" class="col-sm-2 form-control-label">用户名 *</label>
						<div class="col-sm-10">
							<input type="text" id="username" name="username" class="form-control" placeholder="* 请填写用户名" 
	                    			data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="usersex" class="col-sm-2 form-control-label">性别 *</label>
						<div class="col-sm-10">
							<select id="usersex" name="usersex" class="form-control">
								<option id="M" value="M" selected>男</option>
								<option id="F" value="F">女</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label for="userage" class="col-sm-2 form-control-label">年龄 *</label>
						<div class="col-sm-10">
							<input type="number" id="userage" name="userage" min="18" class="form-control" placeholder="* 请选择年龄" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="useremail" class="col-sm-2 form-control-label">电子邮箱 *</label>
						<div class="col-sm-10">
							<input type="text" id="useremail" name="useremail" class="form-control" placeholder="* 请填写电子邮箱" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="usertel" class="col-sm-2 form-control-label">联系电话 *</label>
						<div class="col-sm-10">
							<input type="text" id="usertel" name="usertel" class="form-control" placeholder="* 请填写联系电话" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="userdept" class="col-sm-2 form-control-label">院系专业 *</label>
						<div class="col-sm-10">
							<span id="userdept">无</span>
							<input type="hidden" name="userdept" id="userdept-hidden" />
							<button type="button" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#dept-dialog">修改</button>
						</div>
					</div>
					<div class="form-group row">
						<label for="userhome" class="col-sm-2 form-control-label">家乡</label>
						<div class="col-sm-10">
							<input type="text" id="userhome" name="userhome" class="form-control" placeholder="请填写家乡" />
						</div>
					</div>
					<div class="form-group row">
						<label for="userregtime" class="col-sm-2 form-control-label">注册时间</label>
						<div class="col-sm-10">
							<span id="userregtime">无</span>
						</div>
					</div>
					<div class="form-group row">
						<label for="userscore" class="col-sm-2 form-control-label">漂流值</label>
						<div class="col-sm-10">
							<span id="userscore">无</span>
						</div>
					</div>
					<div class="form-group row">
						<label for="userstatus" class="col-sm-2 form-control-label">账号状态</label>
						<div class="col-sm-10">
							<span id="userstatus">无</span>
						</div>
					</div>
					<div class="form-group row">
						<label for="usernote" class="col-sm-2 form-control-label">备注</label>
						<div class="col-sm-10">
							<textarea id="usernote" name="usernote" class="form-control" placeholder="备注"></textarea>
						</div>
					</div>
				</form>				
			
			</div><!-- card-block -->
		</div><!-- card -->
		
    </body>
</html>
