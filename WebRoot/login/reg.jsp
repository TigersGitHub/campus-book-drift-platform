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
		
        <title>用户注册 - 书角 SHUJIAO</title>

        <link rel="stylesheet" type="text/css" href="css/reg.css" />
        <script type="text/javascript" src="js/reg.js"></script>
    </head>

    <body>
        <div class="modal fade" id="agreement" tabindex="-1" role="dialog" aria-labelledby="amModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">关闭</span>
                        </button>
                        <h4 class="modal-title" id="amModalLabel">书角（SHUJIAO）用户服务协议</h4>
                    </div>
                    <div class="modal-body">
                        <textarea name="agree-content" id="agree-content" readonly="readonly"></textarea>
                    </div>
                </div>
            </div>
        </div>

        <a class="back" href="<%=path %>/index.jsp">
            <img src="images/back.png" alt="返回主页" />
        </a>

        <section>
            <div class="container">
                <form class="form-reg">
                    <h2 class="form-reg-heading">注册 Register</h2>
                    <label for="email" class="sr-only">请输入邮箱地址</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="* 请输入邮箱地址"
                    		data-container="body" data-toggle="popover" data-placement="right"
                    		data-content="" />
                    <label for="username" class="sr-only">请输入用户名</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="* 请输入用户名"
                    		data-container="body" data-toggle="popover" data-placement="right"
                    		data-content="" />
                    <label for="tel" class="sr-only">请输入手机号码</label>
                    <input type="tel" id="tel" name="tel" class="form-control" placeholder="* 请输入手机号码"
                    		data-container="body" data-toggle="popover" data-placement="right"
                    		data-content="" />
                    <label for="password" class="sr-only">请输入登录密码</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="* 请输入登录密码"
                   			data-container="body" data-toggle="popover" data-placement="right"
                    		data-content="" />
                    <label for="password2" class="sr-only">请再次输入登录密码</label>
                    <input type="password" id="password2" name="password2" class="form-control" placeholder="* 请再次输入登录密码"
                    		data-container="body" data-toggle="popover" data-placement="right"
                    		data-content="" />
                    <label for="sex" class="sr-only">请选择性别</label>
                    <select id="sex" name="sex" class="form-control"  
                    		data-container="body" data-toggle="popover" data-placement="right" data-content="">
                        <option value="0" selected>* 请选择性别</option>
                        <option value="M">男</option>
                        <option value="F">女</option>
                    </select>
                    <label for="dept1" class="sr-only">请选择学校</label>
                    <select id="dept1" name="dept1" class="form-control">
                        <option value="0" selected>* 学校</option>
                        
                    </select>
                    <label for="dept2" class="sr-only">请选择院系</label>
                    <select id="dept2" name="dept2" class="form-control">
                        <option value="0" selected>* 院系</option>
                        
                    </select>
                    <label for="dept3" class="sr-only">请选择专业</label>
                    <select id="dept3" name="dept3" class="form-control" data-container="body"
                            data-toggle="popover" data-placement="right" data-content="">
                        <option value="0" selected>* 专业</option>
                        
                    </select>
                    <label for="age" class="sr-only">请选择年龄</label>
                    <input type="number" onkeydown="return false;" id="age" name="age"
                           min="18" max="120" class="form-control" placeholder="请选择年龄" />
                    <label for="hometown" class="sr-only">请输入家乡</label>
                    <input type="text" id="hometown" name="hometown" class="form-control" placeholder="请输入家乡" />
                    <div class="checkbox">
                        <a href="#" data-toggle="modal" data-target="#agreement">书角网服务协议</a>
                        <a class="toLogin" href="index.jsp">已有账号？去登录</a>
                    </div>
                    <button type="button" id="reg" class="btn btn-lg btn-primary btn-block" 
                            data-container="body" data-toggle="popover" data-placement="right" 
                            data-content="">同意协议并注册</button>
                </form>
            </div>
        </section>

        <div class="log-footer">
            <p>2017 &copy; 书角网</p>
        </div>
    </body>
</html>
