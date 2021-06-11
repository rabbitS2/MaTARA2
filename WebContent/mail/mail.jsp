<%@page import="com.matara.mail.random"%>
<%@page import="com.matara.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<link href="../images/logo.png" rel="shortcut icon" type="image/x-icon">
	<title>Ma TARA</title>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->


 <script src="../js/jquery-3.6.0.js"></script>
 
 
 
		<%
			request.setCharacterEncoding("UTF-8");
		
		%>
 

</head>
<body>

	<script type="text/javascript">
	
	 var chkup = false;
	 
			$(document).ready(function(){
				$("#fr").submit(function(){
					 if($.trim($("#umail").val()) == null){
						 $('.chkMsg_umail').text("이메일을 입력하세요");     
			             $('.chkMsg_umail').css("color","red"); 
			             $('.chkMsg_umail').css("padding-left","1rem"); 
			             $("#umail").focus();
			             return false;
					 }
					 if(chkup == false){
						 return false;
					 }
				 });
				 
				 
				 
				 $("#umail").keyup(function(){
					  
						var umail = $("#umail").val();
						var chk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
						
						if(umail.match(chk) != null){
							$('.chkMsg_umail').text("");     
							chkup = true;  
						}else{
							$('.chkMsg_umail').text("이메일을 정확히 입력하세요");     
							$('.chkMsg_umail').css("color","red"); 
							$('.chkMsg_umail').css("padding-left","1rem");
							chkup = false; 
						}
					 	});
			
			});
	</script>
	

	
	
<% 
random r = new random();
String content = r.randomNum();
session.setAttribute("content", content);
%>
</head>
<body>




	<div class="limiter">
		<div class="container-login100" >
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form class="login100-form validate-form" method="post" action="mailPro.jsp" id="fr">
					<span class="login100-form-title p-b-49">
						<a href="../index.html"><img class="img-logo" src="../images/login_logo.png"/></a>
					</span>
					<input type="hidden" name="content" value="<%=content%>"> <label style="font-size: 20px; color:#585858;"> 일반회원 메일인증
					</label><hr><br>
				
					<div class="wrap-input100 validate-input m-b-23">
						<span class="chkMsg_umail"></span>  
						<input type="email" class="input100" id="umail" name="user_mail" placeholder="메일을 입력하세요" required="required">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>


					<div class="container-login100-form-btn m-b-200">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
								<input type="submit" class="login100-form-btn" value="메일인증" style="background-color:transparent;"> 
	  							
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
				


	
</body>
</html>