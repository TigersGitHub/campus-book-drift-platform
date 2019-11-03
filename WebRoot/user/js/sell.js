$(function () {
	//默认地址设置校验
	$.ajax({
		url: "../UserCenter.do",
		type: "post",
		data: "act=getdefaultadr",
		success: function (rel) {
			if (rel == "") {
				alert("您尚未设置默认地址，请先设置");
				window.location.href = "myadr.jsp";
			}
		}
	});
	
	//校验并发布
	$("#save").click(function () {
		if (!isbnEnable()) {
			$("#book_isbn").attr("data-content", "ISBN不能为空，请检查");
        	$("#book_isbn").popover("show");
        	$("#book_isbn").focus();
            return false;
		} else if (!typeEnable()) {
			$("#book_type").attr("data-content", "图书分类不能为空，请检查");
			$("#book_type").popover("show");
        	$("#book_type").focus();
            return false;
		} else if (!namechEnable()) {
			$("#book_name_ch").attr("data-content", "中文书名不能为空，请检查");
			$("#book_name_ch").popover("show");
        	$("#book_name_ch").focus();
            return false;
		} else if (!authchEnable()) {
			$("#book_auth_ch").attr("data-content", "中文作者不能为空，请检查");
			$("#book_auth_ch").popover("show");
        	$("#book_auth_ch").focus();
            return false;
		} else if (!pressEnable()) {
			$("#book_press").attr("data-content", "出版社不能为空，请检查");
			$("#book_press").popover("show");
        	$("#book_press").focus();		
            return false;	
		} else if (!pressdateEnable()) {
			$("#book_pressdate").attr("data-content", "出版时间不能为空，请检查");
			$("#book_pressdate").popover("show");
        	$("#book_pressdate").focus();
            return false;			
		} else if (!lanEnable()) {
			$("#book_language").attr("data-content", "正文语种不能为空，请检查");
			$("#book_language").popover("show");
        	$("#book_language").focus();	
            return false;		
		} else if (!fmtEnable()) {
			$("#book_format").attr("data-content", "图书规格不能为空，请检查");
			$("#book_format").popover("show");
        	$("#book_format").focus();
            return false;			
		} else if (!pageEnable()) {
			$("#book_page").attr("data-content", "页数不能为空，请检查");
			$("#book_page").popover("show");
        	$("#book_page").focus();
            return false;			
		} else if (!coverEnable()) {
			$("#book_cover").attr("data-content", "包装方式不能为空，请检查");
			$("#book_cover").popover("show");
        	$("#book_cover").focus();
            return false;		
		} else if (!versionEnable()) {
			$("#book_version").attr("data-content", "版次不能为空，请检查");
			$("#book_version").popover("show");
        	$("#book_version").focus();		
            return false;	
		} else if (!issellEnable()) {
			$("#book_issell").attr("data-content", "上架类型不能为空，请检查");
			$("#book_issell").popover("show");
        	$("#book_issell").focus();		
            return false;	
		} else if (!priceEnable()) {
			$("#book_price").attr("data-content", "定价不能为空，请检查");
			$("#book_price").popover("show");
        	$("#book_price").focus();		
            return false;	
		} else if (!spriceEnable()) {
			$("#book_sellprice").attr("data-content", "售价不能为空，请检查");
			$("#book_sellprice").popover("show");
        	$("#book_sellprice").focus();		
            return false;	
		} else {
			$("#sell-form").submit();
		}
	});
	
	//验证ISBN
	function isbnEnable() {
		var isbn = $("#book_isbn");
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
	$("#book_isbn").blur(function () {
        isbnEnable();
    });
	
	//监听图书分类
	function typeEnable() {
		var type = $("#book_type");
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
	$("#book_type").change(function () {
		typeEnable();
	});
	
	//验证中文书名
	function namechEnable() {
		var namech = $("#book_name_ch");
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
	$("#book_name_ch").blur(function () {
		namechEnable();
    });
	
	//验证中文作者
	function authchEnable() {
		var authch = $("#book_auth_ch");
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
	$("#book_auth_ch").blur(function () {
		authchEnable();
    });
	
	//验证出版社
	function pressEnable() {
		var press = $("#book_press");
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
	$("#book_press").blur(function () {
		pressEnable();
    });
	
	//验证出版时间
	function pressdateEnable() {
		var pressdate = $("#book_pressdate");
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
	$("#book_pressdate").blur(function () {
		pressdateEnable();
    });
	
	//监听正文语种
	function lanEnable() {
		var lan = $("#book_language");
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
	$("#book_language").change(function () {
		lanEnable();
	});
	
	//监听图书规格
	function fmtEnable() {
		var fmt = $("#book_format");
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
	$("#book_format").change(function () {
		fmtEnable();
	});
	
	//验证页数
	function pageEnable() {
		var page = $("#book_page");
		var filter = /^\d{13}$/;
        if (page.val() == "") {
        	page.attr("data-content", "页数不能为空，请检查");
        	page.popover("show");
            return false;
        } else if (!filter.test(page.val())) {
        	page.attr("data-content", "页数必须为数字，请检查");
        	page.popover("show");
            return false;
        } else {
        	page.attr("data-content", "页数输入正确");
        	page.popover("hide");
            return true;
        }
	}
	$("#book_page").blur(function () {
		pageEnable();
    });
	
	//监听包装方式
	function coverEnable() {
		var cover = $("#book_cover");
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
	$("#book_cover").change(function () {
		coverEnable();
	});
	
	//验证版次
	function versionEnable() {
		var ver = $("#book_version");
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
	$("#book_version").blur(function () {
		versionEnable();
    });
		
	//监听上架类型
	function issellEnable() {
		var issell = $("#book_issell");
		var sellprice = $("#book_sellprice");
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
	$("#book_issell").change(function () {
		issellEnable();
	});
	
	//验证定价
	function priceEnable() {
		var price = $("#book_price");
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
	$("#book_price").blur(function () {
		priceEnable();
    });
	
	//验证售价
	function spriceEnable() {
		var price = $("#book_sellprice");
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
	$("#book_sellprice").blur(function () {
		spriceEnable();
    });
	
	//初始化
	//加载图书规格列表
	$.ajax({
		url: "../LoadInfo.do",
        data: "act=bfmt",
        type: "POST",
        success: function (rel) {
        	var bfmt = $("#book_format");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].FMT_ID + "'>" + data[i].FMT_NAME + "</option>";
        		bfmt.append(str);
        	}
        }
	});
	
	//加载图书语种列表
	$.ajax({
		url: "../LoadInfo.do",
        data: "act=blang",
        type: "POST",
        success: function (rel) {
        	var blang = $("#book_language");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].LAN_ID + "'>" + data[i].LAN_NAME + "</option>";
        		blang.append(str);
        	}
        }
	});
	
	//加载图书分类列表
	$.ajax({
		url: "../LoadInfo.do",
        data: "act=btype",
        type: "POST",
        success: function (rel) {
        	var btype = $("#book_type");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].TYP_ID + "'>" + data[i].TYP_NAME + "</option>";
        		btype.append(str);
        	}
        }
	});
	
	//加载左边栏数字
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
