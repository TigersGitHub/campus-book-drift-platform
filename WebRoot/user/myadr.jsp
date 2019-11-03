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
		
        <title>地址管理 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        <script src="js/myadr.js" type="text/javascript"></script>
        <script type="text/javascript">
        	//编辑加载
        	function editload(obj) {
        		var id = $(obj).attr("data-id");
        		$("#adrid").val(id);
        		$.ajax({
        			url: "../UserCenter.do",
        			data: "act=adrdetail&adrid=" + id,
        			type: "POST",
        			success: function (rel) {
        				var data = eval(rel);
        				$("#uname_edit").val(data[0].ADR_UNAME);
        				$("#uphone_edit").val(data[0].ADR_PHONE);
        				$("#prov_edit").val(0);
        				$("#city_edit").val(0);
        				$("#dist_edit").val(0);
        				$("#address_edit").val(data[0].ADR_ADDRESS);
        				$("#zipcode_edit").val(data[0].ADR_ZIPCODE);
        			}
        		});
        	}
        
	      	//删除框加载
	        function delload(obj) {
	    		var id = $(obj).attr("data-id");
	        	$("#del-adr").attr("href", "../UserCenter.do?act=deladr&adrid=" + id);
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
						<h4 class="modal-title">添加地址</h4>
					</div>
					<div class="modal-body">
						<form id="form_add" class="form-inline" action="<%=path %>/UserCenter.do?act=addadr" method="post">
							<label for="uname">　收货人</label>
							<input id="uname" name="uname" type="text" class="form-control" placeholder="* 收货人" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="uphone">手机号码</label>
							<input id="uphone" name="uphone" type="text" class="form-control" placeholder="* 联系电话" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="prov">　　省份</label>
							<select id="prov" name="prov" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="city">　　城市</label>
							<select id="city" name="city" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="dist">　　区县</label>
							<select id="dist" name="dist" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="address">详细地址</label>
							<input id="address" name="address" type="text" class="form-control" placeholder="* 详细地址" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
                    		<label for="zipcode">邮政编码</label>
							<input id="zipcode" name="zipcode" type="text" class="form-control" placeholder="邮政编码" />
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
						<h4 class="modal-title">编辑地址</h4>
					</div>
					<div class="modal-body">
						<form id="form_edit" class="form-inline" action="<%=path %>/UserCenter.do?act=adredit" method="post">
							<input type="hidden" id="adrid" name="adrid" />
							<label for="uname_edit">　收货人</label>
							<input id="uname_edit" name="uname_edit" type="text" class="form-control" placeholder="* 收货人" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="uphone_edit">手机号码</label>
							<input id="uphone_edit" name="uphone_edit" type="text" class="form-control" placeholder="* 联系电话" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="prov_edit">　　省份</label>
							<select id="prov_edit" name="prov_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="city_edit">　　城市</label>
							<select id="city_edit" name="city_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="dist_edit">　　区县</label>
							<select id="dist_edit" name="dist_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="address_edit">详细地址</label>
							<input id="address_edit" name="address_edit" type="text" class="form-control" placeholder="* 详细地址" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
                    		<label for="zipcode_edit">邮政编码</label>
							<input id="zipcode_edit" name="zipcode_edit" type="text" class="form-control" placeholder="邮政编码" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="saveedit" type="button" class="btn btn-success">保存</button>
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
						<h4 class="modal-title">删除地址</h4>
					</div>
					<div class="modal-body">
						<div style="text-align:center;">
							<div>是否确认删除选定地址？</div>
						</div>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<a id="del-adr" class="btn btn-danger">删除</a>
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
	                <h5>地址管理</h5>
	            </header>
	            
	            <section id="filter-tool">
	            	<button id="btn-add" type="button" class="btn btn-success" data-toggle='modal' data-target='#add-dialog'>+&nbsp;添加地址</button>
	            	<a class="btn btn-outline-secondary disabled" style="border: none;">
	            		当前已添加<span id="adrcount"></span>/10个地址
            		</a>
				</section>
				
				<section id="myadr-list">					
					
				</section>
			</section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
