$(function () {
	//加载原有内容
	$.ajax({
		url: "../../DctCommon.do",
		type: "post",
		data: "act=editload&dct=format",
		success: function (rel) {
			if (rel == "back") {
				window.location.href = "format.jsp";
			} else {
				var data = eval(rel);
				$("#fmtid").html(data[0].FMT_ID);
				$("#fmtid-hidden").val(data[0].FMT_ID);
				$("#fmtname").val(data[0].FMT_NAME);
				$("#fmtnote").html(data[0].FMT_NOTE);
			}
		}
	});
	
	//绑定提交事件
	$("#form-edit-submit").click(function () {
		if ($("#fmtname").val().length > 0) {
			$("#fmtname").attr("data-content", "节点名称填写正确");
			$("#fmtname").popover("hide");
			$("#form-emp-edit").submit();
		} else {
			$("#fmtname").attr("data-content", "节点名称必须填写，请检查");
			$("#fmtname").popover("show");
            return false;
		}
	});
	
	//绑定删除事件
	$("#sure-delete").click(function () {
		$.ajax({
			url: "../../DctCommon.do",
			type: "post",
			data: "act=del&dct=format&aimid=" + $("#fmtid-hidden").val(),
			success: function (rel) {
				if (rel == "success") {
					alert("删除成功！");
					window.location.href = "format.jsp";
				} else {
					alert("删除失败");
					window.location.reload();
				}
			}
		});
	});	
	
});
