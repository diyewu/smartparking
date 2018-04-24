<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var lr_systembtn = $("#lr_systembtn");
	var lr_menu = $("#lr_menu");
	lr_systembtn.mouseenter(function(){
		t_delay= setTimeout(function(){
			lr_menu.fadeIn("slow");
		},200);
	});
	lr_systembtn.mouseleave(function(){
		clearTimeout(t_delay);
		lr_menu.fadeOut("slow");
	});

});
</script>
<style>
body{font-size:13px; font-family:"宋体"; color:#333333;}
a{text-decoration: none; color:#333333; font-size:13px; font-family:"宋体";white-space:nowrap; overflow:hidden;}
a:hover{color:#FB3822;}
body,dl,dt,dd{ padding:0px; margin:0px;}
/*懒人建站弹出菜单*/
#lr_systembox{ width:980px; height:50px; background-color:#CCC; position:relative; margin:0 auto; z-index:100000;}
.lr_systembtn{ width:201px; height:35px; line-height:33px;position:absolute; top:0px; right:0px; z-index:100004;}
.lr_systembtn .lr_abtn{ width:100%; height:35px; display:block; font-size:15px; font-weight:bold;color:#666666;
background-image: url(vbbbbbbbbbimg/btn_system.png);background-repeat:no-repeat;background-position:left top;}
.lr_systembtn .lr_abtn:hover{color:#333333;background-position:left bottom;}
.lr_systembtn .lr_abtn span{ padding-left:28px;}
.lr_menu{ width:184px; padding:8px 6px 8px 6px; background-color:#ffffff; border:#ACACAC solid 2px;filter:alpha(opacity=90);opacity: 0.90;
position:absolute; top:35px; right:0px;  z-index:100005;display:none;}
.lr_menu dl{width:100%; display:block; overflow:hidden;}
.lr_menu a{ width:100%;display:block; color:#666666;border-bottom:#ACACAC dashed 1px;height:30px; line-height:30px; font-size:14px;
background-image: url(img/jt1.gif);background-repeat:no-repeat;background-position:6px center;}
.lr_menu a:hover{background-color:#E2E2E2; color:#333333; text-decoration:none;}
.lr_menu dt{}
.lr_menu dt a{font-weight:bold;text-indent:14px;}
.lr_menu dd a{text-indent:24px;background-position:16px center;}
</style>
</head>

<body>

    <div id="lr_systembtn" class="lr_systembtn">
        <a href="#" class="lr_abtn"><span>懒人建站为您提供</span></a>
        <div id="lr_menu" class="lr_menu">
          <dl>
             <dt><a href="http://www.51xuediannao.com/js/" target="_blank">jquery特效</a></dt>
          </dl>
          <dl>
             <dt><a href="http://www.51xuediannao.com/js/nav/" target="_blank">导航菜单</a></dt>
             <dd><a href="#" target="_blank">三级菜单测试</a></dd>
             <dd><a href="#" target="_blank">三级菜单测试</a></dd>
          </dl>   
        </div>
    </div>



</div>
</body>
</html>
