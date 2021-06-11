<%@page import="com.matara.comment.CommentBean"%>
<%@page import="com.matara.comment.CommentDAO"%>
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
		
		
		
		
		CommentDAO redao = new CommentDAO();
		
		int cnt = redao.getCommentCount();
		
		int pSize = 10;
		
		String pNum = request.getParameter("pNum");
		if(pNum == null){
			pNum = "1";
		}
		
		int cPage = Integer.parseInt(pNum);
		int sRow = (cPage-1)*pSize+1;
		
		int eRow = cPage*pSize;
		
		
		ArrayList commentList = redao.getCommentList(sRow, pSize);
		
		
		%>
		
		
		 
 <script type="text/javascript">
	
		$(document).ready(function(){
			$("#comemnt_msg").keyup(function() {
				 $('#test_cnt').html("("+$(this).val().length+" / 1000)");
				 
			        if($(this).val().length > 1000) {
			            $(this).val($(this).val().substring(0, 1000));
			            $('#test_cnt').html("(1000 / 1000)");
			            $('#test_cnt').css("color","red"); 
			        }else{
			        	 $('#test_cnt').css("color","black"); 
			        }
			});
			
			
			
			
			<% for(int i=0; i<commentList.size(); i++){ 
			CommentBean reb = (CommentBean)commentList.get(i);
			%>
			
			$("#reply<%=reb.getComment_idx()%>").click(function(){
				
				var htmls = "";

				htmls += '<form action="commentRePro.jsp" method="post" name="rfr" >';

				htmls += '<input type="hidden" name="commu_id" class="form-control" value="<%=cb.getCommu_id() %>">';

				htmls += '<input type="hidden" name="pageNum" class="form-control" value="<%=pageNum %>">';

				htmls += '<input type="hidden" name="user_id" class="form-control" value="<%=id %>">';
				
				htmls += '<input type="hidden" name="comment_re_ref" class="form-control" value="<%=reb.getComment_re_ref() %>">';
				htmls += '<input type="hidden" name="comment_re_lev" class="form-control" value="<%=reb.getComment_re_lev() %>">';
				htmls += '<input type="hidden" name="comment_re_seq" class="form-control" value="<%=reb.getComment_re_seq() %>">';

				htmls += '<div class="form-group">';

				htmls += '<textarea name="comment_content" id="comemnt_msg" cols="30" rows="10" class="form-control" style="width:50vw;"></textarea>';

				htmls += '</div>';

				htmls += '<input class="btn btn-primary text-white" type="button" onclick="commentreWrite()" value="댓글등록" style="float: right; margin: 20px;">';
				
				htmls += '</form>'

				$('#re<%=i%>').replaceWith(htmls);

				
			});
			
			<% } %>
			
			
			
			
			
			
			<% for(int i=0; i<commentList.size(); i++){ 
				CommentBean reb = (CommentBean)commentList.get(i);
				%>
				
				$("#reupdate<%=reb.getComment_idx()%>").click(function(){
					
					var htmls = "";

					htmls += '<form action="commentUpdatePro.jsp" method="post" name="ufr" >';

					htmls += '<div id="recontent<%=i%>" style="float:left; margin-left: 20px">';

					htmls += '<input type="hidden" name="comment_idx" value="<%=reb.getComment_idx()%>">';

					htmls += '<h3 style="font-size: 1.3vw;"><%=reb.getUser_id() %></h3>';
					
					htmls += '<div class="meta" style="font-size: 0.7vw; color: #848484;"><%=reb.getComment_date() %></div>';
					
					htmls += '<input type="hidden" name="commu_id" class="form-control" value="<%=cb.getCommu_id() %>">';
					htmls += '<input type="hidden" name="pageNum" class="form-control" value="<%=pageNum %>">';
					htmls += '<input type="hidden" name="user_id" class="form-control" value="<%=id %>">';
					
					htmls += '<textarea name="comment_content" id="comemnt_msg" cols="30" rows="10" class="form-control" style="width:50vw;"><%=reb.getComment_content()%></textarea>';
					
					htmls += '<input class="btn btn-primary text-white" type="button" onclick="reUpate()" value="저장" style="float: right; margin: 20px;" >';
				
					htmls += '</div>';

					htmls += '</form>'
					
					$('#recontent<%=i%>').replaceWith(htmls);
					
					
				});
				
				
				<% } %>
				
				
				
				
			
			
		});
		
</script>
 
		
		
<script type="text/javascript">

	function reWrite() {
		
		if(document.fr.comment_content.value == ""){
				alert("댓글을 입력하세요");
				return false;
			}
			
			document.fr.submit();
	}
	
	function commentreWrite() {
		
		if(document.rfr.comment_content.value == ""){
				alert("댓글을 입력하세요");
				return false;
			}
			
			document.rfr.submit();
	}
	
	
	function reUpate() {
		
		if(document.ufr.comment_content.value == ""){
				alert("댓글을 입력하세요");
				return false;
			}
			
			document.ufr.submit();
	}
	

