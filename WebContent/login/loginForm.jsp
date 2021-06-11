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
		

	<script type="text/javascript">
	
		$(document).ready(function(){
			$("#loginfr").submit(function(){
				 if($.trim($("#id").val()) == ""){
					 $('.chkMsg_id').text("아이디를 입력하세요");     
		             $('.chkMsg_id').css("color","red"); 
		             $('.chkMsg_id').css("padding-left","1rem"); 
		             return false;
				 }
				 if($.trim($("#pw").val()) == ""){
					 $('.chkMsg_pw').text("비밀번호를 입력하세요");     
		             $('.chkMsg_pw').css("color","red"); 
		             $('.chkMsg_pw').css("padding-left","1rem"); 
		             return false;
				 }
			});
			
			$("#id").keyup(function(){
				 if($.trim($("#id").val()) != ""){
					 $('.chkMsg_id').text("");     
				 }
			});
			
			$("#pw").keyup(function(){
				 if($.trim($("#pw").val()) != ""){
					 $('.chkMsg_pw').text("");     
				 }
			});
			
			
		});
		
	</script>



	
	<div class="limiter">
		<div class="container-login100" >
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form class="login100-form validate-form" action="loginPro.jsp" method="post" id="loginfr">
					<span class="login100-form-title p-b-49">
						<a href="../index.html"><img class="img-logo" src="../images/login_logo.png"/></a>
					</span>

					<div class="wrap-input100 validate-input m-b-23">
						<span class="label-input100">아이디</span>
						<span class="chkMsg_id"></span>  
						<input class="input100" id="id" type="text" name="user_id" placeholder="아이디를 입력하세요">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>

					<div class="wrap-input100 validate-input">
						<span class="label-input100">비밀번호</span>
						<span class="chkMsg_pw"></span>
						<input class="input100" id="pw" type="password" name="user_pw" placeholder="비밀번호를 입력하세요">
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>
					
					<div class="text-right p-t-8 p-b-31">
						<a href="#">
							아이디 / 비밀번호 찾기
						</a>
					</div>
					
					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
								<input type="submit" class="login100-form-btn" id="login_submit" value="로그인" style="background-color:transparent;"> 
	  							
						</div>
					</div>

					<div class="txt1 text-center p-t-54 p-b-20">
						<span>
							SNS로 로그인하기
						</span>
					</div>

					<div class="flex-c-m">
						<a href="#" class="login100-social-item bg1">
							<i class="fa fa-facebook"></i>
						</a>

						<a href="#" class="login100-social-item bg2">
							<i class="fa fa-twitter"></i>
						</a>

						<a href="#" class="login100-social-item bg3">
							<i class="fa fa-google"></i>
						</a>
					</div>
					<div class="txt1 text-center p-t-54 p-b-20">
						<a href="joinSelect.jsp" class="txt2"> 회원가입 </a>
					</div>

				</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>




</body>
</html>