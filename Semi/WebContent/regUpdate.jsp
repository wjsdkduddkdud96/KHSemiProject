<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
	        div#main{ position: absolute; border: 1.5px solid #A4A4A4; width: 320px; height: 650px; left: 40%;
				top: 100px; text-align: center; }
	        span#regTxt{ position: absolute; left: 100px;
	            top: 10px; font-size: 20px; }

	        b#id{ position: absolute; left: 15px; top: 77px; font-size: 13px; }
	        input#regId{ position: absolute; left: 75px; top: 75px; width: 200px; height: 25px; font-size: 10px; }
	        button#idChk{ position: absolute; left: 280px; top: 75px; width: 69px;
	            height: 25px; color: white; background-color: black; border-style: none; font-size: 10px; }
	        
	        
	        b#pw{ position: absolute; left: 15px; top: 130px; font-size: 13px; }
	        input#regPw{ position: absolute; left: 105px; top: 127px;
	            width: 170px; height: 25px; font-size: 10px; }	
	        
	        b#newPw{ position: absolute; left: 15px; top: 183px; font-size: 13px; }
	        input#regNewPw{
	            position: absolute; left: 105px; top: 180px;
	            width: 170px; height: 25px; font-size: 10px;  }
	            
	        b#newPwChk{ position: absolute; left: 15px; top: 236px; font-size: 13px; }
	        input#regNewPwChk{  position: absolute; left: 120px; top: 236px;
	            width: 155px; height: 25px; font-size: 10px;  }  

	        b#name{ position: absolute; left: 15px; top: 289px; font-size: 13px;  }
	        input#regName{ position: absolute; left: 75px; top: 286px;
 				width: 200px; height: 25px; font-size: 10px;     } 
	        
	        b#Gender{ position: absolute; left: 15px; top: 340px; font-size: 13px; }  
	        span#gender{ position: absolute; left: 75px; top: 339px; }
			label#lbM{ display: inline-block; border: 1px solid #A4A4A4; padding: 1px 20px;}
			label#lbW{ display: inline-block; border: 1px solid #A4A4A4; padding: 1px 20px; }
			input#man{ display: none; }
			input#woman{ display: none; }
	        
	        b#birth{ position: absolute; left: 15px; top: 395px; font-size: 13px; }
	        select#regBirthYear{ position: absolute; left: 75px; top:392px;}
	        select#regBirthMonth{ position: absolute; left: 130px; top: 392px; }
	        select#regBirthDay{ position: absolute; left: 170px; top: 392px; }
	        
	        b#email{ position: absolute; left: 15px; top: 448px; font-size: 13px; }
	        input#regEmail{ position: absolute; left: 75px; top: 445px;
	            width: 200px; height: 25px; font-size: 10px;             }
	            
	        b#num{ position: absolute; left: 15px; top: 501px; font-size: 13px; }
	        span#regNum-{position: absolute; left: 155px; top: 498px;}
	        input#regNum1{ position: absolute; left: 100px; top: 498px;
	            width: 50px; height: 25px; font-size: 10px;             }    
	        input#regNum2{ position: absolute; left: 165px; top: 498px;
	            width: 50px; height: 25px; font-size: 10px;             }    
	            
	        b#phone{ position: absolute; left: 15px; top: 554px; font-size: 13px; }
	        span#regPhone-1{position: absolute; left: 155px; top: 551px;}
	        span#regPhone-2{position: absolute; left: 220px; top: 551px;}
	        input#regPhone1{ position: absolute; left: 100px; top: 551px;
	            width: 50px; height: 25px; font-size: 10px;             }
			input#regPhone2{ position: absolute; left: 165px; top: 551px;
	            width: 50px; height: 25px; font-size: 10px;             }
			input#regPhone3{ position: absolute; left: 235px; top: 551px;
	            width: 50px; height: 25px; font-size: 10px;             }

	        button#cancel{ position: absolute; left: 180px; top: 607px; width: 50px; height: 25px;    
	            color: white; background-color: black; border-style: none; font-size: 10px;cursor: pointer; }
	        button#save{
	            position: absolute; left: 240px; top: 607px; width: 50px; height: 25px;
	            font-size: 10px; color: white; background-color: black; border-style: none;cursor: pointer; }
	            
	        span#pw_s{position: absolute; left: 75px; top: 157px;}
	        span#pwC1_s{position: absolute; left: 75px; top: 210px;}
	        span#pwC2_s{position: absolute; left: 75px; top: 264px;}
	        span#name_s{position: absolute; left: 75px; top: 316px;}
	        span#gender_s{position: absolute; left: 75px; top: 368px;}
	        span#birth_s{position: absolute; left: 75px; top: 422px;}
	        span#email_s{position: absolute; left: 75px; top: 474px;}
	        span#num_s{position: absolute; left: 75px; top: 526px;}
	        span#phone_s{position: absolute; left: 75px; top: 578px;}
	        
	        span.msg{font-size: 13px; color: red}
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div id="main">
            <span id="regTxt"><b>회원정보 수정</b></span>
            <b id="id">아이디</b>
            <input id="regId" type="text" readonly value="${sessionScope.loginId }"/>
            <b id="pw">현재 비밀번호</b>
            <input onkeyup="onKeyUp_pw()" id="regPw" type="password" placeholder="비밀번호를 입력하세요." maxlength="12"/>
            
            <b id="newPw">새 비밀번호</b>
            <input onkeyup="onKeyUp_pw1()" id="regNewPw" type="password" placeholder="비밀번호를 입력하세요." maxlength="12"/>
            
            <b id="newPwChk">새 비밀번호 확인</b>
            <input onkeyup="onKeyUp_pw2()" id="regNewPwChk" type="password" placeholder="비밀번호를 입력하세요." maxlength="12" />
            
            <b id="name">이름</b>
            <input onkeyup="onKeyUp_name()" id="regName" type="text" placeholder="이름을 입력하세요."/>
            <b id="Gender">성별</b>
          	<span id="gender">
            	<label id="lbM"><input onclick="onClick_gender()" id="man" type="radio" name="regGender" value="남"/>남자</label>
            	&nbsp;
            	<label id="lbW"><input onclick="onClick_gender()" id="woman" type="radio" name="regGender" value="여"/>여자</label>
            </span>

            <b id="birth">생년월일</b>
            <select name="regBirthYear" id="regBirthYear" onclick="onClick_birht()" onkeyup="onKeyUp_birth()">
            	<option value="년도" selected>년도</option>
            	<%for(int i=1920; i<2003; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            
            <select name="regBirthMonth" id="regBirthMonth" onclick="onClick_birht()" onkeyup="onKeyUp_birth()">
            	<option value="월" selected>월</option>
            	<%for(int i=1; i<13; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            
            <select name="regBirthDay" id="regBirthDay" onclick="onClick_birht()" onkeyup="onKeyUp_birth()">
            	<option value="일" selected>일</option>
            	<%for(int i=1; i<32; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            
            <b id="email">이메일</b>
            <input onkeyup="onKeyUp_email()" id="regEmail" type="email" placeholder="이메일을 입력하세요."/>
            <b id="num">주민등록번호</b>
            <input id="regNum1" type="text" placeholder="" onkeyup="onKeyUp_num()" maxlength="6" readonly="readonly"/>
            <span id="regNum-">-</span>
            <input id="regNum2" type="password" placeholder="" onkeyup="onKeyUp_num()" maxlength="7" readonly="readonly"/>
            <b id="phone">휴대폰 번호</b>
            <input id="regPhone1" type="text" onkeyup="onKeyUp_phone()" maxlength="3"/>
            <span id="regPhone-1">-</span>
            <input id="regPhone2" type="text" onkeyup="onKeyUp_phone()" maxlength="4"/>
            <span id="regPhone-2">-</span>
            <input id="regPhone3" type="text" onkeyup="onKeyUp_phone()" maxlength="4"/>
            
            <span class="msg" id="pw_s"></span>
            <span class="msg" id="pwC1_s"></span>
            <span class="msg" id="pwC2_s"></span>
            <span class="msg" id="name_s"></span>
            <span class="msg" id="gender_s"></span>
            <span class="msg" id="birth_s"></span>
            <span class="msg" id="email_s"></span>
            <span class="msg" id="num_s"></span>
            <span class="msg" id="phone_s"></span>
            
            <button id="cancel">취소</button>
            <button id="save">수정</button>
        </div>
	</body>
	<script>
		$(document).ready(function () {
			$.ajax({
				type:"post",
				url:"./userInfo",
				dataType:"json",
				success : function(data){
					$("#regNum1").val(data.userInfo.info_num.substring(0,6));
					$("#regNum2").val(data.userInfo.info_num.substring(6,13));
				},
				error : function (error) {
					console.log(error);
				}
			});
		});
		//현재 비밀번호 onkeyup 이벤트
		function onKeyUp_pw(){
			var regPw = $("#regPw");   
			var msg = $("#pw_s");
			if(regPw.val()==""){
				msg.html("현재 비밀번호를 입력하세요.");
			}else{
				msg.html("");
			}
			$.ajax({
				type : "post",
				url : "./pwChk",
				data : {
					pw : $("#regPw").val()
				},
				dataType : "json",
				success : function(data) {
					if(data.result != regPw.val()){
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
			var regPwTxt1 = $("#regNewPw");
			var msg = $("#pwC1_s");
			if(regPwTxt1.val()==""){
				msg.html("새 비밀번호 입력");
			}else if(regPwTxt1.val().length < 8 || regPwTxt1.val().length >12){
				msg.html("비밀번호 8~12자리 입력");
			}else if(regPwTxt1.val().length >= 8 || regPwTxt1.val().length <=12){
				msg.html("");
			}
		}
		function onKeyUp_pw2(){
			var regPwTxt1 = $("#regNewPw");
			var regPwTxt2 = $("#regNewPwChk");
			var msg = $("#pwC2_s");
	
			if(regPwTxt1.val() != regPwTxt2.val()){
				msg.html("비밀번호가 맞지 않습니다.");
			}else if(regPwTxt1.val() == regPwTxt2.val()){
				msg.html("");
			}
		}
		
		//이름 onkeyup 이벤트
		function onKeyUp_name() {
			var regNameTxt = $("#regName").val();
			//console.log(userNameTxt);
			var msg = $("#name_s");
			if(regNameTxt != ""){
				msg.html("");
			}else if(regNameTxt == ""){
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
		function onClick_birht() {
			var year = $("#regBirthYear");
			var month = $("#regBirthMonth");
			var day = $("#regBirthDay");
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
			var year = $("#regBirthYear");
			var month = $("#regBirthMonth");
			var day = $("#regBirthDay");
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
			var regEmailTxt = $("#regEmail");
			var msg = $("#email_s");
			
			if(regEmailTxt.val() != ""){
				msg.html("");
			}else if(regEmailTxt.val() == ""){
				msg.html("이메일을 입력해주세요.");
			}
		}
		
		//주민등록번호 onkeyup 이벤트
		function onKeyUp_num() {
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
			location.href="regDetail.jsp";
		});
		
		$("#save").click(function() {
			var newPw = $("#regNewPw").val();
			var newPwChk = $("#regNewPwChk").val();
			var pw = $("#regPw").val();
			
			if($("#regPw").val()==""){
				//alert("현재 비밀번호 입력");				
				$("#pw_s").html("현재 비밀번호를 입력하세요.");
				$("#regPw").focus();//포커스 이동
			}else if($("#regNewPw").val()==""){
				//alert("새 비밀번호 입력");		
				$("#pwC1_s").html("새 비밀번호 입력");
				$("#regNewPw").focus();//포커스 이동	
			}else if($("#regNewPw").val().length < 8 || $("#regNewPw").val().length >12){
				//alert("비밀번호 8~12자리 입력");
				$("#pwC1_s").html("비밀번호 8~12자리 입력");
				$("#regNewPw").focus();//포커스 이동	
			}else if($("#regNewPwChk").val()==""){
				//alert("새 비밀번호 재입력");
				$("#pwC2_s").html("새 비밀번호 입력");
				$("#regNewPwChk").focus();
			}else if($("#regNewPw").val() != $("#regNewPwChk").val()){
				//alert("비밀번호 재입력");
				$("#pwC2_s").html("비밀번호가 맞지 않습니다.");
				$("#regNewPwChk").focus();//포커스 이동	
			}else if($("#regName").val()==""){
				//alert("이름을 입력");
				$("#name_s").html("이름을 입력하세요.");
				$("#regName").focus();//포커스 이동	
			}else if($("#man").get(0).checked != true && $("#woman").get(0).checked != true){
				//alert("성별을 선택");	
				$("#gender_s").html("성별을 선택하세요.");
			}else if($("#regBirthYear").val()=="년도"){
				//alert("년도를 선택해주세요.");
				$("#birth_s").html("생년월일을 선택하세요.");
				$("#regBirthYear").focus();
			}else if($("#regBirthMonth").val()=="월"){
				//alert("월을 선택해주세요.");
				$("#birth_s").html("생년월일을 선택하세요.");
				$("#regBirthMonth").focus();
			}else if($("#regBirthDay").val()=="일"){
				//alert("일을 선택해주세요.");
				$("#birth_s").html("생년월일을 선택하세요.");
				$("#regBirthDay").focus();
			}else if($("#regEmail").val()==""){
				//alert("이메일을 입력해주세요.");
				$("#email_s").html("이메일을 입력하세요.");
				$("#regEmail").focus();
			}else if($("#regNum1").val()==""){
				//alert("주민등록번호 앞자리를 입력해주세요.");
				$("#num_s").html("주민등록번호 앞자리를 입력하세요.");
				$("#regNum1").focus();
			}else if($("#regNum1").val().length < 6){
				$("#num_s").html("주민등록번호 앞 6자리 입력");
				$("#regNum1").focus();
			}else if($("#regNum2").val()==""){
				//alert("주민등록번호 뒷자리를 입력해주세요.");
				$("#num_s").html("주민등록번호 뒷자리를 입력하세요.");
				$("#regNum2").focus();
			}else if($("#regNum2").val().length < 7){
				$("#num_s").html("주민등록번호 뒤 7자리 입력");
				$("#regNum2").focus();
			}else if($("#regPhone1").val()==""){
				//alert("휴대폰 번호를 입력해주세요.");
				$("#phone_s").html("휴대폰 번호를 입력하세요.");
				$("#regPhone1").focus();
			}else if($("#regPhone2").val()==""){
				//alert("휴대폰 번호를 입력해주세요.");
				$("#phone_s").html("휴대폰 번호를 입력하세요.");
				$("#regPhone2").focus();
			}else if($("#regPhone3").val()==""){
				//alert("휴대폰 번호를 입력해주세요.");
				$("#phone_s").html("휴대폰 번호를 입력하세요.");
				$("#regPhone3").focus();
			}else {
				$.ajax({
					type : "post",
					url : "./regUpdate",
					data : {
						id : $("#regId").val(),
						pw : $("#regPw").val(),
						newPw : $("#regNewPw").val(),
						newPwChk : $("#regNewPwChk").val(),
						name : $("#regName").val(),
						gender : $("input[name='regGender']:checked").val(),
						year : $("#regBirthYear").val(),
						month : $("#regBirthMonth").val(),
						day : $("#regBirthDay").val(),
						email : $("#regEmail").val(),
						num1 : $("#regNum1").val(),
						num2 : $("#regNum2").val(),
						phone1 : $("#regPhone1").val(),
						phone2 : $("#regPhone2").val(),
						phone3 : $("#regPhone3").val()
					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						if(data.success >0){
							alert("수정 성공");
							location.href="regDetail.jsp";
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