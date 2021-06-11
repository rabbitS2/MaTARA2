<%@page import="com.matara.comment.CommentDAO"%>
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
			int comment_idx = Integer.parseInt(request.getParameter("comment_idx"));
			int commu_id = Integer.parseInt(request.getParameter("commu_id"));
			
			CommentDAO cdao = new CommentDAO();
			
			cdao.deleteComment(comment_idx);
			
			
			%>
			
			<script type="text/javascript">
				alert("댓글이 삭제 되었습니다");
				location.href="comu_content.jsp?commu_id=<%=commu_id %>&pageNum=<%=pageNum %>";
			</script>
			
			<%
		}
		%>
		
		



</body>
</html>