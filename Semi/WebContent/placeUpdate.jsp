<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<style>
		.writeForm { position: relative; margin-top: 50px; margin-left: 50px; width: 1200px; }
            .sec_title {font-size: 45px; text-align: center; margin-left: 450px; width: 400px; height: 50px; line-height: 50px; }
            .div_title { font-size: 30px; text-align: center; margin-top: 50px; width: 150px; height: 50px; line-height: 50px; }
            .sub_title { font-size: 20px; text-align: center; margin-top: 30px; width: 200px; height: 30px; line-height: 30px; background-color: #252525; color: white; }
            .photo_desc { float: left; width: 350px; font-size: 12px; margin-top: -15px; margin-left: 210px; color: #EF4667; }
            .div_content { margin-top: 30px; }
            #placename { width: 400px; height: 30px; }
            .phone { width: 100px; height: 30px; }
            .time { width: 150px; height: 30px; }
            #cash { width: 200px; height: 30px; }
            .address { height: 30px; margin-bottom: 10px; }
            #postnumber { width: 200px; }
            #addr { width: 200px; }
            #detailAddr { width: 400px; }
            .info_content { width: 1100px; height: 200px; }
            #info { width: 1100px; height: 100px; }
            #homepage { width: 1100px; height: 30px; }
            .save { margin-left: 1050px; }
            #categoly{width: 150px; height: 30px; margin-top:10px;}
            #postnumber{background-color: rgba(125,125,125,0.3);}
            #addr{background-color: rgba(125,125,125,0.3); width: 400px;}
            input[type="number"]::-webkit-outer-spin-button,
            input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none; margin: 0;}
		</style>
	</head>
<body>
<div>
	<jsp:include page="menuBar.jsp"/>
</div>
<form action="./placeUpdateWrite" method="post" enctype="multipart/form-data" id="fom">
           <div class="writeForm">
           <input type="hidden" name="place_no" value="${param.place_no}" />
               <div class="sec_title"><strong>장소정보 수정</strong></div>
               <div class="div_title"><strong>필수정보</strong></div>

               <div class="sub_title">상호명</div>
               <div class="div_content"><input maxlength="20" name ="place_name" id="placename" type="text" placeholder="상호명을 입력해주세요."onkeyup="onKeyUp_placename()"/></div>
               <span class="place_span" id="place_n"></span>
			   <div class="sub_title">카테고리</div>
			   <select name="categoly" id="categoly">
                       <option>카페</option>
                       <option>식당</option>
                       <option>주점</option>
                       <option>스튜디오</option>
                       <option>연습실</option>
                       <option>공연장</option>
               </select>
               <div class="sub_title">장소 사진</div>
               <span class="photo_desc">수정시 기존 사진이 삭제 됩니다 새로운 사진을 넣어주세요</span>
               <div class="div_content">
                   <input name="photo1" id="photo1" type="file"/><br/>
                   <input name="photo2" id="photo2" type="file"/><br/>
                   <input name="photo3" id="photo3" type="file"/><br/>
                   <input name="photo4" id="photo4" type="file"/><br/>
                   <input name="photo5" id="photo5" type="file"/><br/>    
               </div>

               <div class="sub_title">전화번호</div>
               <div class="div_content">
                   <input maxlength="3" name="phone1" id="phone1" class="phone" type="number"/> 
                   <input maxlength="4" name="phone2" id="phone2" class="phone" type="number"/> 
                   <input maxlength="5" name="phone3" id="phone3" class="phone" type="number"/>
               </div>

               <div class="sub_title">이용시간 & 이용요금</div>
               <span class="photo_desc">시간을 다시 설정해주세요</span>
               <div class="div_content">
                   <select name="start" class="time" id="starttime">
                       <option>시작시간</option>
                   </select>
                   <select name="end" class="time" id="endtime">
                       <option>종료시간</option>
                   </select>
                   <input name="cash" id="cash" type="number" placeholder="시간당 요금(입력 예시: 13000)"/>
               </div>
               
               <div class="sub_title">장소위치</div>
               <div class="div_content">
                  <input name="postnumber" class="address" id="postnumber" type="text" placeholder="우편번호" readonly/>
                   <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 검색"/><br/>
                   <input name="addr" class="address" id="addr" type="text" placeholder="주소" readonly/><br/>
                   <input name="detailAddr" class="address" id="detailAddr" type="text" placeholder="상세 주소"/>
               </div>

               <div class="sub_title">시설 안내</div>
               <div class="div_content">
                   <textarea maxlength="2000" name="fac_info" class="info_content" id="fac_info" onkeyup="place_detail()"></textarea><br/>
                    <span class="place_span" id="place_info"></span>
               </div>
               
               <div class="div_title"><strong>선택정보</strong></div>
               <div class="sub_title">한 줄 소개</div>
               <div class="div_content">
                   <input maxlength="30" name="info" id="info" type="text" maxlength="30" onkeyup="place_info()"/><br/>
                   <span class="place_span" id="p_info"></span>
               </div>
               
               <div class="sub_title">홈페이지</div>
               <div class="div_content">
                  <input maxlength="2000" name="homepage" id="homepage" type="text" onkeyup="place_detail()"/>
               </div>
               
               <div class="sub_title">주의사항</div>
               <div class="div_content">
                   <textarea maxlength="2000" name="sub_content" class="info_content" id="sub_content" onkeyup="place_content()"></textarea><br/>
                   <span class="place_span" id="place_content"></span>
                   <br/><br/>
                   <input id="save" class="save" type="button" value="저장"/>
               </div>
            </div>
       </form>
</body>
<script>
var place_no="${param.place_no}";
var array_loc=[];
var phone =[];
console.log(place_no);
for(var i=0;i<24;i++){
	$(".time").append('<option>'+i+':00</option>');
}
/* //상호명 글자수 제한
function onKeyUp_placename(){
	if($("#placename").val().length>20){
		$("#place_n").css("color","red");
		$("#place_n").html("상호명이 20자를 넘었습니다")
	}else if($("#placename").val().length<=20){
		$("#place_n").css("color","green");
		$("#place_n").html("상호명은 20자이내로 작성해주세요")
	}
} */
$(document).ready(function(){
	console.log($("#photo1"));
	$.ajax({
		type:"post",
		url:"./placeUpdatedetail",
		dataType:"JSON",
		data:{
			place_no:place_no
		},
		success : function(data){
			console.log(data);
			phone=data.dto.place_phone.split("-");
			array_loc=data.dto.place_loc.split("/");
			$("#placename").val(data.dto.place_name);
			$("#info").val(data.dto.place_info);
			$("#categoly").val(data.dto.place_category);
			$("#phone1").val(phone[0]);
			$("#phone2").val(phone[1]);
			$("#phone3").val(phone[2].trim());
			$("#homepage").val(data.dto.place_home);
			$("#postnumber").val(array_loc[0]);
			$("#addr").val(array_loc[1]);
			$("#detailAddr").val(array_loc[2]);
			$("#fac_info").val(data.dto.place_guide);
			$("#sub_content").val(data.dto.place_attention);
			$("#cash").val(data.dto.place_price);
		},
		error:function(e){
			console.log(e);
		}
	});
});
	$("#save").click(function(){
		if($("#placename").val()==""){
			alert("상호명을 입력하세요");
			$("#placename").focus();
		}else if($("#photo1").val()==""){
			alert("사진을 1장이상 입력하세요");
			$("#photo1").focus();
		}else if($("#phone1").val()==""||$("#phone2").val()==""||$("#phone3").val()==""){
			alert("번호를 입력하세요");
			$("#phone1").focus();
		}else if($("#postnumber").val()==""||$("#addr").val()==""||$("#detailAddr").val()==""){
			alert("주소를 확인하세요");
			$("#detailAddr").focus();
		}else if($("#fac_info").val()==""){
			alert("시설안내를 확인하세요");
			$("#fac_info").focus();
		}else if($("#starttime").val()=="시작시간"||$("#endtime").val()=="종료시간"){
			alert("시간을 입력하세요");
			$("#starttime").focus();
		}else if($("#cash").val()==""){
			alert("가격을 입력하세요");
			$("#cash").focus();
		}else{
			document.getElementById("fom").submit();
		}
	});
</script>

<script>
	/* 다음 지도 api 추가 */
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? '' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postnumber').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('detailAddr').focus();
            }
        
        }).open();
    }
	//상호명 글자수 제한
	function onKeyUp_placename(){
		if($("#placename").val().length>20){
			$("#place_n").css("color","red");
			$("#place_n").html("상호명이 20자를 넘었습니다")
		}else if($("#placename").val().length<=20){
			$("#place_n").css("color","green");
			$("#place_n").html("상호명은 20자이내로 작성해주세요")
		}
	}
	//시설안내 글자수 제한
	function place_detail(){
		if($("#fac_info").val().length>2000){
			$("#place_info").css("color","red");
			$("#place_info").html("시설안내가 2000자를 넘었습니다")
		}else if($("#fac_info").val().length<=2000){
			$("#place_info").css("color","green");
			$("#place_info").html("시설안내는 2000자이내로 작성해주세요")
		}
	}
	//주의사항 글자수 제한
	function place_content(){
		if($("#sub_content").val().length>2000){
			$("#place_content").css("color","red");
			$("#place_content").html("주의사항이 2000자를 넘었습니다")
		}else if($("#sub_content").val().length<=2000){
			$("#place_content").css("color","green");
			$("#place_content").html("주의사항은 2000자이내로 작성해주세요")
		}
	}
	//한줄소개 글자수 제한
	function place_info(){
		if($("#info").val().length>30){
			$("#p_info").css("color","red");
			$("#p_info").html("한줄소개가 30자를 넘었습니다")
		}else if($("#info").val().length<=30){
			$("#p_info").css("color","green");
			$("#p_info").html("한줄소개는 30자이내로 작성해주세요")
		}
	}
	</script>
</html>