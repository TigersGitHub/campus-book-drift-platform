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
		
        <title>字典管理 - 书角 SHUJIAO</title>
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
				<li class="nav-item">
					<a class="nav-link" href="<%=path %>/mgr/base">数据管理</a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="<%=path %>/mgr/dictionary">字典管理<span class="sr-only">(current)</span></a>
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
					<li class="group-li"><a href="<%=path %>/mgr/dictionary">字典管理</a></li>
					<li>
						<ul class="nav-second">
							<li class="active"><a href="dept.jsp" target="iframe-mgr"><img src="images/side_dept.png" />院系专业管理</a></li>
							<li><a href="org.jsp" target="iframe-mgr"><img src="images/side_org.png" />行政区划管理</a></li>
							<li><a href="lang.jsp" target="iframe-mgr"><img src="images/side_lang.png" />图书语种管理</a></li>
							<li><a href="format.jsp" target="iframe-mgr"><img src="images/side_fmt.png" />图书规格管理</a></li>
							<li><a href="booktype.jsp" target="iframe-mgr"><img src="images/side_type.png" />图书分类管理</a></li>
							<li><a href="corp.jsp" target="iframe-mgr"><img src="images/side_corp.png" />合作厂商管理</a></li>
							<li><a href="express.jsp" target="iframe-mgr"><img src="images/side_express.png" />快递厂商管理</a></li>
						</ul>
					</li>
				</ul>
			</div>
        
			<div class="main">
				<iframe id="iframe-mgr" name="iframe-mgr" src="dept.jsp">
					<script type="text/javascript">
						var path = '<%=path %>';
						window.location.href = path + "/common/browserDownload.jsp";
					</script>
				</iframe>
			</div>
		</div> <!-- container-fluid -->
    </body>
</html>