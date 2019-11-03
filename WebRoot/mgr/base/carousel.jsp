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
		
        <title>轮播广告管理 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/carousel.js"></script>
        <script type="text/javascript">
	        function delload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$("#del-dialog-cslid").text(id);
	    		$("#sure-delete").click(function () {
	    			$.ajax({
	    				url: "../../Carousel.do",
	    				type: "post",
	    				data: "act=del&cslid=" + id,
	    				success: function (rel) {
	    					if (rel == "success") {
	    						alert("删除成功！");
	    						window.location.href = "carousel.jsp";
	    					} else {
	    						alert("删除失败");
	    						window.location.reload();
	    					}
	    				}
	    			});
	    		});
	    	}
	        	    
	    	function editload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$.ajax({
		    		url: "../../Carousel.do",
		    		type: "post",
		    		data: "act=detail&cslid=" + id,
		    		success: function (rel) {
		    			var data = eval(rel);
		    			$("#cslid-edit").val(data[0].CSL_ID);
		    			$("#cslid-hidden-edit").val(data[0].CSL_ID);
		    			$("#csltype-edit").val(data[0].CSL_TYPE);
		    			$("#cslsrc-edit").val(data[0].CSL_SRC);
		    			var target = data[0].CSL_TARGET + "";
		    			if (target != "null" && target != "") {
		    				$("#csltarget-edit").val(data[0].CSL_TARGET);
		    			} else {
		    				$("#csltarget-edit").val("");
		    			}
		    			var note = data[0].CSL_NOTE + "";
		    			if (note != "null" && note != "") {
		    				$("#cslnote-edit").val(data[0].CSL_NOTE);
		    			} else {
		    				$("#cslnote-edit").val("");
		    			}
		    		}
		    	});
	    	}
        </script>
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
						<h4 class="modal-title">添加轮播</h4>
					</div>
					<div class="modal-body">
						<form id="form-add" class="form-inline" action="<%=path %>/Carousel.do?act=add" method="post">
							<label for="cslid">　　序号</label>
							<input id="cslid" name="cslid" type="text" class="form-control" placeholder="序号" readonly />
							<label for="csltype">　　类别</label>
							<select id="csltype" name="csltype" class="form-control form-inline-dropdown">	
				       			<option value="B">个人图书</option>
				       			<option value="R">推荐图书</option>
				       			<option value="T">分类活动</option>
				       			<option value="N">非广告</option>
							</select>
							<label for="cslsrc">图片路径</label>
							<input id="cslsrc" name="cslsrc" type="text" class="form-control" placeholder="图片路径" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="csltarget">链接指向</label>
							<input id="csltarget" name="csltarget" type="text" class="form-control" placeholder="链接指向" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="cslnote">　　备注</label>
							<input id="cslnote" name="cslnote" type="text" class="form-control" placeholder="备注" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="save" type="button" class="btn btn-success">保存</button>
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
						<h4 class="modal-title">编辑轮播</h4>
					</div>
					<div class="modal-body">
						<form id="form-edit" class="form-inline" action="<%=path %>/Carousel.do?act=edit" method="post">
							<label for="cslid-edit">　　序号</label>
							<input id="cslid-edit" name="cslid-edit" type="text" class="form-control" placeholder="序号" disabled />
							<input type="hidden" name="cslid" id="cslid-hidden-edit" />
							<label for="csltype-edit">　　类别</label>
							<select id="csltype-edit" name="csltype-edit" class="form-control form-inline-dropdown">	
				       			<option value="B">个人图书</option>
				       			<option value="R">推荐图书</option>
				       			<option value="T">分类活动</option>
				       			<option value="N">非广告</option>
							</select>
							<label for="cslsrc-edit">图片路径</label>
							<input id="cslsrc-edit" name="cslsrc-edit" type="text" class="form-control" placeholder="图片路径" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="csltarget-edit">链接指向</label>
							<input id="csltarget-edit" name="csltarget-edit" type="text" class="form-control" placeholder="链接指向" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="cslnote-edit">　　备注</label>
							<input id="cslnote-edit" name="cslnote-edit" type="text" class="form-control" placeholder="备注" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="form-edit-submit" type="button" class="btn btn-success">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    
    	<div class="modal fade" id="del-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">确认删除</h4>
					</div>
					<div class="modal-body"><p><b>是否确认删除序号为<span id="del-dialog-cslid"></span>的轮播？删除后不可恢复</b></p></div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="sure-delete" type="button" class="btn btn-danger">删除</button>
					</div>
				</div>
			</div>
		</div>
    
    	<div class="card list-tool">
			<div class="card-block">
				<button class="btn btn-success" data-toggle="modal" data-target="#add-dialog">+&nbsp;添加轮播</button>
				<button class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				<form class="form-inline pull-right">
					<select id="stype" name="stype" class="form-control">
		       			<option value="0">全部分类</option>
		       			<option value="B">个人图书</option>
		       			<option value="R">推荐图书</option>
		       			<option value="T">分类活动</option>
		       			<option value="N">非广告</option>
					</select>	
		    		<button type="button" id="search" class="btn btn-primary" type="button">按类别查询</button>			    	
				</form>
			</div>
		</div>
    
		<div class="card list-content">
			<div class="card-block">				
				<div class="alert alert-info alert-dismissible fade in" role="alert">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<strong>注意！</strong>轮播广告总数最大为8条！<strong>个人图书、推荐图书、分类活动</strong>链接指向请填写<strong>页面URL</strong>，<strong>非广告</strong>链接指向留空
				</div>
			
				<table class="table table-hover table-striped overhid">
					<thead class="thead-default">
						<tr>
							<th width="8%">序号</th>
							<th width="12%">类别</th>
							<th width="24%">图片路径</th>
							<th width="24%">链接指向</th>
							<th width="16%">备注</th>
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