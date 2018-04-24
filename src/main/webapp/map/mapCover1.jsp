<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
	body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/fonts/fontawesome-webfont.svg"/>
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="css/industry_map.css" rel="stylesheet">
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=plEzfOG4jm58EGxEsHw4kCPoG3UjOcNv"></script>
	<title>地图展示</title>
</head>
<body>
	<div id="allmap"></div>
</body>
</html>
<script type="text/javascript" src="js/textIconOverlay.js"></script>
<script type="text/javascript" src="js/maplib.js"></script>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	map.centerAndZoom(new BMap.Point(118.871327,32.151263), 12);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.addControl(new BMap.NavigationControl({enableGeolocation:true}));
	map.addControl(new BMap.OverviewMapControl());
	map.setCurrentCity("南京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

	//===================
	var xy = [
		{'x':118.777882,'y':32.059839},
		{'x':118.777882,'y':32.059839},
		{'x':118.457882,'y':32.049839},
		{'x':118.62882,'y':32.039839},
		{'x':118.3882,'y':32.029839},
		{'x':118.6666,'y':32.019839},
		{'x':118.577882,'y':32.051839},
		{'x':118.377882,'y':32.052839},
		{'x':118.277882,'y':32.053839},
		{'x':118.177882,'y':32.054839},
		{'x':118.077882,'y':31.055839},
		{'x':118.795394,'y':32.027002}
	];
	var markers = [];
	var pt = null;
	for (var i in xy) {
	   pt = new BMap.Point(xy[i].x , xy[i].y);
	   markers.push(new BMap.Marker(pt));
	}
	//最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
	var markerClusterer = new BMapLib.MarkerClusterer(map,
		{
			markers:markers,
			girdSize : 100,
			styles : [{
	            url:'./img/red.png',
	            size: new BMap.Size(92, 92),
				backgroundColor : '#E64B4E'
			}],
		});
	markerClusterer.setMaxZoom(13);
	markerClusterer.setGridSize(100);
//================================================
	var xy1 = [	{'x':118.85952,'y':32.0711},
		{'x':118.651976,'y':32.047353},
		{'x':118.735051,'y':32.059839},
		{'x':118.777882,'y':32.054019},
		{'x':118.677882,'y':32.059839},
		{'x':118.787882,'y':32.079839},
		{'x':118.777982,'y':32.069839}];
	var markers1 = [];
	var pt = null;
	for (var i in xy1) {
	   pt = new BMap.Point(xy1[i].x , xy1[i].y);
	   markers1.push(new BMap.Marker(pt));
	}
	//最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
	var markerClusterer1 = new BMapLib.MarkerClusterer(map,
		{
			markers:markers1,
			girdSize : 100,
			styles : [{
	            url:'./img/blue.png',
	            size: new BMap.Size(92, 92),
				backgroundColor : '#4783E7'
			}],
		});
	markerClusterer1.setMaxZoom(13);
	markerClusterer1.setGridSize(100);
</script>
