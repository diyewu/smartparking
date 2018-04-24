$(document).ready(function() {
	
	
	var map = new BMap.Map('map',{enableMapClick:false});
	
//	var pois=[{40.062664,116.29488},{40.062664,116.306055},{40.056838,116.306055},{40.056838,116.29488}];
	var pois = new Array();
	pois.push(new BMap.Point(116.29488,40.062664));
	pois.push(new BMap.Point(116.306055,40.062664));
	pois.push(new BMap.Point(116.306055,40.056838));
	pois.push(new BMap.Point(116.29488,40.056838));
	

	var poi = new BMap.Point(116.307852, 40.057031);
	map.centerAndZoom(poi, 16);
	map.enableScrollWheelZoom();
	var polygon = new BMap.Polygon(pois, {
		strokeColor : "blue",
		strokeWeight : 2,
		fillColor : "none",
		strokeOpacity : 0.5
	}); // 创建多边形
	polygon.addEventListener("mouseover", function(){
		console.log(123);
		this.show();
	});
	polygon.addEventListener("mouseout", function(){
		this.hide();
	});
//	polygon.hide();
	map.addOverlay(polygon); // 增加多边形
	
	var overlays = [];
	var overlaycomplete = function(e) {
		overlays.push(e.overlay);
		console.log(e.overlay.po);
		
		var poilist =e.overlay.po;
//		console.log(poilist);
		for(var poi in poilist){
			console.log(poilist[poi].lat+","+poilist[poi].lng);
		}
		
	};
	var styleOptions = {
		strokeColor : "red", // 边线颜色。
		fillColor : "red", // 填充颜色。当参数为空时，圆形将没有填充效果。
		strokeWeight : 3, // 边线的宽度，以像素为单位。
		strokeOpacity : 0.8, // 边线透明度，取值范围0 - 1。
		fillOpacity : 0, // 填充的透明度，取值范围0 - 1。
		strokeStyle : 'solid' // 边线的样式，solid或dashed。
	}
	var polygonstyleOptions = {
			strokeColor : "red", // 边线颜色。
			fillColor : "none", // 填充颜色。当参数为空时，圆形将没有填充效果。
			strokeWeight : 3, // 边线的宽度，以像素为单位。
			strokeOpacity : 0.8, // 边线透明度，取值范围0 - 1。
			fillOpacity : 0.5, // 填充的透明度，取值范围0 - 1。
			points : pois, // 填充的透明度，取值范围0 - 1。
			strokeStyle : 'solid' // 边线的样式，solid或dashed。
	}
	// 实例化鼠标绘制工具
	var drawingManager = new BMapLib.DrawingManager(map, {
		isOpen : true, // 是否开启绘制模式
		enableDrawingTool : true, // 是否显示工具栏
		drawingToolOptions : {
			anchor : BMAP_ANCHOR_TOP_RIGHT, // 位置
			offset : new BMap.Size(5, 5), // 偏离值
		},
		circleOptions : styleOptions, // 圆的样式
		polylineOptions : styleOptions, // 线的样式
		polygonOptions : polygonstyleOptions, // 多边形的样式
		rectangleOptions : styleOptions
	// 矩形的样式
	});
	// 添加鼠标绘制工具监听事件，用于获取绘制结果
	drawingManager.addEventListener('overlaycomplete', overlaycomplete);
	function clearAll() {
		for ( var i = 0; i < overlays.length; i++) {
			map.removeOverlay(overlays[i]);
		}
		overlays.length = 0
	}
});