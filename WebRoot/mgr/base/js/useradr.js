$(function () {	
	var currpage = 1;
	var totalpage = 1;
	var sprov = 0;
	var scity = 0;
	var sdist = 0;
	var suid = "";
	var sadr = "";
	
	//加载列表内容
	function loadcontent(rel) {
		var data = eval(rel);
		var str = "";
		$("#emplist").html("");
		for (var i = 0; i < data.length; i++) {				
			str = "<tr><th scope='row'>" + data[i].ADR_UID + "</th><td>" + data[i].ADR_UNAME + "</td>" +
					"<td>" + data[i].ADR_PROV + "</td><td>" + data[i].ADR_CITY + "</td><td>" + data[i].ADR_DIST + "</td>" +
					"<td>" + data[i].ADR_ADDRESS + "</td><td>" + data[i].ADR_PHONE + "</td><td>" + data[i].ADR_ZIPCODE 
					+ "</td><td class='col-control'><a href='../../UserCommon.do?act=jump&tab=adr&adrid=" + data[i].ADR_ID + 
					"' class='btn btn-info'>详细</a></td></tr>";
			$("#emplist").append(str);
		}
	}
	
	//加载列表
	function load() {
		$.ajax({
			url: "../../UserCommon.do",
			data: "act=load&tab=adr&suid=" + suid + "&sprov=" + sprov + "&scity=" + scity + "&sdist=" + sdist + "&sadr=" + sadr + "&page=" + currpage,
			type: "post",
			success: function (rel) {
				loadcontent(rel);
			}
		});
		loadPageControl();
	}
	
	//行政区划三级联动
    function loadOrg(org, parent) {
    	$.ajax({
        	url: "../../UserCommon.do",
            data: "act=loadorg&parentid=" + parent,
            type: "POST",
            success: function (rel) {
            	var data = eval(rel);
            	var str = "";
            	org.html("<option value='0' selected>全部</option>");
            	for (var i = 0; i < data.length; i++) {
            		str = "<option value='" + data[i].ORG_ID + "'>" + data[i].ORG_NAME + "</option>";
            		org.append(str);
            	}
            }
        });
    }
    
    //行政区划加载触发
    $("#sprov").change(function () {
    	if ($("#sprov").val() == "0") {
    		$("#scity").html("<option value='0' selected>全部</option>");
    		$("#sdist").html("<option value='0' selected>全部</option>");
    	} else {
    		loadOrg($("#scity"), $("#sprov").val()); 
    		$("#sdist").html("<option value='0' selected>全部</option>");     
    	}
    });
    $("#scity").change(function () {
    	if ($("#scity").val() == "0") {
    		$("#sdist").html("<option value='0' selected>全部</option>");
    	} else {
    		loadOrg($("#sdist"), $("#scity").val());	
    	}
    });
    
	//加载换页组件
	function loadPageControl() {
		$.ajax({
	        url: "../../UserCommon.do",
	        data: "act=adrtotalpage&suid=" + suid + "&sprov=" + sprov + "&scity=" + scity + "&sdist=" + sdist + "&sadr=" + sadr,
	        type: "POST",
	        success: function (rel) {
	        	//加载页码
	        	var total = parseInt(rel);
	        	if (total == 0) {
	        		currpage = total;
	        	}
	        	totalpage = total;
	        	$("#curr-page").html(currpage);
	        	$("#total-page").html(totalpage);
	        	
	        	//是否只有一页
	    		if (currpage == totalpage) {
	    			$("#next-page").attr("disabled", "disabled");
	    		} else {
	    			$("#next-page").removeAttr("disabled");
	    		}
	        }
		});
	}
	
	//向前翻页
	$("#previous-page").click(function () {
		//列表内容加载
		if (currpage > 1) {
			currpage--;
			load();
			$("#previous-page").removeAttr("disabled");
			$("#next-page").removeAttr("disabled");
		}
		
		//是否为第一页
		if (currpage == 1) {
			$("#previous-page").attr("disabled", "disabled");
		}
		
		//加载页码
    	$("#curr-page").html(currpage);
    	$("#total-page").html(totalpage);
	});
	
	//向后翻页
	$("#next-page").click(function () {
		//列表内容加载
		if (currpage < totalpage) {
			currpage++;
			load();
			$("#previous-page").removeAttr("disabled");
			$("#next-page").removeAttr("disabled");
		}
		
		//是否为最后一页
		if (currpage == totalpage) {
			$("#next-page").attr("disabled", "disabled");
		}
		
		//加载页码
    	$("#curr-page").html(currpage);
    	$("#total-page").html(totalpage);
	});
	
	//初始化
    loadOrg($("#sprov"), 0);
	load();
	
	//搜索
	$("#search").click(function () {
		currpage = 1;
		suid = $.trim($("#suid").val());
		sprov = $.trim($("#sprov").val());
		scity = $.trim($("#scity").val());
		sdist = $.trim($("#sdist").val());
		sadr = $.trim($("#sadr").val());
		load();				
	});	
    
});
