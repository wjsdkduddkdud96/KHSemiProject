<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			div{position: absolute; border: 1.5px solid #A4A4A4; width: 300px; height: 250px;
				left: 40%; top: 200px; text-align: center;}
			span#delTxt{position: absolute;  font-size: 20px; left: 35%; top: 10px;}
			span#idTxt{position: absolute;  left: 15px; top: 50px;}
			span#pwTxt{position: absolute; left: 15px; top: 87px;}
			input#id{position: absolute; left: 83px; top: 50px; width: 200px; height: 30px;} 
			input#pw{position: absolute; left: 83px; top: 87px; width: 200px; height: 30px;}
			span#chkTxt{position: absolute; left: 83px; top: 125px; font-size: 10px;
	            color: red;}
			button#cancel{position: absolute; left: 15px; top: 145px; width: 270; height: 30px; 
				background-color: #FA5882; color: white; border-style: none;}
			button#del{position: absolute; left: 15px; top: 185px; width: 270; height: 30px; 
				background-color: #F5A9BC; color: white; border-style: none;}
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div>
			<span id="delTxt"><strong>탈퇴하기</strong></span>
			<span id="idTxt">아이디</span>
			<input id="id" type="text" value="${sessionScope.loginId }" readonly="readonly"/>
			<span id="pwTxt">비밀번호</span>
			<input id="pw" type="password" placeholder="비밀번호"/>
			<span id="chkTxt"></span>
			<button id="cancel">취소</button>
			<button id="del">확인</button>
		</div>
	</body>
	<script>
		$("#cancel").click(function() {
			location.href="updateChk.jsp";
		});
		
		$("#del").click(function () {
			$.ajax({
				type : "post",
				url : "./del",
				data : {
					id : $("#id").val(),
					pw : $("#pw").val()
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					if(data.success > 0){
						alert("탈퇴 성공");
						location.href="index.jsp";
					}else{
						console.log("a");
						$("#chkTxt").html("비밀번호를 확인해주세요.");
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		});
	</script>
</html>