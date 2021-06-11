<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>


<body> 

<script type="text/javascript">

	function keyw() {
		
		if(document.fr.keyword.value == ""){
			alert("키워드를 입력해주세요");
			return false;
		}

			document.fr.submit();
		
			
	}

</script>


 <div class="site-blocks-cover overlay" style="background-image:url(../images/main_img.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row align-items-center justify-content-center text-center">

          <div class="col-md-12" data-aos="fade-up" data-aos-delay="400">
                        
            <div class="row justify-content-center mb-4">
              <div class="col-md-8 text-center">
                <h1 style="font-size: 60px;">That's why I ride <span class="typed-words"></span></h1>
                <p class="lead mb-5" style="font-size: 23px;">Free Web Template by <a href="#" target="_blank">MaTARA</a></p>
     <form action="../map/searchmap.jsp" method="post" name="fr">
              <div class="form-group row m-l-50">
				<div class="col-xs-10 col-sm-10">
				   	<div CLASS="input-group">
					<input type="text" name="keyword" class="form-control" id="keywordInput" style="height: 70px; font-size: 20px;" placeholder="대여소 검색">
					<input class="btn btn-primary text-white" type="button" onclick="keyw()" id="searchBtn" style="margin-left:-30px; width:100px; font-size: 20px;" value="&emsp;검색">
					</div>
				</div>
			</div>
      </form>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>  
 





<%@ include file="../inc/footer.jsp" %>
