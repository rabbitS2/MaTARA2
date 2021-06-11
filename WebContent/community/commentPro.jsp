<%@page import="com.matara.comment.CommentDAO"%>
<%@page import="com.matara.comment.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


	  <%
			request.setCharacterEncoding("UTF-8");
		  

			String id = (String)session.getAttribute("user_id");
			int commu_id = Integer.parseInt(request.getParameter("commu_id"));
			String pageNum = request.getParameter("pageNum");
			
			
			if (id == null) {
				response.sendRedirect("../login/loginForm.jsp");
			}else{
		%>
		
		<!-- 자바빈객체 생성 -->
		<jsp:useBean id="cb" class="com.matara.comment.CommentBean"/>
		<!-- 전달된 파라미터 저장 -->
		<jsp:setProperty property="*" name="cb" />
		
		<% 
		
		   cb.setComment_ip(request.getRemoteAddr());
		   
		
		    System.out.println(cb.toString());
		
			CommentDAO cdao = new CommentDAO();
		
		
			cdao.insertComment(cb);
			
			
			} %>
		
		
		<script type="text/javascript">
			alert("댓글이 작성되었습니다");
			location.href="comu_content.jsp?commu_id=<%=commu_id %>&pageNum=<%=pageNum %>";
		</script>
		
		
		
		
</head>
<body>

</body>
</html>