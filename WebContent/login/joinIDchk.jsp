<%@page import="com.matara.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		// 전달정보를 저장(자바빈객체 - 액션태그) id,pw

		String id = request.getParameter("user_id");
		
		UserDAO udao = new UserDAO();
		
// 		boolean result=true;
		
		
// 	    if(udao.joinIDCheck(id)==1)
// 	    {
// 	    	result = false;
// 	    }

		int result = udao.joinIDCheck(id);

	
	 %>
	<%=result %> 
	    	
	 



















