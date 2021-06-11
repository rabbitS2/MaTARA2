<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.matara.board.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
	
		request.setCharacterEncoding("UTF-8");
		// 로그인한 사람의 정보를 DB에서 조회해서 
		// jsp화면에 출력

		// 로그인 세션처리 (로그인x->로그인페이지로 이동)
		String id = (String) session.getAttribute("user_id");
		String pageNum = request.getParameter("pageNum");
		
		
		if (id == null) {
			response.sendRedirect("../login/loginForm.jsp");
		}else{
			 // 1) 파일이 저장될 위치 지정
			   
			 
			 
		     int maxSize = 10 * 1024 * 1024;
		
			// 파일 업로드 => Multipart객체를 생성
			   MultipartRequest multi 
			      = new MultipartRequest(
			    		  request,
			    		  "D:/workspace_jsp2/MaTARA2/WebContent/boradfile",
			    		  maxSize,
			    		  "UTF-8",
			    		  new DefaultFileRenamePolicy()
			    		  );
			
			
			TravelBean cb = new TravelBean();
			TravelDAO cdao = new TravelDAO();

			
			
//		 	//서버에 업로드할 파일의 원본 파일명 얻기
		
		 	cb.setTravel_sub(multi.getParameter("travel_sub"));
		 	cb.setTravel_content(multi.getParameter("travel_content"));
			cb.setTravel_id(Integer.parseInt(multi.getParameter("travel_id")));
			cb.setFile_name(multi.getFilesystemName("file_name"));
			

			System.out.print(cb.toString());
			
			cdao.updateBoard(cb);
			
			
			
		%>
		
		<script type="text/javascript">
			alert("글이 수정되었습니다");
			location.href="travel_list.jsp?pageNum=<%=pageNum%>";
		</script>
		
		<% } %>

</body>
</html>