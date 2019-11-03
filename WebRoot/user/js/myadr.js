$(function () {
	//添加验证
	$("#save").click(function () {
		if (!textEnable($("#uname"))) {
			$("#uname").focus();
		} else if (!telEnable($("#uphone"))) {
			$("#uphone").focus();
		} else if (!textEnable($("#address"))) {
			$("#address").focus();
		} else if (!orgEnable(1)) {
			$("#prov").focus();
		} else if (!orgEnable(2)) {
			$("#city").focus();
		} else if (!orgEnable(3)) {
			$("#dist").focus();
		} else {
			$("#form_add").submit();
		}
	});
	
	//编辑验证
	$("#saveedit").click(function () {
		if (!textEnable($("#uname_edit"))) {
			$("#uname_edit").focus();
		} else if (!telEnable($("#uphone_edit"))) {
			$("#uphone_edit").focus();
		} else if (!textEnable($("#address_edit"))) {
			$("#address_edit").focus();
		} else if (!orgEditEnable(1)) {
			$("#prov_edit").focus();
		} else if (!orgEditEnable(2)) {
			$("#city_edit").focus();
		} else if (!orgEditEnable(3)) {
			$("#dist_edit").focus();
		} else {
			$("#form_edit").submit();
		}
	});
	
	//绑定blur
	$("#uname").blur(function () {
		textEnable($("#uname"));
    });
	$("#uphone").blur(function () {
		telEnable($("#uphone"));
    });
	$("#address").blur(function () {
		textEnable($("#address"));
    });
	
	//绑定blur
	$("#uname_edit").blur(function () {
		textEnable($("#uname_edit"));
    });
	$("#uphone_edit").blur(function () {
		telEnable($("#uphone_edit"));
    });
	$("#address_edit").blur(function () {
		textEnable($("#address_edit"));
    });
	
	//手机号通用验证
    function telEnable(tel) {
        if (tel.val() == "") {
            tel.attr("data-content", "手机号码不能为空，请检查");
            tel.popover("show");
            return false;
        } else if (tel.val().length != 11) {
            tel.attr("data-content", "手机号码长度应为11位，请检查");
            tel.popover("show");
            return false;
        } else {
        	tel.attr("data-content", "手机号码输入正确");
            tel.popover("hide");
            return true;
        }
    }
	
	//input:text通用验证
	function textEnable(input) {
        if (input.val() == "") {
        	input.attr("data-content", "该项不能为空，请检查");
        	input.popover("show");
            return false;
        } else {
        	input.attr("data-content", "该项输入正确");
        	input.popover("hide");
            return true;
        }
    }
	
	//ORG下拉框选择验证
	function orgEditEnable(org) {
        var prov = $("#prov_edit");
        var city = $("#city_edit");
        var dist = $("#dist_edit");

        switch (org) {
        case 1:
            if (prov.val() == 0) {
            	prov.attr("data-content", "省份不能为空，请检查");
            	prov.popover("show");
                return false;
            } else {
            	prov.attr("data-content", "省份选择正确");
            	prov.popover("hide");
                return true;
            }
            break;
        case 2:
            if (city.val() == 0) {
            	city.attr("data-content", "城市不能为空，请检查");
            	city.popover("show");
                return false;
            } else {
            	city.attr("data-content", "城市选择正确");
            	city.popover("hide");
                return true;
            }
            break;
        case 3:
            if (dist.val() == 0) {
            	dist.attr("data-content", "区县不能为空，请检查");
            	dist.popover("show");
                return false;
            } else {
            	dist.attr("data-content", "区县选择正确");
            	dist.popover("hide");
                return true;
            }
            break;
        case 0:
            if (prov.val() == 0) {
            	prov.attr("data-content", "学校必须选择，请检查");
            	prov.popover("show");
                return false;
            } else if (city.val() == 0) {
            	city.attr("data-content", "院系必须选择，请检查");
            	city.popover("show");
                return false;
            } else if (dist.val() == 0) {
            	dist.attr("data-content", "专业必须选择，请检查");
                dist.popover("show");
                return false;
            }
            break;
        default:
            break;
        }
    }
	
	//ORG下拉框选择验证
    function orgEnable(org) {
        var prov = $("#prov");
        var city = $("#city");
        var dist = $("#dist");

        switch (org) {
        case 1:
            if (prov.val() == 0) {
            	prov.attr("data-content", "省份不能为空，请检查");
            	prov.popover("show");
                return false;
            } else {
            	prov.attr("data-content", "省份选择正确");
            	prov.popover("hide");
                return true;
            }
            break;
        case 2:
            if (city.val() == 0) {
            	city.attr("data-content", "城市不能为空，请检查");
            	city.popover("show");
                return false;
            } else {
            	city.attr("data-content", "城市选择正确");
            	city.popover("hide");
                return true;
            }
            break;
        case 3:
            if (dist.val() == 0) {
            	dist.attr("data-content", "区县不能为空，请检查");
            	dist.popover("show");
                return false;
            } else {
            	dist.attr("data-content", "区县选择正确");
            	dist.popover("hide");
                return true;
            }
            break;
        case 0:
            if (prov.val() == 0) {
            	prov.attr("data-content", "学校必须选择，请检查");
            	prov.popover("show");
                return false;
            } else if (city.val() == 0) {
            	city.attr("data-content", "院系必须选择，请检查");
            	city.popover("show");
                return false;
            } else if (dist.val() == 0) {
            	dist.attr("data-content", "专业必须选择，请检查");
                dist.popover("show");
                return false;
            }
            break;
        default:
            break;
        }
    }
    
	//ORG加载触发
    $("#prov").change(function () {
        if (orgEnable(1)) {
        	loadOrg($("#city"), $("#prov").val());
        }        
    });
    $("#city").change(function () {
        if (orgEnable(2)) {
        	loadOrg($("#dist"), $("#city").val());
        }
    });
    $("#dist").change(function () {
    	orgEnable(3);
    });
    
	//ORG加载触发
    $("#prov_edit").change(function () {
        if (orgEditEnable(1)) {
        	loadOrg($("#city_edit"), $("#prov_edit").val());
        }        
    });
    $("#city_edit").change(function () {
        if (orgEditEnable(2)) {
        	loadOrg($("#dist_edit"), $("#city_edit").val());
        }
    });
    $("#dist_edit").change(function () {
    	orgEditEnable(3);
    });
	
	//ORG三级联动
    function loadOrg(org, parent) {
    	$.ajax({
        	url: "../UserCenter.do",
            data: "act=loadorg&parentid=" + parent,
            type: "POST",
            success: function (rel) {
            	var data = eval(rel);
            	var str = "";
            	org.html("<option value='0' selected>* 请选择</option>");
            	for (var i = 0; i < data.length; i++) {
            		str = "<option value='" + data[i].ORG_ID + "'>" + data[i].ORG_NAME + "</option>";
            		org.append(str);
            	}
            }
        });
    }
    
    //加载ORG一级下拉框
    loadOrg($("#prov"), 0);
    loadOrg($("#prov_edit"), 0);
	
	//收货地址
	$.ajax({
		url: "../UserCenter.do",
		data: "act=loadadr",
		type: "POST",
		success: function (rel) {
			var data = eval(rel);
			$("#myadr-list").html("");
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					var str = "<div class='card card-block col-md-6'><h4 class='card-title'><span id='adr-name'>" + 
						data[i].ADR_UNAME + "</span><span id='adr-phone' class='pull-right'>" + data[i].ADR_PHONE + 
						"</span></h4><p class='card-text'><span id='adr-address'>" + data[i].ADR_PROV + "&nbsp;" + 
						data[i].ADR_CITY + "&nbsp;" + data[i].ADR_DIST + "&nbsp;" + data[i].ADR_ADDRESS + 
						"</span>&nbsp;<span id='adr-zipcode'>" + ((data[i].ADR_ZIPCODE != null)?data[i].ADR_ZIPCODE:"") + 
						"</span></p><button type='button' class='btn btn-success' data-id='" + data[i].ADR_ID + 
						"' data-toggle='modal' data-target='#edit-dialog' onclick='editload(this)'>编辑</button>&nbsp;" +
						"<button type='button' class='btn btn-danger' data-toggle='modal' data-target='#del-dialog' " +
						"data-id='" + data[i].ADR_ID + "' onclick='delload(this)'>删除</button>&nbsp;" +
						((data[i].ADR_DEFAULT == "F")
						?"<a href='../UserCenter.do?act=setdefaultadr&adrid=" + data[i].ADR_ID + "' class='btn btn-info'>设为默认地址</a>"
						:"<a class='btn btn-info disabled'>已设为默认地址</a>") + "</div>";
					$("#myadr-list").append(str);
				}
			} else {
				var str = "<h3>还没有添加过地址，快去添加一个吧~</h3>";
				$("#myadr-list").append(str);
			}
		}
	});
	
	//收货地址数量
	$.ajax({
		url: "../UserCenter.do",
		data: "act=countadr",
		type: "POST",
		success: function (rel) {
			$("#adrcount").text(rel);
			if (parseInt(rel) == 10) {
				$("#btn-add").attr("disabled", "disabled");
			} else {
				$("#btn-add").removeAttr("disabled");
			}
		}
	});
	
	//加载左边栏
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
