<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String path = request.getContextPath();
	String online = (String)request.getSession().getAttribute("online");
	if (online == "true") {
		response.sendRedirect(path);
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/common/meta.jsp" %>
		<%@ include file="/common/css.jsp" %>
		<%@ include file="/common/js.jsp" %>
		
		<title>欢迎登录 - 书角 SHUJIAO</title>
		
        <link rel="stylesheet" type="text/css" href="css/index.css" />
        
        <script type="text/javascript" src="js/index.js"></script>
    </head>

    <body>
        <a class="back" href="<%=path %>/index.jsp">
            <img src="images/back.png" alt="返回主页" />
        </a>

        <section>
            <div class="container">
                <form class="form-signin">
                    <h2 class="form-signin-heading">登录 Sign In</h2>
                    <label for="email" class="sr-only">请输入邮箱地址</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="请输入邮箱地址"
                           data-container="body" data-toggle="popover" data-placement="right"
                           data-content="" />
                    <label for="password" class="sr-only">请输入登录密码</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="请输入登录密码"
                           data-container="body" data-toggle="popover" data-placement="right"
                           data-content="" />
                    <div class="checkbox">
                        <input id="remember-me" name="remember-me" type="checkbox" value="auto" />
                        <label for="remember-me">&nbsp;一周内自动登录</label>
                        <a href="resetpassword.jsp">忘记密码？</a>
                        <a href="reg.jsp">用户注册</a>
                    </div>
                    <button type="button" id="signin" class="btn btn-lg btn-primary btn-block"
                            data-container="body" data-toggle="popover" data-placement="right"
                            data-content="">登录</button>
                </form>
            </div>
        </section>

        <div class="log-footer">
            <p>2017 &copy; 书角网</p>
        </div>
    </body>
</html>
