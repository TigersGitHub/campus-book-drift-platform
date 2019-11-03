$(function () {	
	//行政区划保存
	$("#saveOrg").click(function () {
		if (orgEnable(0)) {
			$.ajax({
				url: "../../UserCommon.do",
				data: "act=edit&tab=adrorg&adrid=" + $("#adrid-hidden").val() 
						+ "&org1=" + $("#org1").val() + "&org2=" + $("#org2").val() + "&org3=" + $("#org3").val(),
				type: "post",
				success: function (rel) {
					if (rel == "s") {
						window.location.reload();
					} else {
						alert("保存失败，请刷新后再试");
					}
				}
			});			
		}
	});
	
	//行政区划下拉框选择验证
    function orgEnable(org) {
        var org1 = $("#org1");
        var org2 = $("#org2");
        var org3 = $("#org3");

        switch (org) {
	        case 1:
	            if (org1.val() == 0) {
	                org1.attr("data-content", "省/自治区/直辖市必须选择，请检查");
	                org1.popover("show");
	                return false;
	            } else {
	            	org1.attr("data-content", "省/自治区/直辖市选择正确");
	            	org1.popover("hide");
	                return true;
	            }
	            break;
	        case 2:
	            if (org2.val() == 0) {
	            	org2.attr("data-content", "市/自治州必须选择，请检查");
	            	org2.popover("show");
	                return false;
	            } else {
	            	org2.attr("data-content", "市/自治州选择正确");
	            	org2.popover("hide");
	                return true;
	            }
	            break;
	        case 3:
	            if (org3.val() == 0) {
	            	org3.attr("data-content", "区/县/自治县必须选择，请检查");
	            	org3.popover("show");
	                return false;
	            } else {
	            	org3.attr("data-content", "区/县/自治县选择正确");
	            	org3.popover("hide");
	                return true;
	            }
	            break;
	        case 0:
	            if (org1.val() == 0) {
	                org1.attr("data-content", "省/自治区/直辖市必须选择，请检查");
	                org1.popover("show");
	                return false;
	            } else if (org2.val() == 0) {
	                org2.attr("data-content", "市/自治州必须选择，请检查");
	                org2.popover("show");
	                return false;
	            } else if (org3.val() == 0) {
	            	org3.attr("data-content", "区/县/自治县必须选择，请检查");
	            	org3.popover("show");
	                return false;
	            } else {
	            	org3.attr("data-content", "全部选择正确");
	            	org3.popover("hide");
	                return true;
	            }
	            break;
	        default:
	            break;
	    }
    }
    
    //行政区划加载触发
    $("#org1").change(function () {
        if (orgEnable(1)) {
        	loadOrg($("#org2"), $("#org1").val());
        }        
    });
    $("#org2").change(function () {
        if (orgEnable(2)) {
        	loadOrg($("#org3"), $("#org2").val());
        }
    });
    $("#org3").change(function () {
    	orgEnable(3);
    });
	
	//行政区划三级联动
    function loadOrg(org, parent) {
    	$.ajax({
        	url: "../../UserCommon.do",
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
    
    //加载行政区划一级下拉框
    loadOrg($("#org1"), 0);
	
	//加载原有内容
	$.ajax({
		url: "../../UserCommon.do",
		type: "post",
		data: "act=detail&tab=adr",
		success: function (rel) {
			if (rel == "back") {
				window.location.href = "useradr.jsp";
			} else {
				var data = eval(rel);
				$("#adrid").html(data[0].ADR_ID);
				$("#adrid-hidden").val(data[0].ADR_ID);
				$("#uid").html(data[0].ADR_USERNAME + "(" + data[0].ADR_UID + ")");
				$("#uname").val(data[0].ADR_UNAME);
				$("#tel").val(data[0].ADR_PHONE);
				$("#org").text(data[0].ADR_PROV + " - " + data[0].ADR_CITY + " - " + data[0].ADR_DIST);
				$("#adr").val(data[0].ADR_ADDRESS);
				var zipcode = data[0].ADR_ZIPCODE + "";
				if (zipcode != "null" && zipcode != "") {
					$("#zipcode").val(data[0].ADR_ZIPCODE);
				}
				var note = data[0].ADR_NOTE + "";
				if (note != "null" && note != "") {
					$("#note").text(data[0].ADR_NOTE);
				}
			}
		}
	});
	
	//手机号输入验证
    function telEnable() {
        var tel = $("#tel");
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
	
	//用户名输入验证
    function userEnable() {
        var uname = $("#username");
        if (uname.val() == "") {
        	uname.attr("data-content", "收货人姓名不能为空，请检查");
        	uname.popover("show");
            return false;
        } else {
        	uname.attr("data-content", "收货人姓名输入正确");
        	uname.popover("hide");
            return true;
        }
    }
	
	//地址输入验证
    function adrEnable() {
        var adr = $("#adr");
        if (adr.val() == "") {
        	adr.attr("data-content", "收货地址不能为空，请检查");
        	adr.popover("show");
            return false;
        } else {
        	adr.attr("data-content", "收货地址输入正确");
        	adr.popover("hide");
            return true;
        }
    }
    
    //邮编输入验证
    function zipcodeEnable() {
        var zipcode = $("#zipcode");
        if (zipcode.val().length != 6) {
        	zipcode.attr("data-content", "邮政编码长度应为6位，请检查");
        	zipcode.popover("show");
            return false;
        } else {
        	zipcode.attr("data-content", "邮政编码输入正确");
        	zipcode.popover("hide");
            return true;
        }    	
    }
    
	//绑定验证函数
    $("#uname").blur(function () {
    	userEnable();
    });
    $("#tel").blur(function () {
        telEnable();
    });
    $("#adr").blur(function () {
    	adrEnable();
    });
    $("#zipcode").blur(function () {
    	zipcodeEnable();
    });
    
	//绑定提交事件
	$("#form-edit-submit").click(function () {
		if (!userEnable()) {
			$("#uname").focus();
		} else if (!telEnable()) {
			$("#tel").focus();
		} else if (!adrEnable()) {
			$("#adr").focus();
		} else if (!zipcodeEnable()) {
			$("#zipcode").focus();
		} else {
			$("#form-emp-edit").submit();
		}
	});
		
});
