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
  
  
  
  <div class="container m-t-150">
		<h1> 회원정보 확인 </h1>
		<hr class="m-b-30" style="border:#32dbc6 2px solid">
		 <form action="updateForm.jsp" method="post" class="p-5 bg-white">
			  	
              <div class="row form-group">
                <div class="col-md-6 mb-3 mb-md-0">
                  <input type="hidden" name="user_id" value="<%=id %>">   	
                  <label class="text-black" for="fname">비밀번호</label>
                  <input type="password" name="user_pw" class="form-control">
                  </div>
              </div>


              <div class="row form-group">
                <div class="col-md-12">
                  <input type="submit" value="확인" class="btn btn-primary text-white m-t-20 m-b-100">
                </div>
              </div>

  
            </form>
         </div>
	
	
	
  
  
  <% } %>
  
  
 
  
  
 


	<%@ include file="../inc/footer.jsp"%>
