<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <style type="text/css">
    @import url("http://cdn.gbtags.com/font-awesome/4.1.0/css/font-awesome.min.css");

		body{
		    background:#CFCFCF;
		    font-family: 'microsoft yahei',Arial,sans-serif;
		}
		
		h2{
		  font-weight: normal;
		  font-size:18px;
		  text-align:center;
		}
		
		.desc{
		  text-align:center;
		  font-size:12px;
		  color: #AFAFAF;
		}
		
		#holder{
		  background: white;
		  padding: 10px;
		  width: 250px;
		  margin: 60px auto;
		  box-shadow: 0px 3px 10px rgba(0,0,0,0.2);
		}
		.button {
		  background: orange;
		  margin : 20px auto;
		  width : 200px;
		  height : 50px;
		  overflow: hidden;
		  text-align : center;
		  transition : .2s;
		  cursor : pointer;
		  box-shadow: 0px 1px 2px rgba(0,0,0,.2);
		}
		.btnTwo {
		  position : relative;
		  width : 200px;
		  height : 100px;
		  margin-top: -100px;
		  padding-top: 2px;
		  background : #26A69A;
		  left : -250px;
		  transition : .3s;
		}
		.btnText {
		  color : white;
		  transition : .3s;
		}
		.btnText2 {
		  margin-top : 63px;
		  margin-right : -130px;
		  color : #FFF;
		}
		.button:hover .btnTwo{ 
		  left: -130px;
		}
		.button:hover .btnText{ 
		  margin-left : 65px;
		}
		.button:active { 
		  box-shadow: 0px 5px 5px rgba(0,0,0,0.4);
		}
	</style>
</head>

<body>
<div id="holder">

<h2>buttotn</h2>
<p class="desc">请将鼠标悬浮于橙色按钮</p>

<div class="button">
    <p class="btnText">确认</p>
    <div class="btnTwo">
      <p class="btnText2"> <i class="fa fa-check"></i> </p>
    </div>
 </div>

<div class="button">
    <p class="btnText">取消</p>
    <div class="btnTwo">
      <p class="btnText2"> <i class="fa fa-times"></i> </p>
    </div>
 </div>

</div>
</body>

<script type="text/javascript" src="http://cdn.gbtags.com/jquery/1.11.1/jquery.min.js"></script>
</html>