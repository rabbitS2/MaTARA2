<%@page import="com.matara.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	var error="";
</script>
<%
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("text/html charset=utf-8");
boolean check=true;
UserDAO udao = new UserDAO();
String mail = request.getParameter("user_mail");

int result = udao.mailCheck(mail);


	if(result == 1)
	{ 
%>
	<script>
	alert("해당 메일이 등록된 아이디가 있습니다");
	window.history.back();
	</script>
<%
	}else{
 response.sendRedirect("rentMailchkPro.jsp?user_mail="+mail);
 
 
}

%>