<%@page import="com.matara.board.TravelBean"%>
<%@page import="com.matara.board.TravelDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/top.jsp"%>
<script src="../js/jquery-3.6.0.js"></script>



</head>
<body>


<%
		TravelDAO tdao = new TravelDAO();

	    int cnt = tdao.getBoardCount();
  	     // 한페이지당 보여줄 글의 개수 
		int pageSize = 6;
	   
	   // 현페이지가 몇페이지 인지 확인
	   String pageNum = request.getParameter("pageNum");
	   if(pageNum == null){
		   pageNum = "1";
	   }
	   
	   // 페이지별 시작행 계산하기
	   // 1p -> 1번, 2p -> 11번,3p->21번, ....=>일반화
	   int currentPage = Integer.parseInt(pageNum);
	   int startRow = (currentPage-1)*pageSize+1;
	   
	   // 끝행 계산하기
	   // 1p->10번, 2p->20번, 3p->30번 ....=> 일반화
	   int endRow = currentPage*pageSize;
	   //////////////////////////////////////////////////////
	   //  디비에 저장된 모든 글정보를 가져오기 
	   //ArrayList boardListAll = bdao.getBoardList(); 
	   
	   // 디비에 저장된 모든 글중에서 원하는 만큼만 가져오기(페이지 사이즈)
   		ArrayList boardList = tdao.getBoardList(startRow,pageSize);
  %>



<div class="container m-t-100">
		
			
			
			<section id="container" class="m-t-150">
			<div class="row justify-content-center mb-5">
	          <div class="col-md-8 text-center">
	            <h1 class="text-center">자전거 여행지</h1>
	             <hr class="m-b-20" style="border:#32dbc6 2px solid">
	          </div>
	        </div>
	        
	        
				<form role="form" method="post">
						<div class="form-group row">
				             [글 수 : <%=cnt %>개]
			        	</div>
					 <div class="row">
					<% for(int i=0; i<boardList.size(); i++){ 
							TravelBean tb = (TravelBean) boardList.get(i);
					%>
					<a href="travel_content.jsp?travel_id=<%=tb.getTravel_id()%>&pageNum=<%=pageNum%>">
					 <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
			            <div class="h-entry">
			              <img alt="img" src="${pageContext.request.contextPath}/boradfile/<%=tb.getFile_name() %>" style="width: 300px; height: 300px">
			              <h2 class="font-size-regular" style="color:#474747; font-size: 1.4vw;"><%=tb.getTravel_sub() %></h2>
			              <div class="meta mb-4" style="font-size: 1vw;"><%=tb.getUser_id() %><span class="mx-2">&bullet;</span><%=tb.getTravel_date() %><span class="mx-2">&bullet;</span> <a href="#">조회수<%=tb.getTravel_readcount() %></a></div>
			            </div> 
			          </div>
			         </a>
				<%} %>	
					</div>
					
					
			<hr>
				<div style=" margin: auto; width: 50%;">
			<%
		    //////////////////////////////////////////////////////
		    // 페이징 처리 - 하단부 페이지 링크
		    if(cnt != 0){// 글이있을때 표시
		
		    	//전체 페이지수 계산
		    	// ex)  총 50개 -> 한페이지당 10개 출력, 5개
				//      총 57개 ->       "        , 6개
				int pageCount = cnt/pageSize+(cnt % pageSize == 0? 0:1);
				
				// 한 화면에 보여줄 페이지 번호의 개수 (페이지 블럭)
				int pageBlock = 2;
				
				// 페이지 블럭의 시작페이지 번호 
				// ex)  1~10 페이지 : 1, 11~20페이지 : 11, 21~30페이지 : 21
		        int startPage = ((currentPage-1)/pageBlock) * pageBlock + 1;
				
				// 페이지 블럭의 끝 페이지 번호
				int endPage = startPage+pageBlock-1;
				
				if(endPage > pageCount){
					endPage = pageCount;
				}
		    	
		    	// 이전 (해당 페이지블럭의 첫번째 페이지 호출)
		    	if(startPage > pageBlock){
		    		%>
		    		>
		    		<a href="travel_list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]&emsp;</a>
		    		<%
		    	}   	
		    	
		    	for(int i=startPage;i<=endPage;i++){
		    		%>
		    		    <a href="travel_list.jsp?pageNum=<%=i%>">[<%=i %>]&nbsp;&nbsp;</a> 
		    		<%    		
		    	}
		    	
		    	// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
		    	if(endPage < pageCount){
		    		%>
		    		<a href="travel_list.jsp?pageNum=<%=startPage+pageBlock%>">&emsp;[다음]</a>
		    		
		    		<%
		    	}
		    	
    }
    //////////////////////////////////////////////////////
  %>
  				</div>
  				<div class="search row">
					<div class="col-auto mr-auto"></div>
							<div class="col-auto">
								<button class="btn btn-primary text-white m-t-30 m-b-150" type="button" role="button" onclick="location.href='travel_writeForm.jsp'">글쓰기</button>
							</div>
						</div>
						 
					
					
				</form>
			</section>
		</div>
		





  







<%@ include file="../inc/footer.jsp"%>