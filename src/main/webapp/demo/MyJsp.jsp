<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
	<script src="demo/js/jquery-3.2.1.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript"> 
	$(document).ready(function() {
		console.log($("#imagea").width());
		console.log($("#imageb").width());
	});
	document.getElementById('imagea').onload=function(){
		console.log("_______w_____"+this.width);
		console.log("_______h_____"+$(this).width());
	};
	</script>
  </head>
  
  <body>
    <img id="imagea" height="500px" src="http://localhost:8085/gismgr/app/getImgBydetailId?id=00152180529076500109"/>
  </body>
</html>
