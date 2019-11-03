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
		
        <title>意见建议管理 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <link href="css/article.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/advice.js"></script>
        <script type="text/javascript">
	    	function editload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$.ajax({
	    			url: "../../Article.do",
	    			data: "act=editload&tab=advice&advid=" + id,
	    			type: "post",
	    			success: function (rel) {
	    				var data = eval(rel);
	    				$("#article-id").val(id);
	    				$("#article-title-edit").val(data[0].ADV_TITLE);
	    				$("#article-content-edit").text(data[0].ADV_CONTENT);
	    				$("#author").val(data[0].ADV_AUTHOR);
	    				$("#datetimebox-edit").val(data[0].ADV_ADDTIME);
	    			}
	    		});
	    	}
	    	
	    	function dispload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$.ajax({
	    			url: "../../Article.do",
	    			data: "act=dispadvice&advid=" + id,
	    			type: "post",
	    			success: function (rel) {
	    				var data = eval(rel);
	    				$("#article-title-disp").val(data[0].ADV_TITLE);
	    				$("#article-content-disp").text(data[0].ADV_CONTENT);
	    				$("#author-disp").val(data[0].ADV_AUTHOR);
	    				$("#datetimebox-disp").val(data[0].ADV_ADDTIME);
	    				$("#article-reply-disp").val(data[0].ADV_REPLY);
	    				$("#reauthor-disp").val(data[0].ADV_REAUTHOR);
	    				$("#datetimebox-reply-disp").val(data[0].ADV_RETIME);
	    			}
	    		});
	    	}
        </script>
    </head>
    
    <body>
    	<div class="modal fade" id="disp-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">建议及审阅查看</h4>
					</div>
					<div class="modal-body">						
						<input id="article-title-disp" type="text" placeholder="建议标题" class="article-advice" readonly="readonly" />
                   		<textarea id="article-content-disp" class="article-reply article-advice" placeholder="建议内容" readonly="readonly"></textarea>
						<span id="form-author-edit" class="form-inline" style="margin-left: 18px;">
							作者：<input id="author-disp" placeholder="建议用户" class="article-advice" readonly="readonly" />
							<span class="pull-right">
								时间：<input id="datetimebox-disp" placeholder="建议时间" class="article-advice" readonly="readonly" />
							</span>
						</span>
					</div>
					<div class="modal-footer modal-footer-sm">
						<form>
							<textarea id="article-reply-disp" name="article-reply" class="article-reply article-advice" readonly="readonly" placeholder="回复内容"></textarea>
                   			<input style="width: 100%;" id="article-note-disp" name="article-note-edit" type="text" readonly="readonly" class="article-advice" placeholder="备注" />
							<span id="form-author-edit" class="form-inline">
								审阅人：<input id="reauthor-disp" placeholder="审阅人" class="article-advice" readonly="readonly" />
								<span class="pull-right">审阅时间：
									<input type="text" class="article-advice" readonly="readonly" id="datetimebox-reply-disp" placeholder="审阅时间" />
								</span>
							</span>
						</form>
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
						<h4 class="modal-title">建议审阅</h4>
					</div>
					<div class="modal-body">						
						<input id="article-title-edit" type="text" placeholder="建议标题" class="article-advice" readonly="readonly" />
                   		<textarea id="article-content-edit" class="article-reply article-advice" placeholder="建议内容" readonly="readonly"></textarea>
						<span id="form-author-edit" class="form-inline">
							作者：<input id="author" placeholder="建议用户" class="article-advice" readonly="readonly" />
							<span class="pull-right">
								时间：<input id="datetimebox-edit" placeholder="建议时间" class="article-advice" readonly="readonly" />
							</span>
						</span>
					</div>
					<div class="modal-footer modal-footer-sm">
						<form id="form-editarticle" action="<%=path %>/Article.do?act=edit&tab=advice" method="post">
							<input type="hidden" id="article-id" name="article-id" />
							<textarea id="article-reply" name="article-reply" class="form-control article-reply" placeholder="请输入回复内容" 
	                    			data-container="body" data-toggle="popover" data-placement="right" data-content=""></textarea>
                   			<span id="form-author-edit" class="form-inline">
								<label for="article-note-edit">备注：<input id="article-note-edit" name="article-note-edit" type="text" class="form-control" placeholder="备注" /></label>
								<label class="pull-right">审阅时间：<input type="text" 
									class="form-control" readonly="readonly" id="datetimebox" placeholder="审阅时间" /></label>
							</span>
						</form>
						<br />
        				<button id="edit-savearticle" type="button" class="btn btn-success">&nbsp;&nbsp;保存&nbsp;&nbsp;</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<!-- 页面内容 -->
		<div class="card list-tool">
			<div class="card-block">
				<button class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				<form class="form-inline pull-right">
					<select class="form-control" id="stype">
						<option value="0">全部</option>
						<option value="1">未处理</option>
						<option value="2">已处理</option>
					</select>
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
							<th width="12%">作者</th>
							<th width="14%">时间</th>
							<th width="14%">审阅</th>
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
