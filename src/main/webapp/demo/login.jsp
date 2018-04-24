<%@page import="javax.websocket.Session"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	session.removeAttribute("webUserId");
	session.removeAttribute("webUserName");
	session.removeAttribute("webUserRole");
	session.removeAttribute("webUserRealName");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>登录</title>
    <link rel="icon" href="img/title.png" type="img/x-ico" />
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/animate.min.css">
    <script src="js/jquery-3.2.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/loader.css">
	
	<script src="plugins/layer/layer.js"></script>
    <script type="text/javascript">
    var path = "<%=path%>";
    // 等待所有加载
    //$(window).load(function(){
    $(document).ready(function() { 
        $('body').addClass('loaded');
        $('#loader-wrapper .load_title').remove();
        document.getElementById("img").src="<%=path%>/authimg/generateImage?date=" + new Date();
    }); 
    function changeImg(){
        var img = document.getElementById("img"); 
        img.src = "<%=path%>/authimg/generateImage?date=" + new Date();
    } 
</script>
</head>

<body style="overflow:hidden;">
	<div id="loader-wrapper">
		<div id="loader"></div>
		<div class="loader-section section-left"></div>
		<div class="loader-section section-right"></div>
		<div class="load_title">
			拼命加载中<br>
			<span>请稍后</span>
		</div>
	</div>
    <div class="container">
        <div class="inputBox idBox">
            <input type="text" class="form-control" id="userName" placeholder="请输入账号" aria-describedby="basic-addon1">
        </div>
        <div class="inputBox pwdBox">
            <input type="password" class="form-control" id="userPwd" placeholder="请输入密码" aria-describedby="basic-addon1">
        </div>
        <div class="inputBox codeBox">
            <input type="text" class="form-control" id="userImgCode" placeholder="请输入验证码" aria-describedby="basic-addon1">
            <!-- <img src="img/code.jpg" alt="code"> -->
            <img id="img" onclick="javascript:changeImg()" alt="点击切换"/>
        </div>
        <div class="inputBox pwdBox">
			<button type="button" style="width: 100%;" class="btn btn-secondary" id="loginBtn_">登录</button>
            <a href="../demo/forgetpwd/forgetPwd1.jsp" class="forgetPwd" style="color:#fff">忘记密码</a>
        </div>
        <div class="btnBox">
            <button type="button" class="btn btn-secondary" id="loginBtn">登录</button>
            <a href="http://www.sunrise-market-research.com/"><button type="button" class="btn btn-secondary" style="float:right" id="registerBtn_">联系我们</button></a>
        </div>
    </div>
    <div id="main" style="z-index:-1;position:absolute;top:0;left:0;bottom:0;right:0;"></div>
</body>
	<script src="js/common.js"></script>
	<script src="js/echarts.min.js"></script>
	<script src="js/echarts-gl.min.js"></script>
	<script type="text/javascript" src="js/login.js"></script>
</html>