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
		
        <title>已完成订单 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        <script src="js/myorder.js" type="text/javascript"></script>			
        <script type="text/javascript">   
	        function priceformat(price) {
	    		return parseFloat(price).toFixed(2);
	    	}
	        
       		function detailLoad(obj) {
       			var id = $(obj).attr("data-id");
       			$.ajax({
       				url: "../Order.do",
       		        data: "act=orderdetail&orderid=" + id,
       		        type: "POST",
       		        success: function (rel) {
       		        	var data = eval(rel);
       		        	if (data.length != 0) {
       		        		$("#order-id").text(data[0].ORD_ID);
       		        		$("#book-id").text(data[0].BOOK_ID);
       		        		$("#order-time").text(data[0].ORD_TIME);
       		        		$("#order-seller").text(data[0].ORD_SELLERNAME + "(" + data[0].ORD_SELLER + ")");       		        		
       		        		$("#order-way").text(data[0].ORD_ORDWAY);
       		        		$("#order-expcorp").text(((data[0].ORD_EXPCORP != null)?data[0].ORD_EXPCORP:"无"));
       		        		$("#order-expid").text(((data[0].ORD_EXPID != null)?data[0].ORD_EXPID:"无"));
       		        		$("#order-customer").text(data[0].ORD_NAME);
       		        		$("#order-tel").text(data[0].ORD_TEL);
       		        		$("#order-zipcode").text(((data[0].ORD_ZIPCODE != null)?data[0].ORD_ZIPCODE:"无"));
       		        		$("#order-address").text(data[0].ORD_ADDRESS);
       		        		$("#order-bookinfo").text(data[0].ORD_TITLE);
       		        		$("#order-msg").text(((data[0].ORD_MSG != null)?data[0].ORD_MSG:"无"));
       		        		$("#order-cuscom").text(((data[0].ORD_CUSCOM != "F")?data[0].ORD_CUSCOM:"未评价"));
       		        		$("#order-selcom").text(((data[0].ORD_SELCOM != "F")?data[0].ORD_SELCOM:"未评价"));
       		        	}
       		        }
       			});
       		}        	
        </script>
    </head>

    <body>
    	<div class="modal fade" id="orddetail-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">订单详情</h4>
					</div>
					<div class="modal-body">
						<div class="col-md-6">
							<label>订单编号：</label>
							<h5 id="order-id"></h5>
						</div>
						<div class="col-md-6">
							<label>图书编号：</label>
							<h5 id="book-id"></h5>
						</div>
						
						<div class="col-md-6">
							<label>下单时间：</label>
							<h5 id="order-time"></h5>
						</div>																				
						<div class="col-md-6">
							<label>卖方帐号：</label>
							<h5 id="order-seller"></h5>
						</div>
						
						<div class="col-md-4">
							<label>交易方式：</label>
							<h5 id="order-way"></h5>
						</div>
						<div class="col-md-4">
							<label>快递公司：</label>
							<h5 id="order-expcorp"></h5>
						</div>
						<div class="col-md-4">
							<label>快递单号：</label>
							<h5 id="order-expid"></h5>
						</div>
						
						<div class="col-md-4">
							<label>　收货人：</label>
							<h5 id="order-customer"></h5>
						</div>
						<div class="col-md-4">
							<label>联系电话：</label>
							<h5 id="order-tel"></h5>
						</div>
						<div class="col-md-4">
							<label>邮政编码：</label>
							<h5 id="order-zipcode"></h5>
						</div>
														
						<div class="col-md-12">
							<label>收货地址：</label>
							<h5 id="order-address"></h5>
						</div>
														
						<div class="col-md-12">
							<label>图书信息：</label>
							<h5 id="order-bookinfo"></h5>
						</div>
														
						<div class="col-md-12">
							<label>买家留言：</label>
							<h5 id="order-msg"></h5>							
						</div>

						<div class="col-md-12">
							<label>买家评价：</label>
							<h5 id="order-cuscom"></h5>				
						</div>
														
						<div class="col-md-12">
							<label>卖家评价：</label>
							<h5 id="order-selcom"></h5>
						</div>
						<div style="clear: both;"></div>
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
	                <h5>已完成订单</h5>
	            </header>
				
				<section id="filter-tool">
		            <form id="search-tool" class="form-inline">
						<label for="sissell">类型&nbsp;</label>
						<select id="sissell" name="sissell" class="form-control">
							<option value="0">全部类型</option>
							<option value="Y">二手交易</option>
							<option value="N">图书漂流</option>
						</select>
						<label for="sname">&nbsp;书名&nbsp;</label>
						<input type="text" id="sname" name="sname" class="form-control text-sm" placeholder="输入中文书名" />
						<label for="sstarttime">&nbsp;时间&nbsp;</label>
						<input type="date" id="sstarttime" name="sstarttime" class="form-control" /> ~
						<input type="date" id="sendtime" name="sendtime" class="form-control" />
						<span class="pull-right">
							<button type="button" id="search" class="btn btn-primary">搜索</button>
							<button type="reset" class="btn btn-secondary">重置</button>
						</span>
					</form>
				</section>
				
				<section id="pastorder-list">	
					
				</section>
				
				<div class="page-control">
					<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
       				<span class="pagenum" id="curr-page"></span>
       				<span class="pagenum">/</span>
       				<span class="pagenum" id="total-page"></span>
       				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
				</div>
			</section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
