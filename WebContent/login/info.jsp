<%@page import="com.matara.user.UserBean"%>
<%@page import="com.matara.user.UserDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../inc/top.jsp"%>
<script src="../js/jquery-3.6.0.js"></script>

</head>
<body>



	<%
		request.setCharacterEncoding("UTF-8");
		// 로그인한 사람의 정보를 DB에서 조회해서 
		// jsp화면에 출력

		// 로그인 세션처리 (로그인x->로그인페이지로 이동)

		if (id == null) {
			response.sendRedirect("loginForm.jsp");
		}
		
		
		UserDAO udao2 = new UserDAO();
		UserBean ub = udao2.infoUser(id);
	
		if (ub != null) {
	%>
	
	
	
<div class="container m-t-180">
 				<h3 class="m-b-20"> 회원정보 조회</h3>
 				<hr class="m-b-30" style="border:#32dbc6 2px solid">
				<table class="table m-b-80" >
					<tr>
						<td style="background-color:#ebfffd">아이디</td>
						<td><%=ub.getUser_id()%></td>
					<tr>
						<td style="background-color:#ebfffd">이름</td>
						<td><%=ub.getUser_name()%></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">연락처</td>
						<td><%=ub.getUser_phone()%></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">메일</td>
						<td><%=ub.getUser_mail()%></td>
					</tr>

				</table>
			


				<%
					}
				%>
				<div style="margin: auto; width:50%">
				<div class="info_title m-b-230">
					<button type="button" class="btn btn-primary text-white m-r-5"  onclick="location.href='updateCheck.jsp'">회원정보 수정</button>
					<button type="button" class="btn btn-outline-primary m-l-5" onclick="location.href='deleteForm.jsp'">회원탈퇴</button>
				</div>
				</div>
</div>













	<%@ include file="../inc/footer.jsp"%>

