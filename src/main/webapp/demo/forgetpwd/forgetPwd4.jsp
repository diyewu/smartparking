<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String preUrl = request.getHeader("Referer");
	if(StringUtils.isBlank(preUrl) || !preUrl.contains("forgetPwd3.jsp")){
		response.sendRedirect("../index.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>忘记密码</title>
<link rel="icon" href="../img/title.png" type="img/x-ico" />
<link type="text/css" href="../css/css.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
 //导航定位
 var emv;
$(document).ready(function () {
	changeClock();
});
var clock = '';
var nums = 5;
function changeClock() {
	clock = setInterval(doLoop, 1000); //一秒执行一次
}
function doLoop() {
	nums--;
	if (nums > 0) {
		$("#secoend").html(nums);
	} else {
		clearInterval(clock); //清除js定时器
		location.href="../login.jsp";
	}
}
</script>

</head>

<body>
<div class="headerBox">
     <img src="../img/logo.png" class="headerLogo">
     <a href="../index.jsp" class="gotoIndex">返回首页</a>
</div>

  <div class="content">
     <div class="for-liucheng">
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liutextbox">
       <div class="liutext for-cur"><em>1</em><br /><strong>填写账户名</strong></div>
       <div class="liutext for-cur"><em>2</em><br /><strong>验证身份</strong></div>
       <div class="liutext for-cur"><em>3</em><br /><strong>设置新密码</strong></div>
       <div class="liutext for-cur"><em>4</em><br /><strong>完成</strong></div>
      </div>
     </div><!--for-liucheng/-->
      <div class="successs">
       <h3>恭喜您，修改成功！</h3>
       <span><em id="secoend" style="color:red">5</em> 秒自动<a style="color:blue" href="../login.jsp">返回首页</a>...</span>
      </div>
   </div><!--web-width/-->
  </div><!--content/-->
 
</body>
</html>
