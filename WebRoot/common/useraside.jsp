<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<aside id="user-menu" class="floors">
	<header>
        <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
        <h5>我的书角</h5>
    </header>
          
	<div class="list-group">
		<a class="list-group-item title"><span id="greeting">欢迎您</span>，${username}</a>
		<a href="<%=path %>/user" class="list-group-item">
			<span id="currorder-num" class="label label-default label-pill pull-right">-</span>
			未完成订单
		</a>
		<a href="<%=path %>/user/myorder.jsp" class="list-group-item">
			<span id="allorder-num" class="label label-default label-pill pull-right">-</span>
			已完成订单
		</a>
		<a href="<%=path %>/user/favorite.jsp" class="list-group-item">
			<span id="fav-num" class="label label-default label-pill pull-right">-</span>
			收藏夹
		</a>
	</div>
	
	<div class="list-group">
		<a href="<%=path %>/user/sell.jsp" class="list-group-item">发布图书</a>
		<a href="<%=path %>/user/mybook.jsp" class="list-group-item">我发布的图书</a>
		<a href="<%=path %>/user/mysold.jsp" class="list-group-item">售出图书管理</a>
	</div>
	
	<div class="list-group">
		<a href="<%=path %>/user/mycomment.jsp" class="list-group-item">我收到的评价</a>
		<a href="<%=path %>/user/myadr.jsp" class="list-group-item">地址管理</a>
		<a href="<%=path %>/user/myinfo.jsp" class="list-group-item">个人资料修改</a>
		<a href="<%=path %>/login/resetpassword.jsp" class="list-group-item">重置密码</a>
	</div>
</aside>
