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
		
        <title>好书推荐 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        <script src="js/index.js" type="text/javascript"></script>	
        <script type="text/javascript">
        	function collect(obj) {
	    		var id = $(obj).attr("id");
	    		$.ajax({
	    			url: "../LoadBookList.do",
	    			data: "act=collect&bookid=" + id,
	    			type: "post",
	    			success: function (rel) {
	    				if (rel == "success") {
	    					$("#" + id).attr("onclick", "");
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
			<section class="floors">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>好书推荐</h5>
	            </header> 
				
				<section id="filter-tool">
					<form id="search-tool" class="form-inline">
						<label for="stype">　分类</label>
						<select id="stype" name="stype" class="form-control">
							<option value="0">全部分类</option>
						</select>
						<label for="sname">　书名</label>
						<input type="text" id="sname" name="sname" class="form-control" placeholder="全部或部分中文书名..." />
						<label for="ssellprice-min">　售价</label>
						<input type="number" step="0.1" min="0.01" id="ssellprice-min" name="ssellprice-min" class="form-control" placeholder="最低售价" style="width: 105px;" />
						&nbsp;~&nbsp;
						<input type="number" step="0.1" min="0.01" id="ssellprice-max" name="ssellprice-max" class="form-control" placeholder="最高售价" style="width: 105px;" />
						<span class="pull-right">
							<button type="button" id="search" class="btn btn-primary">搜索</button>
							<button type="reset" class="btn btn-secondary">重置</button>
						</span>
					</form>	
				</section>
				
				<section id="book-list">
					<h3>正在加载中，请稍候...</h3>
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
