var map;
var infoBox;
var mgr;
$(document).ready(function () { 
	map = new BMap.Map('map_canvas');
	var poi = new BMap.Point(121.48,31.23);
	map.centerAndZoom(poi, 12);
	map.enableScrollWheelZoom(true);
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

//	var marker = new BMap.Marker(poi);
//	map.addOverlay(marker);
//	marker.setAnimation(BMAP_ANIMATION_BOUNCE);
//	marker.disableDragging();
//	marker.addEventListener("click", function(){
//		infoBox.open(marker);
//	});
	
	
	$("close").onclick = function(){
		infoBox.close();
	}
	$("open").onclick = function(){
		infoBox.open(marker);
	}
	$("show").onclick = function(){
		infoBox.show();
	}
	$("hide").onclick = function(){
		infoBox.hide();
	}
	$("enableAutoPan").onclick = function(){
		infoBox.enableAutoPan();
	}
	$("disableAutoPan").onclick = function(){
		infoBox.disableAutoPan();
	}
	function $(id){
		return document.getElementById(id);
	}

	addMarker(121.47, 31.22 );
//	addMarker(121.43, 31.18 );
//	addMarker(121.42, 31.22);
//	addMarker(121.45, 31.23);
//	addMarker(121.4, 31.25 );
//	addMarker(121.45, 31.25 );
//	addMarker(121.5, 31.27);
//	addMarker(121.52, 31.27);
//	addMarker(121.38, 31.12);
//	addMarker(121.48, 31.4);
//	addMarker(121.27, 31.38);
	
	//mgrmarker******************
	var padding = 200;
	mgr = new BMapLib.MarkerManager(map,{
		borderPadding: padding
		,maxZoom: 18
		,trackMarkers: true
	});

    var	markersConfig = [{minZoom: 1, maxZoom: 10, markerCount:10 }
					,{minZoom: 11, maxZoom: 12, markerCount:10 }
					,{minZoom: 13, maxZoom: 15, markerCount:15 }
					,{minZoom: 16, maxZoom: 17, markerCount:10 }
					,{minZoom: 18, maxZoom: 19, markerCount:10 }
					];
	for(var i in markersConfig){
	  	var t = markersConfig[i];
	  	var mks = getRandomMarker(map,t.markerCount,padding);
	  	mgr.addMarkers(mks,t.minZoom,t.maxZoom)
	}
//    mgr.showMarkers()
	//******************
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

/**
 * 随机生成marker
 * 
 * @param {Map}
 *            map 地图map对象
 * @param {Number}
 *            num 要产生的marker的数量
 * @param {Boolean}
 *            isInViewport 是否需要只在视口中的marker
 * @return {Array} marker的数组集合
 */
function getRandomMarker(map,num,borderPadding){
	var container = map.getContainer()
	, markers = []
	, height = parseInt(container.offsetHeight,10) / 2  + borderPadding
	, width = parseInt(container.offsetWidth,10) / 2  + borderPadding;
	var center = map.getCenter(), pixel = map.pointToPixel(center);
	var realBounds = mgr._getRealBounds();
	//随机一个新的坐标，不超过地图+borderPadding范围
	for(var i = num; i--;){
		var w = width * Math.random(), h = height * Math.random();
		var newPixel = { x : pixel.x + (Math.random() > 0.5 ? w : -w),
					   y : pixel.y + (Math.random() > 0.5 ? h : -h)}
		, newPoint = map.pixelToPoint(newPixel);

		var marker = new BMap.Marker(newPoint);
		if(realBounds.containsPoint(newPoint)){
			markers.push(marker);
			(function(mk){
				mk.addEventListener('click', function(){
					infoBox.open(mk);
				});
			})(marker);
		}
	}
	return markers;
}
