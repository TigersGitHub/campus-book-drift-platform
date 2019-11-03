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
		
        <title>图书详情 - 书角 SHUJIAO</title>
        <link href="css/detail.css" rel="stylesheet" type="text/css" />	
        <script src="js/detail.js" type="text/javascript"></script>	
        <script type="text/javascript">
        	function order(obj) {
        		var id = $(obj).attr("data-id");
        		$.ajax({
        			url: "../UserCenter.do",
        			type: "post",
        			data: "act=getdefaultadr",
        			success: function (rel) {
        				if (rel == "") {
        					//拒绝下单并跳转地址设置页面
        					alert("您尚未设置默认地址，请先设置");
        					window.location.href = "../user/myadr.jsp";
        					return;
        				} else {
        					//已设置默认地址
        					window.location.href = "order.jsp?bookid=" + id;
        				}
        			}
        		});
        	}
        
        	function collect(obj) {
	    		var id = $(obj).attr("id");
	    		$.ajax({
	    			url: "../LoadBookList.do",
	    			data: "act=collect&bookid=" + id,
	    			type: "post",
	    			success: function (rel) {
	    				if (rel == "success") {
	    					$("#" + id).attr("onclick", "");
	    					$("#" + id).attr("disabled", "disabled");
	    					$("#" + id).text("已收藏");
	    				} else {
	    					alert("收藏失败！请刷新后再试");
	    				}
	    			}
	    		});
        	}
        </script>
    </head>

    <body>
		<%@ include file="/common/header.jsp" %>

		<div class="container" id="container-index">
			<section id="left-floor" class="floors">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>图书详情</h5>
	            </header>

				<section>
					<img id="book-image" src="../images/defbook.jpg" alt="" />
					
					<section id="book-maininfo">
						<h3 id="book-name"></h3>
						<h5 id="book-name-en"><span></span>&nbsp;</h5>
						<h5 id="book-author"><span></span>&nbsp;著</h5>
						<h5 id="book-author-en"><span></span>&nbsp;</h5>
						<h2 id="price"><span id="book-sellprice">¥<span></span></span><del id="book-price">¥<span></span></del></h2>
						<div id="btn-grp">
							
						</div>
					</section>
					
					<section id="book-tableinfo">
						<table class="table">
							<thead></thead>
							<tbody>
								<tr>
									<th width="12%">ISBN</th>
									<td width="21%" id="book-isbn"></td>
									<th width="12%">分类</th>
									<td width="21%" id="book-type"></td>
									<th width="12%">正文语种</th>
									<td id="book-language"></td>
								</tr>
								<tr>
									<th width="12%">出版社</th>
									<td width="21%" id="book-press"></td>
									<th width="12%">出版时间</th>
									<td width="21%" id="book-pressdate"></td>
									<th width="12%">版次</th>
									<td id="book-version"></td>
								</tr>
								<tr>
									<th width="12%">开本</th>
									<td width="21%" id="book-format"></td>
									<th width="12%">页数</th>
									<td width="21%" id="book-page"></td>
									<th width="12%">包装</th>
									<td id="book-cover"></td>									
								</tr>
								<tr>
									<th width="12%">详细描述</th>
									<td colspan="5" id="book-detail"></td>
								</tr>
							</tbody>
						</table>
					</section>
				</section>
			</section>
			
			<section id="right-floor">
                <section id="rec-floor" class="floors">
                    <header>
                        <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
                        <h5>好书推荐</h5>
                    </header>

                </section>
            </section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
