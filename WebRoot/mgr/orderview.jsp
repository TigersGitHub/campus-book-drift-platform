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
		
        <title>订单信息查询 - 书角 SHUJIAO</title>
        <link href="css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	.ordTab-msg {
				text-align: center;
				padding: 150px 0;
				margin: 0;
			}
			
			.list-content {
				padding-bottom: 16px;
			}
			
			#ordview-list {
				padding-bottom: 0;
			}
			
			.order-detail {
				padding: 16px 8px;
				border-top: 2px dashed rgb(222, 222, 222);
				height: 150px;
			}
			
			.order-detail:first-child {
				border-top: none;
				padding-top: 0;
				height: 134px;
			}
			
			.order-btngroup {
				position: relative;
			}
			
			.order-btngroup div {
				position: absolute;
				top: -16px;
				left: -10px;
				width: 100%;
				text-align: center;
			}
			
			#orddetail-dialog h5,
			#ordview-list h5 {
			    font-weight: bold;
			    display: inline;
			}
        </style>
        <script type="text/javascript" src="js/ordview.js"></script>
        <script type="text/javascript">	        
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
	   		        		$("#order-cuscom").text(((data[0].ORD_CUSCOM != "F")?"已评价":"未评价"));
	   		        		$("#order-selcom").text(((data[0].ORD_SELCOM != "F")?"已评价":"未评价"));
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
		
		<div class="card list-tool">
			<div class="card-block">
				<form class="form-inline">
					<select id="sissell" name="sissell" class="form-control">
						<option value="0">上架类型</option>
						<option value="Y">二手交易</option>
						<option value="N">图书漂流</option>
					</select>
					<select id="sstatus" name="sstatus" class="form-control">
						<option value="0">订单状态</option>
						<option value="1">待付款</option>
						<option value="2">待发货</option>
						<option value="3">待收货</option>
						<option value="4">待评价</option>
						<option value="5">已完成</option>
						<option value="6">已关闭</option>
					</select>
					<input type="text" id="sordid" name="sordid" class="form-control view-searchbox" placeholder="订单编号" />
					<input type="date" id="sstarttime" name="sstarttime" class="form-control view-searchbox" /> ~
					<input type="date" id="sendtime" name="sendtime" class="form-control view-searchbox" />
					<span class="pull-right">
						<button type="button" id="search" class="btn btn-primary">搜索</button>
						<button type="reset" class="btn btn-secondary">重置</button>
					</span>
				</form>		
			</div>
		</div>
		
		<div class="card list-content">
			<div class="card-block" id="ordview-list">
				<h4 class="ordTab-msg">订单信息加载中，请稍候...</h4>
			</div>
		
			<div class="page-control">
				<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
				<span class="pagenum" id="curr-page"></span>
				<span class="pagenum">/</span>
				<span class="pagenum" id="total-page"></span>
				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
			</div>
		</div>
    </body>
</html>
