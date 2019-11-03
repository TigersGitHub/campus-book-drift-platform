<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String online = (String)request.getSession().getAttribute("online");
	String path = request.getContextPath(); 
	String sign = (String)request.getSession().getAttribute("sign");
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
		
        <title>书角 SHUJIAO - 一站式图书漂流交易平台</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />
        <script src="js/index.js" type="text/javascript"></script>
        <script type="text/javascript">
        	function collect(obj) {
	    		var id = $(obj).attr("id");
	    		$.ajax({
	    			url: "LoadBookList.do",
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
                	<script type="text/javascript">
                		var sign = '<%=sign %>';
                		var path = '<%=path %>';
                		if (sign == "A") {
                			var str = "<li class='nav-item'><a class='nav-link nav-link-point'"
                				+ "href='" + path + "/mgr'>管理中心</a></li>";
                			document.write(str);
                		}
                	</script>
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
                            <button id="searchbyname_homepage" class="btn btn-primary" type="button">&nbsp;&nbsp;搜索&nbsp;&nbsp;</button>
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

        <div class="container" id="container-index">
            <nav class="left-menu">
                <ul class="nav" id="list-btype">                
                	<li class="nav-item">
                		<a class="nav-link">马列中社</a>
                		<a class="nav-link">哲学宗教</a>
                	</li>
                	<li class="nav-item">
                		<a class="nav-link">社会科学</a>
                		<a class="nav-link">政法军事</a>
                	</li>
                	<li class="nav-item">
                		<a class="nav-link">经济管理</a>
                		<a class="nav-link">教科文体</a>
                	</li>
                	<li class="nav-item">
                		<a class="nav-link">语言文字</a>
                		<a class="nav-link">文学艺术</a>
                	</li><li class="nav-item">
                		<a class="nav-link">历史地理</a>
                		<a class="nav-link">自然科学</a>
                	</li>
                	<li class="nav-item">
                		<a class="nav-link">数理化学</a>
                		<a class="nav-link">天文地科</a>
                	</li>
                	<li class="nav-item">
                		<a class="nav-link">生物科学</a>
                		<a class="nav-link">医药卫生</a>
                	</li>
                	<li class="nav-item">
                		<a class="nav-link">农业科学</a>
                		<a class="nav-link">工业技术</a>
                	</li>
                	<li class="nav-item">
                		<a class="nav-link">交通运输</a>
                		<a class="nav-link">航空航天</a>
               		</li>
               		<li class="nav-item">
               			<a class="nav-link">环境安全</a>
               			<a class="nav-link">综合图书</a>
             		</li>
             	</ul>
            </nav>

            <section id="carousel-generic" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
					<li data-target="#carousel-generic" data-slide-to="0" class=""></li>
                </ol>
                <div class="carousel-inner" role="listbox">
					<div class="carousel-item">
						<img src="images/carousel1.jpg" alt="示例1">
					</div>
                </div>
                <a class="left carousel-control" href="#carousel-generic" role="button" data-slide="prev">
                    <span class="icon-prev" aria-hidden="true"></span>
                    <span class="sr-only">上一张</span>
                </a>
                <a class="right carousel-control" href="#carousel-generic" role="button" data-slide="next">
                    <span class="icon-next" aria-hidden="true"></span>
                    <span class="sr-only">下一张</span>
                </a>
            </section>

            <aside id="right-bar">
                <section id="user-info" class="text-md-center">                
                    <% if (online == "true") { %>     
            			<img src="images/logo_m.png" alt="书角 SHUJIAO" />
	                    <h6>${username}</h6>
            			<br />
	                    <dl id="data-panel1">
	                    	<dt>待付款</dt>
	                    	<dd id="data1">-</dd>
	                    </dl>
	                    <dl id="data-panel2">
	                    	<dt>待收货</dt>
	                    	<dd id="data2">-</dd>
	                    </dl>
	                    <dl id="data-panel3">
	                    	<dt>待评价</dt>
	                    	<dd id="data3">-</dd>
	                    </dl>
	                    <a href="user" class="btn btn-outline-primary">我的书角</a>						
                    <% } else { %>   
            			<img src="images/logo_m.png" alt="书角 SHUJIAO" />
	                    <h6>您好，欢迎回来</h6>
	                    <a href="login" class="btn btn-info">登录书角</a>
	                    <br />
	                    <h6>还没有账号？</h6>
	                    <a href="login/reg.jsp" class="btn btn-success">注册账号</a>
                    <% } %>
                </section>

                <section id="notice">
                    <h6>新闻公告<span class="pull-right"><a href="notice">More</a></span></h6>
                    <hr />
                    <ul id="notice-list">

                    </ul>
                </section>
            </aside>

            <section id="left-floor">
                <section id="first-floor" class="floors">
                    <header>
                        <img class="floor-logo" src="images/logo_m.png" alt="书角" />
                        <h5>1F 最新上架</h5>
                    </header>
                    
                    <!-- v2
                    <div class="box">
						<div class="box-img">
							<img src="images/defbook.jpg" alt="图书图片" />
						</div>
						<div class="box-content">
							<table>
								<tr><td><h4 class="title">¥9.9</h4></td></tr>
								<tr class="des-tr"><td><p class="description">C程序设计<br />（第四版）<br />清华大学出版社</p></td></tr>
								<tr><td class="social-links"><a href="#">查看</a><a href="#">收藏</a></td></tr>
							</table>							
						</div>
					</div>
                     -->
                     
					<!-- v1
                    <a href="#">
                        <div class="card">
                            <img class="card-img-top" src="images/defbook.jpg" alt="图书图片" />
                            <div class="card-block">
                                <h4 class="card-title">¥9.9</h4>
                                <p class="card-text">C程序设计（第四版）清华大学出版社</p>
                            </div>
                        </div>
                    </a>
                     -->
                </section>

                <section id="second-floor" class="floors">
                    <header>
                        <img class="floor-logo" src="images/logo_m.png" alt="书角" />
                        <h5>2F 热门漂流</h5>
                    </header>

                </section>

                <section id="third-floor" class="floors">
                    <header>
                        <img class="floor-logo" src="images/logo_m.png" alt="书角" />
                        <h5>3F 热门二手</h5>
                    </header>

                </section>
            </section>

            <section id="right-floor">
                <section id="rec-floor" class="floors">
                    <header>
                        <img class="floor-logo" src="images/logo_m.png" alt="书角" />
                        <h5>好书推荐</h5>
                    </header>

                </section>
            </section>
        </div>
        
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
