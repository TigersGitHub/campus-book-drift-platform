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
		
        <title>合作厂商字典 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/corp.js"></script>
        <script type="text/javascript">
        	var delby = ""; 
        
        	function delload(obj) {
        		delby = $(obj).attr("data-id");
        	}
        	
        	function del() {
        		$.ajax({
	    			url: "../../DctCommon.do",
	    			data: "act=del&dct=corp&aimid=" + delby,
	    			type: "post",
	    			success: function (rel) {
	    				if (rel == "success") {
	    					window.location.reload();
	    				} else {
	    					alert("删除失败");
	    					window.location.reload();
	    				}
	    			}
    			});
        	}
        
	        function editload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$.ajax({
	    			url: "../../DctCommon.do",
	    			data: "act=editload&dct=corp&corpid=" + id,
	    			type: "post",
	    			success: function (rel) {
	    				var data = eval(rel);
	    				$("#ecorpid").val(data[0].CORP_ID);
	    				$("#ecorpname").val(data[0].CORP_NAME);
	    				$("#eshortname").val(data[0].CORP_SHORTNAME);
	    				$("#elinkman").val(data[0].CORP_LINKMAN);
	    				$("#etel").val(data[0].CORP_TEL);
	    				$("#eaddress").val(data[0].CORP_ADDRESS);
	    				$("#enote").val(data[0].CORP_NOTE);
	    			}
	    		});
        	}        
        </script>
    </head>
    
    <body>
    	<div class="modal fade" id="del-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">删除合作厂商</h4>
					</div>
					<div class="modal-body">
						<div style="text-align:center;">
							<div>是否确认删除选定的合作商？<br /><b>删除后不可恢复</b></div>
						</div>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="delcorp" class="btn btn-danger" onclick="del()">删除</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
       	<div class="modal fade" id="edit-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">编辑合作厂商</h4>
					</div>
					<div class="modal-body">
						<form id="form-dctedit" class="form-inline" action="../../DctCommon.do?act=edit&dct=corp" method="post">
							<input type="hidden" id="ecorpid" name="ecorpid" />
							<label for="ecorpname">厂商名称</label>
							<input id="ecorpname" name="ecorpname" type="text" class="form-control" placeholder="厂商名称"
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="eshortname">厂商简称</label>
							<input id="eshortname" name="eshortname" type="text" class="form-control" placeholder="厂商简称" 
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="elinkman">　联系人</label>
							<input id="elinkman" name="elinkman" type="text" class="form-control" placeholder="联系人"
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="etel">联系电话</label>
							<input id="etel" name="etel" type="text" class="form-control" placeholder="联系电话" 
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="eaddress">通讯地址</label>
							<input id="eaddress" name="eaddress" type="text" class="form-control" placeholder="通讯地址" 
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="enote">　　备注</label>
							<input id="enote" name="enote" type="text" class="form-control" placeholder="备注" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="update" type="button" class="btn btn-success" 
        				data-container="body" data-toggle="popover" data-placement="right" data-content="">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    
    	<div class="modal fade" id="add-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">新增合作厂商</h4>
					</div>
					<div class="modal-body">
						<form id="form-dctadd" class="form-inline" action="../../DctCommon.do?act=add&dct=corp" method="post">
							<label for="corpname">厂商名称</label>
							<input id="corpname" name="corpname" type="text" class="form-control" placeholder="厂商名称"
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="shortname">厂商简称</label>
							<input id="shortname" name="shortname" type="text" class="form-control" placeholder="厂商简称" 
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="linkman">　联系人</label>
							<input id="linkman" name="linkman" type="text" class="form-control" placeholder="联系人"
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="tel">联系电话</label>
							<input id="tel" name="tel" type="text" class="form-control" placeholder="联系电话" 
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="address">通讯地址</label>
							<input id="address" name="address" type="text" class="form-control" placeholder="通讯地址" 
								data-container="body" data-toggle="popover" data-placement="top" />
							<label for="note">　　备注</label>
							<input id="note" name="note" type="text" class="form-control" placeholder="备注" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="save" type="button" class="btn btn-success" 
        				data-container="body" data-toggle="popover" data-placement="right" data-content="">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    	
		<div class="card list-tool">
			<div class="card-block">
				<button class="btn btn-success" data-toggle="modal" data-target="#add-dialog">+&nbsp;新增厂商</button>
				<button class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				
				<span class="form-inline pull-right">
                	<input type="text" id="key" class="form-control" placeholder="输入节点名称..." />
                	<button type="button" id="search" class="btn btn-primary" type="button">搜索</button>
                </span>
			</div>
		</div>
    
		<div class="card dct-editor list-content">
			<div class="card-block">
				<table class="table table-hover table-striped overhid">
					<thead class="thead-default">
						<tr>
							<th width="12%">编号</th>
							<th width="30%">名称</th>
							<th width="12%">简称</th>
							<th width="12%">联系人</th>
							<th width="18%">联系电话</th>
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