$(function () {
    var mailEnable = false;
    var pwEnable = false;

    //登录邮箱输入验证
    $("#email").blur(function () {
        var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var email = $("#email");
        if (email.val() == "") {
            email.attr("data-content", "邮箱不能为空，请检查");
            email.popover("show");
            mailEnable = false;
        } else if (!filter.test(email.val())) {
            email.attr("data-content", "邮箱格式不正确，请参考：yourname@example.com");
            email.popover("show");
            mailEnable = false;
        } else {
            email.attr("data-content", "邮箱格式输入正确");
            email.popover("hide");
            mailEnable = true;
        }
    });

    //登录密码输入验证
    $("#password").blur(function () {
        var pw = $("#password");
        if (pw.val() == "") {
            pw.attr("data-content", "密码不能为空，请检查");
            pw.popover("show");
            pwEnable = false;
        } else if (pw.val().length < 6) {
            pw.attr("data-content", "密码不能少于6位，请检查");
            pw.popover("show");
            pwEnable = false;        	
        } else {
            pw.attr("data-content", "密码格式输入正确");
            pw.popover("hide");
            pwEnable = true;
        }
    });

    //执行登录
    $("#signin").click(function () {
        if (mailEnable && pwEnable) {
            var signin = $("#signin");
            
            $.ajax({
                url: "../Login.do",
                data: "email=" + $("#email").val() + "&password=" + $("#password").val() + "&auto=" + $("#remember-me:checked").val(),
                type: "POST",
                success: function (rel) {
                    if (rel == "user") {
                    	window.location.href = "../index.jsp";
                    } else if (rel == "admin") {
                    	window.location.href = "../mgr";
                    } else if (rel == "error") {
                        signin.attr("data-content", "邮箱或密码错误，请检查");
                        signin.popover("show");
                        $("#password").val("");
                        pwEnable = false;
                    } else if (rel == "disabled") {
                        signin.attr("data-content", "您的账号已被禁用，请联系管理员");
                        signin.popover("show");
                        $("#password").val("");
                        pwEnable = false;                    	
                    } else {
                        signin.attr("data-content", "未知错误");
                        signin.popover("show");
                        $("#password").val("");
                        pwEnable = false;                     	
                    }
                }
            });
        }
    });
});
