$(function () {
	//加载原有内容
	$.ajax({
		url: "../../DctCommon.do",
		type: "post",
		data: "act=editload&dct=btype",
		success: function (rel) {
			if (rel == "back") {
				window.location.href = "booktype.jsp";
			} else {
				var data = eval(rel);
				$("#btypeid").html(data[0].TYP_ID);
				$("#btypeid-hidden").val(data[0].TYP_ID);
				$("#btypename").val(data[0].TYP_NAME);
				$("#btypenote").html(data[0].TYP_NOTE);
			}
		}
	});
	
	//绑定提交事件
	$("#form-edit-submit").click(function () {
		if ($("#btypename").val().length > 0) {
			$("#btypename").attr("data-content", "节点名称填写正确");
			$("#btypename").popover("hide");
			$("#form-emp-edit").submit();
		} else {
			$("#btypename").attr("data-content", "节点名称必须填写，请检查");
			$("#btypename").popover("show");
            return false;
		}
	});
	
	//绑定删除事件
	$("#sure-delete").click(function () {
		$.ajax({
			url: "../../DctCommon.do",
			type: "post",
			data: "act=del&dct=btype&aimid=" + $("#fmtid-hidden").val(),
			success: function (rel) {
				if (rel == "success") {
					alert("删除成功！");
					window.location.href = "booktype.jsp";
				} else {
					alert("删除失败");
					window.location.reload();
				}
			}
		});
	});	
	
});
