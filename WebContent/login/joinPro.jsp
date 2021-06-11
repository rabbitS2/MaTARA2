<%@page import="com.matara.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		// 전달정보를 저장(자바빈객체 - 액션태그) id,pw
	%>
	<!-- 자바빈객체 생성 -->
	<jsp:useBean id="ub" class="com.matara.user.UserBean"/>
	<!-- 전달된 파라미터 저장 -->
	<jsp:setProperty property="*" name="ub" />


	<%
	
		System.out.print(ub.getUser_mail());
	
		UserDAO udao = new UserDAO();
		
 		udao.joinUser(ub);
		
		response.sendRedirect("loginForm.jsp"); 
	%>
	
	



</body>
</html>





















