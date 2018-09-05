<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			div{position:absolute; width:300px; height: 200px; 
				text-align: center; border: 1.5px solid #A4A4A4;}
			
			h3{position: absolute; left: 100px; top: 0px;}
			
			#name_s{position: absolute; left: 15px; top: 65px;}
			#name{position: absolute; left: 80px; top: 65px;}
			
			#email_s{position: absolute; left: 15px; top: 100px;}
			#email{position: absolute; left: 80px; top: 100px;}
			
			#btn{position: absolute; left: 195px; top: 140px;}
			
			#result{position: absolute; left: 15px; top: 140px; font-size: 13px;}
		</style>
	</head>
	<body>
		<div>
			<h3>아이디 찾기</h3>
			<span id="name_s">이름</span>
			<input type="text" id="name"/>
			<br>
			<span id="email_s">이메일</span>
			<input type="email" id="email"/>
			<button id="btn" onclick="clickEvt()">ID 찾기</button>
			<b><span id="result"></span></b>
		</div>
	</body>
	<script>
		function clickEvt() {
			var name = $("#name").val();
			var email = $("#email").val();

			$.ajax({
				type : "post",
				url : "./id",
				data : {
					name : name,
					email : email
				},
				dataType : "json",
				success : function (data) {
					if(data.result != null){
						var id = data.result;
						id = id.replace(/.{3}$/,"***");
						console.log(data.result);
						$("#result").html("ID : "+id);
					}else{
						$("#result").html("찾을 수 없음");
					}
				},
				error : function (error) {
					console.log(error);
				}
			});
		}
	</script>
</html>