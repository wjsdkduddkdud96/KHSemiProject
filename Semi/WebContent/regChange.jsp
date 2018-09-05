<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
	        div#main{ position: absolute; border: 1.5px solid #A4A4A4; width: 320px; height: 500px; left: 40%;
				top: 100px; text-align: center; }
	        span#regTxt{ position: absolute; left: 100px;
	            top: 10px; font-size: 20px; }

	        b#id{ position: absolute; left: 15px; top: 77px; font-size: 13px; }
	        input#regId{ position: absolute; left: 75px; top: 75px; width: 200px; height: 25px; font-size: 10px; }
	        button#idChk{ position: absolute; left: 280px; top: 75px; width: 69px;
	            height: 25px; color: white; background-color: black; border-style: none; font-size: 10px; }

	        b#name{ position: absolute; left: 15px; top: 130px; font-size: 13px;  }
	        input#regName{ position: absolute; left: 75px; top: 127px;
 				width: 200px; height: 25px; font-size: 10px;     } 
	        
	        b#Gender{ position: absolute; left: 15px; top: 183px; font-size: 13px; }  
	        input#regGender{ position: absolute; left: 75px; top: 180px; }
	        
	        b#birth{ position: absolute; left: 15px; top: 236px; font-size: 13px; }
	        input#regBirth{ position: absolute; left: 75px; top:233px;}
	        
	        b#email{ position: absolute; left: 15px; top: 289px; font-size: 13px; }
	        input#regEmail{ position: absolute; left: 75px; top: 289px;
	            width: 200px; height: 25px; font-size: 10px;             }
	            
	        b#num{ position: absolute; left: 15px; top: 342px; font-size: 13px; }
	        span#regNum-{position: absolute; left: 155px; top: 339px;}
	        input#regNum1{ position: absolute; left: 100px; top: 339px;
	            width: 50px; height: 25px; font-size: 10px;             }    
	        input#regNum2{ position: absolute; left: 165px; top: 339px;
	            width: 50px; height: 25px; font-size: 10px;             }    
	            
	        b#phone{ position: absolute; left: 15px; top: 395px; font-size: 13px; }
	        span#regPhone-1{position: absolute; left: 155px; top: 392px;}
	        span#regPhone-2{position: absolute; left: 220px; top: 392px;}
	        input#regPhone1{ position: absolute; left: 100px; top: 392px;
	            width: 50px; height: 25px; font-size: 10px;             }
			input#regPhone2{ position: absolute; left: 165px; top: 392px;
	            width: 50px; height: 25px; font-size: 10px;             }
			input#regPhone3{ position: absolute; left: 235px; top: 392px;
	            width: 50px; height: 25px; font-size: 10px;             }

	        button#cancel{ position: absolute; left: 180px; top: 448px; width: 50px; height: 25px;    
	            color: white; background-color: black; border-style: none; font-size: 10px;cursor: pointer; }
	        button#change{
	            position: absolute; left: 240px; top: 448px; width: 50px; height: 25px;
	            font-size: 10px; color: white; background-color: black; border-style: none;cursor: pointer; }
	            
	        span#num_s{position: absolute; left: 75px; top: 370px;}
	        span#phone_s{position: absolute; left: 75px; top: 422px;}
	            
	        span.msg{font-size: 13px; color: red}    
            	
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div id="main">
            <span id="regTxt"><b>등록자 전환</b></span>
            <b id="id">아이디</b>
            <input id="regId" type="text" value="${sessionScope.loginId }" readonly="readonly">
            <b id="name">이름</b>
            <input id="regName" type="text" value="" readonly="readonly"/>
            <b id="Gender">성별</b>
            <input id="regGender" type="text" readonly="readonly"/>
            <b id="birth">생년월일</b>
            <input id="regBirth" type="text" readonly="readonly"/>
            <b id="email">이메일</b>
            <input id="regEmail" type="email" readonly="readonly"/>
            <b id="num">주민등록번호</b>
            <input id="regNum1" type="text" placeholder="" onkeyup="onKeyUp_num1()" maxlength="6"/>
            <span id="regNum-">-</span>
            <input id="regNum2" type="password" placeholder="" onkeyup="onKeyUp_num2()" maxlength="7"/>
            <b id="phone">휴대폰 번호</b>
            <input id="regPhone1" type="text" onkeyup="onKeyUp_phone()" maxlength="3"/>
            <span id="regPhone-1">-</span>
            <input id="regPhone2" type="text" onkeyup="onKeyUp_phone()" maxlength="4"/>
            <span id="regPhone-2">-</span>
            <input id="regPhone3" type="text" onkeyup="onKeyUp_phone()" maxlength="4"/>
            
            <button id="cancel">취소</button>
            <button id="change">변경</button>
            
            <span class="msg" id="num_s"></span>
            <span class="msg" id="phone_s"></span>
            
            
        </div>
	</body>
	<script>
		$(document).ready(function() {
			 $.ajax({
				 type : "post",
				 url : "./userInfo",
				 dataType : "json",
				 success : function (data) {
					if(data.login==false){
						alert("로그인 후 사용가능");
						location.href="regDetail.jsp";
					}else if(data.login==true && data.userInfo != null){
						console.log(data.userInfo);
						$("#regName").val(data.userInfo.info_name);
						$("#regGender").val(data.userInfo.info_gender);
						$("#regBirth").val(data.userInfo.info_birth);
						$("#regEmail").val(data.userInfo.info_email);
					}
				},
				error : function (error) {
					console.log(error);
				}
			 });
		});
	
		//주민등록번호 onkeyup 이벤트
		/* function onKeyUp_num() {
			var regNumTxt1 = $("#regNum1");
			var regNumTxt2 = $("#regNum2");
			var msg = $("#num_s");
			
			if(regNumTxt1.val() == ""){
				msg.html("주민등록번호 앞자리를 입력해주세요.");
			}else if(regNumTxt1.val().length < 6){
				msg.html("주민등록번호 앞자리를 입력해주세요.");
			}else if(regNumTxt2.val() == ""){
				msg.html("주민등록번호 뒷자리를 입력해주세요.");
			}else if(regNumTxt2.val().length < 7){
				msg.html("주민등록번호 뒷자리를 입력해주세요.");
			}else if(regNumTxt1.val() != ""){
				msg.html("");
			}else if(regNumTxt2.val() != ""){
				msg.html("");
			}
		} */
		//주민등록번호 onkeyup 이벤트
		function onKeyUp_num1() {
			var regNumTxt1 = $("#regNum1");
			var regNumTxt2 = $("#regNum2");
			var msg = $("#num_s");
			
			if(regNumTxt1.val() == ""){
				msg.html("주민등록번호 앞자리를 입력해주세요.");
			}else if(regNumTxt1.val().length < 6){
				msg.html("주민등록번호 앞자리를 입력해주세요.");
			}else if(regNumTxt1.val() != ""){
				msg.html("");
			}
			
			$.ajax({
				type : "post",
				url : "./numOverlay",
				data : { num1 : regNumTxt1.val(), num2 : regNumTxt2.val() },
				dataType : "json",
				success : function(data) {
					console.log(data);
					if(data.result == true){
						msg.html("등록된 주민등록번호 입니다.");
						msg.css("color", "red");
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		}
		
		//주민번호 중복 확인 onkeyup 이벤트
		function onKeyUp_num2() {
			var regNumTxt1 = $("#regNum1");
			var regNumTxt2 = $("#regNum2");
			var msg = $("#num_s");
			
			if(regNumTxt2.val() == ""){
				msg.html("주민등록번호 뒷자리를 입력해주세요.");
			}else if(regNumTxt2.val().length < 7){
				msg.html("주민등록번호 뒷자리를 입력해주세요.");
			}else if(regNumTxt2.val() != ""){
				msg.html("");
			}
			$.ajax({
				type : "post",
				url : "./numOverlay",
				data : { num1 : regNumTxt1.val(), num2 : regNumTxt2.val() },
				dataType : "json",
				success : function(data) {
					console.log(data);
					if(data.result == true){
						msg.html("등록된 주민등록번호 입니다.");
						msg.css("color", "red");
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		}
		
		//휴대폰번호 onkeyup 이벤트
		function onKeyUp_phone() {
			var regPhoneTxt1 = $("#regPhone1");
			var regPhoneTxt2 = $("#regPhone2");
			var regPhoneTxt3 = $("#regPhone3");
			var msg = $("#phone_s");
			
			if(regPhoneTxt1.val().length < 3){
				msg.html("휴대폰 번호를 입력하세요.");
			}else if(regPhoneTxt1.val()==""){
				msg.html("휴대폰 번호를 입력하세요.");
			}else if(regPhoneTxt2.val().length < 4){
				msg.html("휴대폰 번호를 입력하세요.");
			}else if(regPhoneTxt2.val() == ""){
				msg.html("휴대폰 번호를 입력하세요.");
			}else if(regPhoneTxt3.val().length < 4){
				msg.html("휴대폰 번호를 입력하세요.");
			}else if(regPhoneTxt3.val() == ""){
				msg.html("휴대폰 번호를 입력하세요.");
			}else if(regPhoneTxt1.val() != ""){
				msg.html("");
			}else if(regPhoneTxt2.val() != ""){
				msg.html("");
			}else if(regPhoneTxt3.val() != ""){
				msg.html("");
			}
		}
		
		
		$("#cancel").click(function() {
			location.href="index.jsp";
		});
		
		$("#change").click(function() {
			if($("#regNum1").val()==""){
				$("#num_s").html("주민등록번호 앞자리 입력");
				$("#regNum1").focus();
			}else if($("#regNum1").val().length < 6){
				$("#num_s").html("주민등록번호 앞 6자리 입력");
				$("#regNum1").focus();
			}else if($("#regNum2").val()==""){
				$("#num_s").html("주민등록번호 뒷자리 입력");
				$("#regNum2").focus();
			}else if($("#regNum2").val().length < 7){
				$("#num_s").html("주민등록번호 뒤 7자리 입력");
				$("#regNum2").focus();
			}else if($("#regPhone1").val()==""){
				$("#phone_s").html("휴대폰번호를 입력하세요.");
				$("#regPhone1").focus();
			}else if($("#regPhone1").val().length <3){
				$("#phone_s").html("휴대폰번호를 입력하세요.");
				$("#regPhone1").focus();
			}else if($("#regPhone2").val()==""){
				$("#phone_s").html("휴대폰번호를 입력하세요.");
				$("#regPhone2").focus();
			}else if($("#regPhone2").val().length <4){
				$("#phone_s").html("휴대폰번호를 입력하세요.");
				$("#regPhone1").focus();
			}else if($("#regPhone3").val()==""){
				$("#phone_s").html("휴대폰번호를 입력하세요.");
				$("#regPhone2").focus();
			}else if($("#regPhone3").val().length <4){
				$("#phone_s").html("휴대폰번호를 입력하세요.");
				$("#regPhone3").focus();
			}else{
				$.ajax({
					type : "post",
					url : "./regChange",
					data : {
						num1 : $("#regNum1").val(),
						num2 : $("#regNum2").val(),
						phone1 : $("#regPhone1").val(),
						phone2 : $("#regPhone2").val(),
						phone3 : $("#regPhone3").val()
					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						console.log(data.loginId);
						console.log(data.loginDiv);
						if(data.success > 0 && data.result == false){
							alert("등록자 전환 완료");
							location.href="index.jsp";
						}else{
							alert("등록자 전환 실패");
						}
					},
					error : function(error) {
						console.log(error);
					}
				});
			}
		});
	</script>
</html>