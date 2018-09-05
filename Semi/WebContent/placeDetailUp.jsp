<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
      <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
      <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=PmNgQawFPTLSC4A8I3lT&submodules=geocoder"></script>
      <style>
         /* div{ background-color: white; } */
            
         #all{ position: relative; width: 1200px; height: 1200px; top:50px; left:175px; }
           #main{ position: relative; width: 700px; height: 300px; margin-left: 250px; }
            #area{ position: relative; width: 1125px; top: 70px; margin-left: 37.5px;}
            
            .sub_div { position: relative; width: 300px; margin-left: 460px; }
	        .sub{ position: relative; width: 50px;height: 50px; margin-top: 10px; margin-right: 5px; cursor: pointer; }
	        .info{ position: relative; float: left; text-align: center; top: 30px; left: 37.5px; width: 375px; height: 30px; line-height: 30px; border: 1px solid #7E7E7E;cursor: pointer; }
	        
	        #detail{background-color : #FF376C;}
		</style>
		
	</head>
	<body>
	<div>
	<jsp:include page="menuBar.jsp"/>
	</div>
	<input type="hidden" value="place_no"/>
		<div id="all"> 
	        <img id="main"/><br/>
			<div class="sub_div">
	        	<img id="sub1" class="sub" />
	        	<img id="sub2" class="sub" src="noimage.jpg"/>
	        	<img id="sub3" class="sub" src="noimage.jpg"/>
		        <img id="sub4" class="sub" src="noimage.jpg"/>
		        <img id="sub5" class="sub" src="noimage.jpg"/>
		    </div>
	        <div id="allinfo">
	            <div class="info" id="detail">상세정보</div>
	            <div class="info" id="qa">Q&A</div>
	            <div class="info" id="review">이용후기</div>
	        </div>  
	        <div id="area"></div>
		</div>
	</body>
	<script>
	var mainPhoto;		
		var msg = "${msg}";
		if(msg != "") {
			alert(msg);
		}
		// 하단의 img 태그를 클릭하면 메인 img 태그에 클릭한 사진이 삽입됨
		$(".sub").click(function(){
		    $("#main").attr("src",this.src);
		    console.log("사진 클릭");
		});	

		  $(document).ready(function(){
		         var p_no="${place_no}";
		         var page="${page}";
		         $.ajax({
		               type:"post",
		               url:"./placephotoDetail",
		               dataType:"JSON",
		               data:{
		                  place_no:p_no
		               },
		               success : function(data){
		                  $("#main").attr("src",'./upload/'+data.list[0].place_photo);
		                  mainPhoto='./upload/'+data.list[0].place_photo;
		                  for(var i=0;i<data.list.length;i++){
		                  $("#sub"+(i+1)).attr("src",'./upload/'+data.list[i].place_photo);
		                  }
		                  $("#area").load(page,{place_no:p_no,mainPhoto:mainPhoto},function(res, stat) {/*  $("#area").html(res) */ });
		               },
		               error:function(e){
		                  console.log(e);
		               }
		         });
		         $("#area").load(page,{place_no:p_no},function(res, stat) { /* $("#area").html(res) */ });
		         
		         if(page == "qa.jsp") {
		             $("#qa").css("background-color","#FF376C");
		             $("#qa").css("color","white");
		             $("#detail").css("background-color","white");
		             $("#detail").css("color","black");
		             $("#review").css("background-color","white");
		             $("#review").css("color","black");
		      	 } else if(page == "review.jsp") {
		             $("#review").css("background-color","#FF376C");
		             $("#review").css("color","white");
		             $("#detail").css("background-color","white");
		             $("#detail").css("color","black");
		             $("#qa").css("background-color","white");
		             $("#qa").css("color","black");
		      	 } else {
		             $("#detail").css("background-color","#FF376C");
		             $("#detail").css("color","white");
		             $("#review").css("background-color","white");
		             $("#review").css("color","black");
		             $("#qa").css("background-color","white");
		             $("#qa").css("color","black");
		      	 }
		      });
	
		// div(상세정보, QA, 이용후기)를 클릭하면,
		// 1. 클릭한 div의 색상을 핑크로 변경하고, 나머지 div의 색상을 흰색으로 설정
		// 2. 클릭한 div에 따라, 다른 페이지(placeDetail.jsp OR qa.jsp OR reply.jsp)를 가져옴
		$(".info").click(function(e) {
			console.log("상세정보");
			var p_no=${place_no};
			var page = "";
			$(this).css("background-color","#FF376C");
			$(this).css("color","white");
			
			if(e.target.id == "detail") {
				page = "placeDetail.jsp";
				$("#qa").css("background-color","white");
				$("#qa").css("color","black");
		    	$("#review").css("background-color","white");
		    	$("#review").css("color","black");
			} else if(e.target.id == "qa") {
				page = "qa.jsp";
				$("#detail").css("background-color","white");
				$("#detail").css("color","black");
		    	$("#review").css("background-color","white");
		    	$("#review").css("color","black");
			} else {
				page = "review.jsp";
				$("#detail").css("background-color","white");
				$("#detail").css("color","black");
		    	$("#qa").css("background-color","white");
				$("#qa").css("color","black");
			}			
			$("#area").load(page,{place_no:p_no,mainPhoto:mainPhoto},function(res, stat) {/*  $("#area").html(res) */ });
		});

   </script>
</html>