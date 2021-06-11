<%@page import="com.matara.board.*"%>
<%@page import="java.util.ArrayList"%>
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
				response.sendRedirect("../login/loginForm.jsp");
			}else{
				
				int num = Integer.parseInt(request.getParameter("travel_id"));
				String pageNum = request.getParameter("pageNum");
				
			    TravelDAO tdao = new TravelDAO();
			    TravelBean tb = tdao.getBoard(num);
			    
		
		%>

</head>
<body>
 
 	<script type="text/javascript">
 		function chk(){
 			
 			if( document.fr.travel_sub.value == "") {
 				alert("제목을 입력하세요");
 				return false;
 			}
 			
 			if(document.fr.travel_content.value == ""){
 				alert("내용을 입력하세요");
 				return false;
 			}
 			
 			if(document.fr.file_name.value == ""){
 				alert("사진을 등록하세요");
 				return false;
 			}
 			
 			
 			document.fr.submit();
 			
 		}
 	
 	
 	</script>
	






	<div class="container m-t-150">
		<form action="travel_updatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" enctype="multipart/form-data">
		<h3 class="m-b-20"> [자전거 여행지] &emsp;-&emsp; 글 수정</h3>
		<hr class="m-b-30" style="border:#32dbc6 2px solid">
	    <table class="table">
		
		  <tr>
		        <td style="background-color:#ebfffd">글번호</td>
		        <td><%=tb.getTravel_id()%><input type="hidden" name="travel_id" value="<%=tb.getTravel_id()%>"></td>
		        <td style="background-color:#ebfffd">조회수</td>
		        <td><input type="text" name="travel_readcount" value="<%=tb.getTravel_readcount() %>" style="background-color: transparent;border:0px" readonly="readonly"></td>
		      </tr>
		      
		      
		      <tr>
		        <td style="background-color:#ebfffd">글쓴이</td>
		        <td><input type="text" name="user_id" style="background-color: transparent;border:0px" value="<%=tb.getUser_id()%>" readonly="readonly"></td>
		        <td style="background-color:#ebfffd">작성일</td>
		        <td><%=tb.getTravel_date()%></td>
		      </tr>
		      
		      <tr>
		        <td style="background-color:#ebfffd">글 제목</td>
		        <td colspan="5">
		        	<div class="col-sm-10">
							<input type="text" name="travel_sub" value="<%=tb.getTravel_sub()%>" class="form-control" id="inputTitle">
					</div>
		      </tr>
		      
		      
		      <tr>
		        <td style="background-color:#ebfffd">첨부파일</td>
		        <td colspan="5">
					 <% if(tb.getFile_name() != null ){ %>
					        <a href="travel_fileDown.jsp?file_name=<%=tb.getFile_name() %>"><%=tb.getFile_name() %></a>
					        <%
					        	}else{
					        		%>
					        		-
					        		<%
					        	}
							%>
						&emsp;&emsp;		
					<div class="custom-file" id="inputFile" style="width:50%;">
								<input name="file_name" type="file" class="custom-file-input" id="customFile" >
								<label class="custom-file-label"for="customFile">파일을 선택해 주세요.</label>
							</div>	
				</td>
		      </tr>
		      
		      
		      <tr>
		        <td style="background-color:#ebfffd">글내용</td>
		        <td colspan="5">
		        <div class="col-sm-10">
			         <textarea name="travel_content" class="form-control" id="inputContent"><%=tb.getTravel_content() %></textarea>
			    </div>
		      </tr>
		      
		    </table>
		    	<div class="m-t-60"></div>
		    	<div style="margin: auto; width:50%">
		    
		        <input class="btn btn-primary text-white m-l-20" type="button" onclick="chk()" value="수정하기" >
		          <input class="btn btn-primary text-white m-l-20" type="button" value="목록으로" onclick="location.href='travel_list.jsp?pageNum=<%=pageNum %>';" >        
		    	</div>
		    	<div  class="m-b-200"></div>
		    </form>
		 </div>   
		<script>
				$(".custom-file-input").on("change", function() {
				  var fileName = $(this).val().split("\\").pop();
				  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
				});
			</script>
	


<%} %>







<%@ include file="../inc/footer.jsp"%>