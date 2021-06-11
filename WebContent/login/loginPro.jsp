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
	
	    String id = request.getParameter("user_id");
	
		String pw = request.getParameter("user_pw");
	
		UserDAO udao = new UserDAO();
			
	    int result = udao.idCheck(id , pw);

	    System.out.println(id);
	    System.out.println(pw);
	    
	    
	    if(result == 1){
	    	session.setAttribute("user_id", id);
	    	%>
	    	
	    	<script type="text/javascript">
	    		alert("로그인 되었습니다");
	    		location.href="<%=request.getContextPath()%>/main/main.jsp";
	    	</script>
	    	
	    	<% 
	    }else if(result == 0){
	    	%>
	    	
	    	<script type="text/javascript">
	    		alert("아이디 또는 비밀번호를 확인하세요");
	    		history.back();
	    	</script>
	    	
	    	<% 
	    }else{
	    	%>
	    	
	    	<script type="text/javascript">
	    	
	    		var noid = confirm("비회원입니다. 회원가입하시겠습니까?");
	    		
	    		if(noid){
	    			location.href="joinSelect.jsp"
	    		}else{
	    			history.back();
	    		}
	    	
	    	</script>
	    	
	    	<% 
	    }
	
			%>
	

</body>
</html>

























