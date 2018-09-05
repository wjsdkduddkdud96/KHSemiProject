<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			div#main{ position: absolute; border: 1.5px solid #A4A4A4; width: 310px; height: 400px; left: 40%;
			top: 100px; text-align: center; }
		    span#userTxt{ position: absolute; left: 120px;
		    	top: 10px; font-size: 20px; }
	
		    b#id{ position: absolute; left: 15px; top: 77px; font-size: 13px; }
		    input#userId{ position: absolute; left: 75px; top: 75px; width: 200px; height: 25px; font-size: 10px; }
		    button#idChk{ position: absolute; left: 280px; top: 75px; width: 69px;
		    	height: 25px; color: white; background-color: black; border-style: none; font-size: 10px; }
		             
		    b#pw{ position: absolute; left: 15px; top: 130px; font-size: 13px; }
		    input#userPw{ position: absolute; left: 75px; top: 127px;
		        width: 200px; height: 25px; font-size: 10px; }	
		        
		    b#pwChk{ position: absolute; left: 15px; top: 183px; font-size: 13px; }
		    input#userPwChk{
		        position: absolute; left: 105px; top: 180px;
	     	    width: 170px; height: 25px; font-size: 10px;  }
		        
		    b#name{ position: absolute; left: 15px; top: 130px; font-size: 13px;  }
    		input#userName{ position: absolute; left: 75px; top: 127px;
	 			width: 200px; height: 25px; font-size: 10px;     } 
		        
		    b#Gender{ position: absolute; left: 15px; top: 183px; font-size: 13px; }  
		    input#userGender{ position: absolute; left: 75px; top: 180px; width: 200px; height: 25px; font-size: 10px;     }
		        
		    b#birth{ position: absolute; left: 15px; top: 236px; font-size: 13px; }
		    input#userBirth{ position: absolute; left: 75px; top:233px; width: 200px; height: 25px; font-size: 10px;     }
		        
		    b#email{ position: absolute; left: 15px; top: 289px; font-size: 13px; }
		    input#userEmail{ position: absolute; left: 75px; top: 286px;
		        width: 200px; height: 25px; font-size: 10px;             }
	
			button#del{ position: absolute; left: 15px; top: 342px; width: 60px; height: 25px;    
		        color: white; background-color: black; border-style: none; font-size: 10px; cursor: pointer;}	
	
		    button#cancel{ position: absolute; left: 165px; top: 342px; width: 50px; height: 25px;    
		        color: white; background-color: black; border-style: none; font-size: 10px; cursor: pointer;}
		            
		    button#update{ position: absolute; left: 225px; top: 342px; width: 50px; height: 25px;
		        font-size: 10px; color: white; background-color: black; border-style: none; cursor: pointer;}        
	
		</style>  
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div id="main">
            <span id="userTxt"><b>회원정보</b></span>
            <b id="id">아이디</b>
            <input id="userId" type="text" value="${sessionScope.loginId }" readonly/>
            <b id="name">이름</b>
            <input id="userName" type="text" readonly="readonly"/>
            <b id="Gender">성별</b>
            <input id="userGender" type="text" readonly="readonly"/>
            <b id="birth">생년월일</b>
            <input id="userBirth" type="text" readonly="readonly"/>
            <b id="email">이메일</b>
            <input id="userEmail" type="email" readonly="readonly"/>
            <button id="del">탈퇴하기</button>
            <button id="cancel">취소</button>
            <button id="update">수정</button>
        </div>
	</body>
	<script>
		$(document).ready(function () {
			$.ajax({
				type:"post",
				url:"./userInfo",
				dataType:"json",
				success : function(data){
					console.log(data);
					$("#userName").val(data.userInfo.info_name);
					$("#userGender").val(data.userInfo.info_gender);
					$("#userBirth").val(data.userInfo.info_birth);
					$("#userEmail").val(data.userInfo.info_email);
				},
				error : function (error) {
					console.log(error);
				}
			});
		});
		//탙퇴하기
		$("#del").click(function() {
			location.href="del.jsp";
		});
		//취소
		$("#cancel").click(function() {
			location.href="index.jsp";
		});
		//수정하기
		$("#update").click(function() {
			location.href="userUpdate.jsp";
		});
	</script>
</html>