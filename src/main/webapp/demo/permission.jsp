<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<%@ page language="java" import="java.util.*"%>
<%   
	String webUserId = (String)session.getAttribute("webUserId");
	String ErrorMsg = "您尚未登录！！";
	String urlsessionnoactive = request.getContextPath() + "/demo/login.jsp";
	if(webUserId == null || "".equals(webUserId)){
%>   
<script language="javascript">
	var urlsessionnoactive="<%=urlsessionnoactive%>";
	//alert("<%=ErrorMsg%>");
	top.location.href=urlsessionnoactive;
</script>
<%
}
%>
