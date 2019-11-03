<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String online = (String)request.getSession().getAttribute("online");
	String path = request.getContextPath(); 
	String bookid = request.getParameter("bookid");
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
		
        <title>确认订单 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        
        <style type="text/css">
        	.order-img {
        		padding-left: 0;
        		margin-bottom: 18px;
        	}
        	
        	.order-img img {
        		border: 1px solid rgb(246, 246, 246);
        		padding: 3px;
        		width: 100%;
        	}
        	
        	#ord_way label {
        		margin: 0;
     		}
        </style>
    </head>

    <body>
    	<div class="modal fade" id="adr-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">选择其他地址</h4>
					</div>
					<div class="modal-body">
						<form id="form-adr">
							
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="adr-save" class="btn btn-success">确定</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    
		<%@ include file="/common/header.jsp" %>

		<div class="container" id="container-index">
			<section class="floors" id="book-adrinfo">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>确认收货信息</h5>
	            </header> 
				
				<section>
					<div class="card card-block">
						<p class="card-text">
							<b><span id="adr_uname"></span>&nbsp;</b>
							<b><span id="adr_phone"></span>&nbsp;</b>
							<span id="adr_address"></span>
							<button class="btn btn-primary btn-sm pull-right" data-toggle="modal" data-target="#adr-dialog">选择其他地址</button>
						</p>
					</div>
				</section>
			</section>
			
			<section class="floors" id="book-orderinfo">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>确认订单信息</h5>
	            </header> 
				
				<section>
					<div class="card card-block">
						<div class="col-md-2 order-img">
							<img id="book-image" src="../images/defbook.jpg" />
						</div>
						<div class="col-md-6">
							<label>书名 (Name of Book)：</label>
							<h4 id="book_name_ch">&nbsp;</h4>
							<h4 id="book_name_en">&nbsp;</h4>
							<label>作者 (Author)：</label>
							<h4 id="book_author_ch">&nbsp;</h4>
							<h4 id="book_author_en">&nbsp;</h4>
						</div>
						<div class="col-md-4">
							<label>出版社 (Press)：</label>
							<h4 id="book_press">&nbsp;</h4>
							<label>售价 (Price)：</label>
							<h4 id="book_sellprice">&nbsp;</h4>	
							<label>卖家 (Seller)：</label>
							<h4 id="book_seller">&nbsp;</h4>						
						</div>
						
						<table class="table">
								<tr>
									<td width="12%" scope="row">ISBN</td>
									<td width="21%" id="book_isbn"></td>
									<td width="12%" scope="row">包装</td>
									<td width="21%" id="book_cover"></td>
									<td width="12%" scope="row">版次</td>
									<td width="22%" id="book_version"></td>
								</tr>
								<tr>
									<td scope="row">买家留言</td>
									<td colspan="5">
										<input id="ord_message" type="text" class="form-control" placeholder="请输入留言，如包装、交易方式等信息" />
									</td>
								</tr>
								<tr>
									<td scope="row">交易方式</td>
									<td colspan="5" id="ord_way">
										<b>
										<label><input type="radio" name="ord_way" value="E" checked />&nbsp;快递（邮费到付）</label>
										<label><input type="radio" name="ord_way" value="F" />&nbsp;当面交易</label>
										</b>
									</td>
								</tr>
								<tr>
									<td colspan="6" style="text-align: center;">
										<button id="order-submit" type="button" class="btn btn-danger btn-lg">提交订单</button>
									</td>
								</tr>
						</table>
					</div>
				</section>
			</section>
		</div>
        
        <script type="text/javascript">        
	        //价格格式化
	    	function priceformat(price) {
	    		return parseFloat(price).toFixed(2);
	    	}
        
        	var bookid = '<%=bookid %>';
        	$.ajax({
        		url: "../Order.do",
        		data: "act=beforeorder&bookid=" + bookid,
        		type: "post",
        		success: function (rel) {
        			var data = eval(rel);
        			$("#adr_uname").text(data[0].ADR_UNAME);
        			var adr = data[0].ADR_PROV + " " + data[0].ADR_CITY + " " + data[0].ADR_DIST + " " + data[0].ADR_ADDRESS + 
     							" " + ((data[0].ADR_ZIPCODE != null)?data[0].ADR_ZIPCODE:"");
        			$("#adr_address").text(adr);
        			$("#adr_phone").text(data[0].ADR_PHONE);
        			$("#book_name_ch").text(data[0].BOOK_NAME_CH);
        			$("#book_name_en").text(data[0].BOOK_NAME_EN);
        			$("#book_author_ch").text(data[0].BOOK_AUTHOR_CH);
        			$("#book_author_en").text(data[0].BOOK_AUTHOR_EN);
        			$("#book_press").text(data[0].BOOK_PRESS);
        			$("#book_sellprice").text("￥" + priceformat(data[0].BOOK_SELLPRICE));
        			$("#book_seller").text(data[0].BOOK_SELLERNAME + "(" + data[0].BOOK_SELLER + ")");
        			$("#book_isbn").text(data[0].BOOK_ISBN);
        			$("#book_cover").text(data[0].BOOK_COVER);
        			$("#book_version").text(data[0].BOOK_VERSION);
        			if (data[0].BOOK_IMAGE != null) {
						$("#book-image").attr("src", "../" + data[0].BOOK_IMAGE);
					}
        		}
        	});
        	        	
       		$.ajax({
       			url: "../Order.do",
       			data: "act=loadadrlist",
       			type: "post",
       			success: function (rel) {
       				var data = eval(rel);
       				var str = "";
       				for (var i = 0; i < data.length; i++) {
       					str = "<label><input type='radio' name='adrid' value='" + data[i].ADR_ID + "' " + 
       						((data[i].ADR_DEFAULT == 'T')?"checked":"") + " />&nbsp;<b>" + data[0].ADR_UNAME + 
       						"&nbsp;" + data[i].ADR_PHONE + "</b>&nbsp;" + data[i].ADR_PROV + "&nbsp;" + 
       						data[i].ADR_CITY + "&nbsp;" + data[i].ADR_DIST + "&nbsp;" + data[i].ADR_ADDRESS + "&nbsp;" + 
       						((data[i].ADR_ZIPCODE != null)?data[i].ADR_ZIPCODE:"") + "</label><br />";
       					$("#form-adr").append(str);
       				}
       			}
       		});
    		
        	$("#order-submit").click(function () {
        		$.ajax({
            		url: "../Order.do",
            		data: "act=order&bookid=" + bookid + "&msg=" + $("#ord_message").val() + "&ordway=" + $("input[name='ord_way']:checked").val(),
            		type: "post",
            		success: function (rel) {
            			if (rel == "DONE") {
            				window.location.href = "success.jsp";
            			} else if (rel.substr(0, 3) == "PAY") {
            				var ordid = rel.substr(3);
            				window.location.href = "checkout.jsp?orderid=" + ordid;
            			} else {
            				alert("错误：" + rel + "，请稍后再试");
            			}
            		}
            	});
        	});
        	        	
        	$("#adr-save").click(function () {
        		$.ajax({
            		url: "../Order.do",
            		data: "act=setdefaultadr&adrid=" + $("input[name='adrid']:checked").val(),
            		type: "post",
            		success: function (rel) {  
            			if (rel == "success") {
           					window.location.reload();
            			} else {
            				alert("地址修改失败，请稍后再试");
           					window.location.reload();
            			}
            		}
        		});
        	});
        </script>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
