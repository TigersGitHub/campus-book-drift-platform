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
		
        <title>订单提交成功 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	.card {
        		padding: 80px 0;
        	}
        	
        	#order-msg,
        	#order-jump {
        		text-align: center;
				margin: 24px 0;    
        	}
        	
        	#order-msg img {
        		width: 120px;
        	}
        	
        	#order-msg h2 {
        		margin: 0 24px;
        		display: inline-block;
        	}
        </style>
    </head>

    <body>    
		<%@ include file="/common/header.jsp" %>

		<div class="container" id="container-index">			
			<section class="floors">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>订单提交成功</h5>
	            </header>
				
				<section>
					<div class="card card-block">
						<div id="order-msg">
							<img src="../images/air.png" />
							<h2>下单成功！您订购的图书正整装待发~</h2>
						</div>
						<div id="order-jump">
							<a href="../user" class="btn btn-primary btn-lg">查看我的订单</a>
						</div>
					</div>
				</section>
			</section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
