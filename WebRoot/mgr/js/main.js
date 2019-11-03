$(function () {
	var time = "";
	var count = new Array(0, 0, 0, 0, 0, 0);
	var count2 = new Array(0, 0);
	var count4date = new Array(7);
	var count4 = new Array(0, 0, 0, 0, 0, 0, 0);
	var count5name = new Array(4);
	var count5 = new Array(0, 0, 0, 0);
	
	$.ajax({
		url: "../MgrContact.do",
		data: "act=total",
		type: "post",
		success: function (rel) {
			var data = eval(rel);
			for (var i = 0; i < data.length; i++) {
				switch (data[i].TOTAL_KEY) {
				case "USER":
					$("#total1").text(data[i].TOTAL_VAL);
					break;
				case "BOOK":
					$("#total2").text(data[i].TOTAL_VAL);					
					break;
				case "ORDER":
					$("#total3").text(data[i].TOTAL_VAL);					
					break;
				case "INCOME":
					$("#total4").text("¥" + data[i].TOTAL_VAL);					
					break;
				}
			}
		}
	});
	
	$.ajax({
		url: "../MgrContact.do",
		data: "act=counttime",
		type: "post",
		success: function (rel) {
			time = rel;
			countorder();
			countbyselltype();
			count7days();
			countincome();
		}
	});

	function countorder() {
		$.ajax({
			url: "../MgrContact.do",
			data: "act=countorder",
			type: "post",
			success: function (rel) {
				var data = eval(rel);
				for (var i = 0; i < data.length; i++) {
					switch (parseInt(data[i].ORD_STATUS)) {
					case 1:
						count[0] = data[i].ORD_COUNT;
						break;
					case 2:
						count[1] = data[i].ORD_COUNT;
						break;
					case 3:
						count[2] = data[i].ORD_COUNT;
						break;
					case 4:
						count[3] = data[i].ORD_COUNT;
						break;
					case 5:
						count[4] = data[i].ORD_COUNT;
						break;
					case 6: 
						count[5] = data[i].ORD_COUNT;
						break;
					}
				}
				loadchart1();
			}
		});
	}
	
	function countbyselltype() {
		$.ajax({
			url: "../MgrContact.do",
			data: "act=countbyselltype",
			type: "post",
			success: function (rel) {
				var data = eval(rel);
				for (var i = 0; i < data.length; i++) {
					if (data[i].BOOK_ISSELL == "Y") {
						count2[0] = data[i].BOOK_COUNT;
					} else if (data[i].BOOK_ISSELL == "N") {
						count2[1] = data[i].BOOK_COUNT;
					}
				}
				loadchart2();
			}
		});
	}
	
	function count7days() {
		for (var i = 0; i < 7; i++) {
			var date = new Date();
			count4date[i] = ((date.getMonth() + 1 <= 9)?"0" + (date.getMonth() + 1):date.getMonth()) + "-" + 
							((date.getDate() - (6 - i) <= 9)?"0" + (date.getDate() - (6 - i)):(date.getDate() - (6 - i)));
		}
		$.ajax({
			url: "../MgrContact.do",
			data: "act=count7days",
			type: "post",
			success: function (rel) {
				var data = eval(rel);
				for (var i = 0; i < data.length; i++) {
					if (count4date[i] == data[i].ORD_TIME){
						count4[i] = data[i].ORD_COUNT;
					}
				}
				loadchart4();
			}
		});
	}
	
	function countincome() {
		$.ajax({
			url: "../MgrContact.do",
			data: "act=countincome",
			type: "post",
			success: function (rel) {
				var flag = 0;
				var data = eval(rel);
				for (var i = 0; i < data.length; i++) {
					if (data[i].CORP_NAME == "其他") {
						count5name[3] = data[i].CORP_NAME;
						count5[3] = data[i].CORP_INCOME;
					} else {
						count5name[flag] = data[i].CORP_NAME;
						count5[flag] = data[i].CORP_INCOME;
						flag++;
					}
				}
				loadchart5();
			}
		});
	}

	function loadchart1() {
		FusionCharts.ready(function () {
		    var revenueChart = new FusionCharts({
		        type: 'column3d',
		        renderAt: 'chart-container',
		        width: '100%',
		        height: '250',
		        dataFormat: 'json',
		        dataSource: {
		            "chart": {
		                "caption": "订单总量分类统计",
		                "subCaption": "更新时间：" + time,
		                "xAxisName": "",
		                "yAxisName": "",
		                "paletteColors": "#0075c2",
		                "valueFontColor": "#ffffff",
		                "baseFont": "Helvetica Neue,Arial",
		                "captionFontSize": "14",
		                "subcaptionFontSize": "14",
		                "subcaptionFontBold": "0",
		                "placeValuesInside": "1",
		                "rotateValues": "1",
		                "showShadow": "0",
		                "divlineColor": "#999999",               
		                "divLineIsDashed": "1",
		                "divlineThickness": "1",
		                "divLineDashLen": "1",
		                "divLineGapLen": "1",
		                "canvasBgColor": "#ffffff"
		            },        
		            "data": [
		                {
		                    "label": "待付款",
		                    "value": count[0]
		                }, 
		                {
		                    "label": "待发货",
		                    "value": count[1]
		                }, 
		                {
		                    "label": "待收货",
		                    "value": count[2]
		                }, 
		                {
		                    "label": "待评价",
		                    "value": count[3]
		                }, 
		                {
		                    "label": "已完成",
		                    "value": count[4]
		                }, 
		                {
		                    "label": "已关闭",
		                    "value": count[5]
		                }
		            ]
		        }
		    }).render();
		});
	}	
	
	function loadchart2() {
		FusionCharts.ready(function () {
		    var revenueChart = new FusionCharts({
		        type: 'doughnut3d',
		        renderAt: 'chart-container2',
		        width: '100%',
		        height: '250',
		        dataFormat: 'json',
		        dataSource: {
		            "chart": {
		                "caption": "发布图书上架类别统计",
		                "subCaption": "更新时间：" + time,
		                "paletteColors": "#06c45c,#1599ff",
		                "bgColor": "#ffffff",
		                "showBorder": "0",
		                "use3DLighting": "0",
		                "showShadow": "0",
		                "enableSmartLabels": "0",
		                "startingAngle": "310",
		                "showLabels": "0",
		                "showPercentValues": "1",
		                "showLegend": "1",
		                "legendShadow": "0",
		                "legendBorderAlpha": "0",                                
		                "decimals": "0",
		                "captionFontSize": "14",
		                "subcaptionFontSize": "14",
		                "subcaptionFontBold": "0",
		                "toolTipColor": "#ffffff",
		                "toolTipBorderThickness": "0",
		                "toolTipBgColor": "#000000",
		                "toolTipBgAlpha": "80",
		                "toolTipBorderRadius": "2",
		                "toolTipPadding": "5",
		            },
		            "data": [
		                {
		                    "label": "图书漂流",
		                    "value": count2[1]
		                }, 
		                {
		                    "label": "二手交易",
		                    "value": count2[0]
		                }
		            ]
		        }
		    }).render();
		});
	}

	function loadchart4() {
		FusionCharts.ready(function () {
		    var revenueChart = new FusionCharts({
		        type: 'column3d',
		        renderAt: 'chart-container4',
		        width: '100%',
		        height: '250',
		        dataFormat: 'json',
		        dataSource: {
		            "chart": {
		                "caption": "近七日订单量统计",
		                "subCaption": "更新时间：" + time,
		                "xAxisName": "",
		                "yAxisName": "",
		                "paletteColors": "#0075c2",
		                "valueFontColor": "#ffffff",
		                "baseFont": "Helvetica Neue,Arial",
		                "captionFontSize": "14",
		                "subcaptionFontSize": "14",
		                "subcaptionFontBold": "0",
		                "placeValuesInside": "1",
		                "rotateValues": "1",
		                "showShadow": "0",
		                "divlineColor": "#999999",               
		                "divLineIsDashed": "1",
		                "divlineThickness": "1",
		                "divLineDashLen": "1",
		                "divLineGapLen": "1",
		                "canvasBgColor": "#ffffff"
		            },        
		            "data": [
		                {
		                    "label": count4date[0],
		                    "value": count4[0]
		                }, 
		                {
		                    "label": count4date[1],
		                    "value": count4[1]
		                }, 
		                {
		                    "label": count4date[2],
		                    "value": count4[2]
		                }, 
		                {
		                    "label": count4date[3],
		                    "value": count4[3]
		                }, 
		                {
		                    "label": count4date[4],
		                    "value": count4[4]
		                }, 
		                {
		                    "label": count4date[5],
		                    "value": count4[5]
		                }, 
		                {
		                    "label": count4date[6],
		                    "value": count4[6]
		                }
		            ]
		        }
		    }).render();
		});
	}	

	function loadchart5() {
		FusionCharts.ready(function () {
		    var revenueChart = new FusionCharts({
		        type: 'column3d',
		        renderAt: 'chart-container5',
		        width: '100%',
		        height: '250',
		        dataFormat: 'json',
		        dataSource: {
		            "chart": {
		                "caption": "合作厂商可计分成统计",
		                "subCaption": "更新时间：" + time,
		                "numberPrefix": "¥",
		                "xAxisName": "",
		                "yAxisName": "",
		                "paletteColors": "#0075c2",
		                "valueFontColor": "#ffffff",
		                "baseFont": "Helvetica Neue,Arial",
		                "captionFontSize": "14",
		                "subcaptionFontSize": "14",
		                "subcaptionFontBold": "0",
		                "placeValuesInside": "1",
		                "rotateValues": "1",
		                "showShadow": "0",
		                "divlineColor": "#999999",               
		                "divLineIsDashed": "1",
		                "divlineThickness": "1",
		                "divLineDashLen": "1",
		                "divLineGapLen": "1",
		                "canvasBgColor": "#ffffff"
		            },        
		            "data": [
		                {
		                    "label": count5name[0],
		                    "value": count5[0]
		                }, 
		                {
		                    "label": count5name[1],
		                    "value": count5[1]
		                }, 
		                {
		                    "label": count5name[2],
		                    "value": count5[2]
		                }, 
		                {
		                    "label": count5name[3],
		                    "value": count5[3]
		                }
		            ]
		        }
		    }).render();
		});
	}	
	
});
