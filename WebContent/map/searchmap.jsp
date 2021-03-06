<%@page import="java.io.Console"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../inc/top.jsp"%>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=824c000c199e69a3e3dc1d068f46bdfc"></script>
	 <script src="../js/jquery-3.6.0.js"></script>
	
<style>
.overlaybox {position:relative;width:360px;height:350px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px;}
.overlaybox div, ul {overflow:hidden;margin:0;padding:0;}
.overlaybox li {list-style: none;}
.overlaybox .boxtitle {color:#fff;font-size:16px;font-weight:bold;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png') no-repeat right 120px center;margin-bottom:8px;}
.overlaybox .first {position:relative;width:247px;height:136px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumb.png') no-repeat;margin-bottom:8px;}
.first .text {color:#fff;font-weight:bold;}
.first .triangle {position:absolute;width:48px;height:48px;top:0;left:0;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png') no-repeat; padding:6px;font-size:18px;}
.first .movietitle {position:absolute;width:100%;bottom:0;background:rgba(0,0,0,0.4);padding:7px 15px;font-size:14px;}
.overlaybox ul {width:247px;}
.overlaybox li {position:relative;margin-bottom:2px;background:#2b2d36;padding:5px 10px;color:#aaabaf;line-height: 1;}
.overlaybox li span {display:inline-block;}
.overlaybox li .number {font-size:16px;font-weight:bold;}
.overlaybox li .title {font-size:13px;}
.overlaybox ul .arrow {position:absolute;margin-top:8px;right:25px;width:5px;height:3px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png') no-repeat;} 
.overlaybox li .up {background-position:0 -40px;}
.overlaybox li .down {background-position:0 -60px;}
.overlaybox li .count {position:absolute;margin-top:5px;right:15px;font-size:10px;}
.overlaybox li:hover {color:#fff;background:#d24545;}
.overlaybox li:hover .up {background-position:0 0px;}
.overlaybox li:hover .down {background-position:0 -20px;}   
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'??????',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:80vh;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:25%;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.89);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>
</head>
<body>

		<%
			request.setCharacterEncoding("UTF-8");
			
			
			RentshopDAO rsdao = new RentshopDAO();
			
			 int cnt = rsdao.getRentshopCount();
			int pageSize = 5;
			   
			   // ??????????????? ???????????? ?????? ??????
			   String pageNum = request.getParameter("pageNum");
			   if(pageNum == null){
				   pageNum = "1";
			   }
			   
			   // ???????????? ????????? ????????????
			   // 1p -> 1???, 2p -> 11???,3p->21???, ....=>?????????
			   int currentPage = Integer.parseInt(pageNum);
			   int startRow = (currentPage-1)*pageSize+1;
			   
			   // ?????? ????????????
			   // 1p->10???, 2p->20???, 3p->30??? ....=> ?????????
			   int endRow = currentPage*pageSize;
			   
				
				String sch = request.getParameter("keyword");
				String tsch = sch.trim().substring(0, 2);
				
			
				ArrayList rentshopList = rsdao.getRentshopList(startRow,pageSize,tsch);
				
				
			
				RentshopBean rb = null;

					
			%>
		
		
		
		
		
		
<script type="text/javascript">

	function keyw() {
		
		if(document.fr.keyword.value == ""){
			alert("???????????? ??????????????????");
			return false;
		}

			document.fr.submit();
		
			
	}

</script>
		

<div class="map_wrap" style="margin-top: 100px">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
           		 <h5 style="font-size: 1.6vw;"><img src="../images/bike.png" style="width: 30px;">&nbsp;????????? ????????? </h5>
           		 <form action="../map/searchmap.jsp" method="post" name="fr">
              <div class="form-group row m-l-50">
				<div class="col-xs-10 col-sm-10">
				   	<div CLASS="input-group">
					<input type="text" name="keyword" class="form-control" id="keywordInput" style="height: 4vh; font-size: 1vw; margin-left: 5vw;" placeholder="&emsp;????????? ??????">
					<input class="btn btn-primary text-white" type="button" onclick="keyw()" id="searchBtn" style="margin-left:-30px; height: 4vh; width:100px; font-size: 1vw;" value="&emsp;??????">
					</div>
				</div>
			</div>
      </form>
          
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        
        
         <div class="row">
					<% for(int i=0; i<rentshopList.size(); i++){ 
						RentshopBean tb = (RentshopBean) rentshopList.get(i);
						
						String[] address = tb.getRentshop_info_addr().split("/");
						
						
						
					%>
						
					<div class="col-md-20  mb-4 mb-lg-4" >
			           <div class="h-entry">
			            <table style="margin-top: 15px;">
			            	<tr>
			            		<th rowspan="4"><img src="../images/location.png" style="width: 3vw;"></th>
			            		<th style="font-size: 1.3vw; padding-left: 10px;margin-bottom: 5px;" id="ck<%=i+1%>"><%=tb.getRentshop_info_name() %></th>
			            	</tr>
			            	<tr>
			            		<th><p  style="font-size: 0.9vw; color: #636363; padding-left: 10px;"><%=address[1] %></p></th>
			            	</tr>
			            	<tr>
			            		<th style="font-size: 0.8vw; color: #969696; padding-left: 10px;">?????? : <%=address[0] %></th>
			            	</tr>
			            	<tr>
			            		<th style="font-size: 0.8vw; color: #01DFA5; padding-left: 10px;"><%=tb.getRentshop_info_tel()%></th>
			            	</tr>
			            </table>
			            </div> 
			        </div>  
			       
				<%} %>
		</div>			
				<hr>
				<div style=" margin: auto; width: 50%;">
			<%
		    //////////////////////////////////////////////////////
		    // ????????? ?????? - ????????? ????????? ??????
		    if(cnt != 0){// ??????????????? ??????
		
		    	//?????? ???????????? ??????
		    	// ex)  ??? 50??? -> ??????????????? 10??? ??????, 5???
				//      ??? 57??? ->       "        , 6???
				int pageCount = cnt/pageSize+(cnt % pageSize == 0? 0:1);
				
				// ??? ????????? ????????? ????????? ????????? ?????? (????????? ??????)
				int pageBlock = 2;
				
				// ????????? ????????? ??????????????? ?????? 
				// ex)  1~10 ????????? : 1, 11~20????????? : 11, 21~30????????? : 21
		        int startPage = ((currentPage-1)/pageBlock) * pageBlock + 1;
				
				// ????????? ????????? ??? ????????? ??????
				int endPage = startPage+pageBlock-1;
				
				if(endPage > pageCount){
					endPage = pageCount;
				}
		    	
		    	// ?????? (?????? ?????????????????? ????????? ????????? ??????)
		    	if(startPage > pageBlock){
		    		%>
		    		>
		    		<a href="map.jsp?pageNum=<%=startPage-pageBlock%>" style="font-size: 1vw;">[??????]&emsp;</a>
		    		<%
		    	}   	
		    	
		    	for(int i=startPage;i<=endPage;i++){
		    		%>
		    		    <a href="map.jsp?pageNum=<%=i%>" style="font-size: 1vw;">[<%=i %>]&nbsp;&nbsp;</a> 
		    		<%    		
		    	}
		    	
		    	// ?????? (????????? ????????? ???????????? ???????????? ?????? ?????????)
		    	if(endPage < pageCount){
		    		%>
		    		<a href="map.jsp?pageNum=<%=startPage+pageBlock%>" style="font-size: 1vw;">&emsp;[??????]</a>
		    		
		    		<%
		    	}
		    	
    }
    //////////////////////////////////////////////////////
  %>
  				</div>
		
		
		
        <div id="pagination"></div>
    </div>
</div>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=824c000c199e69a3e3dc1d068f46bdfc&libraries=services"></script>
<script>


<% RentshopBean tb = (RentshopBean) rentshopList.get(0);

System.out.println(tb.toString());

%>

var mapContainer = document.getElementById('map'), // ????????? ????????? div 
	 mapOption = {
	 center: new kakao.maps.LatLng(<%=tb.getRentshop_info_x()%>, <%=tb.getRentshop_info_y()%>), // ????????? ????????????
     level: 3 // ????????? ?????? ??????
	    };  

// ????????? ???????????????    
var map = new kakao.maps.Map(mapContainer, mapOption); 






//????????? ????????? ????????? title ?????? ??????????????? 
var positions = [ 
	
	 <%
	 
	
	 
     for(int i=0;i<rentshopList.size();i++){
    	  rb = (RentshopBean) rentshopList.get(i);
    	  String[] address = rb.getRentshop_info_addr().split("/"); 
    	  if(i == (rentshopList.size()-1)){ %>
			{ title: '<%=rb.getRentshop_info_name()%>' , content : new kakao.maps.LatLng(<%=rb.getRentshop_info_x()%>, <%=rb.getRentshop_info_y()%>) }
		<%	break; } %>
		   { title: '<%=rb.getRentshop_info_name()%>' , content : new kakao.maps.LatLng(<%=rb.getRentshop_info_x()%>, <%=rb.getRentshop_info_y()%>) },
			
	
	 <%
   }
  %>
	
	];




//?????? ???????????? ????????? ???????????????
var imageSrc = "../images/location.png";

for (var i = 0; i < positions.length; i++) {

	// ?????? ???????????? ????????? ?????? ?????????
	var imageSize = new kakao.maps.Size(72, 75);

	// ?????? ???????????? ???????????????    
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

	// ????????? ???????????????
	var marker = new kakao.maps.Marker({
		map : map, // ????????? ????????? ??????
		position : positions[i].content, // ????????? ????????? ??????
		title : positions[i].title, // ????????? ?????????, ????????? ???????????? ????????? ???????????? ???????????????
		image : markerImage
	});
	

	
}
			
			
			
			
			
			
			
			
			
			

$(function() {
	
	<%for(int i = 0; i < rentshopList.size(); i++){ %>		
		
	$("#ck"+(<%=i+1%>)).click(function(){
	 	map.setCenter(positions[<%=i%>].content);						
	});
	
	<%}%>
});




			

</script>




























	<%@ include file="../inc/footer.jsp"%>