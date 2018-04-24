var map;
var infoBox;
var mgr;
$(document).ready(function () { 
	map = new BMap.Map('allmap');
	var poi = new BMap.Point(121.48,31.23);
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.addControl(new BMap.NavigationControl({enableGeolocation:true}));
	map.addControl(new BMap.OverviewMapControl());
	map.centerAndZoom(poi, 13);
	map.enableScrollWheelZoom(true);
	map.setCurrentCity("上海");
	
	map.addEventListener("zoomend", function () {
//        map2.zoomTo(map.getZoom());
//        map2.panTo(map.getCenter());
//		  alert(map.getZoom());
    });

	var html = ["<div class='infoBoxContent'><div class='title'><strong>TEST项目</strong><span class='price'>负责人：test</span></div>",
	"<div class='list'><ul><li><div class='left'><img src='../map/img/tree.jpg'/></div><div class='left'><a target='_blank' href='http://map.baidu.com'>点击可以连接</a><p>描述描述描述描述描述</p></div><div class='rmb'>已处理</div></li>"
	,"<li><div class='left'><img src='../map/img/tree2.jpg'/></div><div class='left'><a target='_blank' href='http://map.baidu.com'>testtesttesttesttesttesttest</a><p>testtesttesttesttest</p></div><div class='rmb'>未处理</div></li>"
	,"<li><div class='left'><img src='../map/img/tree3.jpg'/></div><div class='left'><a target='_blank' href='http://map.baidu.com'>11111111</a><p></p></div><div class='rmb'>已处理</div></li>"
	,"<li><div class='left'><img src='../map/img/tree4.jpg'/></div><div class='left'><a target='_blank' href='http://map.baidu.com'>22222222</a><p></p></div><div class='rmb'>已处理</div></li>"
	,"<li class='last'><div class='left'><img src='../map/img/tree5.jpg'/></div><div class='left'><a target='_blank' href='http://map.baidu.com'>333333333</a><p></p></div><div class='rmb'>已处理</div></li>"
	,"</ul></div>"
	,"</div>"];
	infoBox = new BMapLib.InfoBox(map,html.join(""),{
		boxStyle:{
			background:"url('tipbox.gif') no-repeat center top"
			,width: "270px"
			,height: "300px"
		}
		,closeIconMargin: "1px 1px 0 0"
		,enableAutoPan: true
		,align: INFOBOX_AT_TOP
	});
//	addMarker(121.47, 31.22 );
	var xy = [
	    	{'x':121.47, 'y':31.22 },
	  		{'x':121.43, 'y':31.18 },
	  		{'x':121.42, 'y':31.22 },
	  		{'x':121.45, 'y':31.23 },
	  		{'x':121.4,  'y':31.25 },
	  		{'x':121.45, 'y':31.25 },
	  		{'x':121.5,  'y':31.27 },
	  		{'x':121.52, 'y':31.27 },
	  		{'x':121.38, 'y':31.12 },
	  		{'x':121.48, 'y':31.4 },
	  		{'x':121.27, 'y':31.38 }
	    	];
  var markers = [];
  var pt = null;
  for (var i in xy) {
	 var tmpMk;
     pt = new BMap.Point(xy[i].x , xy[i].y);
     tmpMk = new BMap.Marker(pt);
     console.log(tmpMk);
     tmpMk.addEventListener("click", function(){
 		infoBox.open(this);
 	 });
     markers.push(tmpMk);
     map.addOverlay(tmpMk);
  }
  //最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
  var markerClusterer = new BMapLib.MarkerClusterer(map, {markers:markers});
  markerClusterer.setGridSize(100); 
  markerClusterer.setMaxZoom(13);
  markerClusterer.setMinClusterSize(1);
  var myStyles = [{
	  url:'./img/blue.png',
	  size: new BMap.Size(92, 92),
	  textColor: '#ff0000',
	  backgroundColor : '#4783E7',
      opt_textSize: 10
  }];
  markerClusterer.setStyles(myStyles);
  
	
});
// 编写自定义函数,创建标注
function addMarker(longitude,latitude){
	var point = new BMap.Point(longitude,latitude);
	var marker = new BMap.Marker(point);
//	var marker = richMarker(point);
	map.addOverlay(marker);
	marker.addEventListener("click", function(){
		infoBox.open(marker);
	});
}

function richMarker(point) {
	var htm = "<div id='overLay' class='level1_label'>1256张图片"	+ "</div>";
	var richMarker = new BMapLib.RichMarker(htm, point, {"anchor": new BMap.Size(-72, -84), "enableDragging": true});
	return richMarker;
}

