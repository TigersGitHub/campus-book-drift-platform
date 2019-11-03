$(function () {
	//列表加载通用方法	
	function load(rel) {
		var data = eval(rel);
		var str = "";
		$("#dctlist").html("");
		for (var i = 0; i < data.length; i++) {
			str = "<tr><td>" + data[i].EXP_ID + "</td><td>" + data[i].EXP_NAME + "</td><td>" + data[i].EXP_LINKMAN + 
				"</td><td>" + data[i].EXP_TEL + "</td><td class='col-control'>" +
				"<button onclick='editload(this)' data-toggle='modal' data-target='#edit-dialog' data-id='" + data[i].EXP_ID + 
				"' class='btn btn-info'>编辑</button></td></tr>";
			$("#dctlist").append(str);
		}
	}
	
	//加载全部
	function loadall() {
		$.ajax({
			url: "../../DctCommon.do",
			type: "post",
			data: "act=load&dct=exp",
			success: function (rel) {
				load(rel);
			}
		});
	}
	
	//默认加载全部
	loadall();
	
	//搜索
	$("#search").click(function () {
		var key = $("#key").val();
		if (key.length == 0) {
			loadall();
		} else {
			$.ajax({
				url: "../../DctCommon.do",
				type: "post",
				data: "act=search&dct=exp&key=" + key,
				success: function (rel) {
					load(rel);
				}
			});	
		}
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
	
	//绑定blur
	$("#expname").blur(function () {
		textEnable($("#expname"));
    });
	$("#expid").blur(function () {
		textEnable($("#expid"));
    });
	$("#linkman").blur(function () {
		textEnable($("#linkman"));
    });
	$("#tel").blur(function () {
		telEnable($("#tel"));
    });
	
	//绑定blur
	$("#eexpname").blur(function () {
		textEnable($("#eexpname"));
    });
	$("#elinkman").blur(function () {
		textEnable($("#elinkman"));
    });
	$("#etel").blur(function () {
		telEnable($("#etel"));
    });
	
	//新增节点
	$("#save").click(function () {
		if (!textEnable($("#expid"))) {
			$("#expid").focus();
            return false;	
		} else if (!textEnable($("#expname"))) {
			$("#expname").focus();
            return false;	
		} else if (!textEnable($("#linkman"))) {
			$("#linkman").focus();
            return false;
		} else if (!telEnable($("#tel"))) {
			$("#tel").focus();
            return false;
		} else {
			$("#form-dctadd").submit();
		}
	});
	
	//编辑提交
	$("#update").click(function () {
		if (!textEnable($("#eexpname"))) {
			$("#eexpname").focus();
            return false;	
		} else if (!textEnable($("#elinkman"))) {
			$("#elinkman").focus();
            return false;	
		} else if (!telEnable($("#etel"))) {
			$("#etel").focus();
            return false;	
		} else {
			$("#form-dctedit").submit();
		}
	});
	
});
