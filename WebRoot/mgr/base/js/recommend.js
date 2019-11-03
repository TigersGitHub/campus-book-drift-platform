$(function () {
	var currpage = 1;
	var totalpage = 1;
	var type = 0;
	var corp = 0;
	var isbn = "";
	var bname = "";
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		$("#emplist").html(str);
		for (var i = 0; i < data.length; i++) {
			str = "<tr><th scope='row'>" + data[i].REC_ISBN + "</th><td>" + data[i].REC_TYPE + "</td><td>" + data[i].REC_NAME_CH + 
					"</td><td>" + data[i].REC_AUTHOR_CH + "</td><td>" + data[i].REC_CORPNAME + "</td><td>" + data[i].REC_CLICK +
					"</td><td>¥" + data[i].REC_TOTALPRICE + "</td><td class='col-control'><button class='btn btn-info' " +
					"data-toggle='modal' data-target='#edit-dialog' data-id='" + data[i].REC_ID + "' onclick='editload(this);'>" +
					"编辑</button>" + ((data[i].REC_ENABLE == "T")
					?"<a href='../../BookCommon.do?act=disable&recid=" + data[i].REC_ID + "' class='btn btn-danger'>禁用</a>"
					:"<a href='../../BookCommon.do?act=enable&recid=" + data[i].REC_ID + "' class='btn btn-success'>启用</a>") +
					"</td></tr>";
			$("#emplist").append(str);
		}
	}
	
	//加载列表	
	function load() {
		$.ajax({
			url: "../../BookCommon.do",
			data: "act=loadrec&page=" + currpage + "&type=" + type + "&corp=" + corp + "&isbn=" + isbn + "&bname=" + bname,
			type: "post",
			success: function (rel) {
				loadcontent(rel);
			}
		});
		loadPageControl();
	}	
	
	//验证ISBN
	function isbnEnable() {
		var isbn = $("#isbn");
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
	$("#isbn").blur(function () {
        isbnEnable();
    });
	
	//验证ISBN
	function isbnEnable_edit() {
		var isbn = $("#isbn_edit");
		var filter = /^\d{13}$/;	//13位数字
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
		isbnEnable_edit();
    });	
	
	//验证图书类别
	function btypeEnable() {
		var btype = $("#btype");
        if (btype.val() == "0") {
        	btype.attr("data-content", "图书类别必须选择，请检查");
        	btype.popover("show");
            return false;
        } else {
        	btype.attr("data-content", "图书类别选择正确");
        	btype.popover("hide");
            return true;
        }
	}
	$("#btype").blur(function () {
		btypeEnable();
    });
	
	//验证图书类别
	function btypeEnable_edit() {
		var btype = $("#btype_edit");
        if (btype.val() == "0") {
        	btype.attr("data-content", "图书类别必须选择，请检查");
        	btype.popover("show");
            return false;
        } else {
        	btype.attr("data-content", "图书类别选择正确");
        	btype.popover("hide");
            return true;
        }
	}
	$("#btype_edit").blur(function () {
		btypeEnable_edit();
    });
	
	//验证书名
	function bnameEnable_edit() {
		var bname_ch = $("#bname_ch_edit");
        if (bname_ch.val() == "") {
        	bname_ch.attr("data-content", "中文书名不能为空，请检查");
        	bname_ch.popover("show");
            return false;
        } else {
        	bname_ch.attr("data-content", "中文书名填写正确");
        	bname_ch.popover("hide");
            return true;
        }
	}
	$("#bname_ch_edit").blur(function () {
		bnameEnable_edit();
    });
	
	//验证书名
	function bnameEnable() {
		var bname_ch = $("#bname_ch");
        if (bname_ch.val() == "") {
        	bname_ch.attr("data-content", "中文书名不能为空，请检查");
        	bname_ch.popover("show");
            return false;
        } else {
        	bname_ch.attr("data-content", "中文书名填写正确");
        	bname_ch.popover("hide");
            return true;
        }
	}
	$("#bname_ch").blur(function () {
		bnameEnable();
    });
	
	//验证作者
	function bauthEnable_edit() {
		var bauth_ch = $("#bauth_ch_edit");
        if (bauth_ch.val() == "") {
        	bauth_ch.attr("data-content", "中文作者不能为空，请检查");
        	bauth_ch.popover("show");
            return false;
        } else {
        	bauth_ch.attr("data-content", "中文作者填写正确");
        	bauth_ch.popover("hide");
            return true;
        }
	}
	$("#bauth_ch_edit").blur(function () {
		bauthEnable_edit();
    });
	
	//验证作者
	function bauthEnable() {
		var bauth_ch = $("#bauth_ch");
        if (bauth_ch.val() == "") {
        	bauth_ch.attr("data-content", "中文作者不能为空，请检查");
        	bauth_ch.popover("show");
            return false;
        } else {
        	bauth_ch.attr("data-content", "中文作者填写正确");
        	bauth_ch.popover("hide");
            return true;
        }
	}
	$("#bauth_ch").blur(function () {
		bauthEnable();
    });
	
	//验证图书语种
	function blangEnable_edit() {
		var blang = $("#blang_edit");
        if (blang.val() == "0") {
        	blang.attr("data-content", "图书语种必须选择，请检查");
        	blang.popover("show");
            return false;
        } else {
        	blang.attr("data-content", "图书语种选择正确");
        	blang.popover("hide");
            return true;
        }
	}
	$("#blang_edit").blur(function () {
		blangEnable_edit();
    });
	
	//验证图书语种
	function blangEnable() {
		var blang = $("#blang");
        if (blang.val() == "0") {
        	blang.attr("data-content", "图书语种必须选择，请检查");
        	blang.popover("show");
            return false;
        } else {
        	blang.attr("data-content", "图书语种选择正确");
        	blang.popover("hide");
            return true;
        }
	}
	$("#blang").blur(function () {
		blangEnable();
    });
	
	//验证定价
	function bpriceEnable_edit() {
		var bprice = $("#bprice_edit");
        if (bprice.val() == "") {
        	bprice.attr("data-content", "定价不能为空，请检查");
        	bprice.popover("show");
            return false;
        } else {
        	bprice.attr("data-content", "定价填写正确");
        	bprice.popover("hide");
            return true;
        }
	}
	$("#bprice_edit").blur(function () {
		bpriceEnable_edit();
    });
	
	//验证定价
	function bpriceEnable() {
		var bprice = $("#bprice");
        if (bprice.val() == "") {
        	bprice.attr("data-content", "定价不能为空，请检查");
        	bprice.popover("show");
            return false;
        } else {
        	bprice.attr("data-content", "定价填写正确");
        	bprice.popover("hide");
            return true;
        }
	}
	$("#bprice").blur(function () {
		bpriceEnable();
    });
	
	//验证售价
	function bsellpriceEnable_edit() {
		var bsellprice = $("#bsellprice_edit");
        if (bsellprice.val() == "") {
        	bsellprice.attr("data-content", "售价不能为空，请检查");
        	bsellprice.popover("show");
            return false;
        } else {
        	bsellprice.attr("data-content", "售价填写正确");
        	bsellprice.popover("hide");
            return true;
        }
	}
	$("#bsellprice_edit").blur(function () {
		bsellpriceEnable_edit();
    });
	
	//验证售价
	function bsellpriceEnable() {
		var bsellprice = $("#bsellprice");
        if (bsellprice.val() == "") {
        	bsellprice.attr("data-content", "售价不能为空，请检查");
        	bsellprice.popover("show");
            return false;
        } else {
        	bsellprice.attr("data-content", "售价填写正确");
        	bsellprice.popover("hide");
            return true;
        }
	}
	$("#bsellprice").blur(function () {
		bsellpriceEnable();
    });
	
	//验证合作厂商
	function bcorpEnable() {
		var bcorp = $("#bcorp");
        if (bcorp.val() == "0") {
        	bcorp.attr("data-content", "合作厂商必须选择，请检查");
        	bcorp.popover("show");
            return false;
        } else {
        	bcorp.attr("data-content", "合作厂商选择正确");
        	bcorp.popover("hide");
            return true;
        }
	}
	$("#bcorp").blur(function () {
		bcorpEnable();
    });
	
	//验证合作厂商
	function bcorpEnable_edit() {
		var bcorp = $("#bcorp_edit");
        if (bcorp.val() == "0") {
        	bcorp.attr("data-content", "合作厂商必须选择，请检查");
        	bcorp.popover("show");
            return false;
        } else {
        	bcorp.attr("data-content", "合作厂商选择正确");
        	bcorp.popover("hide");
            return true;
        }
	}
	$("#bcorp_edit").blur(function () {
		bcorpEnable_edit();
    });
	
	//验证购买链接
	function burlEnable() {
		var burl = $("#burl");
        if (burl.val() == "") {
        	burl.attr("data-content", "购买链接不能为空，请检查");
        	burl.popover("show");
            return false;
        } else {
        	burl.attr("data-content", "购买链接填写正确");
        	burl.popover("hide");
            return true;
        }
	}
	$("#burl").blur(function () {
		burlEnable();
    });
	
	//验证购买链接
	function burlEnable_edit() {
		var burl = $("#burl_edit");
        if (burl.val() == "") {
        	burl.attr("data-content", "购买链接不能为空，请检查");
        	burl.popover("show");
            return false;
        } else {
        	burl.attr("data-content", "购买链接填写正确");
        	burl.popover("hide");
            return true;
        }
	}
	$("#burl_edit").blur(function () {
		burlEnable_edit();
    });
	
	//验证推广单价
	function sppriceEnable() {
		var spprice = $("#spprice");
        if (spprice.val() == "") {
        	spprice.attr("data-content", "推广单价不能为空，请检查");
        	spprice.popover("show");
            return false;
        } else {
        	spprice.attr("data-content", "推广单价填写正确");
        	spprice.popover("hide");
            return true;
        }
	}
	$("#spprice").blur(function () {
		sppriceEnable();
    });
	
	//验证推广单价
	function sppriceEnable_edit() {
		var spprice = $("#spprice_edit");
        if (spprice.val() == "") {
        	spprice.attr("data-content", "推广单价不能为空，请检查");
        	spprice.popover("show");
            return false;
        } else {
        	spprice.attr("data-content", "推广单价填写正确");
        	spprice.popover("hide");
            return true;
        }
	}
	$("#spprice_edit").blur(function () {
		sppriceEnable_edit();
    });
	
	//验证结算单位
	function paybalEnable() {
		var paybal = $("#paybal");
        if (paybal.val() == "") {
        	paybal.attr("data-content", "结算单位不能为空，请检查");
        	paybal.popover("show");
            return false;
        } else {
        	paybal.attr("data-content", "结算单位填写正确");
        	paybal.popover("hide");
            return true;
        }
	}
	$("#paybal").blur(function () {
		paybalEnable();
    });
	
	//验证结算单位
	function paybalEnable_edit() {
		var paybal = $("#paybal_edit");
        if (paybal.val() == "") {
        	paybal.attr("data-content", "结算单位不能为空，请检查");
        	paybal.popover("show");
            return false;
        } else {
        	paybal.attr("data-content", "结算单位填写正确");
        	paybal.popover("hide");
            return true;
        }
	}
	$("#paybal_edit").blur(function () {
		paybalEnable_edit();
    });
	
	//新增
	$("#save").click(function () {
		if (!isbnEnable()) {
			$("#isbn").attr("data-content", "ISBN不能为空，请检查");
			$("#isbn").popover("show");
			$("#isbn").focus();
			return false;
		} else if (!btypeEnable()) {
        	$("#btype").attr("data-content", "图书类别必须选择，请检查");
        	$("#btype").popover("show");
        	$("#btype").focus();
            return false;
		} else if (!bnameEnable()) {
        	$("#bname_ch").attr("data-content", "书名不能为空，请检查");
        	$("#bname_ch").popover("show");
        	$("#bname_ch").focus();
            return false;			
		} else if (!bauthEnable()) {
        	$("#bauth_ch").attr("data-content", "作者不能为空，请检查");
        	$("#bauth_ch").popover("show");
        	$("#bauth_ch").focus();
            return false;
		} else if (!blangEnable()) {
        	$("#blang").attr("data-content", "图书语种必须选择，请检查");
        	$("#blang").popover("show");
        	$("#blang").focus();
            return false;			
		} else if (!bpriceEnable()) {
        	$("#bprice").attr("data-content", "定价不能为空，请检查");
        	$("#bprice").popover("show");
        	$("#bprice").focus();
            return false;
		} else if (!bsellpriceEnable()) {
			$("#bsellprice").attr("data-content", "售价不能为空，请检查");
        	$("#bsellprice").popover("show");
        	$("#bsellprice").focus();
            return false;
		} else if (!bcorpEnable()) {
			$("#bcorp").attr("data-content", "合作商必须选择，请检查");
        	$("#bcorp").popover("show");
        	$("#bcorp").focus();
            return false;
		} else if (!burlEnable()) {
			$("#burl").attr("data-content", "购买链接不能为空，请检查");
        	$("#burl").popover("show");
        	$("#burl").focus();
            return false;
		} else if (!sppriceEnable()) {
			$("#spprice").attr("data-content", "推广单价不能为空，请检查");
        	$("#spprice").popover("show");
        	$("#spprice").focus();
            return false;
		} else if (!paybalEnable()) {
			$("#paybal").attr("data-content", "结算单位不能为空，请检查");
			$("#paybal").popover("show");
			$("#paybal").focus();
            return false;
		} else {
			$("#form-add").submit();
		}
	});
	
	//编辑提交
	$("#form-edit-submit").click(function () {
		if (!isbnEnable_edit()) {
			$("#isbn_edit").attr("data-content", "ISBN不能为空，请检查");
			$("#isbn_edit").popover("show");
			$("#isbn_edit").focus();
			return false;
		} else if (!btypeEnable_edit()) {
        	$("#btype_edit").attr("data-content", "图书类别必须选择，请检查");
        	$("#btype_edit").popover("show");
        	$("#btype_edit").focus();
            return false;
		} else if (!bnameEnable_edit()) {
        	$("#bname_ch_edit").attr("data-content", "书名不能为空，请检查");
        	$("#bname_ch_edit").popover("show");
        	$("#bname_ch_edit").focus();
            return false;			
		} else if (!bauthEnable_edit()) {
        	$("#bauth_ch_edit").attr("data-content", "作者不能为空，请检查");
        	$("#bauth_ch_edit").popover("show");
        	$("#bauth_ch_edit").focus();
            return false;
		} else if (!blangEnable_edit()) {
        	$("#blang_edit").attr("data-content", "图书语种必须选择，请检查");
        	$("#blang_edit").popover("show");
        	$("#blang_edit").focus();
            return false;			
		} else if (!bpriceEnable_edit()) {
        	$("#bprice_edit").attr("data-content", "定价不能为空，请检查");
        	$("#bprice_edit").popover("show");
        	$("#bprice_edit").focus();
            return false;
		} else if (!bsellpriceEnable_edit()) {
			$("#bsellprice_edit").attr("data-content", "售价不能为空，请检查");
        	$("#bsellprice_edit").popover("show");
        	$("#bsellprice_edit").focus();
            return false;
		} else if (!bcorpEnable_edit()) {
			$("#bcorp_edit").attr("data-content", "合作商必须选择，请检查");
        	$("#bcorp_edit").popover("show");
        	$("#bcorp_edit").focus();
            return false;
		} else if (!burlEnable_edit()) {
			$("#burl_edit").attr("data-content", "购买链接不能为空，请检查");
        	$("#burl_edit").popover("show");
        	$("#burl_edit").focus();
            return false;
		} else if (!sppriceEnable_edit()) {
			$("#spprice_edit").attr("data-content", "推广单价不能为空，请检查");
        	$("#spprice_edit").popover("show");
        	$("#spprice_edit").focus();
            return false;
		} else if (!paybalEnable_edit()) {
			$("#paybal_edit").attr("data-content", "结算单位不能为空，请检查");
			$("#paybal_edit").popover("show");
			$("#paybal_edit").focus();
            return false;
		} else {
			$("#form_edit").submit();
		}
	});
	
	//搜索
	$("#search").click(function () {
		currpage = 1;
		bname = $.trim($("#sname").val());
		isbn = $.trim($("#sisbn").val());
		corp = $("#scorp").val();
		type = $("#stype").val();
		load();		
	});
    
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../../BookCommon.do",
	        data: "act=rectotalpage&page=" + currpage + "&type=" + type + "&corp=" + corp + "&isbn=" + isbn + "&bname=" + bname,
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
	load();
	$.ajax({
		url: "../../LoadInfo.do",
        data: "act=btype",
        type: "POST",
        success: function (rel) {
        	var stype = $("#stype");
        	var btype = $("#btype");
        	var btype_edit = $("#btype_edit");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {        		
        		str = "<option value='" + data[i].TYP_ID + "'>" + data[i].TYP_NAME + "</option>";
        		stype.append(str);
        		btype.append(str);
        		btype_edit.append(str);
        	}
        }
	});
	$.ajax({
		url: "../../LoadInfo.do",
        data: "act=corp",
        type: "POST",
        success: function (rel) {
        	var scorp = $("#scorp");
        	var bcorp = $("#bcorp");
        	var bcorp_edit = $("#bcorp_edit");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {
        		str = "<option value='" + data[i].CORP_ID + "'>" + data[i].CORP_NAME + "</option>";
        		scorp.append(str);
        		bcorp.append(str);
        		bcorp_edit.append(str);
        	}
        }
	});
	$.ajax({
		url: "../../LoadInfo.do",
        data: "act=blang",
        type: "POST",
        success: function (rel) {
        	var blang = $("#blang");
        	var blang_edit = $("#blang_edit");
        	var data = eval(rel);
        	var str = "";
        	for (var i = 0; i < data.length; i++) {
        		str = "<option value='" + data[i].LAN_ID + "'>" + data[i].LAN_NAME + "</option>";
        		blang.append(str);
        		blang_edit.append(str);
        	}
        }
	});
	
});
