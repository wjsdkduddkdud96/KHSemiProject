<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<style>
		   /* 나눔 스퀘어 폰트 */
		   @import url(//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css);
		   @font-face { font-family: 'odibeeSans'; font-style: normal; src: url('OdibeeSans-Regular.eot'); src: url('OdibeeSans-Regular.woff'); }
		
		   /*  요소 설정  */
		   hr { width: 430px; margin-top: 20px; float: left; }
		   a { color: black; text-decoration: none; }
		
		   .content { position: relative; width: 100%; top: 35px; }
		   .slogan { position: absolute; top: 250px; left: 100px; }
		   .slogan_text { position: relative; top: 0px; font-family: 'Nanum Square'; font-size: 48px; color: white; }
		   .slogan_logo { position: relative; top: 0px; font-family: 'odibeeSans', sans-serif; font-size: 26px; color: #FF376C; }
		   .category { position: absolute; top: 150px; left: 730px; width: 450px;  }
		   .category_text { position: absolute; top: 150px; left: 730px; width: 450px; text-align: center; }
		   .category_header { font-family: 'Nanum Square', sans-serif; font-size: 22px; color: white; }
		   .category_option { position: relative; width: 130px; height: 130px; margin-top: 20px; margin-right: 20px; background-color: white; opacity: 0.1; float: left; }
		   
		   #category_cafe { position: relative; width: 130px; height: 130px; top: 55px; margin-top: 20px; margin-right: 20px; line-height: 130px; color: white; float: left;}
		   #category_restaurant { position: relative; width: 130px; height: 130px; top: 55px; margin-top: 20px; margin-right: 20px; line-height: 130px; color: white; float: left; }
		   #category_pub { position: relative; width: 130px; height: 130px; top: 55px; margin-top: 20px; margin-right: 20px; line-height: 130px; color: white; float: left; }
		   #category_studio { position: relative; width: 130px; height: 130px; top: 55px; margin-top: 20px; margin-right: 20px; line-height: 130px; color: white; float: left; }
		   #category_practiceRoom { position: relative; width: 130px; height: 130px; top: 55px; margin-top: 20px; margin-right: 20px; line-height: 130px; color: white; float: left; }
		   #category_theater { position: relative; width: 130px; height: 130px; top: 55px; margin-top: 20px; margin-right: 20px; line-height: 130px; color: white; float: left; }
		</style>
	</head>
	<body>
		<jsp:include page="/menuBar.jsp" flush="false"/>
		<div class="content">
            <img width="100%" src="main_image.png"/>
            <div class="slogan">
                <div class="slogan_text">세상의 잠든 공간을 깨우다.</div>
                <h2 class="slogan_logo">WAKE UP PLACE</h2>
            </div>
        </div>
        <div class="category">
            <span class="category_header"><strong>어떤 공간</strong>이 필요하신가요?</span><hr/>
            <span class="category_option"></span>
            <span class="category_option"></span>
            <span class="category_option"></span><br/>
            <span class="category_option"></span>
            <span class="category_option"></span>
            <span class="category_option"></span>
        </div>
        <div class="category_text">
            <a href="search.jsp?category=카페"><span id="category_cafe">카페</span></a>
            <a href="search.jsp?category=식당"><span id="category_restaurant">식당</span></a>
            <a href="search.jsp?category=주점"><span id="category_pub">주점</span></a>
            <a href="search.jsp?category=스튜디오"><span id="category_studio">스튜디오</span></a>
            <a href="search.jsp?category=연습실"><span id="category_practiceRoom">연습실</span></a>
            <a href="search.jsp?category=공연장"><span id="category_theater">공연장</span></a>
        </div>	
	</body>
</html>