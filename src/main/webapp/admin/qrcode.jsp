<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<title>二维码</title>
<!-- Custom Theme files -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
<script type="text/javascript" src="../demo/js/jquery-3.2.1.min.js"></script>
<!-- Custom Theme files -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--Google Fonts-->
<!--<link href='//fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
--><!--Google Fonts-->
</head>
<body>
<!--header start here-->
<div class="login-form">
	<div class="top-login">
		<img id="qrcode" src="../demo/img/qrcode.png" width="100%" height="100%" alt="APP下载链接地址"/>
	</div>
	<div class="login-top">
	<div>
		<div class="login-ic">
			<input type="text"  id="code" placeholder="请输入下载APP链接地址"/>
			<div class="clear"> </div>
		</div>
		<div class="log-bwn">
			<input type="submit" onclick="gene();"  value="生成新二维码" >
		</div>
		</div>
	</div>
</div>		
<!--header start here-->
</body>
<script type="text/javascript">
	var path = "<%=path%>";
	function gene(){
    	var code = $("#code").val();
    	if("请输入内容" == code){
    		alert("请填写二维码内容");
    		return;
    	}
    	console.log(code);
    	if($.trim(code)==""){
    		alert("请填写二维码内容");
    		return;
    	}
    	$.post(path+"/authimg/generateQrcode/", 
		{
    		code:code
		},
		function(result){
			if(result.success == true){//登陆成功
				alert("更新成功");
				//$("#qrcode").src = '../demo/img/qrcode.png';
				//$("#qrcode").attr("src", '../demo/img/qrcode.png');
				location.reload(true);   
			}else {
				alert(result.msg);
			}
		},'json');
    }
</script>
</html>