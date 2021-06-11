<%@page import="com.matara.board.CommunityDAO"%>
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


		  <%
			request.setCharacterEncoding("UTF-8");
			// 로그인한 사람의 정보를 DB에서 조회해서 
			// jsp화면에 출력

			// 로그인 세션처리 (로그인x->로그인페이지로 이동)
			
			if (id == null) {
				response.sendRedirect("../login/loginForm.jsp");
			}else{
		
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
		<h1> 자전거 여행지 추천 </h1>
		
		<hr class="m-b-50" style="border:#32dbc6 2px solid">
		
		<form action="travel_writePro.jsp"  method="post" enctype="multipart/form-data" name="fr">
		
			<input type="hidden" name="bg_id" class="form-control" id="inputAuthor" value="2">
		
	        
			<div class="form-group row">
				<label for="inputTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
				<div class="col-sm-10">
					<input type="text" name="travel_sub" class="form-control" id="inputTitle">
				</div>
			</div>
			
			<input type="hidden" name="user_id" class="form-control" id="inputAuthor" value="<%=id %>">
				
			<div class="form-group row">
	            <label for="inputContent" class="col-sm-2 col-form-label"><strong>내용</strong></label>
	            <div class="col-sm-10">
	                <textarea type="text" name="travel_content" class="form-control" id="inputContent"></textarea>
	            </div>
      		</div>
 			<div class="form-group row">
				<label for="inputFile" class="col-sm-2 col-form-label"><strong>첨부
						파일</strong></label>
				<div class="col-sm-10">
					<div class="custom-file" id="inputFile">
						<input name="file_name" type="file" class="custom-file-input" id="customFile">
						<label class="custom-file-label"for="customFile">사진을 선택하세요</label>
					</div>
				</div>
			</div> 
			<div class="row">
				<div class="col-auto mr-auto"></div>
				<div class="col-auto">
					<input type="button" class="btn btn-primary text-white m-t-30 m-b-150" role="button" onclick="chk()" value="글쓰기"  style="width:100px">
				</div>
			</div>
		</form>
	</div>
 	<script>
		$(".custom-file-input").on("change", function() {
		  var fileName = $(this).val().split("\\").pop();
		  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
		});
	</script>
	
	
	
	
	
	
	<%
		}
			
	%>
	
	


<%@ include file="../inc/footer.jsp"%>