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
		
        <title>推荐图书管理 - 书角 SHUJIAO</title>
        <link href="../css/mgrpublic.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	#reupload-dialog .modal-content {
        		box-shadow: 3px 3px 3px #aaa;
        	}
        </style>
        <script type="text/javascript" src="js/recommend.js"></script>
        <script type="text/javascript">
        	function priceformat(price) {
        		return parseFloat(price).toFixed(2);
        	}
        
	    	function editload(obj) {
	    		var id = $(obj).attr("data-id");
	    		$("#reupload-recid").val(id);
	    		$("#recid_edit").val(id);
	    		$.ajax({
		    		url: "../../BookCommon.do",
		    		type: "post",
		    		data: "act=recdetail&recid=" + id,
		    		success: function (rel) {
		    			var data = eval(rel);
		    			$("#isbn_edit").val(data[0].REC_ISBN);
		    			$("#btype_edit").val(data[0].REC_TYPE);
		    			$("#bname_ch_edit").val(data[0].REC_NAME_CH);
		    			$("#bname_en_edit").val(data[0].REC_NAME_EN);
		    			$("#bauth_ch_edit").val(data[0].REC_AUTHOR_CH);
		    			$("#bauth_en_edit").val(data[0].REC_AUTHOR_EN);
		    			$("#press_edit").val(data[0].REC_PRESS);
		    			$("#blang_edit").val(data[0].REC_LANGUAGE);
		    			$("#bimage_edit").val(data[0].REC_IMAGE);
		    			$("#bprice_edit").val(priceformat(data[0].REC_PRICE));
		    			$("#bsellprice_edit").val(priceformat(data[0].REC_SELLPRICE));
		    			$("#bcorp_edit").val(data[0].REC_CORPID);
		    			$("#burl_edit").val(data[0].REC_URL);
		    			$("#spprice_edit").val(priceformat(data[0].REC_SPPRICE));
		    			$("#paybal_edit").val(data[0].REC_PAYBALANCE);
	    				$("#bnote_edit").val(data[0].REC_NOTE);
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
						<h4 class="modal-title">添加推荐图书</h4>
					</div>
					<div class="modal-body">
						<form id="form-add" class="form-inline" action="<%=path %>/BookCommon.do?act=addrec" method="post">
							<label for="isbn">ＩＳＢＮ</label>
							<input id="isbn" name="isbn" type="text" class="form-control" placeholder="* ISBN" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="btype">图书类别</label>
							<select id="btype" name="btype" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="bname_ch">中文全名</label>
							<input id="bname_ch" name="bname_ch" type="text" class="form-control" placeholder="* 中文全名" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bname_en">英文全名</label>
							<input id="bname_en" name="bname_en" type="text" class="form-control" placeholder="英文全名" />
							<label for="bauth_ch">中文作者</label>
							<input id="bauth_ch" name="bauth_ch" type="text" class="form-control" placeholder="* 中文作者" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bauth_en">英文作者</label>
							<input id="bauth_en" name="bauth_en" type="text" class="form-control" placeholder="英文作者" />
							<label for="press">　出版社</label>
							<input id="press" name="press" type="text" class="form-control" placeholder="出版社" />
							<label for="blang">正文语种</label>
							<select id="blang" name="blang" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="bimage">封面图片</label>
							<input id="bimage" name="bimage" type="file" accept="image/*" class="form-control" />
							<label for="bprice">定价／元</label>
							<input id="bprice" name="bprice" type="number" step="0.01" class="form-control" placeholder="* 定价/元" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
							<label for="bsellprice">售价／元</label>
							<input id="bsellprice" name="bsellprice" type="number" step="0.01" class="form-control" placeholder="* 售价/元" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
							<label for="bcorp">合作厂商</label>
							<select id="bcorp" name="bcorp" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="burl">购买链接</label>
							<input id="burl" name="burl" type="text" class="form-control" placeholder="* 购买链接" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
							<label for="spprice">推广单价</label>
							<input id="spprice" name="spprice" type="number" step="0.01" class="form-control" placeholder="* 推广单价" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
							<label for="paybal">结算单位</label>
							<input id="paybal" name="paybal" type="number" class="form-control" placeholder="* 结算单位" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
							<label for="bnote">　　备注</label>
							<input id="bnote" name="bnote" type="text" class="form-control" placeholder="备注" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="save" type="button" class="btn btn-success">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
				
    	<div class="modal fade" id="edit-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">编辑推荐图书</h4>
					</div>
					<div class="modal-body">
						<form id="form_edit" class="form-inline" action="<%=path %>/BookCommon.do?act=editrec" method="post">
							<input type="hidden" id="recid_edit" name="recid_edit" />
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
							<input id="press_edit" name="press_edit" type="text" class="form-control" placeholder="出版社" />
							<label for="blang_edit">正文语种</label>
							<select id="blang_edit" name="blang_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="bimage_edit">封面图片</label>
							<input id="bimage_edit" name="bimage_edit" type="text" class="form-control" disabled="disabled" />
							<button type="button" id="bimage_reupload" class="btn btn-primary" data-toggle="modal" 
								data-target="#reupload-dialog">修改</button>
							<label for="bprice_edit">定价／元</label>
							<input id="bprice_edit" name="bprice_edit" type="number" step="0.01" class="form-control" placeholder="* 定价/元" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bsellprice_edit">售价／元</label>
							<input id="bsellprice_edit" name="bsellprice_edit" type="number" step="0.01" class="form-control" placeholder="* 售价/元" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bcorp_edit">合作厂商</label>
							<select id="bcorp_edit" name="bcorp_edit" class="form-control form-inline-dropdown"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="">
								<option value="0">* 请选择</option>
							</select>
							<label for="burl_edit">购买链接</label>
							<input id="burl_edit" name="burl_edit" type="text" class="form-control" placeholder="* 购买链接" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="spprice_edit">推广单价</label>
							<input id="spprice_edit" name="spprice_edit" type="number" step="0.01" class="form-control" placeholder="* 推广单价"
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="paybal_edit">结算单位</label>
							<input id="paybal_edit" name="paybal_edit" type="number" class="form-control" placeholder="* 结算单位" 
	                    		data-container="body" data-toggle="popover" data-placement="top" data-content="" />
							<label for="bnote_edit">　　备注</label>
							<input id="bnote_edit" name="bnote_edit" type="text" class="form-control" placeholder="备注" />
						</form>
					</div>
					<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="form-edit-submit" type="button" class="btn btn-success">保存</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    
    	<div class="modal fade" id="reupload-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">修改图片</h4>
					</div>
					<div class="modal-body">
						<form action="" method="post">
							<input type="hidden" id="reupload-recid" />
							<input type="file" />
						</form>
					</div>
					<div class="modal-footer modal-footer-sm">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        				<button id="reupload-submit" type="button" class="btn btn-success">保存</button>
					</div>
				</div>
			</div>
		</div>
    
    	<div class="card list-tool">
			<div class="card-block">
				<button type="button" class="btn btn-success" data-toggle="modal" data-target="#add-dialog">+&nbsp;添加图书</button>
				<button type="button" class="btn btn-info" onclick="window.location.reload();">⇓&nbsp;显示全部</button>
				<form class="form-inline pull-right">
					<select id="stype" name="stype" class="form-control">
		       			<option value="0">全部分类</option>
					</select>
					<select id="scorp" name="scorp" class="form-control" style="width: 148px;">
		       			<option value="0">全部合作商</option>
					</select>
					<input class="form-control" type="text" id="sisbn" name="sisbn" placeholder="全部或部分ISBN编码..." />
					<input class="form-control" type="text" id="sname" name="sname" placeholder="全部或部分中文书名..." />
		    		<button type="button" id="search" class="btn btn-primary" type="button">查询</button>			    	
				</form>
			</div>
		</div>
    
		<div class="card list-content">
			<div class="card-block">
				<div class="alert alert-info alert-dismissible fade in" role="alert">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<strong>什么是可计收入？</strong>可计收入是指可以通过点击量计算的收入，客户点击链接后购买产生的分成为不可计收入，只能由合作商进行统计
				</div>
				
				<table class="table table-hover table-striped overhid">
					<thead class="thead-default">
						<tr>
							<th width="18%">ISBN</th>
							<th width="10%">类别</th>
							<th width="14%">中文书名</th>
							<th width="10%">中文作者</th>
							<th width="12%">合作商</th>
							<th width="10%">点击量</th>
							<th width="10%">可计收入</th>
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
