<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String preUrl = request.getHeader("Referer");
	if(StringUtils.isBlank(preUrl) || !preUrl.contains("index.jsp")){
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
<style type="text/css">

</style>
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
      <div class="liulist"></div>
      <div class="liulist"></div>
      <div class="liulist"></div>
      <div class="liutextbox">
       <div class="liutext for-cur"><em>1</em><br /><strong>填写账户名</strong></div>
       <div class="liutext"><em>2</em><br /><strong>验证身份</strong></div>
       <div class="liutext"><em>3</em><br /><strong>设置新密码</strong></div>
       <div class="liutext"><em>4</em><br /><strong>完成</strong></div>
      </div>
     </div><!--for-liucheng/-->
     <div  class="forget-pwd">
       <dl>
        <dt>账户名：</dt>
        <dd><input type="text" id="userName" /></dd>
        <div class="clears"></div>
       </dl> 
       <dl>
        <dt>验证码：</dt>
        <dd>
         <input type="text" id="code" /> 
         <div class="yanzma">
          <img id="img" src="<%=path%>/authimg/generateImage" onclick="javascript:changeImg()" alt="点击切换"/> <a href="javascript:;" onclick="changeImg();">换一换</a>
         </div>
        </dd>
        <div class="clears"></div>
       </dl>
       <div class="subtijiao"><input type ="submit" id="tijiaobtn" onClick="next();" value="下一步" /></div> 
      </div><!--forget-pwd/-->
   </div><!--web-width/-->
  </div><!--content/-->
  <script type="text/javascript">
    var path = "<%=path%>";
    var preUrl = "<%=preUrl%>";
    console.log(preUrl);
    function changeImg(){
        var img = document.getElementById("img"); 
        img.src = "<%=path%>/authimg/generateImage?date=" + new Date();;
    }
    function next(){
    	var userName = $("#userName").val();
    	var code = $("#code").val();
    	if($.trim(userName)==""){
    		showTip("请填写用户名！",'#userName');
    		return;
    	}
    	if($.trim(code)==""){
    		showTip("请填写图片验证码！",'#code');
    		return;
    	}
    	$.post(path+"/webctrl/forgetPwdCheckNameAndCode/", 
		{
    		userName:userName,
    		code:code
		},
		function(result){
			if(result.success == true){//登陆成功
				window.location.href="forgetPwd2.jsp"; 
			}else {
				layer.tips('操作失败：'+result.msg, '#tijiaobtn', {
					tips: [2, '#CC0033']
				});
				changeImg()
			}
		},'json');
    }
    function showTip(msg,id){
	layer.tips(msg, id, {
		tips: [2, '#CC0033'] //还可配置颜色
	});
}
</script>
</body>
</html>
