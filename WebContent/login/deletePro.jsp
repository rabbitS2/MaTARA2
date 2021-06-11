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
</head>
<body>

	<%
		// 세션제어 
		String uid = (String) session.getAttribute("user_id");
		if (uid == null) {
			response.sendRedirect("loginForm.jsp");
		}
		// 한글처리 
		request.setCharacterEncoding("UTF-8");

		// 전달되는 정보 저장
	%>
	<jsp:useBean id="ub" class="com.matara.user.UserBean" />
	<jsp:setProperty property="*" name="ub" />

	<%
		
 		String id = request.getParameter("user_id");
	
		String pw = request.getParameter("user_pw");
	
		UserDAO udao = new UserDAO();
 	
	    int result = udao.deleteUser(id , pw);
	
		
		if(result == 1){
	    	session.invalidate();
	    	%>
	    	
	    	<script type="text/javascript">
	    		alert("회원 탈퇴되었습니다");
	    		location.href="<%=request.getContextPath()%>/main/main.jsp";
	    	</script>
	    	
	    	<% 
	    }else if(result == 0){
	    	%>
	    	
	    	<script type="text/javascript">
	    		alert("비밀번호를 확인하세요");
	    		history.back();
	    	</script>
	    	
	    	<% 
	    }else{
	    	%>
	    	
	    	<script type="text/javascript">
	    	  alert(" 세션 만료입니다 ");
	    	  location.href="<%=request.getContextPath()%>/main/main.jsp";
	    	</script>
	    	
	    	<% 
	    }
	
			%>






</body>
</html>














