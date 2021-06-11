<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.matara.board.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

		  <%
			request.setCharacterEncoding("UTF-8");
		  

			String id = (String)session.getAttribute("user_id");
			
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
		
			
		
			
			TravelBean tb = new TravelBean();
			TravelDAO tdao = new TravelDAO();

			
			
//		 	//서버에 업로드할 파일의 원본 파일명 얻기
		 	String fileName = multi.getFilesystemName("file_name");
			
		 	
		 	tb.setBg_id(Integer.parseInt(multi.getParameter("bg_id")));
		 	tb.setTravel_sub(multi.getParameter("travel_sub"));
		 	tb.setTravel_content(multi.getParameter("travel_content"));
		 	tb.setUser_id(multi.getParameter("user_id"));
			tb.setTravel_ip(request.getRemoteAddr());
			tb.setFile_name(fileName);
			
			tdao.insertBoard(tb);
			
			response.sendRedirect("travel_list.jsp");
			
		
		
		
			}
		%>
		
		
</head>
<body>

</body>
</html>