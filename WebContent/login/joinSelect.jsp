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
 
 

</head>
<body>

		<%
			request.setCharacterEncoding("UTF-8");
		
		%>
		


	<div class="limiter">
		<div class="container-login100" >
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form class="login100-form validate-form" action="joinPro.jsp" method="post" id="joinfr">
					<span class="login100-form-title p-b-49">
						<a href="../index.html"><img class="img-logo" src="../images/login_logo.png"/></a>
					</span>

					<div class="m-b-30">
						<a href="../mail/mail.jsp"><img class="img-joins" src="../images/userJOIN.png"/></a>
						<a href="../mail/rentMail.jsp"><img class="img-joins" src="../images/rentshopJOIN.png"/></a>
					</div>
					
					<div class="txt1 text-center p-t-54 p-b-20 m-b-250">
						<a href="loginForm.jsp" class="txt2"> 로그인하러 가기 </a>
					</div>
					
					
				</form>
			</div>
		</div>
	</div>
	




</body>
</html>