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
		
        <title>收藏夹 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        <script src="js/favorite.js" type="text/javascript"></script>	
        <script type="text/javascript">
        	function removecollect(obj) {
	    		var id = $(obj).attr("id");
	    		$.ajax({
	    			url: "../UserCenter.do",
	    			data: "act=removecollect&favid=" + id,
	    			type: "post",
	    			success: function (rel) {
	    				if (rel == "success") {
	    					$("#" + id).attr("onclick", "");
	    					$("#" + id).text("已删除");
	    				} else {
	    					alert("删除失败！请刷新后再试");
	    				}
	    			}
	    		});
        	}
        </script>
    </head>

    <body>
    	<%@ include file="/common/header.jsp" %>
    	
		<div class="container" id="container-index">
			<%@ include file="/common/useraside.jsp" %>
			
			<section id="user-main" class="floors">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>收藏夹</h5>
	            </header>
				
				<section id="filter-tool">
					<form id="search-tool" class="form-inline">
						<label for="sissell">上架类型</label>
						<select id="sissell" name="sissell" class="form-control">
							<option value="0">全部类型</option>
							<option value="Y">二手交易</option>
							<option value="N">图书漂流</option>
						</select>
						<label for="stype">　分类</label>
						<select id="stype" name="stype" class="form-control">
							<option value="0">全部分类</option>
						</select>
						<label for="sname">　书名</label>
						<input type="text" id="sname" name="sname" class="form-control" placeholder="全部或部分中文书名..." />
						<span class="pull-right">
							<button type="button" id="search" class="btn btn-primary">搜索</button>
							<button type="reset" class="btn btn-secondary">重置</button>
						</span>
					</form>	
				</section>
				
				<section id="book-list">
				
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
