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
		
        <title>行政区划字典 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/org.js"></script>
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
						<h4 class="modal-title">新增节点</h4>
					</div>
					<div class="modal-body">
						<form id="form-dctadd" class="form-inline" action="../../DctCommon.do?act=add&dct=org" method="post">
							<label for="level">节点级别</label>
							<select id="level" name="level" class="form-control" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
                    			<option value="0">请选择节点级别</option>
                    			<option value="a">省/自治区/直辖市</option>
                    			<option value="b">市/自治州</option>
                    			<option value="c">区/县/自治县</option>
                    		</select>
							<label for="parent">　父节点</label>
							<select id="parent" name="parent" class="form-control" disabled 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
                    			<option value="-1">请先选择节点级别</option>
                    		</select>
							<label for="orgid">节点编号</label>
							<input id="orgid" name="orgid" type="text" class="form-control" placeholder="节点编号" readonly="readonly" />
							<label for="orgname">节点名称</label>
							<input id="orgname" name="orgname" type="text" class="form-control" placeholder="节点名称" readonly="readonly" />
							<label for="note">　　备注</label>
							<input id="note" name="note" type="text" class="form-control" placeholder="备注" readonly="readonly" />
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
				<button class="btn btn-success" data-toggle="modal" data-target="#add-dialog">+&nbsp;新增节点</button>
				<button class="btn btn-warning" id="dct-uppon" disabled>↑&nbsp;向上一级</button>
				<form class="form-inline pull-right">							
					<select id="sparent" name="sparent" class="form-control" 
						data-container="body" data-toggle="popover" data-placement="top" data-content="">
						<option value="0">中华人民共和国</option>
					</select>			
					<select id="slevel" name="slevel" class="form-control" 
                   		data-container="body" data-toggle="popover" data-placement="top" data-content="">
                   		<option value="a">省/自治区/直辖市</option>
                  		<option value="b">市/自治州</option>
                 		<option value="c">区/县/自治县</option>
               		</select>	
		    		<button type="button" id="search" class="btn btn-primary" type="button">按节点级别查询</button>			    	
                </form>
			</div>
		</div>
    
		<div class="card dct-editor list-content">
			<div class="card-block">
				<ol class="breadcrumb">
				
				</ol>
			
				<table class="table table-hover table-striped overhid">
					<thead class="thead-default">
						<tr>
							<th width="12%">编号</th>
							<th width="20%">名称</th>
							<th>备注</th>
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