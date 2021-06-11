<%@page import="com.matara.user.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

		<%
			request.setCharacterEncoding("UTF-8");
			// 로그인한 사람의 정보를 DB에서 조회해서 
			// jsp화면에 출력

			// 로그인 세션처리 (로그인x->로그인페이지로 이동)
			String id = (String) session.getAttribute("user_id");
			
			if (id == null) {
				response.sendRedirect("loginForm.jsp");
			}
		
		%>
	<!-- 자바빈객체 생성 -->
	<jsp:useBean id="ub" class="com.matara.user.UserBean"/>
	<!-- 전달된 파라미터 저장 -->
	<jsp:setProperty property="*" name="ub" />
	
	
	<%
		
		UserDAO udao = new UserDAO();
	
		System.out.println(ub.toString());
		
	

		int result = udao.updateUser(ub);
		

		if(result == 1){
			%>
	    	<script type="text/javascript">
	    		alert("회원정보가 수정되었습니다");
	    		location.href="<%=request.getContextPath()%>/login/info.jsp";
	    	</script>
	    	
	    	<% 		
		}else{
			%>
	    	<script type="text/javascript">
	    		alert("세션이 만료되었습니다");
	    		location.href="<%=request.getContextPath()%>/main/main.jsp";
	    	</script>
	    	<% 
		}
		
		
		
	%>





</body>
</html>


































