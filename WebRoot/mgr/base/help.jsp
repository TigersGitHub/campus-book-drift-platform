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
		
        <title>用户帮助管理 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <link href="css/article.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/help.js"></script>
        <script type="text/javascript">
        	function delload(obj) {
        		var id = $(obj).attr("data-id");
        		var title = $(obj).attr("data-title");
        		$("#del-title").text("《" + title + "》");
        		$("#del-article").attr("href", "../../Article.do?act=del&tab=help&helpid=" + id);
        	}
        
	    	function editload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$.ajax({
	    			url: "../../Article.do",
	    			data: "act=editload&tab=help&helpid=" + id,
	    			type: "post",
	    			success: function (rel) {
	    				var data = eval(rel);
	    				$("#article-id").val(id);
	    				$("#article-title-edit").val(data[0].HELP_TITLE);
	    				$("#article-content-edit").text(data[0].HELP_CONTENT);
	    				$("#author-edit").val(data[0].HELP_AUTHOR);
	    				$("#datetimebox-edit").val(data[0].HELP_ADDTIME);
	    				$("#article-note-edit").val(data[0].HELP_NOTE);
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
						<h4 class="modal-title">写帮助</h4>
					</div>
					<div class="modal-body">
						<form id="form-addarticle" action="<%=path %>/Article.do?act=add&tab=help" method="post">						
							<input id="article-title" name="article-title" type="text" class="form-control" placeholder="请输入文章标题" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
                    		<textarea id="article-content" name="article-content" class="form-control" placeholder="请输入文章内容" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content=""></textarea>
							<span id="form-author" class="form-inline">
								<label for="article-note">备注：<input id="article-note" name="article-note" type="text" class="form-control" placeholder="备注" /></label>
								<label for="datetimebox"  class="pull-right">时间：<input type="text" 
									class="form-control" readonly="readonly" id="datetimebox" placeholder="时间" /></label>
							</span>
						</form>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button id="savearticle" type="button" class="btn btn-success">&nbsp;&nbsp;保存&nbsp;&nbsp;</button>
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
						<h4 class="modal-title">编辑帮助</h4>
					</div>
					<div class="modal-body">
						<form id="form-editarticle" action="<%=path %>/Article.do?act=edit&tab=help" method="post">
							<input type="hidden" id="article-id" name="article-id" />
							<input id="article-title-edit" name="article-title-edit" type="text" class="form-control" placeholder="请输入文章标题" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content="" />
                    		<textarea id="article-content-edit" name="article-content-edit" class="form-control" placeholder="请输入文章内容" 
	                    		data-container="body" data-toggle="popover" data-placement="right" data-content=""></textarea>
							<span id="form-author-edit" class="form-inline">
								<label for="article-note-edit">备注：<input id="article-note-edit" name="article-note-edit" type="text" class="form-control" placeholder="备注" /></label>
								<label class="pull-right">创建时间：<input type="text" 
									class="form-control" readonly="readonly" id="datetimebox-edit" placeholder="创建时间" /></label>
							</span>
						</form>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button id="edit-savearticle" type="button" class="btn btn-success">&nbsp;&nbsp;保存&nbsp;&nbsp;</button>
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
						<h4 class="modal-title">删除帮助</h4>
					</div>
					<div class="modal-body">
						<div style="text-align:center;">
							<div>是否确认删除标题为</div>
							<div id="del-title" style="font-weight:bold;"></div>
							<div>的文章？删除后不可恢复</div>
						</div>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<a id="del-article" class="btn btn-danger">删除</a>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
		<!-- 页面内容 -->
		<div class="card list-tool">
			<div class="card-block">
				<button class="btn btn-success" data-toggle="modal" data-target="#add-dialog">+&nbsp;写帮助</button>
				<button class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				<form class="form-inline pull-right">
					<input type="date" class="form-control" id="starttime" />&nbsp;~
					<input type="date" class="form-control" id="endtime" />
                	<input type="text" id="searchbox" class="form-control" placeholder="全部或部分标题..." />
    		    	<button type="button" id="search" class="btn btn-primary" type="button">搜索</button>
			    </form>
			</div>
		</div>
		
		<div class="card list-content">
			<div class="card-block">
				<table class="table table-hover table-striped">
					<thead class="thead-default">
						<tr>
							<th width="20%">编号</th>
							<th width="24%">标题</th>
							<th width="14%">内容</th>
							<th width="12%">作者</th>
							<th width="14%">时间</th>
							<th width="16%" class="col-control">操作</th>
						</tr>
					</thead>
					
					<tbody id="emplist">

					</tbody>
				</table>
				
				<div class="page-control">
					<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
       				<span class="pagenum" id="curr-page"></span>
       				<span class="pagenum">/</span>
       				<span class="pagenum" id="total-page"></span>
       				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
				</div>
			</div>
		</div>
    </body>
</html>
