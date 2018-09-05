<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style> 
	        div#main{ position: absolute; border: 1.5px solid #A4A4A4; width: 300px; height: 500px; left: 40%; 
				top: 100px; text-align: center; }
	        span#regTxt{ position: absolute; left: 115px;  top: 10px; font-size: 20px; }

	        b#id{ position: absolute; left: 15px; top: 77px; font-size: 13px; }
	        input#regId{ position: absolute; left: 75px; top: 75px; width: 200px; height: 25px; font-size: 10px; }
	        button#idChk{ position: absolute; left: 280px; top: 75px; width: 69px;
	            height: 25px; color: white; background-color: black; border-style: none; font-size: 10px; }
	        
	        b#name{ position: absolute; left: 15px; top: 128px; font-size: 13px;  }
	        input#regName{ position: absolute; left: 75px; top: 125px;
 				width: 200px; height: 25px; font-size: 10px;     } 
	        
	        b#Gender{ position: absolute; left: 15px; top: 181px; font-size: 13px; }  
	        input#regGender{ position: absolute; left: 75px; top: 178px; width: 200px; height: 25px; font-size: 10px;     }
	        
	        b#birth{ position: absolute; left: 15px; top: 234px; font-size: 13px; }
	        input#regBirth{ position: absolute; left: 75px; top:231px; width: 200px; height: 25px; font-size: 10px;     }
	        
	        b#email{ position: absolute; left: 15px; top: 287px; font-size: 13px; }
	        input#regEmail{ position: absolute; left: 75px; top: 284px;
	            width: 200px; height: 25px; font-size: 10px;             }
	            
	        b#num{ position: absolute; left: 15px; top: 340px; font-size: 13px; }
	        span#regNum-{position: absolute; left: 155px; top: 339px;}
	        input#regNum1{ position: absolute; left: 100px; top: 339px;
	            width: 50px; height: 25px; font-size: 10px;             }    
	        input#regNum2{ position: absolute; left: 165px; top: 339px;
	            width: 50px; height: 25px; font-size: 10px;             }    
	            
	        b#phone{ position: absolute; left: 15px; top: 393px; font-size: 13px; }
/* 	        span#regPhone-1{position: absolute; left: 155px; top: 501px;}
	        span#regPhone-2{position: absolute; left: 220px; top: 501px;} */
	        input#regPhone{ position: absolute; left: 100px; top: 390px;
	            width: 175px; height: 25px; font-size: 10px;             }

			button#del{ position: absolute; left: 15px; top: 446px; width: 60px; height: 25px;    
	            color: white; background-color: black; border-style: none; font-size: 10px; cursor: pointer;}
	        button#cancel{ position: absolute; left: 165px; top: 446px; width: 50px; height: 25px;    
	            color: white; background-color: black; border-style: none; font-size: 10px;cursor: pointer; }
	        button#update{ position: absolute; left: 225px; top: 446px; width: 50px; height: 25px;
	            font-size: 10px; color: white; background-color: black; border-style: none;cursor: pointer; }
            
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div id="main">
            <span id="regTxt"><b>회원정보</b></span>
            <b id="id">아이디</b>
            <input id="regId" type="text" value="${sessionScope.loginId }" readonly>
            <b id="name">이름</b>
            <input id="regName" type="text" readonly/>
            <b id="Gender">성별</b>
            <input id="regGender" type="text" readonly/>
            <b id="birth">생년월일</b>
            <input id="regBirth" type="text" readonly="readonly"/>
            <b id="email">이메일</b>
            <input id="regEmail" type="email" readonly="readonly"/>
            <b id="num">주민등록번호</b>
            <input id="regNum1" type="text" placeholder="" onkeyup="onKeyUp_num1()" maxlength="6"/ readonly="readonly">
            <span id="regNum-">-</span>
            <input id="regNum2" type="password" placeholder="" onkeyup="onKeyUp_num2()" maxlength="7" readonly="readonly"/>
            <b id="phone">휴대폰 번호</b>
            <input id="regPhone" type="tel" readonly="readonly"/>
            
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
					$("#regName").val(data.userInfo.info_name);
					$("#regGender").val(data.userInfo.info_gender);
					$("#regBirth").val(data.userInfo.info_birth);
					$("#regEmail").val(data.userInfo.info_email);
					$("#regNum1").val(data.userInfo.info_num.substring(0,6));
					$("#regNum2").val(data.userInfo.info_num.substring(6,13));
					$("#regPhone").val(data.userInfo.info_phone);
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
			location.href="regUpdate.jsp";
		});
		
	</script>
</html>