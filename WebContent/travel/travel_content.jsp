<%@page import="com.matara.board.TravelBean"%>
<%@page import="com.matara.board.TravelDAO"%>
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
	
		if (id == null) {
			response.sendRedirect("../login/loginForm.jsp");
		}else{
			
		
		int num = Integer.parseInt(request.getParameter("travel_id"));
		String pageNum = request.getParameter("pageNum");
		
	    // BoardDAO 객체 생성
	    TravelDAO tdao = new TravelDAO();
	    
		// 글 조회수를 1증가  (DB 처리)
		tdao.updateReadcount(num);
		
		// DB에서 글번호(num)에 해당하 글정보를 모두 가져와서 출력	
		TravelBean cb = tdao.getBoard(num); 
	%>
	
	


<div class="container m-t-150">
	<h3 class="m-b-20"> [자전거 여행지]</h3>
	<hr class="m-b-30" style="border:#32dbc6 2px solid">
    <table class="table">
    	
        <tr>
        <td style="background-color:#ebfffd">글번호</td>
        <td><%=cb.getTravel_id() %></td>
        <td style="background-color:#ebfffd">조회수</td>
        <td><%=cb.getTravel_readcount() %></td>
      </tr>
      <tr>
        <td style="background-color:#ebfffd">글쓴이</td>
        <td><%=cb.getUser_id() %></td>
        <td style="background-color:#ebfffd">작성일</td>
        <td><%=cb.getTravel_date() %></td>
      </tr>
      <tr>
        <td style="background-color:#ebfffd">글 제목</td>
        <td colspan="5"><%=cb.getTravel_sub() %></td>
      </tr>
      <tr>
        <td style="background-color:#ebfffd">첨부파일</td>
        <td colspan="5" >
         <% if(cb.getFile_name() != null ){ %>
        <a href="travel_fileDown.jsp?file_name=<%=cb.getFile_name() %>"><%=cb.getFile_name() %></a>
        <%
        	}else{
        		%>
        		-
        		<%
        	}
		%>
		
        
        </td>
      </tr>
      <tr>
        <td style="background-color:#ebfffd">글내용</td>
        <td colspan="5"><%=cb.getTravel_content() %>
        
      
        <% 
        if(cb.getFile_name() != null){
		       String filePath = cb.getFile_name();
		       int pos = filePath.lastIndexOf(".");
		       String fileExt = filePath.substring( pos + 1 );
        
		       if(fileExt.toUpperCase().equals("JPG") || fileExt.toUpperCase().equals("GIF") || fileExt.toUpperCase().equals("PNG")){
		    	  %>
		    	  <br><img alt="img" src="${pageContext.request.contextPath}/boradfile/<%=cb.getFile_name() %>" style="width: 50%"><br>
		    	  <%
		       }
		       
		       
		       
        }
        
        
		%>
        	
        	
        	
   		</td>
      </tr>
      
    </table>
    	<div class="m-t-60"></div>
    	<div style="margin: auto; width:50%">
    	
    	
    	<% 
    	
    	if(id.equals(cb.getUser_id())){ 
    	%>
        <input class="btn btn-primary text-white m-l-20" type="button" value="수정하기" 
                 onclick="location.href='travel_updateForm.jsp?travel_id=<%=cb.getTravel_id() %>&pageNum=<%=pageNum %>';">
          <input class="btn btn-primary text-white m-l-20" type="button" value="삭제하기" 
                onclick=" location.href='travel_delPro.jsp?travel_id=<%=cb.getTravel_id() %>&pageNum=<%=pageNum %>';">
          <%
    	}else{
        
        } %>
          <input class="btn btn-primary text-white m-l-20" type="button" value="목록으로" onclick="location.href='travel_list.jsp?pageNum=<%=pageNum %>';" >        
    	</div>
    	<div  class="m-b-200"></div>
    
 </div>   


<%
		}
%>





<%@ include file="../inc/footer.jsp"%>