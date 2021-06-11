<%@page import="com.matara.user.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Quicksand:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="../fonts/icomoon/style.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/jquery-ui.css">
    <link rel="stylesheet" href="../css/owl.carousel.min.css">
    <link rel="stylesheet" href="../css/owl.theme.default.min.css">
    <link rel="stylesheet" href="../css/owl.theme.default.min.css">
    <link rel="stylesheet" href="../css/jquery.fancybox.min.css">
    <link rel="stylesheet" href="../css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="../fonts/flaticon/font/flaticon.css">
    <link rel="stylesheet" href="../css/aos.css">
    <link rel="stylesheet" href="../css/style.css">

	<link href="../images/logo.png" rel="shortcut icon" type="image/x-icon">
	<title>Ma TARA</title>
	

	<link rel="stylesheet" type="text/css" href="../css/util.css">
	
	
</head>
<body>


	<%
		request.setCharacterEncoding("UTF-8");

	%>





	<!-- 모바일 메뉴   -->
    <div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
          <span class="icon-close2 js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div>
   
   
   
   	<!-- 상단바(로그인/회원가입)   -->
    <div class="border-bottom top-bar py-2 bg-dark" id="home-section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <p class="mb-0">
              <span class="mr-3"><strong class="text-white">Phone:</strong> <a href="tel://#">+1 234 1234 1234</a></span>
              <span><strong class="text-white">Email:</strong> <a href="#">MaTARA@gmail.com</a></span>
            </p>
          </div>
          <div class="col-md-6">
            <ul class="social-media">
			        <% 
			   		String id = (String) session.getAttribute("user_id");
			      
			      	UserDAO udao = new UserDAO();
					int id_result = udao.joinIDCheck(id);
			      
			    
			  			if(id_result == 1){
			  	  %>		
					      <li style="color:#ffffff;"><%=id %>님 </li>&emsp;&emsp;
					      <li><a href="../login/info.jsp"> 회원정보 </a></li>&emsp;&emsp;
					      <li><a href="../login/logout.jsp"> 로그아웃</a></li>
			      <% 	}else if(id_result == 2){
			      %> 
			      		  <li style="color:#ffffff;"><%=id %>님</li>&emsp;&emsp;
			      		  <li><a href="../rentshop/rentshopList.jsp"> 대여소등록 </a></li>&emsp;&emsp;
					      <li><a href="../login/info.jsp"> 회원정보</a></li>&emsp;&emsp;
					      <li><a href="../login/logout.jsp"> 로그아웃</a></li>
			      <%  
			     		 }else{
			     			 %>
						      <li><a href="../login/loginForm.jsp">로그인</a></li>&emsp;&emsp;
						      <li><a href="../login/joinSelect.jsp">회원가입</a></li>
						      <%
			     		 }
			    	
				  %>
            </ul>
          </div>
        </div>
      </div> 
    </div>
   
   
   
   
   <!-- 네비바   -->
   <header class="site-navbar py-4 bg-white js-sticky-header site-navbar-target" role="banner">

      <div class="container">
        <div class="row align-items-center">
          
          <div class="col-11 col-xl-2">
           <a href="../main/main.jsp" class="text-black h2 mb-0"><img class="img-logo" src="../images/logo2.png"/></a>
          </div>
          <div class="col-12 col-md-10 d-none d-xl-block">
            <nav class="site-navigation position-relative text-right" role="navigation">

              <ul class="site-menu main-menu js-clone-nav mr-auto d-none d-lg-block">
                <li><a href="../map/map.jsp" class="nav-link">자전거 대여소</a></li>
                <li> | </li>
                <li>
                  <a href="../community/comu_list.jsp" class="nav-link">커뮤니티</a>
                </li>
                <li> | </li>
                <li>
                  <a href="../travel/travel_list.jsp" class="nav-link">추억이 방울방울</a>
                </li>
                <li> | </li>
                <li class="has-children">
                  <a href="#about-section" class="nav-link">고객센터</a>
                  <ul class="dropdown">
                    <li><a href="#about-section">공지사항</a></li>
                    <li><a href="#team-section">1:1문의</a></li>
                  </ul>
                </li>
              </ul>
            </nav>
          </div>

          <div class="d-inline-block d-xl-none ml-md-0 mr-auto py-3" style="position: relative; top: 3px;"><a href="#" class="site-menu-toggle js-menu-toggle text-black"><span class="icon-menu h3"></span></a></div>

        </div>
      </div>
      
    </header>
   
   
   
   
