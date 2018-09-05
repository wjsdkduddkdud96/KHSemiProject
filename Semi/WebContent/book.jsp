<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			/* 나눔 스퀘어 폰트 */
			@import url(//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css);
			
 			div#bookInfo{ border: 1px solid black;  position: absolute; left: 40%; top: 100px; 
 				width: 300px; height: 280px; text-align: center; }
 			b#a{position: absolute;  left: 15px;}
 			b#b{position: absolute;  left: 15px; top: 90px;}
 			b#c{position: absolute;  left: 15px; top: 120px;}
 			b#d{position: absolute;  left: 15px; top: 150px;}
 			b#e{position: absolute;  left: 15px; top: 180px;}
 			
 			span#placeName{position: absolute;  left: 100px;}
 			span#bookDate{position: absolute;  left: 100px; top: 90px;}
 			span#bookTime{position: absolute;  left: 100px; top: 120px;}
 			span#bookCustom{position: absolute;  left: 100px; top: 150px;}
 			span#bookPrice{position: absolute;  left: 70px; top: 180px;}
 			
 			button{border: none;  background-color: black; color: white;}
 			button#mainPage{position: absolute;  left: 60px; top: 220px}
 			button#book{position: absolute;  left: 150px; top: 220px}
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		
		<div id="bookInfo">
			<h3>예약 정보</h3>
			<b id="a">장소이름 : </b><span id="placeName">${bookInfo.place_name}</span><br>
			<b id="b">예약날짜 : </b><span id="bookDate"></span><br>
			<b id="c">예약시간 : </b><span id="bookTime">${bookInfo.book_start} ~ ${bookInfo.book_end}</span><br>
			<b id="d">예약인원 : </b><span id="bookCustom">${bookInfo.book_custom}</span><br>
			<b id="e">금액 : </b><span id="bookPrice">${bookInfo.book_price}</span><br>
			
			<button id="mainPage">메인으로</button>
			<button id="book">예약내역확인</button>
        </div>
	</body>
	<script>
	
	var date = "${bookInfo.book_date}";
	var date2 = date.substring(2,10);
	console.log(date2);
	$("#bookDate").html(date2);
		/* $(document).ready(function() {
			$.ajax({
				type:"post",
				url:"./bookInfo",
				dataType:"json",
				success : function(data){
					console.log(data);
					if(data.login == false){
						alert("로그인");
						history.back();
					}else{
						$("#placeName").html(data.bookInfo.place_name);
						$("#bookDate").html(data.bookInfo.book_date);
						$("#bookTime").html(data.bookInfo.book_start+" ~ "+data.bookInfo.book_end);
						$("#bookCustom").html(data.bookInfo.book_custom);
						$("#bookPrice").html(data.bookInfo.book_price+" 원");
					}
				},
				error : function (error) {
					console.log(error);
				}
			});
		}); */
		
		$("#mainPage").click(function() {
			location.href="index.jsp";
		});
		
		$("#book").click(function() {
			location.href="bookList.jsp";
		});
	</script>
</html>