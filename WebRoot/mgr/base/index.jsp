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
		
        <title>数据管理 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../js/mgrpublic.js"></script>
    </head>
    
    <body>
	    <nav class="navbar navbar-dark navbar-fixed-top bg-inverse">
			<ul class="nav navbar-nav">
	   			<a class="navbar-brand" href="<%=path %>/mgr">
	   				<img alt="logo" src="<%=path %>/mgr/images/logo_mgr.png" />
				</a>
				<li class="nav-item">
					<a class="nav-link" href="<%=path %>/mgr">运营中心</a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="<%=path %>/mgr/base">数据管理<span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<%=path %>/mgr/dictionary">字典管理</a>
				</li>
			</ul>
			<ul class="nav navbar-nav pull-right">
				<li class="nav-item">
					<a class="nav-link active" href="<%=path %>/index.jsp" target="_blank">用户首页</a>
				</li>
                <li class="nav-item">
                    <a class="nav-link active">|</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link"></a>
                </li>
				<a class="navbar-brand">
   					<img alt="logo" src="<%=path %>/mgr/images/user.png" />
				</a>
				<li class="nav-item">
					<a class="nav-link active">${username}</a>					
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="<%=path %>/Logout.do">注销</a>
				</li>	
				<a class="navbar-brand" href="<%=path %>/Logout.do">
					<img src="<%=path %>/mgr/images/logout.png" />
				</a>
			</ul>
		</nav>
		
		<div class="container-fluid">
			<div class="sidebar">
				<ul class="nav nav-sidebar">
					<li class="group-li"><a href="<%=path %>/mgr">运营中心</a></li>
					<li class="group-li"><a href="<%=path %>/mgr/base">数据管理</a></li>
					<li>
						<ul class="nav-second">
							<li class="active"><a href="userinfo.jsp" target="iframe-mgr"><img src="images/side_user.png" />用户信息管理<span class="sr-only">(current)</span></a></li>
							<li><a href="useradr.jsp" target="iframe-mgr"><img src="images/side_adr.png" />用户地址管理</a></li>
							<li><a href="mgrinfo.jsp" target="iframe-mgr"><img src="images/side_order.png" />员工信息管理</a></li>
							<li><a href="recommend.jsp" target="iframe-mgr"><img src="images/side_book.png" />推荐图书管理</a></li>
							<li><a href="carousel.jsp" target="iframe-mgr"><img src="images/side_csl.png" />轮播广告管理</a></li>
							<li><a href="news.jsp" target="iframe-mgr"><img src="images/side_news.png" />新闻公告管理</a></li>
							<li><a href="help.jsp" target="iframe-mgr"><img src="images/side_help.png" />用户帮助管理</a></li>
							<li><a href="advice.jsp" target="iframe-mgr"><img src="images/side_adv.png" />意见建议管理</a></li>
						</ul>
					</li>
					<li class="group-li"><a href="<%=path %>/mgr/dictionary">字典管理</a></li>
				</ul>
			</div>
        
			<div class="main">
				<iframe id="iframe-mgr" name="iframe-mgr" src="userinfo.jsp">
					<script type="text/javascript">
						var path = '<%=path %>';
						window.location.href = path + "/common/browserDownload.jsp";
					</script>
				</iframe>
			</div>
		</div> <!-- container-fluid -->
    </body>
</html>
