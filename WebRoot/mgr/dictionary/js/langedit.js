$(function () {
	//加载原有内容
	$.ajax({
		url: "../../DctCommon.do",
		type: "post",
		data: "act=editload&dct=lang",
		success: function (rel) {
			if (rel == "back") {
				window.location.href = "lang.jsp";
			} else {
				var data = eval(rel);
				$("#langid").html(data[0].LAN_ID);
				$("#langid-hidden").val(data[0].LAN_ID);
				$("#langname").val(data[0].LAN_NAME);
				$("#langnote").html(data[0].LAN_NOTE);
			}
		}
	});
	
	//绑定提交事件
	$("#form-edit-submit").click(function () {
		if ($("#langname").val().length > 0) {
			$("#langname").attr("data-content", "节点名称填写正确");
			$("#langname").popover("hide");
			$("#form-emp-edit").submit();
		} else {
			$("#langname").attr("data-content", "节点名称必须填写，请检查");
			$("#langname").popover("show");
            return false;
		}
	});
	
	//绑定删除事件
	$("#sure-delete").click(function () {
		$.ajax({
			url: "../../DctCommon.do",
			type: "post",
			data: "act=del&dct=lang&aimid=" + $("#langid-hidden").val(),
			success: function (rel) {
				if (rel == "success") {
					alert("删除成功！");
					window.location.href = "lang.jsp";
				} else {
					alert("删除失败");
					window.location.reload();
				}
			}
		});
	});	
	
});
