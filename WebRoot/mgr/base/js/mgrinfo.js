$(function () {	
	var uid = "";
	var uname = "";
	var stime = "";
	var etime = "";
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		$("#emplist").html(str);
		for (var i = 0; i < data.length; i++) {				
			str = "<tr><th scope='row'>" + data[i].U_ID + "</th><td>" + data[i].U_NAME + "</td><td>" + data[i].U_MOBILE + "</td>" +
					"<td>" + data[i].U_EMAIL + "</td><td>" + ((data[i].R_SIGN == "U")?"已开通":"未开通") + "</td><td class='col-control'>" +
					"<a href='../../MgrContact.do?act=editjump&id=" + data[i].U_ID + "' class='btn btn-success'>详细</button>";
			if ("" + data[i].R_SIGN == "U") {
				str += "<a href='../../MgrContact.do?act=removeuserrole&id=" + data[i].U_ID + "' class='btn btn-warning'>取消</a>";
			} else {
				str += "<a href='../../MgrContact.do?act=adduserrole&id=" + data[i].U_ID + "' class='btn btn-info'>开通</a>";
			}
			if ("" + data[i].U_ENABLE == "T") {
				str += "<a href='../../MgrContact.do?act=disable&id=" + data[i].U_ID + "' class='btn btn-danger'>禁用</a>";
			} else {
				str += "<a href='../../MgrContact.do?act=enable&id=" + data[i].U_ID + "' class='btn btn-success'>启用</a>";					
			}
			str += "</td></tr>";
			$("#emplist").append(str);
		}
	}
	
	//加载列表
	function load() {
		$.ajax({
			url: "../../MgrContact.do",
			data: "act=loadrolelist&uid=" + uid + "&uname=" + uname + "&stime=" + stime + "&etime=" + etime,
			type: "post",
			success: function (rel) {
				loadcontent(rel);
			}
		});
	}
	load();
	
	//搜索
	$("#search").click(function () {
		uid = $("#suid").val();
		uname = $("#suname").val();
		stime = $("#stime").val();
		etime = $("#etime").val();
		load();
	});
	
	//注册邮箱输入验证（与普通用户通检，不可重复）
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
	
	//手机号输入验证（与普通用户通检，不可重复）
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
        var pw = $("#pw");
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
                data: "act=chkpw&pw=" + $("#pw").val(),
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
        var pw1 = $("#pw");
        var pw = $("#pw2");
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

	//用户名输入验证
    function userEnable() {
        var username = $("#name");
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
        var age = $("#age");
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
        var hometown = $("#hometown");
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
    $("#email").blur(function () {
        mailEnable();
    });
    $("#name").blur(function () {
    	userEnable();
    });
    $("#tel").blur(function () {
        telEnable();
    });
    $("#pw").blur(function () {
        pwEnable();
    });
    $("#pw2").blur(function () {
        pw2Enable();
    });
    $("#sex").change(function () {
        sexEnable();
    });
    $("#age").blur(function () {
    	ageEnable();
    });
    $("#hometown").blur(function () {
    	hometownEnable();
    });
    	
	//表单提交
	$("#saveemp").click(function () {
		if (!userEnable()) {
            $("#username").focus();        	
        } else if (!sexEnable()) {
            $("#sex").focus();
        } else if (!vPwEnable) {
            $("#pw").focus();
        } else if (!pw2Enable()) {
            $("#pw2").focus();
        } else if (!vMailEnable) {
            $("#email").focus();
        } else if (!vTelEnable) {
            $("#tel").focus();
        } else if (!ageEnable()) {
            $("#age").focus();
        } else if (!hometownEnable()) {
            $("#hometown").focus();
        } else {
        	$("#form-addemp").submit();
        }
	});
    
});
