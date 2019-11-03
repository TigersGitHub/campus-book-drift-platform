<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<nav class="navbar navbar-light" id="defnav">
    <div class="container">
        <ul class="nav navbar-nav nav-left">
            <li class="nav-item">
                <a class="nav-link" id="userposition">
                    <script type="text/javascript">
                    	var path = '<%=path %>';
                        document.write("<img src='" + path + "/images/position.png' />");
                    </script>
                </a>
            </li>
        </ul>

        <ul class="nav navbar-nav pull-right">
        	<li class="nav-item">
        		<a class="nav-link nav-link-point" href="../">返回首页</a>
       		</li>
			<% if (online == "true") { %>                   
        	<li class="nav-item">
            	<a class="nav-link">欢迎您，${username}</a>
        	</li>
        	<li class="nav-item">
            	<a class="nav-link" href="<%=path %>/Logout.do">注销</a>
			</li>   
			<% } else { %>
            <li class="nav-item">
            	<a class="nav-link" href="<%=path %>/login">您好，请登录</a>
			</li>
			<li class="nav-item">
            	<a class="nav-link nav-link-point" href="<%=path %>/login/reg.jsp">免费注册</a>
			</li>    
			<% } %>
            <li class="nav-item">
                <a class="nav-link">|</a>
            </li>
            <li id="myShuJiao" class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="myShuJiaoBtn"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">我的书角</a>
                <div id="myShuJiaoList" class="dropdown-menu" aria-labelledby="myShuJiaoBtn">
                    <a class="dropdown-item" href="<%=path %>/user">未完成订单</a>
                    <a class="dropdown-item" href="<%=path %>/user/myorder.jsp">已完成订单</a>
                    <a class="dropdown-item" href="<%=path %>/user/favorite.jsp">收藏夹</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="<%=path %>/user/sell.jsp">发布图书</a>
                    <a class="dropdown-item" href="<%=path %>/user/mybook.jsp">我发布的图书</a>
                    <a class="dropdown-item" href="<%=path %>/user/mysold.jsp">售出图书管理</a>
                </div>
            </li>
            <li id="cusService" class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="cusServiceBtn"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">客户服务</a>
                <div id="cusServiceList" class="dropdown-menu" aria-labelledby="cusServiceBtn">
                    <a class="dropdown-item" href="<%=path %>/help">帮助中心</a>
                    <a class="dropdown-item" href="<%=path %>/notice">新闻公告</a>
                    <a class="dropdown-item" href="<%=path %>/advice">意见建议</a>
                    <a class="dropdown-item" href="<%=path %>/about">关于我们</a>
                </div>
            </li>
        </ul>
    </div>
</nav>

<div class="container">
    <header class="page-header">
        <div class="logo">
            <img src="<%=path %>/images/logo.png" alt="书角 SHUJIAO" />
        </div>

        <div class="search-box col-xl-5 col-lg-5 col-md-5 col-sm-5 col-xs-5">
            <form id="search-form" action="" method="post">
            	<div class="input-group">
                <input type="text" name="key" id="key" class="form-control" placeholder="今天有什么想看的书？" />
                <label class="sr-only" for="search-content">图书搜索</label>
                <span class="input-group-btn">
                    <button id="searchbyname" class="btn btn-primary" type="button">&nbsp;&nbsp;搜索&nbsp;&nbsp;</button>
                </span>
            </div>
            </form>
        </div>

        <nav class="menu">
            <ul>
                <li>
                    <a href="<%=path %>/about/introduction.jsp">走近书角</a>
                </li>
                <li>
                    <a href="<%=path %>/LoadBookList.do?act=loaddrift">图书漂流</a>
                </li>
                <li>
                    <a href="<%=path %>/LoadBookList.do?act=loadsell">二手图书</a>
                </li>
                <li>
                    <a href="<%=path %>/recommend">好书推荐</a>
                </li>
            </ul>
        </nav>
    </header>
</div>
    