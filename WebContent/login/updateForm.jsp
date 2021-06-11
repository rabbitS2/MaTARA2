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
			}else{
		
		%>
		
			<jsp:useBean id="ub" class="com.matara.user.UserBean" />
			<jsp:setProperty property="*" name="ub" />
			
			

		<%

		
 			String uid = request.getParameter("user_id");
	
			String pw = request.getParameter("user_pw");
	
			UserDAO udao2 = new UserDAO();
 	
	    	int result = udao.idCheck(uid, pw);
	    	
	    	if(result == 0){
	    		%>
		    	
		    	<script type="text/javascript">
		    		alert("비밀번호를 확인하세요");
		    		history.back();
		    	</script>
		    	
		    	<% 
	    	}else if(result == -1){
	    		%>
		    	<script type="text/javascript">
		    	  alert("세션 만료입니다");
			      location.href="../main/main.jsp";
		    	</script>
		    	
		    	<% 
	    	}
	    	
	    	
	    	%>
	    	
	    	
		<script type="text/javascript">
		
		 var chkup1 = false;
		 var chkup2 = false;
		 
		$(document).ready(function(){
			 $("#updatefr").submit(function(){
				 if($.trim($("#uname").val()) == ""){
					 $('.chkMsg_uname').text("이름을 입력하세요");     
		             $('.chkMsg_uname').css("color","red"); 
		             $('.chkMsg_uname').css("padding-left","1rem"); 
		             return false;
				 }
				 if($.trim($("#uphone").val()) == ""){
					 $('.chkMsg_uphone').text("연락처를 입력하세요");     
		             $('.chkMsg_uphone').css("color","red"); 
		             $('.chkMsg_uphone').css("padding-left","1rem"); 
		             return false;
				 }
			
				 
				   if(chkup1 == false || chkup2 == false ){
						 return false;
					 }
			 });//umdatefr
				
				 $("#uname").keyup(function(){
					 var uname = $("#uname").val();
					 var chk = /^[A-Z|a-z|가-힣]{1,14}$/;
					 if(uname.match(chk) != null){
							$('.chkMsg_uname').text("");     
							chkup1 = true;
						}else{
				            $('.chkMsg_uname').text("이름을 정확히 입력하세요");     
							$('.chkMsg_uname').css("color","red"); 
							$('.chkMsg_uname').css("padding-left","1rem");
							chkup1 = false;
						}
					 
				 });//uname
				 
				 
				 $("#uphone").keyup(function(){
					 var uphone = $("#uphone").val();
					 var chk1 = /^010([0-9]{8})$/;
					 var chk2 = /^01([1|6|7|8|9])([0-9]{3})([0-9]{4})$/;
						if(uphone.match(chk1) != null || uphone.match(chk2) != null ){
							$('.chkMsg_uphone').text("");     
							chkup2 = true;
						}else{
				            $('.chkMsg_uphone').text("연락처를 정확히 입력하세요");     
							$('.chkMsg_uphone').css("color","red"); 
							$('.chkMsg_uphone').css("padding-left","1rem");
							chkup2 = false;
						}
				 	});//uphone
				 	
				 
			
				 
			 });//updatefr
		
		
		
		
		</script>
		
	    	
	    	<%

	    	ub = udao.infoUser(id);
	    
	    	
			if (ub != null) {
				
				
				
		%>
	
	
	
    <div class="container m-t-180">
 				<h3 class="m-b-20"> 회원정보 수정</h3>
 				<hr class="m-b-50" style="border:#32dbc6 2px solid">
 				<form action="updatePro.jsp" method="post" name="fr" id="updatefr">
				<table class="table m-b-50" >
					<tr>
						<td style="background-color:#ebfffd">아이디</td>
						<td><input type="text" name="user_id" value="<%=ub.getUser_id() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">비밀번호</td>
						<td><input type="hidden" name="user_pw" value="<%=ub.getUser_pw() %>"><button type="button" class="btn btn-primary text-white">비밀번호 변경하기</button></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">이름</td>
						<td><input type="text" id="uname" name="user_name" value="<%=ub.getUser_name() %>">
							<span class="chkMsg_uname"></span></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">연락처</td>
						<td><input type="text" id="uphone" name="user_phone" value="<%=ub.getUser_phone()%>">
							<span class="chkMsg_uphone"></span></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">메일</td>
						<td><input type="email" id="umail" name="user_mail" value="<%=ub.getUser_mail() %>" readonly="readonly">
							<span class="chkMsg_umail"></span></td>
					</tr>

				</table>


              <div class="row form-group" style="margin-left: 50%">
                <div class="col-md-12">
                  <input type="submit" value="저장" class="btn btn-primary text-white m-b-100" id="update_submit">
                </div>
              </div>
			</form>
  		</div>
  
	
	
	

		<%
					}
			}
		%>

				



	<%@ include file="../inc/footer.jsp"%>

