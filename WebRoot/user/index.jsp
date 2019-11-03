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
		
        <title>未完成订单 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        <script src="js/index.js" type="text/javascript"></script>	
        <style type="text/css">
        	.dialog-msg {
        		font-weight: bold;
        		text-align: center;
        	}
        	
        	#sureCancel {
        		color: white;
        	}
        </style>
        <script type="text/javascript">  
	        //金额格式化
	    	function priceformat(price) {
	    		return parseFloat(price).toFixed(2);
	    	}
	        
	        function commentLoad(obj) {
	        	var id = $(obj).attr("data-id");
       			$("#comment-form").attr("action", "../Order.do?act=cuscomment&orderid=" + id);
	        }
	        
	        function acceptLoad(obj) {
	        	var id = $(obj).attr("data-id");
       			$("#sureAccept").attr("href", "../Order.do?act=acceptorder&orderid=" + id);
	        }
	        
       		function cancelLoad(obj) {
       			var id = $(obj).attr("data-id");
       			$("#sureCancel").attr("href", "../Order.do?act=cancelorder&orderid=" + id);
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
		
    	<div class="modal fade" id="ordcancel-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">取消订单确认</h4>
					</div>
					<div class="modal-body">
						<div class="dialog-msg">是否确认取消订单？如您已经付款，资金将原路退回</div>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">我再想想</button>
        				<a id="sureCancel" class="btn btn-danger">取消订单</a>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal --> 
		
    	<div class="modal fade" id="ordaccept-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">确认收货</h4>
					</div>
					<div class="modal-body">
						<div class="dialog-msg">是否已收到图书？确认后，如有线上款项，系统将转账至卖方账户</div>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<a id="sureAccept" class="btn btn-info">我已收到图书</a>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal --> 
		
    	<div class="modal fade" id="ordcomment-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">订单评价</h4>
					</div>
					<div class="modal-body">
						<form id="comment-form" method="post">
							<label class="comment-label">评价：</label>
							<label>
								<input type="radio" name="comtype" id="good" value="G" checked />
								<img src="../images/good.png" />
							</label>
							<label>
								<input type="radio" name="comtype" id="worse" value="B" />
								<img src="../images/bad.png" />
							</label>
							<label for="comment" class="comment-label">评价内容：</label>
							<textarea id="comment" name="comment" class="form-control" placeholder="本次交易是否满意？"
								data-container="body" data-toggle="popover" data-placement="right" data-content=""></textarea>
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="cusComment" class="btn btn-info">提交评价</button>
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
	                <h5>未完成订单</h5>
	            </header>
				
				<section id="order-tabs">
					<ul id="ordTab" class="nav nav-tabs" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" href="#beforepay" id="home-tab" role="tab" data-toggle="tab" aria-controls="beforepay" aria-expanded="true">
								待付款<span id="data1" class="label label-default label-pill pull-right">-</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#beforesign" role="tab" id="profile-tab" data-toggle="tab" aria-controls="beforesign" aria-expanded="false">
								待收货<span id="data2" class="label label-default label-pill pull-right">-</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#beforecom" role="tab" id="profile-tab" data-toggle="tab" aria-controls="beforecom" aria-expanded="false">
								待评价<span id="data3" class="label label-default label-pill pull-right">-</span>
							</a>
						</li>
					</ul>
					
					<div id="ordTabContent" class="tab-content">
						<div role="tabpanel" class="tab-pane fade active in" id="beforepay" aria-labelledby="beforepay-tab" aria-expanded="true">
							<h4 class="ordTab-msg">订单信息加载中，请稍候...</h4>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="beforesign" aria-labelledby="beforesign-tab" aria-expanded="false">
							<h4 class="ordTab-msg">订单信息加载中，请稍候...</h4>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="beforecom" aria-labelledby="beforecom-tab" aria-expanded="false">
							<h4 class="ordTab-msg">订单信息加载中，请稍候...</h4>
						</div>
					</div>
				</section>
			</section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
