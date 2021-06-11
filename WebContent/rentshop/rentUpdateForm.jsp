<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>

 <script src="../js/jquery-3.6.0.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=824c000c199e69a3e3dc1d068f46bdfc&libraries=services"></script>
</head>

<body>

		<%
			request.setCharacterEncoding("UTF-8");
			// 로그인한 사람의 정보를 DB에서 조회해서 
			// jsp화면에 출력

			// 로그인 세션처리 (로그인x->로그인페이지로 이동)
			
			if (id == null) {
				response.sendRedirect("../login/loginForm.jsp");
			}else{
	
	
			int idx = Integer.parseInt(request.getParameter("rentshop_info_idx"));
		
			RentshopDAO rsdao = new RentshopDAO();
			
			RentshopBean rb = rsdao.getRentshop(idx);
			
			String[] addr = rb.getRentshop_info_addr().split("/");
			
			
		
		
		%>
		
		<script type="text/javascript">
		
				$(document).ready(function(){
				 $("#rentUpdatefr").submit(function(){
					 if($.trim($("#rentinfo_name").val()) == ""){
						 $('.chkMsg_name').text("대여소 이름을 입력하세요");     
			             $('.chkMsg_name').css("color","red"); 
			             $('.chkMsg_name').css("padding-left","1rem"); 
			             $("#rentinfo_name").focus();
			             return false;
					 }
					 
					 if($.trim($("#rentinfo_tel").val()) == ""){
						 $('.chkMsg_tel').text("연락처를 입력하세요");     
			             $('.chkMsg_tel').css("color","red"); 
			             $('.chkMsg_tel').css("padding-left","1rem"); 
			             $("#rentinfo_tel").focus();
			             return false;
					 }
					 
					 
					 if($.trim($("#rentinfo_addr1").val()) == ""){
						 $('.chkMsg_addr').text("우편번호를 검색하세요");     
			             $('.chkMsg_addr').css("color","red"); 
			             $('.chkMsg_addr').css("padding-left","1rem");
			             $("#rentinfo_addr1").focus();
			             return false;
					 }
					 
					 if($.trim($("#rentinfo_addr3").val()) == ""){
						 $('.chkMsg_addr').text("상세주소를 입력하세요");     
			             $('.chkMsg_addr').css("color","red"); 
			             $('.chkMsg_addr').css("padding-left","1rem"); 
			             $("#rentinfo_addr3").focus();
			             return false;
					 }
					 
					 
				 });//rentfr
						
				 
				 $("#rentinfo_name").keyup(function(){
					 var rentname = $("#rentinfo_name").val();
					 var chk = /^[A-Z|a-z|가-힣|0-9|_|-]{1,20}$/;
					 if(rentname.match(chk) != null){
							$('.chkMsg_name').text("");     
				            $('#rentfr').attr("disabled", false);
						}else{
				            $('.chkMsg_name').text("이름을 정확히 입력하세요");     
							$('.chkMsg_name').css("color","red"); 
							$('.chkMsg_name').css("padding-left","1rem");
							$('#rentfr').attr("disabled", true);
							$("#rentinfo_name").focus();
						}
					 
				 });//rentinfo_name
				 
				 $("#rentinfo_tel").keyup(function(){
					 var uphone = $("#rentinfo_tel").val();
					 var chk1 = /^010([0-9]{8})$/;
					 var chk2 = /^01([1|6|7|8|9])([0-9]{3})([0-9]{4})$/;
						if(uphone.match(chk1) != null || uphone.match(chk2) != null ){
							$('.chkMsg_tel').text("");    
							 $('#rentfr').attr("disabled", false);
						}else{
				            $('.chkMsg_tel').text("연락처를 정확히 입력하세요");     
							$('.chkMsg_tel').css("color","red"); 
							$('.chkMsg_tel').css("padding-left","1rem");
							$('#rentfr').attr("disabled", true);
							$("#rentinfo_tel").focus();
						}
				 	});//uphone
				 
				 
				 $("#rentinfo_addr3").keyup(function(){
					 var rentaddr = $("#rentinfo_addr3").val();
					 var chk = /^[A-Z|a-z|가-힣|0-9|_|-]{1,20}$/;
					 if(rentaddr.match(chk) != null){
							$('.chkMsg_addr').text("");     
				            $('#rentfr').attr("disabled", false);
						}else{
				            $('.chkMsg_addr').text("상세주소를 정확히 입력하세요");     
							$('.chkMsg_addr').css("color","red"); 
							$('.chkMsg_addr').css("padding-left","1rem");
							$('#rentfr').attr("disabled", true);
							$("#rentinfo_addr3").focus();
						}
				 	});//rentinfo_addr3
				 	
				 
				 	$("#rentinfo_total").keyup(function(){
						 var renttotal = $("#rentinfo_total").val();
						 var chk = /^[0-9]{1,20}$/;
						 if(renttotal.match(chk) != null){
								$('.chkMsg_total').text("");     
					            $('#rentfr').attr("disabled", false);
			
							}else{
								
								 if(renttotal == ""){
						            	$('.chkMsg_total').text("");
							            $('#rentfr').attr("disabled", false);
						            }else{
							            $('.chkMsg_total').text("숫자만 입력해주세요");     
										$('.chkMsg_total').css("color","red"); 
										$('.chkMsg_total').css("padding-left","1rem");
										$('#rentfr').attr("disabled", true);
										$("#rentinfo_total").focus();
						            }
							}
					 	});//rentinfo_total
					 	
					 	
					 	
					 	$("#rentinfo_abike").keyup(function(){
							 var rentabike = $("#rentinfo_abike").val();
							 var chk = /^[0-9]{1,20}$/;
							 if(rentabike.match(chk) != null){
									$('.chkMsg_abike').text("");     
						            $('#rentfr').attr("disabled", false);
								}else{
									 if(rentabike == ""){
							            	$('.chkMsg_abike').text("");
								            $('#rentfr').attr("disabled", false);
							            }else{
								            $('.chkMsg_abike').text("숫자만 입력해주세요");     
											$('.chkMsg_abike').css("color","red"); 
											$('.chkMsg_abike').css("padding-left","1rem");
											$('#rentfr').attr("disabled", true);
											$("#rentinfo_abike").focus();
							            }
								}
						 	});//rentinfo_abike
			
						 	
						 	$("#rentinfo_kbike").keyup(function(){
								 var rentkbike = $("#rentinfo_kbike").val();
								 var chk = /^[0-9]{1,20}$/;
								 if(rentkbike.match(chk) != null){
										$('.chkMsg_kbike').text("");     
							            $('#rentfr').attr("disabled", false);
									}else{
										 if(rentkbike == ""){
								            	$('.chkMsg_kbike').text("");
									            $('#rentfr').attr("disabled", false);
								            }else{
							            $('.chkMsg_kbike').text("숫자만 입력해주세요");     
										$('.chkMsg_kbike').css("color","red"); 
										$('.chkMsg_kbike').css("padding-left","1rem");
										$('#rentfr').attr("disabled", true);
										$("#rentinfo_kbike").focus();
								            }
									}
							 	});//rentinfo_kbike
							 	
							 	
							 	
							 	$("#rentinfo_tbike").keyup(function(){
							 		var renttbike = $("#rentinfo_tbike").val();
									 var chk = /^[0-9]{1,20}$/;
									 if(renttbike.match(chk) != null){
											$('.chkMsg_tbike').text("");     
								            $('#rentfr').attr("disabled", false);
										}else{
											if(renttbike == ""){
								            	$('.chkMsg_tbike').text("");
									            $('#rentfr').attr("disabled", false);
								            }else{
									            $('.chkMsg_tbike').text("숫자만 입력해주세요");     
												$('.chkMsg_tbike').css("color","red"); 
												$('.chkMsg_tbike').css("padding-left","1rem");
												$('#rentfr').attr("disabled", true);
												$("#rentinfo_tbike").focus();
								            }
										}
								 	});//rentinfo_kbike	
					 	
					 		 	
				});
		</script>
			<script type="text/javascript">
				function execDaumPostcode() {
			       new daum.Postcode({
			           oncomplete: function(data) {
			               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
			               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			               var fullAddr = ''; // 최종 주소 변수
			               var extraAddr = ''; // 조합형 주소 변수
			
			               // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                   fullAddr = data.roadAddress;
			
			               } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                   fullAddr = data.jibunAddress;
			               }
			
			               // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
			               if(data.userSelectedType === 'R'){
			                   //법정동명이 있을 경우 추가한다.
			                   if(data.bname !== ''){
			                       extraAddr += data.bname;
			                   }
			                   // 건물명이 있을 경우 추가한다.
			                   if(data.buildingName !== ''){
			                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                   }
			                   // 조합형주소의 유무에 따라
			                   fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			               }
			
			               // 우편번호와 주소 정보를 해당 필드에 넣는다.
			               document.getElementById('rentinfo_addr1').value = data.zonecode; //5자리 새우편번호 사용
			               document.getElementById('rentinfo_addr2').value = fullAddr;
			
			               // 커서를 상세주소 필드로 이동한다.
			               document.getElementById('rentinfo_addr3').focus();


			               Promise.resolve(data).then(o => {
			                   const { address } = data;

			                   return new Promise((resolve, reject) => {
			                       const geocoder = new daum.maps.services.Geocoder();

			                       geocoder.addressSearch(address, (result, status) =>{
			                           if(status === daum.maps.services.Status.OK){
			                               const { x, y } = result[0];

			                               resolve({ lat: y, lon: x })
			                           }else{
			                               reject();
			                           }
			                       });
			                   })
			               }).then(result => {
			            	   // console.log(result);
//			            	   alert(JSON.stringify(result));
			            	   //{"lat":"37.5132284781619","lon":"127.033437226842"}
			            	   var sp = JSON.stringify(result).split(',');
			            	   var x=sp[0].substring(8).replace('"','');
			            	   var y=sp[1].substring(7).replace('"','').replace('}','');
			            	   
			            	   document.getElementById('rentshop_info_x').value = x;
			            	   document.getElementById('rentshop_info_y').value = y;
			            	   
			               });
			           },
			       }).open();
			       
				} 
			</script>
		
		
			
			
			
	<div class="container m-t-150">
	<h3 class="m-b-20">  [자전거대여소] &emsp;-&emsp; 수정</h3>
	<hr class="m-b-20" style="border:#32dbc6 2px solid">
    
 				<form action="rentUpdatePro.jsp" method="post" id="rentUpdatefr" class="p-5 bg-white">
 					<input type="hidden" name="rentshop_info_idx" value="<%=idx %>">
				<table border="1" class="table m-b-30" >
					<tr>
						<td style="background-color:#ebfffd">대여소 이름</td>
						<td><input type="text" id="rentinfo_name" name="rentshop_info_name" value="<%=rb.getRentshop_info_name()%>">
						    <span class="chkMsg_name"></span></td>
					</tr>
					
					<tr>
						<td style="background-color:#ebfffd">대여소 연락처</td>
						<td><input type="text" id="rentinfo_tel" name="rentshop_info_tel" value="<%=rb.getRentshop_info_tel()%>">
						    <span class="chkMsg_tel"></span></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">대여소 위치</td>
						<td>
							<input class="btn btn-primary text-white" type="button" onclick="execDaumPostcode()" value="우편주소검색"><br>
							<span class="chkMsg_addr"></span>
							<input id="rentinfo_addr1" name="rentshop_info_addr1" type="text" value="<%=addr[0] %>" readonly ><br>
	   						<input id="rentinfo_addr2" name="rentshop_info_addr2" type="text" value="<%=addr[1] %>" readonly><br>
	   						<input id="rentinfo_addr3" name="rentshop_info_addr3" type="text" value="<%=addr[2] %>" ><br>
   						</td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">보유 자전거 총대수</td>
						<td><input type="text" id="rentinfo_total" name="rentshop_info_total" value="<%=rb.getRentshop_info_total() %>">
							<span class="chkMsg_total"></span></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">성인용 자전거 대수</td>
						<td><input type="text" id="rentinfo_abike" name="rentshop_info_abike" value="<%=rb.getRentshop_info_abike() %>">
							<span class="chkMsg_abike"></span></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">어린이용 자전거 대수</td>
						<td><input type="text" id="rentinfo_kbike" name="rentshop_info_kbike" value="<%=rb.getRentshop_info_kbike() %>">
							<span class="chkMsg_kbike"></span></td>
					</tr>
					<tr>
						<td style="background-color:#ebfffd">2인용 자전거 대수</td>
						<td><input type="text" id="rentinfo_tbike" name="rentshop_info_tbike" value="<%=rb.getRentshop_info_tbike() %>">
							<span class="chkMsg_tbike"></span></td>
					</tr>
				</table>
				
				
				<div class="info_title m-t-50 m-b-230" style="margin-left: 40%">
					<button type="submit" class="btn btn-primary text-white" id="update_submit">저장</button>
					<button type="button" class="btn btn-outline-primary m-l-5" onclick="location.href='rentshopList.jsp'">목록</button>
				</div>
				

						<input class="form-control" id="rentshop_info_x" name="rentshop_info_x" type="hidden" placeholder="x" ><br>
   						<input class="form-control" id="rentshop_info_y" name="rentshop_info_y" type="hidden" placeholder="y" ><br>
				
				</form>
		</div>
			
			
			
			
			
			
			
			
			
			
			
			<%} %>
			
			
			
			
			
			

<%@ include file="../inc/footer.jsp"%>