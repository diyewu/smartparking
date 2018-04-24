<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'mapTest.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
<!--引用百度地图API-->
<style type="text/css">
.iw_poi_title {
    color: #CC5522;
    font-size: 14px;
    font-weight: bold;
    overflow: hidden;
    padding-right: 13px;
    white-space: nowrap
}

.iw_poi_content {
    font: 12px arial, sans-serif;
    overflow: visible;
    padding-top: 4px;
    white-space: -moz-pre-wrap;
    word-wrap: break-word
}
</style>
<script type="text/javascript"
    src="http://api.map.baidu.com/api?key=&v=1.1&services=true">
</script>
<!--百度地图容器-->
	<div
	    style="width: 600px; height: 450px; border: #ccc solid 1px; margin-bottom: 20px;"
	    id="dituContent"></div>
	<div>
	    <input type="text" id="input" />
	    <input type="button" onclick="searchMap();" value="搜索地图" />
	</div>
</html>
<script type="text/javascript">
//创建和初始化地图函数：
function initMap() {
    createMap(114.025974, 22.546054);//创建地图
    setMapEvent();//设置地图事件
    addMapControl();//向地图添加控件
}

//地图搜索
function searchMap() {
    var area = document.getElementById("input").value; //得到地区
    var ls = new BMap.LocalSearch(map);
    ls.setSearchCompleteCallback(function(rs) {
        if (ls.getStatus() == BMAP_STATUS_SUCCESS) {
            var poi = rs.getPoi(0);
            if (poi) {
                createMap(poi.point.lng, poi.point.lat);//创建地图(经度poi.point.lng,纬度poi.point.lat)
                setMapEvent();//设置地图事件
                addMapControl();//向地图添加控件
            }
        }
    });
    ls.search(area);
}

//创建地图函数：
function createMap(x, y) {
    var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
    var point = new BMap.Point(x, y);//定义一个中心点坐标
    map.centerAndZoom(point, 19);//设定地图的中心点和坐标并将地图显示在地图容器中
    window.map = map;//将map变量存储在全局
}

//地图事件设置函数：
function setMapEvent() {
    map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
    map.enableScrollWheelZoom();//启用地图滚轮放大缩小
    map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
    map.enableKeyboard();//启用键盘上下左右键移动地图
}

//地图控件添加函数：
function addMapControl() {
    //向地图中添加缩放控件
    var ctrl_nav = new BMap.NavigationControl( {
        anchor : BMAP_ANCHOR_TOP_LEFT,
        type : BMAP_NAVIGATION_CONTROL_LARGE
    });
    map.addControl(ctrl_nav);
    //向地图中添加缩略图控件
    var ctrl_ove = new BMap.OverviewMapControl( {
        anchor : BMAP_ANCHOR_BOTTOM_RIGHT,
        isOpen : 1
    });
    map.addControl(ctrl_ove);
    //向地图中添加比例尺控件
    var ctrl_sca = new BMap.ScaleControl( {
        anchor : BMAP_ANCHOR_BOTTOM_LEFT
    });
    map.addControl(ctrl_sca);
}

initMap();//创建和初始化地图
</script>
