$(function () {
	var currpage = 1;
	var totalpage = 1;
	var bname = "";
	var btype = 0;
	var issell = 0;
	
	//编辑提交
	$("#form-edit-submit").click(function () {
		if (!isbnEnable()) {
			$("#isbn_edit").attr("data-content", "ISBN不能为空，请检查");
        	$("#isbn_edit").popover("show");
        	$("#isbn_edit").focus();
            return false;
		} else if (!typeEnable()) {
			$("#btype_edit").attr("data-content", "图书分类不能为空，请检查");
			$("#btype_edit").popover("show");
        	$("#btype_edit").focus();
            return false;
		} else if (!namechEnable()) {
			$("#bname_ch_edit").attr("data-content", "中文书名不能为空，请检查");
			$("#bname_ch_edit").popover("show");
        	$("#bname_ch_edit").focus();
            return false;
		} else if (!authchEnable()) {
			$("#bauth_ch_edit").attr("data-content", "中文作者不能为空，请检查");
			$("#bauth_ch_edit").popover("show");
        	$("#bauth_ch_edit").focus();
            return false;
		} else if (!pressEnable()) {
			$("#press_edit").attr("data-content", "出版社不能为空，请检查");
			$("#press_edit").popover("show");
        	$("#press_edit").focus();		
            return false;	
		} else if (!pressdateEnable()) {
			$("#pressdate_edit").attr("data-content", "出版时间不能为空，请检查");
			$("#pressdate_edit").popover("show");
        	$("#pressdate_edit").focus();
            return false;			
		} else if (!lanEnable()) {
			$("#blang_edit").attr("data-content", "正文语种不能为空，请检查");
			$("#blang_edit").popover("show");
        	$("#blang_edit").focus();	
            return false;		
		} else if (!fmtEnable()) {
			$("#bfmt_edit").attr("data-content", "图书规格不能为空，请检查");
			$("#bfmt_edit").popover("show");
        	$("#bfmt_edit").focus();
            return false;			
		} else if (!pageEnable()) {
			$("#page_edit").attr("data-content", "页数不能为空，请检查");
			$("#page_edit").popover("show");
        	$("#page_edit").focus();
            return false;			
		} else if (!coverEnable()) {
			$("#cover_edit").attr("data-content", "包装方式不能为空，请检查");
			$("#cover_edit").popover("show");
        	$("#cover_edit").focus();
            return false;		
		} else if (!versionEnable()) {
			$("#version_edit").attr("data-content", "版次不能为空，请检查");
			$("#version_edit").popover("show");
        	$("#version_edit").focus();		
            return false;	
		} else if (!issellEnable()) {
			$("#issell_edit").attr("data-content", "上架类型不能为空，请检查");
			$("#issell_edit").popover("show");
        	$("#issell_edit").focus();		
            return false;	
		} else if (!priceEnable()) {
			$("#bprice_edit").attr("data-content", "定价不能为空，请检查");
			$("#bprice_edit").popover("show");
        	$("#bprice_edit").focus();		
            return false;	
		} else if (!spriceEnable()) {
			$("#bsellprice_edit").attr("data-content", "售价不能为空，请检查");
			$("#bsellprice_edit").popover("show");
        	$("#bsellprice_edit").focus();		
            return false;	
		} else {
			$("#form_edit").submit();
		}
	});
	
	//验证ISBN
	function isbnEnable() {
		var isbn = $("#isbn_edit");
		var filter = /^\d{13}$/;
        if (isbn.val() == "") {
        	isbn.attr("data-content", "ISBN不能为空，请检查");
        	isbn.popover("show");
            return false;
        } else if (!filter.test(isbn.val())) {
        	isbn.attr("data-content", "ISBN必须为13位数字，请检查");
        	isbn.popover("show");
            return false;
        } else {
        	isbn.attr("data-content", "ISBN输入正确");
        	isbn.popover("hide");
            return true;
        }
	}
	$("#isbn_edit").blur(function () {
        isbnEnable();
    });
	
	//监听图书分类
	function typeEnable() {
		var type = $("#btype_edit");
		if (type.val() == "0") {
			type.attr("data-content", "图书分类不能为空，请检查");
			type.popover("show");
            return false;
        } else {
        	type.attr("data-content", "图书分类选择正确");
        	type.popover("hide");
            return true;
        }
	}
	$("#btype_edit").change(function () {
		typeEnable();
	});
	
	//验证中文书名
	function namechEnable() {
		var namech = $("#bname_ch_edit");
        if (namech.val() == "") {
        	namech.attr("data-content", "中文书名不能为空，请检查");
        	namech.popover("show");
            return false;
        } else {
        	namech.attr("data-content", "中文书名输入正确");
        	namech.popover("hide");
            return true;
        }
	}
	$("#bname_ch_edit").blur(function () {
		namechEnable();
    });
	
	//验证中文作者
	function authchEnable() {
		var authch = $("#bauth_ch_edit");
        if (authch.val() == "") {
        	authch.attr("data-content", "中文作者不能为空，请检查");
        	authch.popover("show");
            return false;
        } else {
        	authch.attr("data-content", "中文作者输入正确");
        	authch.popover("hide");
            return true;
        }
	}
	$("#bauth_ch_edit").blur(function () {
		authchEnable();
    });
	
	//验证出版社
	function pressEnable() {
		var press = $("#press_edit");
        if (press.val() == "") {
        	press.attr("data-content", "出版社不能为空，请检查");
        	press.popover("show");
            return false;
        } else {
        	press.attr("data-content", "出版社输入正确");
        	press.popover("hide");
            return true;
        }
	}
	$("#press_edit").blur(function () {
		pressEnable();
    });
	
	//验证出版时间
	function pressdateEnable() {
		var pressdate = $("#pressdate_edit");
        if (pressdate.val() == "") {
        	pressdate.attr("data-content", "出版时间不能为空，请检查");
        	pressdate.popover("show");
            return false;
        } else {
        	pressdate.attr("data-content", "出版时间输入正确");
        	pressdate.popover("hide");
            return true;
        }
	}
	$("#pressdate_edit").blur(function () {
		pressdateEnable();
    });
	
	//监听正文语种
	function lanEnable() {
		var lan = $("#blang_edit");
		if (lan.val() == "0") {
			lan.attr("data-content", "正文语种不能为空，请检查");
			lan.popover("show");
            return false;
        } else {
        	lan.attr("data-content", "正文语种选择正确");
        	lan.popover("hide");
            return true;
        }
	}
	$("#blang_edit").change(function () {
		lanEnable();
	});
	
	//监听图书规格
	function fmtEnable() {
		var fmt = $("#bfmt_edit");
		if (fmt.val() == "0") {
			fmt.attr("data-content", "图书规格不能为空，请检查");
			fmt.popover("show");
            return false;
        } else {
        	fmt.attr("data-content", "图书规格选择正确");
        	fmt.popover("hide");
            return true;
        }
	}
	$("#bfmt_edit").change(function () {
		fmtEnable();
	});
	
	//验证页数
	function pageEnable() {
		var page = $("#page_edit");
        if (page.val() == "") {
        	page.attr("data-content", "页数不能为空，请检查");
        	page.popover("show");
            return false;
        } else {
        	page.attr("data-content", "页数输入正确");
        	page.popover("hide");
            return true;
        }
	}
	$("#page_edit").blur(function () {
		pageEnable();
    });
	
	//监听包装方式
	function coverEnable() {
		var cover = $("#cover_edit");
		if (cover.val() == "0") {
			cover.attr("data-content", "包装方式不能为空，请检查");
			cover.popover("show");
            return false;
        } else {
        	cover.attr("data-content", "包装方式选择正确");
        	cover.popover("hide");
            return true;
        }
	}
	$("#cover_edit").change(function () {
		coverEnable();
	});
	
	//验证版次
	function versionEnable() {
		var ver = $("#version_edit");
        if (ver.val() == "") {
        	ver.attr("data-content", "版次不能为空，请检查");
        	ver.popover("show");
            return false;
        } else {
        	ver.attr("data-content", "版次输入正确");
        	ver.popover("hide");
            return true;
        }
	}
	$("#version_edit").blur(function () {
		versionEnable();
    });
		
	//监听上架类型
	function issellEnable() {
		var issell = $("#issell_edit");
		var sellprice = $("#bsellprice_edit");
		if (issell.val() == "N") {
			sellprice.attr("readonly", "readonly");
			sellprice.val("0.00");
			sellprice.attr("data-content", "感谢您选择“图书漂流”这一绿色传递方式，售价已帮您设置为0元~");
			sellprice.popover("show");
        	issell.attr("data-content", "上架类型选择正确");
        	issell.popover("hide");
            return true;
		} else if (issell.val() == "0") {
			sellprice.removeAttr("readonly", "readonly");
			sellprice.removeAttr("data-content");
			sellprice.popover("hide");
			issell.attr("data-content", "上架类型不能为空，请检查");
			issell.popover("show");
            return false;
		} else {
			sellprice.removeAttr("readonly", "readonly");
			sellprice.removeAttr("data-content");
			sellprice.popover("hide");
        	issell.attr("data-content", "上架类型选择正确");
        	issell.popover("hide");
            return true;
        }
	}
	$("#issell_edit").change(function () {
		issellEnable();
	});
	
	//验证定价
	function priceEnable() {
		var price = $("#bprice_edit");
        if (price.val() == "") {
        	price.attr("data-content", "定价不能为空，请检查");
        	price.popover("show");
            return false;
        } else {
        	price.attr("data-content", "定价输入正确");
        	price.popover("hide");
            return true;
        }
	}
	$("#bprice_edit").blur(function () {
		priceEnable();
    });
	
	//验证售价
	function spriceEnable() {
		var price = $("#bsellprice_edit");
        if (price.val() == "") {
        	price.attr("data-content", "售价不能为空，请检查");
        	price.popover("show");
            return false;
        } else {
        	price.attr("data-content", "售价输入正确");
        	price.popover("hide");
            return true;
        }
	}
	$("#bsellprice_edit").blur(function () {
		spriceEnable();
    });

	//金额格式化
	function priceformat(price) {
		return parseFloat(price).toFixed(2);
	}
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		if (data.length > 0) {
			var str = "";
			$("#mybook-list").html(str);
			for (var i = 0; i < data.length; i++) {
				str = "<div class='card card-block col-md-6'><img src='../" +
        				((data[i].BOOK_IMAGE != null)?data[i].BOOK_IMAGE:"images/defbook.jpg") + "' /><h4 class='card-title'><span id='book-name'>" +
						data[i].BOOK_NAME_CH + ((data[i].BOOK_NAME_LEN > 6)?"...":"") + "</span><span id='book-sellprice' " +
						"class='text-danger pull-right'>" + ((data[i].BOOK_ISSELL == "Y")
						?("¥" + priceformat(data[i].BOOK_SELLPRICE)):"漂流") + "</span></h4>" +
						"<p class='card-text'>" + data[i].BOOK_DETAIL + ((data[i].BOOK_DETAIL_LEN > 46)?"...":"") + "</p>" +
						((data[i].BOOK_ISEXIST == 'Y')
						?("<button type='button' class='btn btn-success' data-id='" + data[i].BOOK_ID + 
						"'data-toggle='modal' data-target='#edit-dialog' onclick='editload(this)'>编辑</button>&nbsp;&nbsp;" +
						"<button type='button' class='btn btn-danger' data-toggle='modal' data-target='#del-dialog' " +
						"data-id='" + data[i].BOOK_ID + "' onclick='delload(this)'>删除</button>")
						:("<button type='button' class='btn btn-secondary' disabled='disabled'>已售出</button>")) + "</div>";
				$("#mybook-list").append(str);
			}
		} else {
			var str = "<h3>没有找到符合条件的图书(⊙o⊙)~</h3>";
			$("#mybook-list").html(str);
		}
	}
	
	//加载列表
	function load() {
		$.ajax({
			url: "../UserCenter.do",
			data: "act=loadmybook&bname=" + bname + "&btype=" + btype + "&issell=" + issell + "&page=" + currpage,
			type: "post",
			success: function (rel) {
				loadcontent(rel);
			}
		});
		loadPageControl();
	}	
	
	//搜索
	$("#search").click(function () {
		currpage = 1;
		bname = $.trim($("#sname").val());
		issell = $("#sissell").val();
		btype = $("#stype").val();
		load();
	});
    
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../UserCenter.do",
	        data: "act=mybooktotalpage&bname=" + bname + "&btype=" + btype + "&issell=" + issell,
	        type: "POST",
	        success: function (rel) {
	        	//加载页码
	        	var total = parseInt(rel);
	        	if (total == 0) {
	        		currpage = total;
	        	}
	        	totalpage = total;
	        	$("#curr-page").html(currpage);
	        	$("#total-page").html(totalpage);
	        	
	        	//是否只有一页
	    		if (currpage == totalpage) {
	    			$("#next-page").attr("disabled", "disabled");
	    		} else {
	    			$("#next-page").removeAttr("disabled");
	    		}
	        }
		});
	}
	
	//向前翻页
	$("#previous-page").click(function () {
		//列表内容加载
		if (currpage > 1) {
			currpage--;
			load();
			$("#previous-page").removeAttr("disabled");
			$("#next-page").removeAttr("disabled");
		}
		
		//是否为第一页
		if (currpage == 1) {
			$("#previous-page").attr("disabled", "disabled");
		}
		
		//加载页码
    	$("#curr-page").html(currpage);
    	$("#total-page").html(totalpage);
	});
	
	//向后翻页
	$("#next-page").click(function () {
		//列表内容加载
		if (currpage < totalpage) {
			currpage++;
			load();
			$("#previous-page").removeAttr("disabled");
			$("#next-page").removeAttr("disabled");
		}
		
		//是否为最后一页
		if (currpage == totalpage) {
			$("#next-page").attr("disabled", "disabled");
		}
		
		//加载页码
    	$("#curr-page").html(currpage);
    	$("#total-page").html(totalpage);
	});

	//初始化
	bname = $.trim($("#sname").val());
	btype = $("#stype").val();
	issell = $("#sissell").val();
	load();
	$.ajax({
		url: "../LoadInfo.do",
        data: "act=btype",
        type: "POST",
        success: function (rel) {
        	var btype = $("#stype");
        	var btype_edit = $("#btype_edit");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].TYP_ID + "'>" + data[i].TYP_NAME + "</option>";
        		btype.append(str);
        		btype_edit.append(str);
        	}
        }
	});
	$.ajax({
		url: "../LoadInfo.do",
        data: "act=bfmt",
        type: "POST",
        success: function (rel) {
        	var bfmt = $("#bfmt_edit");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].FMT_ID + "'>" + data[i].FMT_NAME + "</option>";
        		bfmt.append(str);
        	}
        }
	});
	$.ajax({
		url: "../LoadInfo.do",
        data: "act=blang",
        type: "POST",
        success: function (rel) {
        	var blang = $("#blang_edit");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].LAN_ID + "'>" + data[i].LAN_NAME + "</option>";
        		blang.append(str);
        	}
        }
	});
	$.ajax({
		url: "../UserCenter.do",
		data: "act=countuser",
		type: "POST",
		success: function (rel) {
			var data = eval(rel);
			for (var i = 0; i < data.length; i++) {
				if (data[i].STATUS == 'ALL') {
					$("#allorder-num").text(data[i].ORDCOUNT);
				} else if (data[i].STATUS == 'CURRENT') {
					$("#currorder-num").text(data[i].ORDCOUNT);
				} else if (data[i].STATUS == 'FAVORITE') {
					$("#fav-num").text(data[i].ORDCOUNT);
				}
			}
		}
	});
	
});
