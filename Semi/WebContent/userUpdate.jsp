<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
	        div#main{ position: absolute; border: 1.5px solid #A4A4A4; width: 300px; height: 540px; left: 40%;
				top: 100px; text-align: center; }
	        span#usertxt{ position: absolute; left: 100px;
	            top: 10px; font-size: 20px; }

	        b#id{ position: absolute; left: 15px; top: 77px; font-size: 13px; }
	        input#userId{ position: absolute; left: 75px; top: 75px; width: 200px; height: 25px; font-size: 10px; }
	        button#idChk{ position: absolute; left: 280px; top: 75px; width: 69px;
	            height: 25px; color: white; background-color: black; border-style: none; font-size: 10px; }
	        
	        
	        b#pw{ position: absolute; left: 15px; top: 130px; font-size: 13px; }
	        input#userPw{ position: absolute; left: 105px; top: 127px;
	            width: 170px; height: 25px; font-size: 10px; }	
	        
	        b#newPw{ position: absolute; left: 15px; top: 183px; font-size: 13px; }
	        input#userNewPw{
	            position: absolute; left: 105px; top: 180px;
	            width: 170px; height: 25px; font-size: 10px;  }
	            
	        b#newPwChk{ position: absolute; left: 15px; top: 236px; font-size: 13px; }
	        input#userNewPwChk{  position: absolute; left: 120px; top: 236px;
	            width: 155px; height: 25px; font-size: 10px;  }  
	        
	        b#name{ position: absolute; left: 15px; top: 289px; font-size: 13px;  }
	        input#userName{ position: absolute; left: 75px; top: 286px;
 				width: 200px; height: 25px; font-size: 10px;     } 
	        
	        b#Gender{ position: absolute; left: 15px; top: 340px; font-size: 13px; }  
	        span#gender{ position: absolute; left: 75px; top: 339px; }
			label#lbM{ display: inline-block; border: 1px solid #A4A4A4; padding: 1px 20px;}
			label#lbW{ display: inline-block; border: 1px solid #A4A4A4; padding: 1px 20px; }
			input#man{ display: none; }
			input#woman{ display: none; }
	        
	        b#birth{ position: absolute; left: 15px; top: 395px; font-size: 13px; }
	        select#userBirthYear{ position: absolute; left: 75px; top:392px;}
	        select#userBirthMonth{ position: absolute; left: 130px; top: 392px; }
	        select#userBirthDay{ position: absolute; left: 170px; top: 392px; }
	        
	        b#email{ position: absolute; left: 15px; top: 448px; font-size: 13px; }
	        input#userEmail{ position: absolute; left: 75px; top: 445px;
	            width: 200px; height: 25px; font-size: 10px;             }

	        button#cancel{ position: absolute; left: 165px; top: 495px; width: 50px; height: 25px;    
	            color: white; background-color: black; border-style: none; font-size: 10px; cursor: pointer;}
	        button#save{ position: absolute; left: 225px; top: 495px; width: 50px; height: 25px;
	            font-size: 10px; color: white; background-color: black; border-style: none; cursor: pointer;}
	            
	        span#pw_s{position: absolute; left: 75px; top: 157px;}
	        span#pwC1_s{position: absolute; left: 75px; top: 210px;}
	        span#pwC2_s{position: absolute; left: 75px; top: 264px;}
	        span#name_s{position: absolute; left: 75px; top: 316px;}
	        span#gender_s{position: absolute; left: 75px; top: 368px;}
	        span#birth_s{position: absolute; left: 75px; top: 420px;}
	        span#email_s{position: absolute; left: 75px; top: 474px;}
	        
	        span.msg{font-size: 13px; color: red}
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div id="main">
            <span id="userTxt"><b>회원정보 수정</b></span>
            <b id="id">아이디</b>
            <input id="userId" type="text" value="${sessionScope.loginId }" readonly/>
            
            <b id="pw">현재 비밀번호</b>
            <input onkeyup="onKeyUp_pw()" id="userPw" type="password" placeholder="비밀번호를 입력하세요." maxlength="12"/>
            
            <b id="newPw">새 비밀번호</b>
            <input id="userNewPw" type="password" placeholder="비밀번호를 입력하세요." onkeyup="onKeyUp_pw1()" maxlength="12"/>
            
            <b id="newPwChk">새 비밀번호 확인</b>
            <input id="userNewPwChk" type="password" placeholder="비밀번호를 입력하세요." onkeyup="onKeyUp_pw2()" maxlength="12"/> 
            <b id="name">이름</b>
            <input onkeyup="onKeyUp_name()" id="userName" type="text" placeholder="이름을 입력하세요."/>
            <b id="Gender">성별</b>
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
            
            <span class="msg" id="pw_s"></span>
            <span class="msg" id="pwC1_s"></span>
            <span class="msg" id="pwC2_s"></span>
            <span class="msg" id="name_s"></span>
            <span class="msg" id="gender_s"></span>
            <span class="msg" id="birth_s"></span>
            <span class="msg" id="email_s"></span>
              
            <button id="cancel">취소</button>
            <button id="save">수정</button>
        </div>
	</body>
	<script>
		function onKeyUp_pw(){
			var userPw = $("#userPw");   
			var msg = $("#pw_s");
			if(userPw.val()==""){
				msg.html("현재 비밀번호를 입력하세요.");
			}else{
				msg.html("");
			}
			
			$.ajax({
				type : "post",
				url : "./pwChk",
				data : {
					pw : $("#userPw").val()
				},
				dataType : "json",
				success : function(data) {
					if(data.result != userPw.val()){
						msg.html("현재 비밀번호가 틀립니다.");
					}
				},
				error : function(error) {
					console.log(error);
				}
			}); 
		}
	
		//비밀번호 onkeyup 이벤트
		function onKeyUp_pw1(){
			var userPwTxt1 = $("#userNewPw");
			var msg = $("#pwC1_s");
			if(userPwTxt1.val()==""){
				msg.html("새 비밀번호 입력");
			}else if(userPwTxt1.val().length < 8 || userPwTxt1.val().length >12){
				msg.html("비밀번호 8~12자리 입력");
			}else if(userPwTxt1.val().length >= 8 || userPwTxt1.val().length <=12){
				msg.html("");
			}
		}
		function onKeyUp_pw2(){
			var userPwTxt1 = $("#userNewPw");
			var userPwTxt2 = $("#userNewPwChk");
			var msg = $("#pwC2_s");

			if(userPwTxt1.val() != userPwTxt2.val()){
				msg.html("비밀번호가 맞지 않습니다.");
			}else if(userPwTxt1.val() == userPwTxt2.val()){
				msg.html("");
			}
		}
		
		//이름 onkeyup 이벤트
		function onKeyUp_name() {
			var userNameTxt = $("#userName").val();
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
				msg.html("생년월일을 선택하세요.");
			}else if(month.val() == "월"){
				msg.html("생년월일을 선택하세요.");
			}else if(day.val() == "일"){
				msg.html("생년월일을 선택하세요.");
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
				msg.html("생년월일을 선택하세요.");
			}else if(month.val() == "월"){
				msg.html("생년월일을 선택하세요.");
			}else if(day.val() == "일"){
				msg.html("생년월일을 선택하세요.");
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
		}

		
		$("#cancel").click(function() {
			location.href="userDetail.jsp";
		});
	
		$("#save").click(function() {
			var newPw = $("#userNewPw").val();
			var newPwChk = $("#userNewPwChk").val();
			var pw = $("#userPw").val();

			if($("#userPw").val()==""){
				//alert("현재비밀번호 입력");
				$("#pw_s").html("현재 비밀번호를 입력하세요.");
				$("#userPw").focus();
			}else if($("#userNewPw").val()==""){
				$("#pwC1_s").html("새 비밀번호 입력");
				//alert("새 비밀번호 입력");
				$("#userNewPw").focus();
			}else if($("#userNewPw").val().length < 8 || $("#userNewPw").val().length >12){
				$("#pwC1_s").html("비밀번호 8~12자리 입력");
				$("#userNewPw").focus();
			}else if($("#userNewPwChk").val()==""){
				//alert("새 비밀번호 재입력");
				$("#pwC2_s").html("새 비밀번호 재입력");
				$("#userNewPwChk").focus();
			}else if(newPw != newPwChk){
				//alert("비밀번호가 맞지 않습니다.");
				$("#pwC2_s").html("비밀번호가 맞지 않습니다.");
				$("#userNewPwChk").focus();
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
			}else{
				$.ajax({
					type : "post",
					url : "./userUpdate",
					data : {
						id : $("#userId").val(),
						pw : $("#userPw").val(),
						newPw : $("#userNewPw").val(),
						newPwChk : $("#userNewPwChk").val(),
						name : $("#userName").val(),
						gender : $("input[name='userGender']:checked").val(),
						year : $("#userBirthYear").val(),
						month : $("#userBirthMonth").val(),
						day : $("#userBirthDay").val(),
						email : $("#userEmail").val()
					},
					dataType : "json",
					success : function(data) {
						if(data.success >0){
							alert("수정 성공");
							location.href="userDetail.jsp";
						}else{
							alert("수정 실패");
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