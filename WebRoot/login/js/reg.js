$(function () {
	var vMailEnable = false;
	var vTelEnable = false;
	var vPwEnable = false;
		
    //加载用户协议内容
    var textarea = $("#agree-content");
    $.ajax({
        url: "../files/userAgreements.txt",
        dataType: "text",
        success: function(data) {
            textarea.text(data);
        }
    });
    
    //加载院校下拉框
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
    
    //注册邮箱输入验证
    function mailEnable() {
        var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var email = $("#email");
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
            $.ajax({
                url: "../Reg.do",
                data: "act=chkemail&email=" + $("#email").val(),
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

    //手机号输入验证
    function telEnable() {
        var tel = $("#tel");
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
        	$.ajax({
                url: "../Reg.do",
                data: "act=chkmobile&tel=" + $("#tel").val(),
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

    //注册密码输入验证
    function pwEnable() {
        var pw = $("#password");
        if (pw.val() == "") {
            pw.attr("data-content", "密码不能为空，请检查");
            pw.popover("show");
        	vPwEnable = false;
            return false;
        } else if (pw.val().length < 6) {
            pw.attr("data-content", "密码不能少于6位，请检查");
            pw.popover("show");
            vPwEnable = false;
            return false;
        } else if (pw.val().length > 16) {
            pw.attr("data-content", "密码不能多于16位，请检查");
            pw.popover("show");
            vPwEnable = false;
            return false;
        } else {
        	$.ajax({
                url: "../Reg.do",
                data: "act=chkpw&pw=" + $("#password").val(),
                type: "POST",
                success: function (rel) {
                    if (rel == "new") {
                        pw.attr("data-content", "密码格式输入正确");
                        pw.popover("hide");
                        vPwEnable = true;
                        return true;
                    } else {
                    	pw.attr("data-content", "密码过于简单，请设置更复杂的密码");
                    	pw.popover("show");
                    	vPwEnable = false;
                        return false;
                    }
                }
            });
        }
    }

    //注册确认密码输入验证
    function pw2Enable() {
        var pw1 = $("#password");
        var pw = $("#password2");
        if (pw.val() == "") {
            pw.attr("data-content", "确认密码不能为空，请检查");
            pw.popover("show");
            return false;
        } else if (pw.val().length < 6) {
            pw.attr("data-content", "确认密码不能少于6位，请检查");
            pw.popover("show");
            return false;
        } else if (pw.val().length > 16) {
            pw.attr("data-content", "确认密码不能多于16位，请检查");
            pw.popover("show");
            return false;
        } else if (pw.val() != pw1.val()) {
            pw.attr("data-content", "两次输入的密码不一致，请检查");
            pw.popover("show");
            return false;
        } else {
            pw.attr("data-content", "密码格式输入正确");
            pw.popover("hide");
            return true;
        }
    }

    //性别下拉框选择验证
    function sexEnable() {
        var sex = $("#sex");
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

    //院校下拉框选择验证
    function deptEnable(dept) {
        var dept1 = $("#dept1");
        var dept2 = $("#dept2");
        var dept3 = $("#dept3");    //提示框设置在dept3上

        switch (dept) {
            case 1:
                if (dept1.val() == 0) {
                    dept3.attr("data-content", "学校必须选择，请检查");
                    dept3.popover("show");
                    return false;
                } else {
                    dept3.attr("data-content", "学校选择正确");
                    dept3.popover("hide");
                    return true;
                }
                break;
            case 2:
                if (dept2.val() == 0) {
                    dept3.attr("data-content", "院系必须选择，请检查");
                    dept3.popover("show");
                    return false;
                } else {
                    dept3.attr("data-content", "院系选择正确");
                    dept3.popover("hide");
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
                    dept3.attr("data-content", "学校必须选择，请检查");
                    dept3.popover("show");
                    return false;
                } else if (dept2.val() == 0) {
                    dept3.attr("data-content", "院系必须选择，请检查");
                    dept3.popover("show");
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

    //绑定验证函数
    $("#email").blur(function () {
        mailEnable();
    });
    $("#username").blur(function () {
    	userEnable();
    });
    $("#tel").blur(function () {
        telEnable();
    });
    $("#password").blur(function () {
        pwEnable();
    });
    $("#password2").blur(function () {
        pw2Enable();
    });
    $("#sex").change(function () {
        sexEnable();
    });
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

    //执行注册
    $("#reg").click(function () {
        if (!vMailEnable) {
            $("#email").focus();
        } else if (!userEnable()) {
            $("#username").focus();        	
        } else if (!vTelEnable) {
            $("#tel").focus();
        } else if (!vPwEnable) {
            $("#password").focus();
        } else if (!pw2Enable()) {
            $("#password2").focus();
        } else if (!sexEnable()) {
            $("#sex").focus();
        } else if (!deptEnable(0)) {
            $("#dept1").focus();
        } else {
        	var reg = $("#reg");
            $.ajax({
                url: "../Reg.do",
                data: "act=reg&email=" + $("#email").val() + "&username=" + $("#username").val()
		            	+ "&tel=" + $("#tel").val() + "&password=" + $("#password").val()
		            	+ "&sex=" + $("#sex").val() + "&dept3=" + $("#dept3").val()
		            	+ "&age=" + $("#age").val() + "&hometown=" + $("#hometown").val(),
                type: "POST",
                success: function (rel) {
                    if (rel == "failed") {
                    	reg.attr("data-content", "注册失败，请刷新页面重试");
                    	reg.popover("show");
                        return false;
                    } else {
                    	alert("注册成功！请登录");
                    	reg.attr("data-content", "注册成功！请登录");
                    	reg.popover("hide");
                    	window.location.href= "index.jsp";
                    }
                }
            });
        }
    });
});
