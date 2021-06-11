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
		
			
		
			
			CommunityBean cb = new CommunityBean();
			CommunityDAO cdao = new CommunityDAO();

			
			
//		 	//서버에 업로드할 파일의 원본 파일명 얻기
		 	String fileName = multi.getFilesystemName("file_name");
			
		 	
		 	cb.setBg_id(Integer.parseInt(multi.getParameter("bg_id")));
		 	cb.setCommu_category(multi.getParameter("commu_category"));
		 	cb.setCommu_sub(multi.getParameter("commu_sub"));
		 	cb.setCommu_content(multi.getParameter("commu_content"));
		 	cb.setUser_id(multi.getParameter("user_id"));
			cb.setCommu_ip(request.getRemoteAddr());
			cb.setFile_name(fileName);
			
			cdao.insertBoard(cb);
			
			response.sendRedirect("comu_list.jsp");
			
		
		
		
			}
		%>
		
		
</head>
<body>

</body>
</html>