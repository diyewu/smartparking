<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>video</title>
    <script type="text/javascript" src="../map/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../map/js/layer/layer.js"></script>
    <link rel="stylesheet" type="text/css" href="../map/css/layerown.css" />
    <script type="text/javascript" src="../map/js/layerown.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  <body>
  	<div class = "video-class" id = "playearthmap">
	  	<video autoplay muted style="width:100%" onended = "endPlay();";>
	  		<source src="../map/img/dfmz1.mp4">
	  	</video>
  	</div>
  </body>
 <script>

  </script>
</html>
