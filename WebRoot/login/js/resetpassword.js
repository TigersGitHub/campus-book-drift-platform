$(function () {
	var vPwEnable = false;
	
    //注册邮箱输入验证
    function mailEnable() {
        var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var email = $("#email");
        if (email.val() == "") {
            email.attr("data-content", "邮箱不能为空，请检查");
            email.popover("show");
            return false;
        } else if (!filter.test(email.val())) {
            email.attr("data-content", "邮箱格式不正确，请参考：yourname@example.com");
            email.popover("show");
            return false;
        } else {
            email.attr("data-content", "邮箱格式输入正确");
            email.popover("hide");
            return true;
        }
    }

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

    //新密码输入验证
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

    //确认密码输入验证
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

    //绑定验证函数
    $("#email").blur(function () {
        mailEnable();
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

    //第一步跳转
    $("#next-step").click(function () {
        var email = $("#email");
        var tel = $("#tel");
        var nextstep = $("#next-step");

        if (!mailEnable()) {
            email.focus();
        } else if (!telEnable()) {
            tel.focus();
        } else {
            $.ajax({
                url: "../Reg.do",
                method: "post",
                data: "act=chkreset&email=" + email.val() + "&tel=" + tel.val(),
                success: function (rel) {
                    if (rel == "exist") {
                        $("#step1").removeClass("currstep");
                        $("#step2").addClass("currstep");
                        $("#step-form1").css("display", "none");
                        $("#step-form2").css("display", "block");
                    } else {
                        nextstep.attr("data-content", "身份信息验证失败，请检查后重试");
                        nextstep.popover("show");
                    }
                }
            });
        }
    });

    //第二步跳转
    $("#reset-step").click(function () {
        var pw = $("#password");
        var pw2 = $("#password2");
        var reset = $("#reset-step");

        if (!vPwEnable) {
            pw.focus();
        } else if (!pw2Enable()) {
            pw2.focus();
        } else {
            $.ajax({
                url: "../Reg.do",
                method: "post",
                data: "act=reset&email=" + $("#email").val() + "&pw=" + pw.val(),
                success: function (rel) {
                    if (rel == "succeed") {
                        $("#step2").removeClass("currstep");
                        $("#step3").addClass("currstep");
                        $("#step-form2").css("display", "none");
                        $("#step-form3").css("display", "block");
                    } else {
                        reset.attr("data-content", "密码修改失败，请刷新后重试");
                        reset.popover("show");
                    }
                }
            });
        }
    });
});
