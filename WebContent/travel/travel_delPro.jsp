<%@page import="com.matara.board.TravelDAO"%>
<%@page import="com.matara.board.CommunityDAO"%>
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
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("user_id");
		if (id == null) {
			response.sendRedirect("../login/loginForm.jsp");
		}else{
		
			String pageNum = request.getParameter("pageNum");
			int travelid = Integer.parseInt(request.getParameter("travel_id"));
			
			TravelDAO tdao = new TravelDAO();
			
			tdao.deleteBoard(travelid);
			
			
			%>
			
			<script type="text/javascript">
				alert("글이 삭제 되었습니다");
				location.href="travel_list.jsp?pageNum=<%=pageNum%>";
			</script>
			
			<%
		}
		%>
		
		


</body>
</html>