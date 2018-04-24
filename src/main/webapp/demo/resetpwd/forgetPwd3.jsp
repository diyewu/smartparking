<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String preUrl = request.getHeader("Referer");
	if(StringUtils.isBlank(preUrl) || !preUrl.contains("forgetPwd2.jsp")){
		response.sendRedirect("../index.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>忘记密码</title>
<link rel="icon" href="../img/title.png" type="img/x-ico" />
 <style type="text/css">
	 #tips{ font-size: 12px; width: 400px; height: 25px; margin: 4px 0 0 20px;}
	 #tips span{float: left; width: 40px; height: 20px; color: #fff; overflow:hidden; margin-right: 10px;margin-left: 3px; background: #D7D9DD; line-height:20px; text-align: center; }
	 #tips .s1{background: #cc0;}/*黄色*/
	 #tips .s2{background: #fc0;}/*橙色*/
	 #tips .s3{background: #14B12F;}/*绿色*/
	 #tips .s4{background: #D7D9DD;}/*灰色*/
 </style>
<link type="text/css" href="../css/css.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
<script src="../../demo/plugins/layer/layer.js"></script>
 <script type="text/javascript">
 var path = "<%=path%>";
 $(document).ready(function () {
 	$("#firpwd").keyup(function(){
 	  $("#sp1")
	  var index = checkPassWord(this.value);
	  if(index == 0){
	  	$("#sp1").css("background-color","#cc0");
	  	$("#sp2").css("background-color","#D7D9DD");
	  	$("#sp3").css("background-color","#D7D9DD");
	  }else if(index == 2){
	  	$("#sp1").css("background-color","#D7D9DD");
	  	$("#sp2").css("background-color","#fc0");
	  	$("#sp3").css("background-color","#D7D9DD");
	  }else if(index == 3){
	  	$("#sp1").css("background-color","#D7D9DD");
	  	$("#sp2").css("background-color","#D7D9DD");
	  	$("#sp3").css("background-color","#14B12F");
	  }
	});
	
 });
 	//校验密码强度
 function checkPassWord(value){
  var modes = 0;
  if(value.length < 6){//最初级别
   return modes;
  }
  if(/\d/.test(value)){//如果用户输入的密码 包含了数字
   modes++;
  }
  if(/[a-z]/.test(value)){//如果用户输入的密码 包含了小写的a到z
   modes++;
  }
  if(/[A-Z]/.test(value) || /\W/.test(value)){//如果用户输入的密码 包含了大写的A到Z
   modes++;
  }
  return modes;
 }
 function next(){
 	var fpwd = $("#firpwd").val();
 	var spwd = $("#secpwd").val();
 	if(fpwd != spwd){
 		layer.tips('两次输入密码不一致', '#subbtn', {
			tips: [2, '#CC0033']
		});
		return;
 	}
 	var email = $("#femail").val();
	$.post(path+"/webctrl/forgetPwdUpdatePwd/", 
		{
    		pwd:fpwd
		},
		function(result){
			if(result.success == true){//登陆成功
				window.location.href="forgetPwd4.jsp"; 
			}else {
				layer.tips('操作失败：'+result.msg, '#subbtn', {
					tips: [2, '#CC0033']
				});
			}
	},'json');
 }
 </script>
</head>
<body>

<div class="headerBox">
     <img src="../img/logo.png" class="headerLogo">
     <a href="../index.jsp" class="gotoIndex">返回首页</a>
</div>


  <div class="content">
   <div class="web-width">
     <div class="for-liucheng">
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liulist"></div>
      <div class="liutextbox">
       <div class="liutext for-cur"><em>1</em><br /><strong>填写账户名</strong></div>
       <div class="liutext for-cur"><em>2</em><br /><strong>验证身份</strong></div>
       <div class="liutext for-cur"><em>3</em><br /><strong>设置新密码</strong></div>
       <div class="liutext"><em>4</em><br /><strong>完成</strong></div>
      </div>
     </div><!--for-liucheng/-->
     <div class="forget-pwd">
       <dl>
        <dt>新密码：</dt>
        <dd><input style="float: left;" type="password" id="firpwd" />
	        <span id="tips" style="line-height: 30px;magin-left:5px">
				 <span id="sp1">弱</span>
				 <span id="sp2">中</span>
				 <span id="sp3">强</span>
			</span>
        </dd>
        <div class="clears"></div>
       </dl> 
       <dl>
        <dt>确认密码：</dt>
        <dd><input type="password" id ="secpwd"/></dd>
        <div class="clears"></div>
       </dl> 
       <div class="subtijiao"><input type="submit" onclick="next();" id="subbtn" value="提交" /></div> 
      </div><!--forget-pwd/-->
   </div><!--web-width/-->
  </div><!--content/-->
  
</body>
</html>
