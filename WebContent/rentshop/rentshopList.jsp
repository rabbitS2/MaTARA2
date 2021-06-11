<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/top.jsp"%>
<script src="../js/jquery-3.6.0.js"></script>
  
<link rel='stylesheet'
	href='/webjars/bootstrap/4.5.0/css/bootstrap.min.css'>
	
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>	
<script src="summer/summernote-lite.js"></script>
<script src="summer/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="summer/summernote-lite.css">
  
</head>
<body>



	<%
		request.setCharacterEncoding("UTF-8");
			
		if (id == null) {
			response.sendRedirect("../login/loginForm.jsp");
		}else{


	
	
   // BoardDAO 객체 생성
   RentshopDAO rsdao = new RentshopDAO();
   // 디비에 글의 수를 계산하는 메서드 생성 -> 호출
   // getBoardCount();
   int cnt = rsdao.getRentshopCount(id);
   
   // 디비에 저장된 모든 글중에서 원하는 만큼만 가져오기(페이지 사이즈)
   ArrayList rentshopList = rsdao.getRentshopList(id);
   
   RentshopBean rb = null;
    
  %>
  
  <script type="text/javascript">
  
  	$(document).ready(function(){
  		$("#chkDel").click(function() {
  			if($("input:checkbox").is(":checked")){
  				var fr = document.listchkDel;
  				fr.submit();
  			}else{
  				alert("삭제할 대여점을 선택하세요");
  			}
  		
  			
  		});	
	});
  	 
 

  </script>
  

		<section id="container" class="m-t-150 m-b-100">
				<div class="row justify-content-center mb-5">
		          <div class="col-md-8 text-center">
		            <h1 class="text-center"><%=id %>님의 자전거 대여소 등록 현황</h1>
		            <hr class="m-b-20" style="border:#32dbc6 2px solid">
		          </div>
		        </div>		  
					   <div class="rentshop_list m-t-30" style="margin-left: 40%">
							<button type="button" class="btn btn-primary text-white" onclick="location.href='rentshopForm.jsp'">대여소등록</button>
							<input type="button" class="btn btn-primary text-white m-l-20" id="chkDel" value="선택 삭제">
					   </div>
					  
					  <div class="form-group row" style="margin-left: 90%">
				             [글 수 : <%=cnt %>개]
			        	</div>
					<form  action="rentDelPro.jsp" method="post" name="listchkDel">
					  <table border="1" class="table table-hover m-b-100">
					    <tr>
					      <td>선택</td>
					      <td>대여소 이름</td>
					      <td>대여소 연락처</td>
					      <td>대여소 위치</td>
					      <td>보유 자전거 총대수</td>
					      <td>성인용 자전거 대수</td>
					      <td>어린이용 자전거 대수</td>
					      <td>2인용 자전거</td>
					    </tr>
	
    
					    <%
					     for(int i=0;i<rentshopList.size();i++){
					    	  rb = (RentshopBean) rentshopList.get(i);
					    	  
					    %>
					     <tr class="rentUpdateEvent">
					      <td><input type="checkbox" name="rsLinstChk_del" value="<%=rb.getRentshop_info_idx() %>"></td>
					      <td onClick="location.href='rentUpdateForm.jsp?rentshop_info_idx=<%=rb.getRentshop_info_idx() %>'"><%=rb.getRentshop_info_name() %></td>
					      <td onClick="location.href='rentUpdateForm.jsp?rentshop_info_idx=<%=rb.getRentshop_info_idx() %>'"><%=rb.getRentshop_info_tel() %></td>
					      <td onClick="location.href='rentUpdateForm.jsp?rentshop_info_idx=<%=rb.getRentshop_info_idx() %>'"><%=rb.getRentshop_info_addr() %></td>
					      <td onClick="location.href='rentUpdateForm.jsp?rentshop_info_idx=<%=rb.getRentshop_info_idx() %>'"><%=rb.getRentshop_info_total() %></td>
					      <td onClick="location.href='rentUpdateForm.jsp?rentshop_info_idx=<%=rb.getRentshop_info_idx() %>'"><%=rb.getRentshop_info_abike() %></td>
					      <td onClick="location.href='rentUpdateForm.jsp?rentshop_info_idx=<%=rb.getRentshop_info_idx() %>'"><%=rb.getRentshop_info_kbike() %></td> 
					      <td onClick="location.href='rentUpdateForm.jsp?rentshop_info_idx=<%=rb.getRentshop_info_idx() %>'"><%=rb.getRentshop_info_tbike() %></td>
					    </tr>
					    
					    <%
					     }
					    %>
					  </table>
					</form>
			</section>









	<script type="text/javascript">
 	 
 	
	
	</script>
	
	<%} %>



	<%@ include file="../inc/footer.jsp"%>
