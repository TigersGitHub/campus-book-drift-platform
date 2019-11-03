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
		
        <title>发布图书 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        <script src="js/sell.js" type="text/javascript"></script>	
    </head>

    <body>
		<%@ include file="/common/header.jsp" %>

		<div class="container" id="container-index">
			<%@ include file="/common/useraside.jsp" %>
			
			<section id="user-main" class="floors">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>发布图书</h5>
	            </header>
				
				<section id="sell-new">
					<form id="sell-form" action="../UserCenter.do?act=addbook" method="post">
						<div class="col-md-12">
							<label for="book_isbn" class="col-md-2">* ISBN</label>
							<span class="col-md-5">
								<input type="text" id="book_isbn" name="book_isbn" class="form-control" placeholder="ISBN" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_type" class="col-md-2">* 图书分类</label>
							<span class="col-md-5">
								<select id="book_type" name="book_type" class="form-control"
									data-container="body" data-toggle="popover" data-placement="right" data-content="">
									<option value="0">--- 请选择 ---</option>
								</select>
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_name_ch" class="col-md-2">* 中文书名</label>
							<span class="col-md-5">
								<input type="text" id="book_name_ch" name="book_name_ch" class="form-control" placeholder="中文书名" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_name_en" class="col-md-2">英文书名</label>
							<span class="col-md-5">
								<input type="text" id="book_name_en" name="book_name_en" class="form-control" placeholder="英文书名" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_auth_ch" class="col-md-2">* 中文作者</label>
							<span class="col-md-5">
								<input type="text" id="book_auth_ch" name="book_auth_ch" class="form-control" placeholder="中文作者" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_auth_en" class="col-md-2">英文作者</label>
							<span class="col-md-5">
								<input type="text" id="book_auth_en" name="book_auth_en" class="form-control" placeholder="英文作者" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_press" class="col-md-2">* 出版社</label>
							<span class="col-md-5">
								<input type="text" id="book_press" name="book_press" class="form-control" placeholder="出版社" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_pressdate" class="col-md-2">* 出版时间</label>
							<span class="col-md-5">
								<input type="date" id="book_pressdate" name="book_pressdate" class="form-control"
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_language" class="col-md-2">* 图书语种</label>
							<span class="col-md-5">
								<select id="book_language" name="book_language" class="form-control"
									data-container="body" data-toggle="popover" data-placement="right" data-content="">
									<option value="0">--- 请选择 ---</option>
								</select>
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_format" class="col-md-2">* 图书规格</label>
							<span class="col-md-5">
								<select id="book_format" name="book_format" class="form-control"
									data-container="body" data-toggle="popover" data-placement="right" data-content="">
									<option value="0">--- 请选择 ---</option>
								</select>
							</span>
						</div>						
						<div class="col-md-12">
							<label for="book_page" class="col-md-2">* 页数</label>
							<span class="col-md-5">
								<input type="text" id="book_page" name="book_page" class="form-control" placeholder="页数" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_cover" class="col-md-2">* 包装方式</label>
							<span class="col-md-5">
								<select id="book_cover" name="book_cover" class="form-control"
									data-container="body" data-toggle="popover" data-placement="right" data-content="">
									<option value="0">--- 请选择 ---</option>
									<option value="P">平装</option>
									<option value="R">精装</option>
								</select>
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_version" class="col-md-2">* 版次</label>
							<span class="col-md-5">
								<input type="text" id="book_version" name="book_version" class="form-control" placeholder="版次" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_issell" class="col-md-2">* 上架类型</label>
							<span class="col-md-5">
								<select id="book_issell" name="book_issell" class="form-control"
									data-container="body" data-toggle="popover" data-placement="right" data-content="">
									<option value="0">--- 请选择 ---</option>
									<option value="Y">二手交易</option>
									<option value="N">图书漂流</option>
								</select>
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_price" class="col-md-2">* 定价</label>
							<span class="col-md-5">
								<input type="number" min="0" step="0.1" id="book_price" name="book_price" class="form-control" placeholder="定价" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_sellprice" class="col-md-2">* 售价</label>
							<span class="col-md-5">
								<input type="number" min="0" step="0.1" id="book_sellprice" name="book_sellprice" class="form-control" placeholder="售价" 
									data-container="body" data-toggle="popover" data-placement="right" data-content="" />
							</span>
						</div>						
						<div class="col-md-12">
							<label for="book_image" class="col-md-2">封面图片</label>
							<span class="col-md-5">
								<input type="text" id="book_image_path" style="width:232px;display:inline;" class="form-control" placeholder="封面图片" readonly="readonly" />
								<input type="file" id="file_input" style="display: none;" />
								<input type="hidden" name="book_image" id="book_image_data" />
								<button type="button" id="file_input" onclick="onFile()" class="btn btn-primary" style="margin-top: -4px;">选择图片</button>  
							</span>
						</div>
						<div class="col-md-12">
							<label for="book_detail" class="col-md-2">图书详情</label>
							<span class="col-md-5">
								<textarea id="book_detail" name="book_detail" class="form-control" placeholder="图书详情"></textarea>
							</span>
						</div>
						<div class="col-md-12">
							<label class="col-md-2"></label>
							<span class="col-md-5">
								<button id="save" type="button" class="btn btn-success">发布图书</button>
							</span>
						</div>
					</form>
				</section>
			</section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
    
    <script type="text/javascript">  
		var input = document.getElementById("file_input");
	  
		if (typeof FileReader === 'undefined') {  
			alert("您的浏览器不支持图片上传组件");  
			input.setAttribute('disabled','disabled');  
		} else {
			//事件名，方法，true-捕获阶段执行/false-冒泡阶段执行
	        input.addEventListener('change', readFile, false);
		}
	
		function onFile() {
			//模拟单击input:file控件
			document.getElementById('file_input').click();
		}
	
		function readFile() {
			var file = this.files[0];
			
			//过滤文件类型
			if(!/image\/\w+/.test(file.type)){  
				alert("您选择的不是图片文件，请重新选择");  
				return false;  
			}
			
			//文件大小Byte转KB
			var fsize = parseInt((file.size)/1024);
			
			//检查文件大小
			if (fsize > 512) {
				alert("图片大小不能超过0.5MB，请重新选择");
				return false;
			}
	
			//读取为data:image格式
			var reader = new FileReader();  
			reader.readAsDataURL(file);
	
			reader.onload = function(e) {
				document.getElementById('book_image_data').value = this.result;
				
				//图片路径分割为数组
				var arr = input.value.split('\\');
	
				//取文件名（路径数组最后一段）
				document.getElementById('book_image_path').value = arr[arr.length - 1];	
	        }
		}
	</script>
</html>
