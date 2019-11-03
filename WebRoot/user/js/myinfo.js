$(function () {
	var vMailEnable = false;
	var vTelEnable = false;
	var useremail = "";
	var usertel = "";
	
	//校验并发布
	$("#save").click(function () {
		//编辑非新增，不一定会发生焦点事件，vMailEnable/vTelEnable状态或非最新
    	mailEnable();
    	telEnable();
    	if (!userEnable()) {
            $("#u_name").focus();
        } else if (!vMailEnable) {
            $("#u_email").focus();
        } else if (!vTelEnable) {
            $("#u_mobile").focus();
        } else {
			$("#sell-form").submit();
		}
	});
	
	//邮箱输入验证
	function mailEnable() {
        var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var email = $("#u_email");
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
                    data: "act=chkemail&email=" + $("#u_email").val(),
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
        var tel = $("#u_mobile");
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
	                data: "act=chkmobile&tel=" + $("#u_mobile").val(),
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
        var username = $("#u_name");
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
    
	//绑定验证函数
    $("#u_email").blur(function () {
        mailEnable();
    });
    $("#u_name").blur(function () {
    	userEnable();
    });
    $("#u_mobile").blur(function () {
        telEnable();
    });
	
	//DEPT保存
	$("#saveDept").click(function () {
		if (deptEnable(0)) {
			$.ajax({
				url: "../UserCommon.do",
				data: "act=edit&tab=userdept&userid=" + $("#u_id").val() + "&deptid=" + $("#dept3").val(),
				type: "post",
				success: function (rel) {
					if (rel == "s") {
						window.location.reload();
					} else {
						alert("保存失败，请稍后再试");
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
        	url: "../Reg.do",
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
	
	//预加载
	$.ajax({
		url: "../UserCenter.do",
		data: "act=loadmyinfo",
		type: "POST",
		success: function (rel) {
			var data = eval(rel);
			$("#u_name").val(data[0].U_NAME);
			$("#u_email").val(data[0].U_EMAIL);
			useremail = data[0].U_EMAIL + "";
			$("#u_mobile").val(data[0].U_MOBILE);
			usertel = data[0].U_MOBILE + "";
			$("#u_sex").val(data[0].U_SEX);
			if (data[0].U_ROLE == "U") {
				$("#u_deptid").text(data[0].U_DEPT1 + " - " + data[0].U_DEPT2 +  " - " + data[0].U_DEPT3);
			} else {
				$("#u_deptid").text("无");
				$("#u_dept_edit").attr("disabled", "disabled");
			}
			$("#u_age").val(data[0].U_AGE);
			$("#u_hometown").val(data[0].U_HOMETOWN);
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
