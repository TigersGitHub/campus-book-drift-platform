$(function () {
	//加载原有内容
	$.ajax({
		url: "../../DctCommon.do",
		type: "post",
		data: "act=editload&dct=dept",
		success: function (rel) {
			if (rel == "back") {
				window.location.href = "dept.jsp";
			} else {
				var data = eval(rel);
				$("#deptid").html(data[0].DEPT_ID);
				$("#deptid-hidden").val(data[0].DEPT_ID);
				$("#deptname").val(data[0].DEPT_NAME);
				$("#deptparent").html(data[0].DEPT_PARENTNAME);
				$("#deptadr").val(data[0].DEPT_ADDRESS);
				$("#deptnote").html(data[0].DEPT_NOTE);
			}
		}
	});
	
	//绑定提交事件
	$("#form-edit-submit").click(function () {
		if ($("#deptname").val().length > 0) {
			$("#deptname").attr("data-content", "节点名称填写正确");
			$("#deptname").popover("hide");
			$("#form-emp-edit").submit();
		} else {
			$("#deptname").attr("data-content", "节点名称必须填写，请检查");
			$("#deptname").popover("show");
            return false;
		}
	});
	
	//绑定删除事件
	$("#sure-delete").click(function () {
		$.ajax({
			url: "../../DctCommon.do",
			type: "post",
			data: "act=del&dct=dept&deptid=" + $("#deptid-hidden").val(),
			success: function (rel) {
				if (rel == "notleaf") {
					alert("该节点存在子节点，不允许删除！");
					window.location.reload();
				} else if (rel == "success") {
					alert("删除成功！");
					window.location.href = "dept.jsp";
				} else {
					alert("删除失败");
					window.location.reload();
				}
			}
		});
	});	
	
});
