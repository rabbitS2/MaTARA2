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
	
	
	 var chkup1 = false;
	 var chkup2 = false;
	 var chkup3 = false;
	 var chkup4 = false;
	 var chkup5 = false;

		$(document).ready(function(){
			$("#joinfr").submit(function(){
				 if($.trim($("#uid").val()) == ""){
					 $('.chkMsg_uid').text("아이디를 입력하세요");     
		             $('.chkMsg_uid').css("color","red"); 
		             $('.chkMsg_uid').css("padding-left","1rem"); 
		             $("#uid").focus();
		             return false;
				 }
				 if($.trim($("#upw").val()) == ""){
					 $('.chkMsg_upw').text("비밀번호를 입력하세요");     
		             $('.chkMsg_upw').css("color","red"); 
		             $('.chkMsg_upw').css("padding-left","1rem"); 
		             $("#upw").focus();
		             return false;
				 }
				 if($.trim($("#upwc").val()) == ""){
					 $('.chkMsg_upwc').text("비밀번호 확인을 입력하세요");     
		             $('.chkMsg_upwc').css("color","red"); 
		             $('.chkMsg_upwc').css("padding-left","1rem"); 
		             $("#upwc").focus();
		             return false;
				 }
				 if($.trim($("#uname").val()) == ""){
					 $('.chkMsg_uname').text("이름을 입력하세요");     
		             $('.chkMsg_uname').css("color","red"); 
		             $('.chkMsg_uname').css("padding-left","1rem"); 
		             $("#uname").focus();
		             return false;
				 }
				 if($.trim($("#uphone").val()) == ""){
					 $('.chkMsg_uphone').text("연락처를 입력하세요");     
		             $('.chkMsg_uphone').css("color","red"); 
		             $('.chkMsg_uphone').css("padding-left","1rem"); 
		             $("#uphone").focus();
		             return false;
				 }
				 if($.trim($("#umail").val()) == ""){
					 $('.chkMsg_umail').text("이메일을 입력하세요");     
		             $('.chkMsg_umail').css("color","red"); 
		             $('.chkMsg_umail').css("padding-left","1rem"); 
		             $("#umail").focus();
		             return false;
				 }
				 
				 if(chkup1 == false || chkup2 == false || chkup3 == false || chkup4 == false || chkup5 == false){
					 return false;
				 }
		
			 });//joinfr
			 
			 
			 
		 $("#uid").keyup(function(){
			var user_id = $("#uid").val();
			var chk = /^[A-Za-z\d_-]{4,15}$/;
			
			$.ajax({
				 url:'joinIDchk.jsp',
			     type:'post',
			     data:{"user_id":user_id}, 
			     success:function(data){
			    	if(data.trim() > 0){
			                $('.chkMsg_uid').text("이미 존재하는 아이디입니다");     
			                $('.chkMsg_uid').css("color","red"); 
			                $('.chkMsg_uid').css("padding-left","1rem"); 
			                chkup1 = false; 			                
			    		}else{
			    			
			    			if(user_id.match(chk) != null){
								$('.chkMsg_uid').text("사용가능한 아이디입니다");
								$('.chkMsg_uid').css("color","green");
								chkup1 = true;
							}else{
								$('.chkMsg_uid').text("아이디는 4~15자리만 가능합니다");     
								$('.chkMsg_uid').css("color","red"); 
								$('.chkMsg_uid').css("padding-left","1rem");
								chkup1 = false; 
							}
		                }
		               },
		        		error:function(){
		                alert("에러입니다");
		               }
		          });
			});//uid
		 
		 $("#upw").keyup(function(){
			 var user_pw = $("#upw").val();
			 var chk=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/.test(user_pw);
			 
			 if(user_pw == null){
					$('.chkMsg_upw').text("비밀번호를 입력하세요");     
					$('.chkMsg_upw').css("color","red"); 
 					$('.chkMsg_upw').css("padding-left","1rem"); 
 					chkup2 = false;
				
			 }else if(chk){
				 	$('.chkMsg_upw').text("사용 가능한 비밀번호입니다");     
					$('.chkMsg_upw').css("color","green");
					$('.chkMsg_upw').css("padding-left","1rem"); 
					chkup2 = true; 
			 }else{
				 $('.chkMsg_upw').text("대소문자,숫자,특수문자 중 세가지를 조합한 8~16자리를 입력하세요");     
				 $('.chkMsg_upw').css("color","red"); 
				 $('.chkMsg_upw').css("padding-left","1rem");
				 chkup2 = false;
			 }
			 
		 });//upw
		
		 
		 $("#upwc").keyup(function(){
			 if($("#upw").val() !== $("#upwc").val()){
					$('.chkMsg_upwc').text("비밀번호가 다릅니다");     
					$('.chkMsg_upwc').css("color","red"); 
					$('.chkMsg_upwc').css("padding-left","1rem"); 
					chkup3 = false;
			 }else{
					$('.chkMsg_upwc').text("비밀번호가 일치합니다");     
					$('.chkMsg_upwc').css("color","green");
					$('.chkMsg_upwc').css("padding-left","1rem"); 
					chkup3 = true;
			 }
		 });//upwc
		 
		 
		 $("#uname").keyup(function(){
			 var uname = $("#uname").val();
			 var chk = /^[A-Z|a-z|가-힣]{1,14}$/;
			 if(uname.match(chk) != null){
					$('.chkMsg_uname').text("");     
					chkup4 = true;
				}else{
		            $('.chkMsg_uname').text("이름을 정확히 입력하세요");     
					$('.chkMsg_uname').css("color","red"); 
					$('.chkMsg_uname').css("padding-left","1rem");
					chkup4 = false;
				}
			 
		 });//uname
		 
		 
		 $("#uphone").keyup(function(){
			 var uphone = $("#uphone").val();
			 var chk1 = /^010([0-9]{8})$/;
			 var chk2 = /^01([1|6|7|8|9])([0-9]{3})([0-9]{4})$/;
				if(uphone.match(chk1) != null || uphone.match(chk2) != null ){
					$('.chkMsg_uphone').text("");     
					chkup5 = true;
				}else{
		            $('.chkMsg_uphone').text("연락처를 정확히 입력하세요");     
					$('.chkMsg_uphone').css("color","red"); 
					$('.chkMsg_uphone').css("padding-left","1rem");
					chkup5 = false; 
				}
		 	});//uphone
		 	
		  	 
				 
		});
		
		
	</script>
	
	
	 <script type="text/javascript">
		    function winopen(){
		    	
		    	location.href="mail.jsp";
		    	
		    }
 </script>
 
	


	<div class="limiter">
		<div class="container-login100" >
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form class="login100-form validate-form" action="joinPro.jsp" method="post" id="joinfr" name="joinfr">
					<span class="login100-form-title p-b-49">
						<a href="../index.html"><img class="img-logo" src="../images/login_logo.png"/></a>
					</span>

					<div  class="wrap-form m-b-35 ">
						<img class="joinform" src="../images/userjoinform.png"/>
					</div>
					<div class="wrap-input100  m-b-23">
						<span class="label-input100">아이디</span>
						<span class="chkMsg_uid"></span>  
						<input class="input100" id="uid" type="text" name="user_id" placeholder="아이디를 입력하세요" >
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>
								
						

					<div class="wrap-input100  m-b-23">
						<span class="label-input100">비밀번호</span>
						<span class="chkMsg_upw"></span>
						<input class="input100" id="upw" type="password" name="user_pw" placeholder="비밀번호를 입력하세요">
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>
					
					<div class="wrap-input100  m-b-23">
						<span class="label-input100">비밀번호 확인</span>
						<span class="chkMsg_upwc"></span>
						<input class="input100" id="upwc" type="password" name="user_pwc" placeholder="비밀번호 확인을 위해 다시 입력하세요">
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>
					
					<div class="wrap-input100  m-b-23">
						<span class="label-input100">이름</span>
						<span class="chkMsg_uname"></span>
						<input class="input100" id="uname" type="text" name="user_name" placeholder="이름을 입력하세요">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>
					
					<div class="wrap-input100  m-b-23">
						<span class="label-input100">연락처</span>
						<span class="chkMsg_uphone"></span>
						<input class="input100" id="uphone" type="text" name="user_phone" placeholder="'-'를 제외한 연락처를 입력하세요">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>
					
					<div class="wrap-input100" >
						<span class="label-input100">메일</span>
						<span class="chkMsg_umail"></span><br>
							<input class="input100" id="umail" type="email" name="user_mail"
							<%if(request.getParameter("user_mail") != null){ %>
							 value=<%=request.getParameter("user_mail")  %> 
							<%} %>
							placeholder="메일을 입력하세요" readonly>
						
						
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>
					
					<input type="hidden" name="user_div" value="<%=1 %>">
					
					
					<div class="text-right p-t-8 p-b-31">
					
					</div>
					
					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<input type="submit" class="login100-form-btn" id="join_submit" value="회원가입" style="background-color:transparent;"> 
	  							
						</div>
					</div>

					<div class="txt1 text-center p-t-54 p-b-20">
						<a href="loginForm.jsp" class="txt2"> 로그인하러 가기 </a>
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