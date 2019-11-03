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
		
        <title>节点编辑 - 图书规格字典 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/formatedit.js"></script>
    </head>
    
    <body>		
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
					<div class="modal-body"><p><b>是否确认删除节点？确认删除后不可恢复</b></p></div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="sure-delete" type="button" class="btn btn-danger">删除</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    
		<div class="card">
			<div class="card-block">
				<form id="form-emp-edit" action="../../DctCommon.do?act=edit&dct=format" method="post">
					<legend>节点编辑 - 图书规格字典</legend>
					<span class="pull-right">
						<a href="format.jsp" class="btn btn-secondary">返回</a>	
						<button type="button" id="form-edit-delete" class="btn btn-danger" data-toggle="modal" 
							data-target="#del-dialog">删除</button>
						<button type="button" id="form-edit-submit" class="btn btn-success">保存</button>
					</span>
					<hr />
					<div class="form-group row">
						<label for="fmtid" class="col-sm-2 form-control-label">节点编号</label>
						<div class="col-sm-10">
							<span id="fmtid">无</span>
							<input type="hidden" name="fmtid" id="fmtid-hidden" />
						</div>
					</div>
					<div class="form-group row">
						<label for="fmtname" class="col-sm-2 form-control-label">节点名称</label>
						<div class="col-sm-10">
							<input type="text" id="fmtname" name="fmtname" class="form-control" placeholder="节点名称" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="fmtnote" class="col-sm-2 form-control-label">备注</label>
						<div class="col-sm-10">
							<textarea id="fmtnote" name="fmtnote" class="form-control" placeholder="备注"></textarea>
						</div>
					</div>
					
				</form>
			</div>
		</div>
		
    </body>
</html>
