<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
	     	div#main{ position: absolute; border: 1.5px solid #A4A4A4; width: 300px; height: 600px; left: 40%;
				top: 100px; text-align: center; }
	        span#regTxt{ position: absolute; left: 80px;
	            top: 10px; font-size: 20px; }

	        b#id{ position: absolute; left: 15px; top: 77px; font-size: 13px; }
	        input#regId{ position: absolute; left: 75px; top: 75px; width: 200px; height: 25px; font-size: 10px; }
	        
	        
	        b#pw{ position: absolute; left: 15px; top: 130px; font-size: 13px; }
	        input#regPw{ position: absolute; left: 75px; top: 127px;
	            width: 200px; height: 25px; font-size: 10px; }	
	        
	        b#pwChk{ position: absolute; left: 15px; top: 183px; font-size: 13px; }
	        input#regPwChk{
	            position: absolute; left: 105px; top: 180px;
	            width: 170px; height: 25px; font-size: 10px;  }
	        
	        b#name{ position: absolute; left: 15px; top: 236px; font-size: 13px;  }
	        input#regName{ position: absolute; left: 75px; top: 233px;
 				width: 200px; height: 25px; font-size: 10px;     } 
	        
	        b#Gender{ position: absolute; left: 15px; top: 289px; font-size: 13px; }  
	        span#gender{ position: absolute; left: 75px; top: 286px; }
			label#lbM{ display: inline-block; border: 1px solid #A4A4A4; padding: 1px 20px;}
			label#lbW{ display: inline-block; border: 1px solid #A4A4A4; padding: 1px 20px; }
			input#man{ display: none; }
			input#woman{ display: none; }
	        
	        b#birth{ position: absolute; left: 15px; top: 340px; font-size: 13px; }
	        select#regBirthYear{ position: absolute; left: 75px; top:339px;}
	        select#regBirthMonth{ position: absolute; left: 130px; top: 339px; }
	        select#regBirthDay{ position: absolute; left: 170px; top: 339px; }
	        
	        b#email{ position: absolute; left: 15px; top: 395px; font-size: 13px; }
	        input#regEmail{ position: absolute; left: 75px; top: 392px;
	            width: 200px; height: 25px; font-size: 10px;             }
	            
	        b#num{ position: absolute; left: 15px; top: 448px; font-size: 13px; }
	        span#regNum-{position: absolute; left: 155px; top: 445px;}
	        input#regNum1{ position: absolute; left: 100px; top: 445px;
	            width: 50px; height: 25px; font-size: 10px;             }    
	        input#regNum2{ position: absolute; left: 165px; top: 445px;
	            width: 50px; height: 25px; font-size: 10px;             }    
	            
	        b#phone{ position: absolute; left: 15px; top: 501px; font-size: 13px; }
	        span#regPhone-1{position: absolute; left: 155px; top: 501px;}
	        span#regPhone-2{position: absolute; left: 220px; top: 501px;}
	        input#regPhone1{ position: absolute; left: 100px; top: 501px;
	            width: 50px; height: 25px; font-size: 10px;             }
			input#regPhone2{ position: absolute; left: 165px; top: 501px;
	            width: 50px; height: 25px; font-size: 10px;             }
			input#regPhone3{ position: absolute; left: 230px; top: 501px;
	            width: 50px; height: 25px; font-size: 10px;             }

	            
	        button#cancel{ position: absolute; left: 170px; top: 554px; width: 50px; height: 25px;    
	            color: white; background-color: black; border-style: none; font-size: 10px;cursor: pointer; }
	        button#join{position: absolute; left: 230px; top: 554px; width: 50px; height: 25px;
	            font-size: 10px; color: white; background-color: black; border-style: none; cursor: pointer;}
	            
	        span#id_s{position: absolute; left: 75px; top: 105px;}
	        span#pw_s{position: absolute; left: 75px; top: 157px;}
	        span#pwC_s{position: absolute; left: 75px; top: 210px;}
	        span#name_s{position: absolute; left: 75px; top: 262px;}
	        span#gender_s{position: absolute; left: 75px; top: 314px;}
	        span#birth_s{position: absolute; left: 75px; top: 366px;}
	        span#email_s{position: absolute; left: 75px; top: 420px;}
	        span#num_s{position: absolute; left: 75px; top: 474px;}
	        span#phone_s{position: absolute; left: 75px; top: 526px;}
	        
	        span.msg{font-size: 13px; color: red}
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div id="main">
            <span id="regTxt"><b>등록자 회원가입</b></span>
            <b id="id">아이디</b>
            <input id="regId" type="text" placeholder=" 아이디를 입력하세요." onkeyup="onKeyUp_idChk()" maxlength="16"/>
            <b id="pw">비밀번호</b>
            <input id="regPw" type="password" placeholder="비밀번호를 입력하세요." onkeyup="onKeyUp_pw1()" maxlength="12"/>
            <b id="pwChk">비밀번호 확인</b>
            <input id="regPwChk" type="password" placeholder="비밀번호를 입력하세요." onkeyup="onKeyUp_pw2()" maxlength="12"/>
            <b id="name">이름</b>
            <input id="regName" type="text" placeholder="이름을 입력하세요." onkeyup="onKeyUp_name()"/>
            <b id="Gender">성별</b>
            <span id="gender">
            	<label id="lbM"><input id="man" type="radio" name="regGender" value="남" onclick="onClick_gender()"/>남자</label>
            	&nbsp;
            	<label id="lbW"><input id="woman" type="radio" name="regGender" value="여" onclick="onClick_gender()"/>여자</label>
            </span>
            <b id="birth">생년월일</b>
            <select name="regBirthYear" id="regBirthYear" onkeyup="onKeyUp_birth()" onclick="onClick_birth()">
            	<option value="년도" selected>년도</option>
            	<%for(int i=1920; i<2003; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            
            <select name="regBirthMonth" id="regBirthMonth" onkeyup="onKeyUp_birth()" onclick="onClick_birth()">
            	<option value="월" selected>월</option>
            	<%for(int i=1; i<13; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            
            <select name="regBirthDay" id="regBirthDay" onkeyup="onKeyUp_birth()" onclick="onClick_birth()">
            	<option value="일" selected>일</option>
            	<%for(int i=1; i<32; i++){ %>
            		<option value="<%=i %>"><%=i %></option>
            	<%} %>
            </select>
            <b id="email">이메일</b>
            <input id="regEmail" type="email" placeholder="이메일을 입력하세요." onkeyup="onKeyUp_email()"/>
            <b id="num">주민등록번호</b>
            <input id="regNum1" type="text" placeholder="" onkeyup="onKeyUp_num1()" maxlength="6" />
            <span id="regNum-">-</span>
            <input id="regNum2" type="password" placeholder="" onkeyup="onKeyUp_num2()" maxlength="7"/>
            <b id="phone">휴대폰 번호</b>
            <input id="regPhone1" type="text" onkeyup="onKeyUp_phone()" maxlength="3"/>
            <span id="regPhone-1">-</span>
            <input id="regPhone2" type="text" onkeyup="onKeyUp_phone()" maxlength="4"/>
            <span id="regPhone-2">-</span>
            <input id="regPhone3" type="text" onkeyup="onKeyUp_phone()" maxlength="4"/>
            
          	<span class="msg" id="id_s"></span>
            <span class="msg" id="pw_s"></span>
            <span class="msg" id="pwC_s"></span>
            <span class="msg" id="name_s"></span>
            <span class="msg" id="gender_s"></span>
            <span class="msg" id="birth_s"></span>
            <span class="msg" id="email_s"></span>
            <span class="msg" id="num_s"></span>
            <span class="msg" id="phone_s"></span>
            
            
            <button id="cancel">취소</button>
            <button id="join">완료</button>
        </div>
	</body>
	<script>
		var chk = false;//아이디 중복값 체크
		var numChk = false;//주민등록 중복값 체크
		//아이디 중복 확인 onkeyup 이벤트
		function onKeyUp_idChk() {
			var regIdTxt = $("#regId").val();
			var msg = $("#id_s");
			
			var idReg = /^[A-Za-z0-9+]{5,16}$/;
			
			$.ajax({
				type : "post",
				url : "./overlay",
				data : { id : regIdTxt },
				dataType : "json",
				success : function(data) {
					console.log(data);
					if(regIdTxt==""){
						msg.html("아이디 입력을 해주세요.");
						msg.css("color", "red");
						//$("#regId").focus();
					}else if(!idReg.test(regIdTxt)){
						msg.html("5~16자리 영문과 숫자만 가능");
						msg.css("color", "red");
					}else if(data.result == true){
						msg.html("중복된 아이디 입니다.");
						msg.css("color", "red");
						//$("#regId").focus();
					}else{
						msg.html("사용 가능한 아이디");
						msg.css("color", "green");
						//$("#regPw").focus();
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
			var regPwTxt1 = $("#regPw");
			var msg = $("#pw_s");
			if(regPwTxt1.val()==""){
				msg.html("새 비밀번호 입력");
			}else if(regPwTxt1.val().length < 8 || regPwTxt1.val().length >12){
				msg.html("비밀번호 8~12자리 입력");
			}else if(regPwTxt1.val().length >= 8 || regPwTxt1.val().length <=12){
				msg.html("");
			}
		}
		function onKeyUp_pw2(){
			var regPwTxt1 = $("#regPw");
			var regPwTxt2 = $("#regPwChk");
			var msg = $("#pwC_s");
	
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
		function onClick_birth() {
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
			/* $.ajax({
				type : "post",
				url : "./emailOverlay",
				data : {
					email : $("#regEmail").val()
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
					}else{
						numChk = true;
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
					}else{
						numChk = true;
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
		

		//취소버튼
		$("#cancel").click(function() {
			location.href="login.jsp";
		});
		
		
		//완료버튼(회원가입)
		$("#join").click(function() {
			var regIdTxt = $("#regId").val();
			var regPw = $("#regPw").val();
			var regPwChk = $("#regPwChk").val();
			
			var idReg = /^[A-Za-z0-9+]{5,16}$/;
				
			if($("#regId").val()==""){
				$("#id_s").html("아이디를 입력하세요.");
				$("#regId").focus();
			}else if(!idReg.test(regIdTxt)){
				$("#id_s").html("5~16자리 영문과 숫자만 가능");
				$("#regId").focus();
			}else if($("#regPw").val()==""){		
				$("#pw_s").html("비밀번호를 입력하세요.");
				$("#regPw").focus();//포커스 이동
			}else if($("#regPw").val().length < 8 || $("#regPw").val().length >12){
				$("#pw_s").html("비밀번호 8~12자리 입력");
				$("#regPw").focus();
			}else if($("#regPwChk").val()==""){				
				$("#pwC_s").html("비밀번호를 입력하세요.");
				$("#regPwChk").focus();//포커스 이동	
			}else if(regPw != regPwChk){
				$("#pwC_s").html("비밀번호를 재입력하세요.");
				$("#regPwChk").focus();//포커스 이동	
			}else if($("#regName").val()==""){
				$("#name_s").html("이름을 입력해주세요.");
				$("#regName").focus();//포커스 이동	
			}else if($("#man").get(0).checked != true && $("#woman").get(0).checked != true){
				$("#gender_s").html("성별을 선택해주세요.");
			}else if($("#regBirthYear").val()=="년도"){
				$("#birth_s").html("년도를 선택해주세요");
				$("#regBirthYear").focus();
			}else if($("#regBirthMonth").val()=="월"){
				$("#birth_s").html("월을 선택해주세요");
				$("#regBirthMonth").focus();
			}else if($("#regBirthDay").val()=="일"){
				$("#birth_s").html("일을 선택해주세요");
				$("#regBirthDay").focus();
			}else if($("#regEmail").val()==""){
				$("#email_s").html("이메일을 입력해주세요");
				$("#regEmail").focus();
			}else if($("#regNum1").val()==""){
				$("#num_s").html("주민등록번호 앞자리를 입력해주세요.");
				$("#regNum1").focus();
			}else if($("#regNum1").val().length < 6){
				$("#num_s").html("주민등록번호 앞자리 입력");
				$("#regNum1").focus();
			}else if($("#regNum2").val()==""){
				$("#num_s").html("주민등록번호 뒷자리를 입력해주세요.");
				$("#regNum2").focus();
			}else if($("#regNum2").val().length < 7){
				$("#num_s").html("주민등록번호 뒷자리 입력");
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
			}else if(chk==false){
				$("#id_s").html("아이디 중복확인 하세요.");
				$("#regId").focus();
			}else if(numChk==false){
				$("#num_s").html("주민등록번호 확인 하세요.");
				$("#regNum2").focus();
			}else{
				$.ajax({
					type : "post",
					url : "./regJoin",
					data : {
						id : $("#regId").val(),
						pw : $("#regPw").val(),
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
						if(data.success > 0 && data.result2 == false){
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