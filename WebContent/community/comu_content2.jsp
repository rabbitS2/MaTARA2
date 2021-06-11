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
			
		
		int num = Integer.parseInt(request.getParameter("commu_id"));
		String pageNum = request.getParameter("pageNum");
		
	    // BoardDAO 객체 생성
	    CommunityDAO cdao = new CommunityDAO();
	    
		// 글 조회수를 1증가  (DB 처리)
		cdao.updateReadcount(num);
		
		// DB에서 글번호(num)에 해당하 글정보를 모두 가져와서 출력	
		CommunityBean cb = cdao.getBoard(num); 
	%>


<div class="container m-t-150">
	<h3 class="m-b-20"> [커뮤니티]</h3>
	 <hr class="m-b-30" style="border:#32dbc6 2px solid">
    <table class="table">
    	<tr>
    	<td></td><td></td><td></td><td></td><td></td><td></td>
    	</tr>
        <tr>
         <td style="background-color:#ebfffd">글번호</td>
        <td ><%=cb.getCommu_id() %></td>
        <td style="background-color:#ebfffd" >조회수</td>
        <td ><%=cb.getCommu_readcount() %></td>
      </tr>
      <tr>
        <td style="background-color:#ebfffd" >글쓴이</td>
        <td ><%=cb.getUser_id() %></td>
        <td style="background-color:#ebfffd"  >작성일</td>
        <td ><%=cb.getCommu_date() %></td>
      </tr>
      <tr>
        <td style="background-color:#ebfffd">글 제목</td>
        <td colspan="4">[<%=cb.getCommu_category()%>]&emsp;<%=cb.getCommu_sub() %>
        </td>
      </tr>
      <tr>
        <td style="background-color:#ebfffd">첨부파일</td>
        <td colspan="4">
         <% if(cb.getFile_name() != null ){ %>
        <a href="comu_fileDown.jsp?file_name=<%=cb.getFile_name() %>"><%=cb.getFile_name() %></a>
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
        <td colspan="4"><%=cb.getCommu_content() %>
        
      
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
                 onclick="location.href='comu_updateForm.jsp?commu_id=<%=cb.getCommu_id() %>&pageNum=<%=pageNum %>';">
          <input class="btn btn-primary text-white m-l-20" type="button" value="삭제하기" 
                onclick=" location.href='comu_delPro.jsp?commu_id=<%=cb.getCommu_id() %>&pageNum=<%=pageNum %>';">
          
          
          <%
    	} %>
        
        <input class="btn btn-primary text-white m-l-20" type="button" value="답글쓰기" 
                onclick="location.href='comu_reWriteForm.jsp?commu_id=<%=cb.getCommu_id() %>&commu_re_ref=<%=cb.getCommu_re_ref() %>&commu_re_lev=<%=cb.getCommu_re_lev() %>&commu_re_seq=<%=cb.getCommu_re_seq() %>';">
                
          <input class="btn btn-primary text-white m-l-20" type="button" value="목록으로" onclick="location.href='comu_list.jsp?pageNum=<%=pageNum %>';" >        
    	</div>
    	<div class="m-b-60"></div>
    	
    	<hr>
    	<div class="pt-5">
              <h3 class="mb-5">6 Comments</h3>
              <ul class="comment-list">
                <li class="comment">
                  <div class="vcard bio">
                    <img src="../images/user.png" alt="Image">
                  </div>
                  <div class="comment-body">
                    <h3>Jacob Smith</h3>
                    <div class="meta">January 9, 2018 at 2:21pm</div>
                    <p>When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrove, the headline of Alphabet Village and the subline of her own road, the Line Lane. Pityful a rethoric question ran over her cheek, then she continued her way.</p>
                    <p><a href="#" class="reply">답글쓰기</a></p>
                  </div>
                </li>

              </ul>
              <!-- END comment-list -->
              
              <div class="comment-form-wrap pt-5">
                <h3 class="mb-5">Leave a comment</h3>
                <form action="#" class="">
                  <div class="form-group">
                    <label for="name">Name *</label>
                    <input type="text" class="form-control" id="name">
                  </div>
                  <div class="form-group">
                    <label for="email">Email *</label>
                    <input type="email" class="form-control" id="email">
                  </div>
                  <div class="form-group">
                    <label for="website">Website</label>
                    <input type="url" class="form-control" id="website">
                  </div>

                  <div class="form-group">
                    <label for="message">Message</label>
                    <textarea name="" id="message" cols="30" rows="10" class="form-control"></textarea>
                  </div>
                  <div class="form-group">
                    <input type="submit" value="Post Comment" class="btn btn-primary btn-md text-white">
                  </div>

                </form>
              </div>
            </div>
            
            
 </div>   


<%
		}
%>
















<%@ include file="../inc/footer.jsp"%>