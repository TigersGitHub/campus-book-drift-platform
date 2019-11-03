$(function () {
	//解析列表
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		$("#emplist").html("");
		for (var i = 0; i < data.length; i++) {				
			str = "<tr><th scope='row'>" + data[i].CSL_ID + "</th><td>";
			switch (data[i].CSL_TYPE) {
			case 'B':
				str += "个人图书";
				break;
			case 'R':
				str += "推荐图书";
				break;
			case 'T':
				str += "分类活动";
				break;
			case 'N':
				str += "非广告";
				break;
			}
			str += "</td><td>" + data[i].CSL_SRC + "</td><td>" + ((data[i].CSL_TARGET == null)?"无":data[i].CSL_TARGET) + 
					"</td><td>" + ((data[i].CSL_NOTE == null)?"无":data[i].CSL_NOTE) + "</td><td class='col-control'>" +
					"<button data-id='" + data[i].CSL_ID + "' class='btn btn-success' onclick='editload(this)' data-toggle='modal' data-target='#edit-dialog'>编辑</button>" +
					"<button data-id='" + data[i].CSL_ID + "' class='btn btn-danger' onclick='delload(this)' data-toggle='modal' data-target='#del-dialog'>删除</button></td></tr>";
			$("#emplist").append(str);
		}		
	}
	
	//加载列表
	$.ajax({
		url: "../../Carousel.do",
		data: "act=load",
		type: "post",
		success: function (rel) {
			loadcontent(rel);
		}
	});
	
	//新增框加载序号
	$.ajax({
		url: "../../Carousel.do",
		data: "act=loadnewid",
		type: "post",
		success: function (rel) {
			$("#cslid").val(rel);
		}
	});
	
	//新增提交
	$("#save").click(function () {
		var src = $("#cslsrc");
		if (src.val() == "" || src.val().length == 0) {
			src.attr("data-content", "图片路径不能为空，请检查");
			src.popover("show");
            return false;
		} else {
			src.attr("data-content", "图片路径填写正确");
			src.popover("hide");
			$("#form-add").submit();
			return true;
		}
	});
	
	//按分类查询
	$("#search").click(function () {
		$.ajax({
			url: "../../Carousel.do",
			data: "act=search&type=" + $("#stype").val(),
			type: "post",
			success: function (rel) {
				loadcontent(rel);
			}
		});
	});	
	
	//图片路径输入验证
    function srcEnable() {
        var src = $("#cslsrc-edit");
        if (src.val() == "") {
        	src.attr("data-content", "图片路径不能为空，请检查");
        	src.popover("show");
            return false;
        } else {
        	src.attr("data-content", "图片路径输入正确");
        	src.popover("hide");
            return true;
        }    	
    }
    
	//绑定验证函数    
    $("#cslsrc-edit").blur(function () {
    	srcEnable();
    });
    
	//绑定编辑提交
	$("#form-edit-submit").click(function () {
    	if (!srcEnable()) {
            $("#cslsrc-edit").focus();
        } else {
        	$("#form-edit").submit();
        }
	});
	
});
