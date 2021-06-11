<%@page import="com.matara.user.UserBean"%>
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
	String content = (String)session.getAttribute("content");
	String user_mail= (String)session.getAttribute("user_mail");
	session.removeAttribute("user_mail");
	

	request.setCharacterEncoding("UTF-8");




%>



<script type="text/javascript">

function check() {
	var code = document.fr.con_chk.value;
	var authNum = <%=content %>;
	
	if(!code) {
		alert("인증번호를 입력해주세요");
		return;
	}
	
	if(authNum == code) {
		
		alert("인증 되었습니다.");
		
	<%
		session.removeAttribute("content");
	
	%>
		
		fr.submit();
	
		
	} else {
		alert("인증번호가 틀립니다. 다시 입력해 주세요.");
		return;
	}
}
</script>

</head>
<body>

<div class="limiter">
		<div class="container-login100" >
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form class="login100-form validate-form" method="post" name="fr" action="../login/joinForm.jsp" id="fr">
					<span class="login100-form-title p-b-49">
						<a href="../index.html"><img class="img-logo" src="../images/login_logo.png"/></a>
					</span>
					<label style="font-size: 20px; color:#585858;"> 인증번호</label>
					<hr><br>
					
					<div class="wrap-input100 validate-input m-b-23">
						<input type="text" class="input100" id="umail" name="con_chk" placeholder="인증번호를 입력하세요" required="required">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
						<input type="hidden" name="user_mail" value="<%=user_mail%>">
					</div>
					<div class="container-login100-form-btn m-b-200">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
								<input type="button" class="login100-form-btn" onclick="check();" value="메일인증" style="background-color:transparent;"> 
						</div>
					</div>
				</form>
		</div>
	</div>
</div>











</body>
</html>