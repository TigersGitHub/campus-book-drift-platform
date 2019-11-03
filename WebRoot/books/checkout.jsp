<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String online = (String)request.getSession().getAttribute("online");
	String path = request.getContextPath(); 
	String orderid = request.getParameter("orderid");
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
		
        <title>收银台 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	#order-price {
        		color: red;
        	}
        	
        	.payment {
        		margin-right: 36px;
        	}
        	
        	#payment-list,
        	#checkout-submit {
        		margin: 36px auto 18px auto !important;
        	}
        	
        	#checkout-submit {
        		display: block;
        		margin: 0 auto;
        	}
        	
        	#checkout-msg {
        		padding: 12px 8px 0 8px;
        		text-align: center;
        	}
        </style>
        <script type="text/javascript">    
        	$(function () {
        		//价格格式化
    	    	function priceformat(price) {
    	    		return parseFloat(price).toFixed(2);
    	    	}
            
            	var orderid = '<%=orderid %>';
            	$.ajax({
            		url: "../Order.do",
            		data: "act=beforecheckout&orderid=" + orderid,
            		type: "post",
            		success: function (rel) {
            			var data = eval(rel);
            			$("#order-id").text(data[0].ORD_ID);
            			$("#order-bookname").text(data[0].ORD_BOOKNAME);
            			$("#order-price").text("¥" + priceformat(data[0].ORD_PRICE));
            		}
            	});
            	
            	//确认支付更改订单状态
            	$("#checkout-done").click(function () {
            		$.ajax({
                		url: "../Order.do",
                		data: "act=checkout&orderid=" + orderid,
                		type: "post",
                		success: function (rel) {
                			if (rel == "DONE") {
                				window.location.href = "success.jsp";
                			} else {
                				alert("错误：" + rel);
                			}
                		}
                	});
            	});
            	
        	});	        
        </script>	
    </head>

    <body>    
    	<div class="modal fade" id="checkout-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">支付完成？</h4>
					</div>
					<div class="modal-body">
						<h5 id="checkout-msg">请在新打开的页面中完成支付并在此处确认</h5>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">支付遇到问题</button>
        				<button id="checkout-done" class="btn btn-success">我已完成支付</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    
		<%@ include file="/common/header.jsp" %>

		<div class="container" id="container-index">			
			<section class="floors">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>收银台</h5>
	            </header> 
				
				<section>
					<div class="card card-block">
						<div class="col-md-3">
							<label>订单编号：</label>
							<h4 id="order-id"></h4>
						</div>
						<div class="col-md-6">
							<label>图书名称：</label>
							<h4 id="order-bookname"></h4>
						</div>
						<div class="col-md-3">
							<label>订单金额：</label>
							<h4 id="order-price"></h4>
						</div>

						<div id="payment-list" class="col-md-12">
							<label>支付方式：</label>
							<br />
							<label class="payment">
								<input type="radio" name="payment" checked />
								<img src="../images/alipay.jpg" />
							</label>
							<label class="payment">
								<input type="radio" name="payment" />
								<img src="../images/wechat.jpg" />
							</label>
							<label class="payment">
								<input type="radio" name="payment" />
								<img src="../images/jdwallet.jpg" />
							</label>
						</div>

						<button type="button" class="btn btn-danger btn-lg" id="checkout-submit" data-toggle="modal" data-target="#checkout-dialog">去支付</button>
					</div>
				</section>
			</section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
