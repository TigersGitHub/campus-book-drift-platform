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
		
        <title>地址详细信息 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/adredit.js"></script>
    </head>
    
    <body>	
    	<div class="modal fade" id="org-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">行政区划变更</h4>
					</div>
					<div class="modal-body">
						<label for="org1" class="sr-only">请选择省/自治区/直辖市</label>
	                    <select id="org1" name="org1" class="form-control"
	                            data-toggle="popover" data-placement="right" data-content="">
	                        <option value="0" selected>* 请选择</option>
	                        
	                    </select>
	                    <label for="org2" class="sr-only">请选择市/自治州</label>
	                    <select id="org2" name="org2" class="form-control"
	                            data-toggle="popover" data-placement="right" data-content="">
	                        <option value="0" selected>* 请选择</option>
	                        
	                    </select>
	                    <label for="org3" class="sr-only">请选择区/县/自治县</label>
	                    <select id="org3" name="org3" class="form-control" data-container="body"
	                            data-toggle="popover" data-placement="right" data-content="">
	                        <option value="0" selected>* 请选择</option>
	                        
	                    </select>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="saveOrg" type="button" class="btn btn-success">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal --> 

		<div class="card">
			<div class="card-block">
				<form id="form-emp-edit" action="../../UserCommon.do?act=edit&tab=adr" method="post">
					<legend>地址详细信息</legend>
					<span class="pull-right">
						<a href="useradr.jsp" class="btn btn-secondary">返回</a>
						<button type="button" id="form-edit-submit" class="btn btn-success">保存</button>
					</span>
					<hr />
					<div class="form-group row">
						<label for="adrid" class="col-sm-2 form-control-label">地址编号</label>
						<div class="col-sm-10">
							<span id="adrid">无</span>
							<input type="hidden" name="adrid" id="adrid-hidden" />
						</div>
					</div>
					<div class="form-group row">
						<label for="uid" class="col-sm-2 form-control-label">所属用户账号</label>
						<div class="col-sm-10">
							<span id="uid">无</span>
						</div>
					</div>
					<div class="form-group row">
						<label for="uname" class="col-sm-2 form-control-label">收货人姓名 *</label>
						<div class="col-sm-10">
							<input type="text" id="uname" name="uname" class="form-control" placeholder="* 请填写收货人姓名" 
                    			data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="tel" class="col-sm-2 form-control-label">联系电话 *</label>
						<div class="col-sm-10">
							<input type="text" id="tel" name="tel" class="form-control" placeholder="* 请填写联系电话" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="adr" class="col-sm-2 form-control-label">收货地址 *</label>
						<div class="col-sm-10">
							<span id="org">无</span>
							<button type="button" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#org-dialog">修改</button>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 form-control-label"></label>
						<div class="col-sm-10">
							<input type="text" id="adr" name="adr" class="form-control" placeholder="* 请填写详细地址" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="zipcode" class="col-sm-2 form-control-label">邮政编码</label>
						<div class="col-sm-10">
							<input type="text" id="zipcode" name="zipcode" class="form-control" placeholder="邮政编码" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
						</div>
					</div>
					<div class="form-group row">
						<label for="note" class="col-sm-2 form-control-label">备注</label>
						<div class="col-sm-10">
							<textarea id="note" name="note" class="form-control" placeholder="备注"></textarea>
						</div>
					</div>
				</form>			
			
			</div><!-- card-block -->
		</div><!-- card -->
		
    </body>
</html>
