<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String email = session.getAttribute("webUserEmail")+"";
	String preUrl = request.getHeader("Referer");
	if(StringUtils.isBlank(preUrl) || !preUrl.contains("forgetPwd1.jsp")){
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
<script src="../../demo/plugins/layer/layer.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
var email = '<%=email%>'; 
var hasEmail = false;
 //导航定位
$(document).ready(function () {
	if(email && "null" != email){
	 hasEmail = true;
	 $(".selyz").val(1);
	 $(".sel-yzsj").hide();
	 $(".sel-yzyx").show();
	 $("#yzemail").val(email);
	}else{
	 $(".selyz").val(0);
	 $(".sel-yzsj").show();
	 $(".sel-yzyx").hide();
	}
});

var clock = '';
var nums = 120;
var btn;
function sendCode(thisBtn) {
	btn = thisBtn;
	btn.disabled = true; //将按钮置为不可点击
	var temail = "";
	if(hasEmail){
		temail = email;
	}else{
		temail = $("#femail").val();
	}
	$.post(path+"/webctrl/forgetPwdMailCode/", 
		{
    		email:temail
		},
		function(result){
			if(result.success == true){//登陆成功
				//window.location.href="forgetPwd2.jsp"; 
				changeClock(thisBtn);
			}else {
				layer.tips('操作失败：'+result.msg, '#getcode', {
					tips: [2, '#CC0033']
				});
				btn.disabled = false;
			}
	},'json');
}
function changeClock(thisBtn) {
	
	btn.value = nums + '秒后可重新获取';
	clock = setInterval(doLoop, 1000); //一秒执行一次
}
function doLoop() {
	nums--;
	if (nums > 0) {
		btn.value = nums + '秒后可重新获取';
	} else {
		clearInterval(clock); //清除js定时器
		btn.disabled = false;
		btn.value = '点击发送验证码';
		nums = 120; //重置时间
	}
}

function checkCode(){
	var emailcode = $("#emailcode").val();
	$.post(path+"/webctrl/forgetPwdCheckMailCode/", 
		{
    		code:emailcode
		},
		function(result){
			if(result.success == true){//登陆成功
				window.location.href="forgetPwd3.jsp"; 
			}else {
				layer.tips('操作失败：'+result.msg, '#next', {
					tips: [2, '#CC0033']
				});
				btn.disabled = false;
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
      <div class="liulist"></div>
      <div class="liulist"></div>
      <div class="liutextbox">
       <div class="liutext for-cur"><em>1</em><br /><strong>填写账户名</strong></div>
       <div class="liutext for-cur"><em>2</em><br /><strong>验证身份</strong></div>
       <div class="liutext"><em>3</em><br /><strong>设置新密码</strong></div>
       <div class="liutext"><em>4</em><br /><strong>完成</strong></div>
      </div>
     </div><!--for-liucheng/-->
     <div  class="forget-pwd">
       <dl>
        <dt>登陆状态：</dt>
        <dd>
         <select class="selyz" disabled>
          <option value="0">首次登陆</option>
          <option value="1">已有验证邮箱</option>
         </select>
        </dd>
        <div class="clears"></div>
       </dl>
       <!-- 
       <dl>
        <dt>用户名：</dt>
        <dd><input type="text" /></dd>
        <div class="clears"></div>
       </dl>
        -->
       <dl class="sel-yzsj">
        <dt>填写邮箱地址：</dt>
        <dd><input type="text" id="femail"/></dd>
        <div class="clears"></div>
       </dl>
       <dl class="sel-yzyx">
        <dt>已验证邮箱：</dt>
        <dd><input type="text" id = "yzemail" value="" readonly /></dd>
        <div class="clears"></div>
       </dl>
       <dl>
        <dt>邮箱验证码：</dt>
        <dd>
        	<input type="text" id="emailcode"/> 	
        	<input type="button" id="getcode" style="height:32px;width:120px;cursor: pointer;" value="点击发送验证码" onclick="sendCode(this)" />
        </dd>
        <div class="clears"></div>
       </dl>
       <div class="subtijiao"><input type="submit" id="next" onClick = "checkCode();" value="下一步" /></div> 
      </div><!--forget-pwd/-->
   </div><!--web-width/-->
  </div><!--content/-->
  
</body>
</html>
