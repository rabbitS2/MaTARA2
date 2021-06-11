<%@page import="com.matara.board.CommunityBean"%>
<%@page import="com.matara.board.CommunityDAO"%>
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
	
	
	
		int num = Integer.parseInt(request.getParameter("commu_id"));
		String pageNum = request.getParameter("pageNum");
		
	    // BoardDAO 객체 생성
	    CommunityDAO cdao = new CommunityDAO();
	    
		CommunityBean cb = cdao.getBoard(num);
	%>



	 	<script type="text/javascript">
 		function chk(){
 			
 			if( document.fr.commu_sub.value == "") {
 				alert("제목을 입력하세요");
 				return false;
 			}
 			
 			if(document.fr.commu_content.value == ""){
 				alert("내용을 입력하세요");
 				return false;
 			}
 			
 			document.fr.submit();
 			
 		}
	</script>





<div class="container m-t-150">
	<form action="comu_updatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" enctype="multipart/form-data">
	<h3 class="m-b-20">  [커뮤니티] &emsp;-&emsp; 글 수정</h3>
	<hr class="m-b-30" style="border:#32dbc6 2px solid">
    <table class="table">
    
        <tr>
        <td style="background-color:#ebfffd">글번호</td>
        <td><%=cb.getCommu_id()%><input type="hidden" name="commu_id" value="<%=cb.getCommu_id()%>"></td>
        <td style="background-color:#ebfffd">조회수</td>
        <td><input type="text" name="commu_readcount" value="<%=cb.getCommu_readcount() %>" style="background-color: transparent;border:0px" readonly="readonly"></td>
      </tr>
      
      
      <tr>
        <td style="background-color:#ebfffd">글쓴이</td>
        <td><input type="text" name="user_id" style="background-color: transparent;border:0px" value="<%=cb.getUser_id()%>" readonly="readonly"></td>
        <td style="background-color:#ebfffd">작성일</td>
        <td><%=cb.getCommu_date()%></td>
      </tr>
      
      <tr>
        <td style="background-color:#ebfffd">말머리</td>
        <td colspan="5">
	            <select name="commu_category" class="form-control m-l-15" style="width: 20%">
				  <option value="기타">기타</option>
				  <option value="정보">정보</option>
				  <option value="후기">후기</option>
				  <option value="질문">질문</option>
				</select>
      </tr>
      
      
      <tr>
        <td style="background-color:#ebfffd">글 제목</td>
        <td colspan="5">
        	<div class="col-sm-10">
					<input type="text" name="commu_sub" value="<%=cb.getCommu_sub()%>" class="form-control" id="inputTitle">
			</div>
      </tr>
      
      
      <tr>
        <td style="background-color:#ebfffd">첨부파일</td>
        <td colspan="5">
			 <% if(cb.getFile_name() != null ){ %>
			        <a href="comu_fileDown.jsp?file_name=<%=cb.getFile_name() %>"><%=cb.getFile_name() %></a>
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
	         <textarea name="commu_content" class="form-control" id="inputContent"><%=cb.getCommu_content() %></textarea>
	    </div>
      </tr>
      
    </table>
    	<div class="m-t-60"></div>
    	<div style="margin: auto; width:50%">
    
        <input class="btn btn-primary text-white m-l-20" type="button" onclick="chk()" value="수정하기" >
          <input class="btn btn-primary text-white m-l-20" type="button" value="목록으로" onclick="location.href='comu_list.jsp?pageNum=<%=pageNum %>';" >        
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