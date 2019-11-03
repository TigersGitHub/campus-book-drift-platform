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
		
        <title>个人资料修改 - 书角 SHUJIAO</title>
        <style type="text/css">
        	#u_deptid {
        		line-height: 38px;
        		padding: 0 15px;
        	}
        </style>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        <script src="js/myinfo.js" type="text/javascript"></script>	
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
    
        <%@ include file="/common/header.jsp" %>

		<div class="container" id="container-index">
			<%@ include file="/common/useraside.jsp" %>
			
			<section id="user-main" class="floors">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>个人资料修改</h5>
	            </header>
				
				<section id="myinfo">
					<form id="sell-form" action="../UserCenter.do?act=editinfo" method="post">
						<div class="col-md-12">
							<label for="u_name" class="col-md-2">* 用户名</label>
							<span class="col-md-5">
								<input type="text" id="u_name" name="u_name" class="form-control" placeholder="用户名" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="u_email" class="col-md-2">* E-mail</label>
							<span class="col-md-5">
								<input type="text" id="u_email" name="u_email" class="form-control" placeholder="E-mail" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="u_mobile" class="col-md-2">* 手机号码</label>
							<span class="col-md-5">
								<input type="text" id="u_mobile" name="u_mobile" class="form-control" placeholder="手机号码" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="u_sex" class="col-md-2">* 性别</label>
							<span class="col-md-5">
								<select id="u_sex" name="u_sex" class="form-control"
									data-container="body" data-toggle="popover" data-placement="right" data-content="">
									<option value="M">男</option>
									<option value="F">女</option>
								</select>
							</span>
						</div>
						<div class="col-md-12">
							<label for="u_deptid" class="col-md-2">* 院校专业</label>
							<span id="u_deptid"></span>
							<button type="button" id="u_dept_edit" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#dept-dialog">更改</button>
						</div>
						<div class="col-md-12">
							<label for="u_age" class="col-md-2">年龄</label>
							<span class="col-md-5">
								<input type="number" min="18" id="u_age" name="u_age" class="form-control" placeholder="年龄" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="u_hometown" class="col-md-2">家乡</label>
							<span class="col-md-5">
								<input type="text" id="u_hometown" name="u_hometown" class="form-control" placeholder="家乡" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>	
						<div class="col-md-12">
							<label class="col-md-2"></label>
							<span class="col-md-5">
								<button id="save" type="button" class="btn btn-success">保存</button>
							</span>
						</div>			
					</form>
				</section>
			</section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
