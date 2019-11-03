$(function () {
	//列表加载通用方法	
	function load(rel) {
		var data = eval(rel);
		var str = "";
		$("#dctlist").html("");
		for (var i = 0; i < data.length; i++) {
			str = "<tr><td>" + data[i].LAN_ID + "</td><td>" + data[i].LAN_NAME + "</td><td>"; 
			if (data[i].LAN_NOTE == null) {
				str += "未填写";
			} else {
				str += data[i].LAN_NOTE;
			}
			str += "</td><td class='col-control'><a href='../../DctCommon.do?act=editjump&dct=lang&langid=" + data[i].LAN_ID + 
				"' class='btn btn-info'>编辑</a></td></tr>";
			$("#dctlist").append(str);
		}
	}
	
	//加载全部
	function loadall() {
		$.ajax({
			url: "../../DctCommon.do",
			type: "post",
			data: "act=load&dct=lang",
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
				data: "act=search&dct=lang&key=" + key,
				success: function (rel) {
					load(rel);
				}
			});			
		}
	});
	
	//新增节点
	$("#save").click(function () {
		if ($.trim($("#langname").val()).length > 0) {	//str.trim()的写法貌似不支持IE？
			$("#form-dctadd").submit();		
			$("#save").attr("data-content", "表单填写正确");
			$("#save").popover("hide");	
		} else {
			$("#save").attr("data-content", "表单填写不完整，请检查");
			$("#save").popover("show");
			$("#langname").focus();
            return false;
		}
	});
	
});
