<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>加载动画</title>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
-->
<!--页面加载start-->
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">         
    // 等待所有加载
    $(window).load(function(){
        $('body').addClass('loaded');
        $('#loader-wrapper .load_title').remove();
    }); 
</script>    
<link rel="stylesheet" type="text/css" href="../map/css/loader.css">
</head>

<body>
	<div id="loader-wrapper">
		<div id="loader"></div>
		<div class="loader-section section-left"></div>
		<div class="loader-section section-right"></div>
		<div class="load_title">
			正在加载LoveFeel站点<br>
			<span>V1.0</span>
		</div>
	</div>
	
	<!--页面加载end-->
</body>
</html>
