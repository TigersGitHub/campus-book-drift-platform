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
		
        <title>图书信息管理 - 书角 SHUJIAO</title>
        <link href="css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/bookinfo.js"></script>
        <script type="text/javascript">
    		$(function () {
    			$("#add-dialog input[type='text']").attr("readonly", "readonly");
    		});
        
        	function priceformat(price) {
        		return parseFloat(price).toFixed(2);
        	}
        
	    	function viewload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$.ajax({
		    		url: "../BookCommon.do",
		    		type: "post",
		    		data: "act=binfodetail&bookid=" + id,
		    		success: function (rel) {
		    			var data = eval(rel);
		    			$("#isbn").val(data[0].BOOK_ISBN);
		    			$("#btype").val(data[0].BOOK_TYPE);
		    			$("#bname_ch").val(data[0].BOOK_NAME_CH);
		    			$("#bname_en").val(data[0].BOOK_NAME_EN);
		    			$("#bauth_ch").val(data[0].BOOK_AUTHOR_CH);
		    			$("#bauth_en").val(data[0].BOOK_AUTHOR_EN);
		    			$("#bpress").val(data[0].BOOK_PRESS);
		    			$("#bpressdate").val(data[0].BOOK_PRESSDATE);
		    			$("#blang").val(data[0].BOOK_LANGUAGE);
		    			$("#bfmt").val(data[0].BOOK_FORMAT);
		    			$("#bpage").val(data[0].BOOK_PAGE);
		    			$("#bcover").val(data[0].BOOK_COVER);
		    			$("#bversion").val(data[0].BOOK_VERSION);
		    			$("#issell").val(data[0].BOOK_ISSELL);		    			
		    			$("#bprice").val(priceformat(data[0].BOOK_PRICE));
		    			$("#bsellprice").val(priceformat(data[0].BOOK_SELLPRICE));
		    			$("#isexist").val(data[0].BOOK_ISEXIST);
		    			$("#bimage").val(data[0].BOOK_IMAGE);
		    			$("#bdetail").val(data[0].BOOK_DETAIL);
	    				$("#bnote").val(data[0].BOOK_NOTE);
		    		}
		    	});
	    	}
        </script>
    </head>
    
    <body>    
    	<div class="modal fade" id="add-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">图书详细信息</h4>
					</div>
					<div class="modal-body">
						<form id="form-add" class="form-inline" action="<%=path %>/BookCommon.do?act=addrec" method="post">
							<label for="isbn">ＩＳＢＮ</label>
							<input id="isbn" name="isbn" type="text" class="form-control" />
							<label for="btype">图书类别</label>
							<input id="btype" name="btype" type="text" class="form-control" />
							<label for="bname_ch">中文全名</label>
							<input id="bname_ch" name="bname_ch" type="text" class="form-control" />
							<label for="bname_en">英文全名</label>
							<input id="bname_en" name="bname_en" type="text" class="form-control" />
							<label for="bauth_ch">中文作者</label>
							<input id="bauth_ch" name="bauth_ch" type="text" class="form-control" />
							<label for="bauth_en">英文作者</label>
							<input id="bauth_en" name="bauth_en" type="text" class="form-control" />
							<label for="bpress">　出版社</label>
							<input id="bpress" name="bpress" type="text" class="form-control" />
							<label for="bpressdate">出版时间</label>
							<input id="bpressdate" name="bpressdate" type="text" class="form-control" />
							<label for="blang">正文语种</label>
							<input id="blang" name="blang" type="text" class="form-control" />							
							<label for="bfmt">图书规格</label>
							<input id="bfmt" name="bfmt" type="text" class="form-control" />							
							<label for="bpage">　　页数</label>
							<input id="bpage" name="bpage" type="text" class="form-control" />							
							<label for="bcover">包装方式</label>
							<input id="bcover" name="bcover" type="text" class="form-control" />							
							<label for="bversion">　　版次</label>
							<input id="bversion" name="bversion" type="text" class="form-control" />						
							<label for="issell">上架类型</label>
							<input id="issell" name="issell" type="text" class="form-control" />
							<label for="bprice">定价／元</label>
							<input id="bprice" name="bprice" type="text" class="form-control" />
							<label for="bsellprice">售价／元</label>
							<input id="bsellprice" name="bsellprice" type="text" class="form-control" />
							<label for="isexist">出售状态</label>
							<input id="isexist" name="isexist" type="text" class="form-control" />
							<label for="bimage">图片路径</label>
							<input id="bimage" name="bimage" type="text" class="form-control" />
							<label for="bdetail">图书详情</label>
							<input id="bdetail" name="bdetail" type="text" class="form-control" />
							<label for="bnote">　　备注</label>
							<input id="bnote" name="bnote" type="text" class="form-control" />
						</form>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
    	<div class="card list-tool">
			<div class="card-block">
				<button type="button" class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				<form class="form-inline pull-right">
					<select id="stype" name="stype" class="form-control">
		       			<option value="0">全部分类</option>
					</select>
					<select id="sissell" name="sissell" class="form-control">
		       			<option value="0">全部上架类型</option>
		       			<option value="Y">二手交易</option>
		       			<option value="N">图书漂流</option>
					</select>
					<select id="sisexist" name="sisexist" class="form-control">
		       			<option value="0">全部状态</option>
		       			<option value="Y">在售</option>
		       			<option value="N">售出</option>
					</select>
					<input class="form-control" type="text" id="sisbn" name="sisbn" placeholder="全部或部分ISBN编码..." />
					<input class="form-control" type="text" id="sname" name="sname" placeholder="全部或部分中文书名..." />
		    		<button type="button" id="search" class="btn btn-primary" type="button">查询</button>			    	
				</form>
			</div>
		</div>
    
		<div class="card list-content">
			<div class="card-block">				
				<table class="table table-hover table-striped overhid">
					<thead class="thead-default">
						<tr>
							<th width="18%">ISBN</th>
							<th width="16%">中文书名</th>
							<th width="10%">类别</th>
							<th width="10%">上架类型</th>
							<th width="10%">售价</th>
							<th width="10%">图书状态</th>
							<th width="10%">订单状态</th>
							<th width="16%" class="col-control">操作</th>
						</tr>
					</thead>
					
					<tbody id="emplist">
						
					</tbody>
				</table>
				
				<div class="page-control">
					<button id="previous-page" class="btn btn-secondary" disabled>&laquo;</button>
       				<span class="pagenum" id="curr-page"></span>
       				<span class="pagenum">/</span>
       				<span class="pagenum" id="total-page"></span>
       				<button id="next-page" href="#" class="btn btn-secondary">&raquo;</button>
				</div>
			</div>
		</div>
    </body>
</html>
