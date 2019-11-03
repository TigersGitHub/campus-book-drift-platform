$(function () {
	var vMailEnable = false;
	var vTelEnable = false;
	var empemail = "";
	var emptel = "";
	
	//原始信息加载
	$.ajax({
		url: "../../MgrContact.do",
		type: "post",
		data: "act=detailcontent",
		success: function (rel) {
			if (rel == "back") {
				window.location.href = "mgrinfo.jsp";
			} else {
				var data = eval(rel);
				$("#empid").text(data[0].U_ID);
				$("#empid-hidden").val(data[0].U_ID);
				$("#empname").val(data[0].U_NAME);
				$("#empsex option").removeAttr("selected");
				if (data[0].U_SEX == "M") {
					$("#empsex #M").attr("selected", "selected");
				} else {
					$("#empsex #F").attr("selected", "selected");
				}
				$("#empage").val(data[0].U_AGE);
				$("#emphome").val(data[0].U_HOMETOWN);
				$("#empemail").val(data[0].U_EMAIL);
				empemail = data[0].U_EMAIL + "";
				$("#emptel").val(data[0].U_MOBILE);
				emptel = data[0].U_MOBILE + "";
				$("#empentime").text(data[0].U_ENTTIME);
				if (data[0].U_ENABLE == "T") {
					$("#empstatus").text("正常");
				} else {
					$("#empstatus").text("禁用");
				}
				var note = data[0].U_NOTE + "";
				if (note != "null" && note != "") {
					$("#empnote").text(data[0].U_NOTE);
				}
			}	
		}
	});
	
	//注册邮箱输入验证（与普通用户通检，不可重复）
    function mailEnable() {
        var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var email = $("#empemail");
        
        if (email.val() == "") {
            email.attr("data-content", "邮箱不能为空，请检查");
            email.popover("show");
            vMailEnable = false;
            return false;
        } else if (!filter.test(email.val())) {
            email.attr("data-content", "邮箱格式不正确，请参考：yourname@example.com");
            email.popover("show");
            vMailEnable = false;
            return false;
        } else {
        	if (email.val() == empemail) {
                email.attr("data-content", "邮箱未修改");
                email.popover("hide");
                vMailEnable = true;
                return true;
            } else {
                $.ajax({
                    url: "../Reg.do",
                    data: "act=chkemail&email=" + $("#empemail").val(),
                    type: "POST",
                    success: function (rel) {
                        if (rel == "new") {
                            email.attr("data-content", "邮箱格式输入正确");
                            email.popover("hide");
                            vMailEnable = true;
                            return true;
                        } else {
                            email.attr("data-content", "邮箱已存在，请更改或直接登录");
                            email.popover("show");
                            vMailEnable = false;
                            return false;
                        }
                    }
                });
            }
        }
    }
	
	//手机号输入验证（与普通用户通检，不可重复）
    function telEnable() {
        var tel = $("#emptel");
        if (tel.val() == "") {
            tel.attr("data-content", "手机号码不能为空，请检查");
            tel.popover("show");
            vTelEnable = false;
            return false;
        } else if (tel.val().length != 11) {
            tel.attr("data-content", "手机号码长度应为11位，请检查");
            tel.popover("show");
            vTelEnable = false;
            return false;
        } else {
        	if (tel.val() == emptel) {
        		tel.attr("data-content", "手机号码未修改");
                tel.popover("hide");
                vTelEnable = true;
                return true;        	
            } else {
            	$.ajax({            
	                url: "../Reg.do",
	                data: "act=chkmobile&tel=" + $("#emptel").val(),
	                type: "POST",
	                success: function (rel) {
	                    if (rel == "new") {
	                        tel.attr("data-content", "手机号码输入正确");
	                        tel.popover("hide");
	                        vTelEnable = true;
	                        return true;
	                    } else {
	                    	tel.attr("data-content", "手机号码已存在，请更改或直接登录");
	                    	tel.popover("show");
	                    	vTelEnable = false;
	                        return false;
	                    }
	                }
            	});
            }
        }
    }
    
	//性别下拉框选择验证
    function sexEnable() {
        var sex = $("#empsex");
        if (sex.val() == 0) {
            sex.attr("data-content", "性别必须选择，请检查");
            sex.popover("show");
            return false;
        } else {
            sex.attr("data-content", "性别选择正确");
            sex.popover("hide");
            return true;
        }
    }

	//用户名输入验证
    function userEnable() {
        var username = $("#empname");
        if (username.val() == "") {
        	username.attr("data-content", "用户名不能为空，请检查");
        	username.popover("show");
            return false;
        } else {
        	username.attr("data-content", "用户名输入正确");
        	username.popover("hide");
            return true;
        }
    }
    
    //年龄输入验证
    function ageEnable() {
        var age = $("#empage");
        if (age.val() == "") {
        	age.attr("data-content", "年龄不能为空，请检查");
        	age.popover("show");
            return false;
        } else {
        	age.attr("data-content", "年龄选择正确");
        	age.popover("hide");
            return true;
        }    	
    }
    
    //家乡输入验证
    function hometownEnable() {
        var hometown = $("#emphome");
        if (hometown.val() == "") {
        	hometown.attr("data-content", "家乡不能为空，请检查");
        	hometown.popover("show");
            return false;
        } else {
        	hometown.attr("data-content", "家乡输入正确");
        	hometown.popover("hide");
            return true;
        }    	
    }
    
	//绑定验证函数
    $("#empemail").blur(function () {
        mailEnable();
    });
    $("#empname").blur(function () {
    	userEnable();
    });
    $("#emptel").blur(function () {
        telEnable();
    });
    $("#empsex").change(function () {
        sexEnable();
    });
    $("#empage").blur(function () {
    	ageEnable();
    });
    $("#emphome").blur(function () {
    	hometownEnable();
    });
    
    //表单提交
    $("#form-edit-submit").click(function () {
    	//编辑非新增，不一定会发生焦点事件，vMailEnable/vTelEnable状态或非最新
    	mailEnable();
    	telEnable();

    	if (!userEnable()) {
            $("#empname").focus();
        } else if (!sexEnable()) {
            $("#empsex").focus();
        } else if (!ageEnable()) {
            $("#empage").focus();
        } else if (!hometownEnable()) {
            $("#emphome").focus();
        } else if (!vMailEnable) {
            $("#empemail").focus();
        } else if (!vTelEnable) {
            $("#emptel").focus();
        } else {
        	$("#form-emp-edit").submit();
        }
    });
});
