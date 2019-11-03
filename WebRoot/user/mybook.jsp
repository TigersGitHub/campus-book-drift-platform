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
		
        <title>我发布的图书 - 书角 SHUJIAO</title>
        <link href="css/index.css" rel="stylesheet" type="text/css" />	
        <script src="js/mybook.js" type="text/javascript"></script>	
        <script type="text/javascript">
	      	//金额格式化
	    	function priceformat(price) {
	    		return parseFloat(price).toFixed(2);
	    	}
      
	      	//编辑框加载
	        function editload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$.ajax({
		    		url: "../UserCenter.do",
		    		type: "post",
		    		data: "act=editbookload&bookid=" + id,
		    		success: function (rel) {
		    			var data = eval(rel);
		    			$("#bookid_edit").val(data[0].BOOK_ID);
		    			$("#isbn_edit").val(data[0].BOOK_ISBN);
		    			$("#btype_edit").val(data[0].BOOK_TYPE);
		    			$("#bname_ch_edit").val(data[0].BOOK_NAME_CH);
		    			$("#bname_en_edit").val(data[0].BOOK_NAME_EN);
		    			$("#bauth_ch_edit").val(data[0].BOOK_AUTHOR_CH);
		    			$("#bauth_en_edit").val(data[0].BOOK_AUTHOR_EN);
		    			$("#press_edit").val(data[0].BOOK_PRESS);
		    			$("#pressdate_edit").val(data[0].BOOK_PRESSDATE);
		    			$("#blang_edit").val(data[0].BOOK_LANGUAGE);
		    			$("#bfmt_edit").val(data[0].BOOK_FORMAT);
		    			$("#page_edit").val(data[0].BOOK_PAGE);
		    			$("#cover_edit").val(data[0].BOOK_COVER);
		    			$("#version_edit").val(data[0].BOOK_VERSION);
		    			$("#issell_edit").val(data[0].BOOK_ISSELL);
		    			if (data[0].BOOK_ISSELL == "N") {
		    				$("#bsellprice_edit").attr("readonly", "readonly");
		    			} else {
		    				$("#bsellprice_edit").removeAttr("readonly");
		    			}
		    			//$("#bimage_edit").val(data[0].BOOK_IMAGE);
		    			$("#bprice_edit").val(priceformat(data[0].BOOK_PRICE));
		    			$("#bsellprice_edit").val(priceformat(data[0].BOOK_SELLPRICE));
	    				$("#bdetail_edit").val(data[0].BOOK_DETAIL);
		    		}
		    	});
	    	}
	        
	      	//删除框加载
	        function delload(obj) {
	    		var id = $(obj).attr("data-id");
	        	$("#del-book").attr("href", "../UserCenter.do?act=delbook&bookid=" + id);
	        }	        
        </script>
    </head>

    <body>
    	<div class="modal fade" id="edit-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">编辑图书</h4>
					</div>
					<div class="modal-body">
						<form id="form_edit" class="form-inline" action="<%=path %>/UserCenter.do?act=editbook" method="post">
							<input type="hidden" id="bookid_edit" name="bookid_edit" />
							<label for="isbn_edit">ＩＳＢＮ</label>
							<input id="isbn_edit" name="isbn_edit" type="text" class="form-control" placeholder="* ISBN" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="btype_edit">图书类别</label>
							<select id="btype_edit" name="btype_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="bname_ch_edit">中文全名</label>
							<input id="bname_ch_edit" name="bname_ch_edit" type="text" class="form-control" placeholder="* 中文全名" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bname_en_edit">英文全名</label>
							<input id="bname_en_edit" name="bname_en_edit" type="text" class="form-control" placeholder="英文全名" />
							<label for="bauth_ch_edit">中文作者</label>
							<input id="bauth_ch_edit" name="bauth_ch_edit" type="text" class="form-control" placeholder="* 中文作者" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bauth_en_edit">英文作者</label>
							<input id="bauth_en_edit" name="bauth_en_edit" type="text" class="form-control" placeholder="英文作者" />
							<label for="press_edit">　出版社</label>
							<input id="press_edit" name="press_edit" type="text" class="form-control" placeholder="* 出版社"  
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="pressdate_edit">出版时间</label>
							<input id="pressdate_edit" name="pressdate_edit" type="date" class="form-control form-inline-dropdown"  
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="blang_edit">正文语种</label>
							<select id="blang_edit" name="blang_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="bfmt_edit">图书规格</label>
							<select id="bfmt_edit" name="bfmt_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="page_edit">　　页数</label>
							<input id="page_edit" name="page_edit" type="number" min="0" class="form-control" placeholder="* 页数" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="cover_edit">包装方式</label>
							<select id="cover_edit" name="cover_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
								<option value="P">平装</option>
								<option value="R">精装</option>
							</select>
							<label for="version_edit">　　版次</label>
							<input id="version_edit" name="version_edit" type="text" class="form-control" placeholder="* 版次" 
								data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="issell_edit">上架类型</label>
							<select id="issell_edit" name="issell_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
								<option value="Y">二手交易</option>
								<option value="N">图书漂流</option>
							</select>
							<label for="bprice_edit">定价／元</label>
							<input id="bprice_edit" name="bprice_edit" type="number" step="0.01" class="form-control" placeholder="* 定价/元" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bsellprice_edit">售价／元</label>
							<input id="bsellprice_edit" name="bsellprice_edit" type="number" step="0.01" class="form-control" placeholder="* 售价/元" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bimage_edit">封面图片</label>
							<input id="bimage_edit" name="bimage_edit" type="text" class="form-control" disabled="disabled" />
							<button type="button" id="bimage_reupload" class="btn btn-primary" data-toggle="modal" disabled="disabled"
								data-target="#reupload-dialog">修改</button>
							<label for="bdetail_edit">图书详情</label>
							<input id="bdetail_edit" name="bdetail_edit" type="text" class="form-control" placeholder="图书详情" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="form-edit-submit" type="button" class="btn btn-success">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div class="modal fade" id="del-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">删除图书</h4>
					</div>
					<div class="modal-body">
						<div style="text-align:center;">
							<div>是否确认删除选定图书？</div>
						</div>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<a id="del-book" class="btn btn-danger">删除</a>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
 
        <%@ include file="/common/header.jsp" %>
        
		<div class="container" id="container-index">
			<%@ include file="/common/useraside.jsp" %>
			
			<section id="user-main" class="floors">
	            <header>
	                <img class="floor-logo" src="../images/logo_m.png" alt="书角" />
	                <h5>我发布的图书</h5>
	            </header>
	            
	            <section id="filter-tool">
		            <form id="search-tool" class="form-inline">
						<label for="sissell">上架类型</label>
						<select id="sissell" name="sissell" class="form-control">
							<option value="0">全部类型</option>
							<option value="Y">二手交易</option>
							<option value="N">图书漂流</option>
						</select>
						<label for="stype">　分类</label>
						<select id="stype" name="stype" class="form-control">
							<option value="0">全部分类</option>
						</select>
						<label for="sname">　书名</label>
						<input type="text" id="sname" name="sname" class="form-control" placeholder="全部或部分中文书名..." />
						<span class="pull-right">
							<button type="button" id="search" class="btn btn-primary">搜索</button>
							<button type="reset" class="btn btn-secondary">重置</button>
						</span>
					</form>
				</section>
				
				<section id="mybook-list">	
				
				</section>
				
				<div class="page-control">
					<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
       				<span class="pagenum" id="curr-page"></span>
       				<span class="pagenum">/</span>
       				<span class="pagenum" id="total-page"></span>
       				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
				</div>
			</section>
		</div>
		
		<%@ include file="/common/footer.jsp" %>
    </body>
</html>
