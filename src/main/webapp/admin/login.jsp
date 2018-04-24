<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String pathName = request.getParameter("pathName")==null?"index":request.getParameter("pathName");
session.removeAttribute("userId");
session.removeAttribute("userName");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>登陆</title>
    <link rel="icon" href="images/title.png" type="img/x-ico" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="../css/jquery.alerts.css">
	<script src="../js/jquery.js"></script>
	<script src="../js/jquery.ui.draggable.js" type="text/javascript"></script>
	<script src="../js/jquery.alerts.js" type="text/javascript"></script>
	<link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/style.css">

  </head>
  
  <body>
    <div class="bg"></div>
    <div class="container">
        <div class="line bouncein">
            <div id="logindiv" class="xs6 xm4 xs3-move xm4-move">
                <div style="height:150px;"></div>
                <div class="media media-y margin-big-bottom">
                </div>
                <form action="index.html" method="post">
                    <div  class="panel loginbox">
                        <div class="text-center margin-big padding-big-top">
                            <h1>GIS后台管理中心</h1>
                        </div>
                        <div class="panel-body" style="padding:30px; padding-bottom:10px; padding-top:10px;">
                            <div class="form-group">
                                <div class="field field-icon-right">
                                    <input type="text" class="input input-big" name="name" id="username" placeholder="登录账号" />
                                    <span class="icon icon-user margin-small"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="field field-icon-right">
                                    <input type="password" class="input input-big" name="password" id="userpwd"  placeholder="登录密码" />
                                    <span class="icon icon-key margin-small"></span>
                                </div>
                            </div>
                            <!-- 
                            <div class="form-group">
                                <div class="field">
                                    <input type="text" class="input input-big" name="code" placeholder="填写右侧的验证码" />
                                    <img src="images/passcode.jpg" alt="" width="100" height="32" class="passcode" style="height:43px;cursor:pointer;" onClick="this.src=this.src+'?'">
                                </div>
                            </div>
                             -->
                        </div>
                        <div style="padding:30px;">
                            <input type="button" id="button" class="button button-block bg-main text-big input-big" onclick="login();" value="登录">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
<script type="text/javascript">
	var path = '<%=path%>';
	function login(){
		var username = $("#username").val();
		var userpwd = $("#userpwd").val();
		var pathName = '<%=pathName%>';
		if(username == null || username == ""){
			jAlert("请输入用户名", '提示');
		}else if(userpwd == null || userpwd == ""){
			jAlert("请输入密码", '提示');
		}else{
			$.post(path+"/userlogin/checkUser/",{"userName":username,"userPwd":userpwd},function(data){
				console.log(data);
				if(true == data.success){
					//跳转
					//console.log(pathName+".jsp");
					window.location.href = pathName+".jsp";
				}else{
					jAlert(data.msg, '提示');
				}
			},"json");
		}
	}
	
	$("#logindiv").keypress(function(e) {
		var keyCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
		if (keyCode == 13) {
			login();
		}
	});
</script>
</html>
