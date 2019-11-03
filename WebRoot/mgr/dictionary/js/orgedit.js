$(function () {
	//加载原有内容
	$.ajax({
		url: "../../DctCommon.do",
		type: "post",
		data: "act=editload&dct=org",
		success: function (rel) {
			if (rel == "back") {
				window.location.href = "org.jsp";
			} else {
				var data = eval(rel);
				$("#orgid").html(data[0].ORG_ID);
				$("#orgid-hidden").val(data[0].ORG_ID);
				$("#orgname").val(data[0].ORG_NAME);
				$("#orgparent").html(data[0].ORG_PARENTNAME);
				$("#orgnote").html(data[0].ORG_NOTE);
			}
		}
	});
	
	//绑定提交事件
	$("#form-edit-submit").click(function () {
		if ($("#orgname").val().length > 0) {
			$("#orgname").attr("data-content", "节点名称填写正确");
			$("#orgname").popover("hide");
			$("#form-emp-edit").submit();
		} else {
			$("#orgname").attr("data-content", "节点名称必须填写，请检查");
			$("#orgname").popover("show");
            return false;
		}
	});
	
	//绑定删除事件
	$("#sure-delete").click(function () {
		$.ajax({
			url: "../../DctCommon.do",
			type: "post",
			data: "act=del&dct=org&orgid=" + $("#orgid-hidden").val(),
			success: function (rel) {
				if (rel == "notleaf") {
					alert("该节点存在子节点，不允许删除！");
					window.location.reload();
				} else if (rel == "success") {
					alert("删除成功！");
					window.location.href = "org.jsp";
				} else {
					alert("删除失败");
					window.location.reload();
				}
			}
		});
	});	
	
});
