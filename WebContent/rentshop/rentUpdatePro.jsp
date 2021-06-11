<%@page import="com.matara.user.RentshopDAO"%>
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
			}else{
		
	%>
		
	<!-- 자바빈객체 생성 -->
	<jsp:useBean id="rb" class="com.matara.user.RentshopBean"/>
	<!-- 전달된 파라미터 저장 -->
	<jsp:setProperty property="*" name="rb" />


	<%
		String rentshop_info_addr1 = request.getParameter("rentshop_info_addr1");
		String rentshop_info_addr2 = request.getParameter("rentshop_info_addr2");
		String rentshop_info_addr3 = request.getParameter("rentshop_info_addr3");
	
		String rentshop_info_addr = rentshop_info_addr1 + "/" + rentshop_info_addr2 + "/" + rentshop_info_addr3;
	
		rb.setRentshop_info_addr(rentshop_info_addr);
		
		RentshopDAO udao = new RentshopDAO();
		
 		udao.rentshopUpdate(rb);
 		

		response.sendRedirect("rentshopList.jsp");

		
		
		}
	%>
	
	



</body>
</html>