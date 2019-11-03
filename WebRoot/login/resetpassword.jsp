<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String path = request.getContextPath();
	String online = (String)request.getSession().getAttribute("online");
%>

<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/common/meta.jsp" %>
		<%@ include file="/common/css.jsp" %>
		<%@ include file="/common/js.jsp" %>
		
	    <title>重置密码 - 书角 SHUJIAO</title>
	
	    <script type="text/javascript" src="js/resetpassword.js"></script>
	    <link href="css/resetpassword.css" type="text/css" rel="stylesheet" />
	</head>

	<body>
	    <a class="back" href="<%=path %>/index.jsp">
	        <img src="images/back.png" alt="返回主页" />
	    </a>
	
	    <div class="container">
	        <section class="resetpw">
	            <form>
	                <h2 class="form-rpw-heading">重置密码 Reset</h2>
	                <dl id="step1" class="step currstep">
	                    <dt>1</dt>
	                    <dd>验证身份</dd>
	                </dl>
	                <dl id="step2" class="step">
	                    <dt>2</dt>
	                    <dd>设置新密码</dd>
	                </dl>
	                <dl id="step3" class="step">
	                    <dt>√</dt>
	                    <dd>完成</dd>
	                </dl>
	                <div id="step-form1">
	                    <input type="text" id="email" class="form-control form-top" placeholder="请输入邮箱地址"
	                           data-container="body" data-toggle="popover" data-placement="right"
	                           data-content="" />
	                    <input type="text" id="tel" class="form-control form-bottom" placeholder="请输入注册时填写的手机号码"
	                           data-container="body" data-toggle="popover" data-placement="right"
	                           data-content="" />
	                    <input type="button" id="next-step" class="btn btn-lg btn-block btn-primary" value="下一步"
	                           data-container="body" data-toggle="popover" data-placement="right"
	                           data-content="" />
	                </div>
	                <div id="step-form2">
	                    <input type="password" id="password" class="form-control form-top" placeholder="请输入新密码"
	                           data-container="body" data-toggle="popover" data-placement="right"
	                           data-content="" />
	                    <input type="password" id="password2" class="form-control form-bottom" placeholder="请再次输入新密码"
	                           data-container="body" data-toggle="popover" data-placement="right"
	                           data-content="" />
	                    <input type="button" id="reset-step" class="btn btn-primary btn-lg btn-block" value="提交"
	                           data-container="body" data-toggle="popover" data-placement="right"
	                           data-content="" />
	                </div>
	                <div id="step-form3">
	                    <div id="resetpw-msg">
							密码修改成功！请重新登录
	                    </div>
	                    <br />
	                    <a href="index.jsp" class="form-control btn btn-primary">返回</a>
	                </div>
	            </form>
	        </section>
	    </div>
	
	    <div class="log-footer">
            <p>2017 &copy; 书角网</p>
        </div>
	</body>
</html>
