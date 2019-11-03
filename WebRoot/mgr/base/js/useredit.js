$(function () {
	var vMailEnable = false;
	var vTelEnable = false;
	var useremail = "";
	var usertel = "";
	
	//DEPT保存
	$("#saveDept").click(function () {
		if (deptEnable(0)) {
			$.ajax({
				url: "../../UserCommon.do",
				data: "act=edit&tab=userdept&userid=" + $("#userid-hidden").val() + "&deptid=" + $("#dept3").val(),
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
	
	//DEPT下拉框选择验证
    function deptEnable(dept) {
        var dept1 = $("#dept1");
        var dept2 = $("#dept2");
        var dept3 = $("#dept3");    //提示框设置在dept3上

        switch (dept) {
        case 1:
            if (dept1.val() == 0) {
                dept1.attr("data-content", "学校必须选择，请检查");
                dept1.popover("show");
                return false;
            } else {
                dept1.attr("data-content", "学校选择正确");
                dept1.popover("hide");
                return true;
            }
            break;
        case 2:
            if (dept2.val() == 0) {
                dept2.attr("data-content", "院系必须选择，请检查");
                dept2.popover("show");
                return false;
            } else {
                dept2.attr("data-content", "院系选择正确");
                dept2.popover("hide");
                return true;
            }
            break;
        case 3:
            if (dept3.val() == 0) {
                dept3.attr("data-content", "专业必须选择，请检查");
                dept3.popover("show");
                return false;
            } else {
                dept3.attr("data-content", "专业选择正确");
                dept3.popover("hide");
                return true;
            }
            break;
        case 0:
            if (dept1.val() == 0) {
                dept1.attr("data-content", "学校必须选择，请检查");
                dept1.popover("show");
                return false;
            } else if (dept2.val() == 0) {
                dept2.attr("data-content", "院系必须选择，请检查");
                dept2.popover("show");
                return false;
            } else if (dept3.val() == 0) {
                dept3.attr("data-content", "专业必须选择，请检查");
                dept3.popover("show");
                return false;
            } else {
                dept3.attr("data-content", "全部选择正确");
                dept3.popover("hide");
                return true;
            }
            break;
        default:
            break;
    }
    }
    
    //DEPT加载触发
    $("#dept1").change(function () {
        if (deptEnable(1)) {
        	loadDept($("#dept2"), $("#dept1").val());
        }        
    });
    $("#dept2").change(function () {
        if (deptEnable(2)) {
        	loadDept($("#dept3"), $("#dept2").val());
        }
    });
    $("#dept3").change(function () {
        deptEnable(3);
    });
	
	//DEPT表三级联动
    function loadDept(dept, parent) {
    	$.ajax({
        	url: "../../Reg.do",
            data: "act=loaddept&parentid=" + parent,
            type: "POST",
            success: function (rel) {
            	var data = eval(rel);
            	var str = "";
            	dept.html("<option value='0' selected>* 请选择</option>");
            	for (var i = 0; i < data.length; i++) {
            		str = "<option value='" + data[i].DEPT_ID + "'>" + data[i].DEPT_NAME + "</option>";
            		dept.append(str);
            	}
            }
        });
    }
    
    //加载院校一级下拉框
    loadDept($("#dept1"), 0);
	
	//加载原有内容
	$.ajax({
		url: "../../UserCommon.do",
		type: "post",
		data: "act=detail&tab=user",
		success: function (rel) {
			if (rel == "back") {
				window.location.href = "userinfo.jsp";
			} else {
				var data = eval(rel);
				$("#userid").html(data[0].U_ID);
				$("#userid-hidden").val(data[0].U_ID);
				$("#username").val(data[0].U_NAME);
				$("#usersex").val(data[0].U_SEX);
				$("#userage").val(data[0].U_AGE);
				$("#userhome").val(data[0].U_HOMETOWN);
				$("#useremail").val(data[0].U_EMAIL);
				useremail = data[0].U_EMAIL + "";
				$("#usertel").val(data[0].U_MOBILE);
				usertel = data[0].U_MOBILE + "";
				$("#userdept-hidden").val(data[0].U_DEPTID);
				$("#userdept").text(data[0].U_DEPT1 + " - " + data[0].U_DEPT2 + " - " + data[0].U_DEPT3);
				$("#userregtime").html(data[0].U_REGTIME);
				$("#userscore").html(data[0].U_SCORE);
				if (data[0].U_ENABLE == "T") {
					$("#userstatus").text("正常");
				} else {
					$("#userstatus").text("禁用");
				}
				var note = data[0].U_NOTE + "";
				if (note != "null" && note != "") {
					$("#usernote").text(data[0].U_NOTE);
				}
			}
		}
	});
	
	//邮箱输入验证
	function mailEnable() {
        var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var email = $("#useremail");        
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
        	if (email.val() == useremail) {
                email.attr("data-content", "邮箱未修改");
                email.popover("hide");
                vMailEnable = true;
                return true;
            } else {
                $.ajax({
                    url: "../Reg.do",
                    data: "act=chkemail&email=" + $("#useremail").val(),
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
	
	//手机号输入验证
    function telEnable() {
        var tel = $("#usertel");
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
        	if (tel.val() == usertel) {
        		tel.attr("data-content", "手机号码未修改");
                tel.popover("hide");
                vTelEnable = true;
                return true;        	
            } else {
            	$.ajax({            
	                url: "../Reg.do",
	                data: "act=chkmobile&tel=" + $("#usertel").val(),
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
	
	//用户名输入验证
    function userEnable() {
        var username = $("#username");
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
        var age = $("#userage");
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
    
	//绑定验证函数
    $("#useremail").blur(function () {
        mailEnable();
    });
    $("#username").blur(function () {
    	userEnable();
    });
    $("#usertel").blur(function () {
        telEnable();
    });
    $("#userage").blur(function () {
    	ageEnable();
    });
    
	//绑定提交事件
	$("#form-edit-submit").click(function () {
		//编辑非新增，不一定会发生焦点事件，vMailEnable/vTelEnable状态或非最新
    	mailEnable();
    	telEnable();
    	if (!userEnable()) {
            $("#username").focus();
        } else if (!ageEnable()) {
            $("#userage").focus();
        } else if (!vMailEnable) {
            $("#useremail").focus();
        } else if (!vTelEnable) {
            $("#usertel").focus();
        } else {
        	$("#form-emp-edit").submit();
        }
	});
	
	/*绑定删除事件
	$("#sure-delete").click(function () {
		$.ajax({
			url: "../../UserCommon.do",
			type: "post",
			data: "act=del&tab=user&userid=" + $("#userid-hidden").val(),
			success: function (rel) {
				if (rel == "success") {
					alert("删除成功！");
					window.location.href = "userinfo.jsp";
				} else {
					alert("删除失败");
					window.location.reload();
				}
			}
		});
	});	*/
	
});
