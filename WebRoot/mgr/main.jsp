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
		
        <title>运营信息总览 - 书角 SHUJIAO</title>
        <link href="css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/main.js"></script>
        <style type="text/css">			
			body>.charts h5 {
				text-align: center;
				margin: 117px 0;
			}
			
			body>.col-md-4 {
				padding: 0 8px;
				width: 32.5%;
				height: 258px;
			}
			
			#chart2,
			#chart5 {
				margin: 0 1.25%;
			}
			
			body>.col-md-4 .card-block {
				padding: 0;
			}
			
			#chart3 #time {
				text-align: center;
				margin-top: 12px;
			}
			
			#chart3 h3 {
				line-height: 48px;
			}
			
			#chart3 h3 span {
				margin: 6px;
			}
			
			#chart3 #datetimebox {
				font-weight: bold;
			}
			
			#chart3 p {
				text-align: left;
				text-indent: 2em;
				padding: 6px;
			}
			
			#chart6 .col-md-5 {
				font-weight: bold;
				text-align: right;
			}
			
			#chart6 .col-md-6 {
				text-align: right;
				font-size: 16px;
				line-height: 30px;
			}
			
			#chart6 .col-md-12 {
				padding: 16px 0;
				font-size: 20px;
				border-top: 2px dashed rgb(224, 224, 224);
			}
			
			#chart6 .col-md-12:first-child {
				border-top: none;				
			}
        </style>
    </head>
    
    <body>
		<div class="card col-md-4 charts" id="chart1">
			<div class="card-block">
				<div id="chart-container">
					<h5>图表正在加载，请稍候...</h5>
				</div>
			</div>
		</div>
		
		<div class="card col-md-4 charts" id="chart2">
			<div class="card-block">
				<div id="chart-container2">
					<h5>图表正在加载，请稍候...</h5>
				</div>
			</div>
		</div>
		
		<div class="card col-md-4" id="chart3">
			<div class="card-block">
				<div id="chart-container3">
					<div id="time">						
						<h3>书角网运营系统V1.1</h3>
						<h4 id="datetimebox">---------- --:--:--</h4>
						<hr />
						<h4>公告</h4>
						<p>为节约用电，下班后请关闭办公区个人计算机、热水器、办公室照明、空气净化器等设备电源，谢谢！</p>
					</div>
				</div>
			</div>
		</div>	
		
		<div class="card col-md-4 charts" id="chart4">
			<div class="card-block">
				<div id="chart-container4">
					<h5>图表正在加载，请稍候...</h5>
				</div>
			</div>
		</div>	
		
		<div class="card col-md-4 charts" id="chart5">
			<div class="card-block">
				<div id="chart-container5">
					<h5>图表正在加载，请稍候...</h5>
				</div>
			</div>
		</div>
		
		<div class="card col-md-4" id="chart6">
			<div class="card-block">
				<div id="chart-container6">
					<div class="col-md-12">
						<div class="col-md-6">注册用户总数</div>
						<div class="col-md-5"><span id="total1">-</span>&nbsp;人</div>
						<div class="com-md-1"></div>
					</div>
					<div class="col-md-12">
						<div class="col-md-6">上架图书总数</div>
						<div class="col-md-5"><span id="total2">-</span>&nbsp;册</div>
						<div class="com-md-1"></div>
					</div>
					<div class="col-md-12">
						<div class="col-md-6">生成订单总数</div>
						<div class="col-md-5"><span id="total3">-</span>&nbsp;单</div>
						<div class="com-md-1"></div>
					</div>
					<div class="col-md-12">
						<div class="col-md-6">厂商分成合计</div>
						<div class="col-md-5"><span id="total4">-</span>&nbsp;元</div>
						<div class="com-md-1"></div>
					</div>
				</div>
			</div>
		</div>	
		
    </body>
</html>