</script>
				


		
		
		
		
		



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
              <h3 class="mb-5" >댓글</h3>
              <h5 class="mb-5"><%=cnt %> Comments</h5>
              
            
              <ul class="comment-list">
               <% for(int i=0; i<commentList.size(); i++){
            	 	CommentBean reb = (CommentBean)commentList.get(i);
            	 %>
                <li class="comment" style="border-bottom: 1px solid #BDBDBD;">
                  <div style="float:left; margin-left: 20px">
                   <% int wid=0;
                   	  if(reb.getComment_re_lev() > 0){
                   		  wid = 35 * reb.getComment_re_lev();
                   		%>
                        <img src="../images/comment_level.png" height="15px" width="<%=wid%>">
     			       <img src="../images/comment_re.png"  width="30px" >
                        <% } %>
                         <img src="../images/user.png" style="width: 3vw;">
                       </div>
                       <div id="recontent<%=i%>" style="float:left; margin-left: 20px">
                       	<input type="hidden" name="comment_idx" value="<%=reb.getComment_idx()%>">
                         <h3 style="font-size: 1.3vw;"><%=reb.getUser_id() %></h3>
                         <div class="meta" style="font-size: 0.7vw; color: #848484;"><%=reb.getComment_date() %></div>
                         <p style="font-size: 1vw;"><%=reb.getComment_content() %></p>
                        <button type="button" class="btn" style="font-size: 12px; margin-right: 20px;" id="reply<%=reb.getComment_idx()%>">답글쓰기</button>
                         <% if(id.equals(reb.getUser_id())){ %>
                        <button type="button" class="btn" style="font-size: 12px; margin-right: 20px;" id="reupdate<%=reb.getComment_idx()%>">수정</button>	
                         <button type="button" class="btn" style="font-size: 12px; margin-right: 20px;" onclick=" location.href='comment_delPro.jsp?comment_idx=<%=reb.getComment_idx()%>&commu_id=<%=cb.getCommu_id() %>&pageNum=<%=pageNum %>';">삭제</button>	
                         
                         <%} %>
                         <div class="m-b-30" id="re<%=i%>"></div>
                       </div>
                     </li>
                
              
                 <% } %>
              </ul>
	              
             
              <!-- END comment-list -->
              
              
          <div style=" margin-left:40%;" >
			<%
		    //////////////////////////////////////////////////////
		    // 페이징 처리 - 하단부 페이지 링크
		    if(cnt != 0){// 글이있을때 표시
		
		    	//전체 페이지수 계산
		    	// ex)  총 50개 -> 한페이지당 10개 출력, 5개
				//      총 57개 ->       "        , 6개
				int pCount = cnt/pSize+(cnt % pSize == 0? 0:1);
				
				// 한 화면에 보여줄 페이지 번호의 개수 (페이지 블럭)
				int pBlock = 2;
				
				// 페이지 블럭의 시작페이지 번호 
				// ex)  1~10 페이지 : 1, 11~20페이지 : 11, 21~30페이지 : 21
		        int sPage = ((cPage-1)/pBlock) * pBlock + 1;
				
				// 페이지 블럭의 끝 페이지 번호
				int ePage = sPage+pBlock-1;
				
				if(ePage > pCount){
					ePage = pCount;
				}
		    	
		    	// 이전 (해당 페이지블럭의 첫번째 페이지 호출)
		    	if(sPage > pBlock){
		    		%>
		    		>
		    		<a href="comu_content.jsp?pNum=<%=sPage-pBlock%>&pageNum=<%=pageNum %>&commu_id=<%=num %>">[이전]&emsp;</a>
		    		<%
		    	}   	
		    	
		    	for(int i=sPage;i<=ePage;i++){
		    		%>
		    		    <a href="comu_content.jsp?pNum=<%=i%>&pageNum=<%=pageNum %>&commu_id=<%=num %>">[<%=i %>]&nbsp;&nbsp;</a> 
		    		<%    		
		    	}
		    	
		    	// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
		    	if(ePage < pCount){
		    		%>
		    		<a href="comu_content.jsp?pNum=<%=sPage+pBlock%>&pageNum=<%=pageNum %>&commu_id=<%=num %>">&emsp;[다음]</a>
		    		
		    		<%
		    	}
		    	
   		 }
	    //////////////////////////////////////////////////////
	  %>
       </div>
              
              
              
              

              
              <div class="comment-form-wrap pt-5">
                <form action="commentPro.jsp" method="post" name="fr" >
                
                 	<input type="hidden" name="commu_id" class="form-control" value="<%=cb.getCommu_id() %>">
                 	<input type="hidden" name="pageNum" class="form-control" value="<%=pageNum %>">
                 	<input type="hidden" name="user_id" class="form-control" value="<%=id %>">
                 	
                 	
                  <div class="form-group">
                    <div class="m-l-10 m-b-10" id="test_cnt">(0 / 1000)</div>
                    <textarea name="comment_content" id="comemnt_msg" cols="30" rows="10" class="form-control"></textarea>
                  </div>
                  <div class="m-b-200">
                   <input class="btn btn-primary text-white" type="button" onclick="reWrite()" value="댓글등록" style="float: right;">
				  </div>
                </form>
              </div>
            </div>
            
            
 </div>   


<%
		}
%>
















<%@ include file="../inc/footer.jsp"%>