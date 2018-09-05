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
	        span#usertxt{ position: absolute; left: 80px;
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
	        
	        b#name{ position: absolute; left: 15px; top: 236px; font-size: 13px;  }
	        input#userName{ position: absolute; left: 75px; top: 233px;
 				width: 200px; height: 25px; font-size: 10px;     } 
	        
	        b#Gender{ position: absolute; left: 15px; top: 289px; font-size: 13px; }  
	        span#gender{ position: absolute; left: 75px; top: 286px; }
			label#lbM{ display: inline-block; border: 1px solid #A4A4A4; padding: 1px 20px;}
			label#lbW{ display: inline-block; border: 1px solid #A4A4A4; padding: 1px 20px; }
			input#man{ display: none; }
			input#woman{ display: none; }
	        
	        b#birth{ position: absolute; left: 15px; top: 340px; font-size: 13px; }
	        select#userBirthYear{ position: absolute; left: 75px; top:339px;}
	        select#userBirthMonth{ position: absolute; left: 130px; top: 339px; }
	        select#userBirthDay{ position: absolute; left: 170px; top: 339px; }
	        
	        b#email{ position: absolute; left: 15px; top: 395px; font-size: 13px; }
	        input#userEmail{ position: absolute; left: 75px; top: 392px;
	            width: 200px; height: 25px; font-size: 10px;             }

	        button#cancel{ position: absolute; left: 165px; top: 455px; width: 50px; height: 25px;    
	            color: white; background-color: black; border-style: none; font-size: 10px; cursor: pointer; }
	        button#join{ position: absolute; left: 225px; top: 455px; width: 50px; height: 25px;
	            font-size: 10px; color: white; background-color: black; border-style: none; cursor: pointer; }
	            
	        span#id_s{position: absolute; left: 75px; top: 105px;}
	        span#pw_s{position: absolute; left: 75px; top: 157px;}
	        span#pwC_s{position: absolute; left: 75px; top: 210px;}
	        span#name_s{position: absolute; left: 75px; top: 264px;}
	        span#gender_s{position: absolute; left: 75px; top: 316px;}
	        span#birth_s{position: absolute; left: 75px; top: 368px;}
	        span#email_s{position: absolute; left: 75px; top: 422px;}
	        
	        span.msg{font-size: 13px; color: red}
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div id="main">
            <span id="userTxt"><b>사용자 회원가입</b></span>
            <b id="id">아이디</b>
            <input id="userId" name="userId" type="text" placeholder=" 아이디를 입력하세요.(5~16)" maxlength="16" onkeyup="onKeyUp_idChk()"/>
            <!--<input id="idChk" type="button" value="중복 확인"/>-->
            <!-- <button id="idChk" name="idChk">중복 확인</button> -->
            <b id="pw">비밀번호</b>
            <input id="userPw" name="userPw" type="password" placeholder="비밀번호를 입력하세요.(8~12)" onkeyup="onKeyUp_pw1()" maxlength="12"/>
            <b id="pwChk">비밀번호 확인</b>
            <input id="userPwChk" name="userPwChk" type="password" placeholder="비밀번호를 입력하세요.(8~12)" onkeyup="onKeyUp_pw2()" maxlength="12"/>
            <b id="name">이&nbsp;&nbsp;&nbsp;&nbsp;름</b>
            <input id="userName" name="userName" type="text" placeholder="이름을 입력하세요." onkeyup="onKeyUp_name()"/>
            <b id="Gender">성&nbsp;&nbsp;&nbsp;&nbsp;별</b>
            <span id="gender">
            	<label id="lbM"><input onclick="onClick_gender()" id="man" type="radio" name="userGender" value="남"/>남자</label>
            	&nbsp;
            	<label id="lbW"><input onclick="onClick_gender()" id="woman" type="radio" name="userGender" value="여"/>여자</label>
            </span>
                      
            <b id="birth">생년월일</b>
            <select name="userBirthYear" id="userBirthYear" onclick="onClick_birth()" onkeyup="onKeyUp_birth()">
            	<option value="년도" selected>년도</option>
            	<%for(int i=1920; i<2003; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            
            <select name="userBirthMonth" id="userBirthMonth" onclick="onClick_birth()" onkeyup="onKeyUp_birth()">
            	<option value="월" selected>월</option>
            	<%for(int i=1; i<13; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            
            <select name="userBirthDay" id="userBirthDay" onclick="onClick_birth()" onkeyup="onKeyUp_birth()">
            	<option value="일" selected>일</option>
            	<%for(int i=1; i<32; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            
            <b id="email">이메일</b>
            <input onkeyup="onKeyUp_email()" id="userEmail" type="email" placeholder="이메일을 입력하세요."/>
            
            
            
            <span class="msg" id="id_s"></span>
            <span class="msg" id="pw_s"></span>
            <span class="msg" id="pwC_s"></span>
            <span class="msg" id="name_s"></span>
            <span class="msg" id="gender_s"></span>
            <span class="msg" id="birth_s"></span>
            <span class="msg" id="email_s"></span>
            
            <button id="cancel">취소</button>
            <button id="join">완료</button>
        </div>
	</body>
	<script>
		var chk = false;//아이디 중복값 체크
		var emailChk = false;//이메일 중복값 체크
		//아이디 중복 확인 onkeyup 이벤트
		function onKeyUp_idChk() {
			var userIdTxt = $("#userId").val();
			var msg = $("#id_s");
			
			var idReg = /^[A-Za-z0-9+]{5,16}$/;
			$.ajax({
				type : "post",
				url : "./overlay",
				data : { id : userIdTxt },
				dataType : "json",
				success : function(data) {
					if(userIdTxt==""){
						msg.html("아이디 입력을 해주세요.");
						msg.css("color", "red");
					}else if(!idReg.test(userIdTxt)){
						msg.html("5~16자리 영문과 숫자만 가능");
						msg.css("color", "red");
					}else if(data.result == true){
						msg.html("중복된 아이디 입니다.");
						msg.css("color", "red");
					}else{
						msg.html("사용 가능한 아이디");
						msg.css("color", "green");
						chk = true;
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		}
		
		//비밀번호 onkeyup 이벤트
		function onKeyUp_pw1(){
			var userPwTxt1 = $("#userPw");
			var msg = $("#pw_s");

			if(userPwTxt1.val()==""){
				msg.html("비밀번호 8~12자리 입력");
			}else if(userPwTxt1.val().length < 8 || userPwTxt1.val().length >12){
				msg.html("비밀번호 8~12자리 입력");
			}else if(userPwTxt1.val().length >= 8 || userPwTxt1.val().length <=12){
				msg.html("");
			}
		}
 		function onKeyUp_pw2(){
 			var userPwTxt1 = $("#userPw");
			var userPwTxt2 = $("#userPwChk");
			var msg = $("#pwC_s");

			if(userPwTxt1.val() != userPwTxt2.val()){
				msg.html("비밀번호가 맞지 않습니다.");
			}else if(userPwTxt1.val() == userPwTxt2.val()){
				msg.html("");
			} 
		} 
		
		//이름 onkeyup 이벤트
		function onKeyUp_name() {
			var userNameTxt = $("#userName").val();
			console.log(userNameTxt);
			var msg = $("#name_s");
			if(userNameTxt != ""){
				msg.html("");
			}else if(userNameTxt == ""){
				msg.html("이름을 입력해주세요.");
			}
		}
		
		//성별 onclick 이벤트
		function onClick_gender() {
			var man = $("#man");
			var woman = $("#woman");
			var msg = $("#gender_s");

			if(man.get(0).checked){
				$("#lbM").css("background", "#FA5882");
				$("#lbW").css("background", "white");
				
				$("#lbM").css("color", "white");
				$("#lbW").css("color", "black");
				msg.html("");	
			}else if(woman.get(0).checked){
				$("#lbW").css("background", "#FA5882");
				$("#lbM").css("background", "white");
				
				$("#lbW").css("color", "white");
				$("#lbM").css("color", "black");
				msg.html("");	
			}
		}
		
		//생년월일 click 이벤트
		function onClick_birth() {
			var year = $("#userBirthYear");
			var month = $("#userBirthMonth");
			var day = $("#userBirthDay");
			var msg = $("#birth_s");
			
			if(year.val() == "년도"){
				msg.html("생년월일을 선택해주세요.");
			}else if(month.val() == "월"){
				msg.html("생년월일을 선택해주세요.");
			}else if(day.val() == "일"){
				msg.html("생년월일을 선택해주세요.");
			}else if(year.val() != "년도"){
				msg.html("");
			}else if(month.val() != "월"){
				msg.html("");
			}else if(day.val() != "일"){
				msg.html("");
			}
		}

		
		//생년월일 onkeyup 이벤트
		function onKeyUp_birth() {
			var year = $("#userBirthYear");
			var month = $("#userBirthMonth");
			var day = $("#userBirthDay");
			var msg = $("#birth_s");

			if(year.val() == "년도"){
					msg.html("생년월일을 선택해주세요.");
			}else if(month.val() == "월"){
				msg.html("생년월일을 선택해주세요.");
			}else if(day.val() == "일"){
				msg.html("생년월일을 선택해주세요.");
			}else if(year.val() != "년도"){
				msg.html("");
			}else if(month.val() != "월"){
				msg.html("");
			}else if(day.val() != "일"){
				msg.html("");
			}
		}
		
		//이메일 onkeyup 이벤트
		function onKeyUp_email() {
			var userEmailTxt = $("#userEmail");
			var msg = $("#email_s");
			
			if(userEmailTxt.val() != ""){
				msg.html("");
			}else if(userEmailTxt.val() == ""){
				msg.html("이메일을 입력해주세요.");
			}
/* 			$.ajax({
				type : "post",
				url : "./emailOverlay",
				data : {
					email : $("#userEmail").val()
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					if(data.result == true){
						msg.html("등록된 이메일 입니다.");
						msg.css("color", "red");
					}else{
						emailChk = true;
					}
				}, 
				error : function(error) {
					console.log(error);
				}
			}); */
		}
		

		
		//취소
		$("#cancel").click(function() {
			location.href="login.jsp";
		});
		
		//회원가입
		$("#join").click(function() {
			var userIdTxt = $("#userId").val();
			var userPw = $("#userPw").val();
			var userPwChk = $("#userPwChk").val();
			
			var idReg = /^[A-Za-z0-9+]{5,16}$/;
			
			if($("#userId").val()==""){
				$("#id_s").html("아이디를 입력하세요.");
				$("#userId").focus();
			}else if(!idReg.test(userIdTxt)){
				$("#id_s").html("5~16자리 영문과 숫자만 가능");
				$("#userId").focus();
			}else if(userPw==""){
				$("#pw_s").html("비밀번호를 입력하세요.");
				$("#userPw").focus();
			}else if($("#userPw").val().length < 8 || $("#userPw").val().length >12){
				$("#pw_s").html("비밀번호 8~12자리 입력");
				$("#userPw").focus();
			}else if(userPwChk==""){		
				$("#pwC_s").html("비밀번호를 입력하세요.");
				$("#userPwChk").focus();
			}else if(userPw != userPwChk){
				$("#pwC_s").html("비밀번호를 재입력하세요.");
				$("#userPwChk").focus();
			}else if($("#userName").val()==""){
				$("#name_s").html("이름을 입력하세요.");
				$("#userName").focus();
			}else if($("#man").get(0).checked != true && $("#woman").get(0).checked != true){
				$("#gender_s").html("성별을 선택하세요.");
			}else if($("#userBirthYear").val()=="년도"){
				$("#birth_s").html("생년월일을 선택하세요.");
				$("#userBirthYear").focus();
			}else if($("#userBirthMonth").val()=="월"){
				$("#birth_s").html("생년월일을 선택하세요.");
				$("#userBirthMonth").focus();
			}else if($("#userBirthDay").val()=="일"){
				$("#birth_s").html("생년월일을 선택하세요.");
				$("#userBirthDay").focus();
			}else if($("#userEmail").val()==""){
				$("#email_s").html("이메일을 입력하세요.");
				$("#userEmail").focus();
			}else if(chk==false){
				$("#id_s").html("아이디 중복확인 하세요.");
				$("#userId").focus();
			}else{
				$.ajax({
					type : "post",
					url : "./userJoin",
					data : {
						id : $("#userId").val(),
						pw : $("#userPw").val(),
						name : $("#userName").val(),
						gender : $("input[name='userGender']:checked").val(),
						year : $("#userBirthYear").val(),
						month : $("#userBirthMonth").val(),
						day : $("#userBirthDay").val(),
						email : $("#userEmail").val()
					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						if(data.success > 0){
							alert("회원가입 성공");
							location.href="login.jsp";
						}else{
							alert("회원가입 실패");
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