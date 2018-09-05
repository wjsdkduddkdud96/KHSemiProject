<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <style>
            body{
                max-width: none !important;
            }
            h1{
                text-align: center;
            }
            table,tr,th,td{
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
                position: static;
                margin:0 auto;
            }
            th{
                background-color: #212121;
                color: white; 
                padding: 5px 20px;
            }
            #pre{
                position: absolute;
                top: 480px;
                left: 500px;
                background-color: #212121;
            }
            #next{
                position: absolute;
                top: 480px;
                left: 605px;
                background-color: #212121;
            }
            #chart{
                position: absolute;
                top: 480px;
                left: 1030px;
                background-color: #212121;
            }
            button{
                color: white;
                padding: 2px 7px;
                border: 0;
                font-size: 12pt;
            }
            td>button{
                background-color: lightpink;
                border: 0;
                width: 100%;
                height: 100%;
                cursor: pointer;
            }
             #menuBar{
            	height: 20px;
            }
            input[type="checkbox"]{
            	height: 14px;
            }
        </style>
    </head>
    <body>
    	<div id="menuBar">
    		<jsp:include page="/menuBar.jsp" flush="false"/>
    	</div>
    	<h1>등록 내역 확인</h1>
        <br/>
        <table id="listTable">
            <tr>
                <th style="padding: 5px 10px">번호</th>
                <th style="padding: 5px 150px">상호명</th>
                <th style="padding: 5px 30px">대표자 ID</th>
                <th style="padding: 5px 50px">등록 일시</th>
                <th>평점 평균</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </table>
        <button id="pre">이전 목록</button>
        <button id="next">다음 목록</button>
        <button id="chart">통계</button>
    </body>
    <script>
	var tableTh = ""; //테이블 껍데기 담는 변수
	var msg = ""; //비로그인시 오는 값 담을 변수
	var sNum = 1; //페이징 시작 값
	var eNum = 10; //페이징 마지막 값
	
	var obj = {}; //ajax 실행시 보낼 오브젝트 초기화
	obj.error=function(e){console.log(e)}; //ajax 에러날 경우의 함수
	obj.type="POST"; //ajax로 보낼 타입
	obj.dataType="JSON"; //ajax 실행 후 받을 값 형태
	
	//페이지 로드하자마자 실행
	$(document).ready(function(){
		//console.log($("#listTable").children().html());
		tableTh = $("#listTable").children().html(); //페이지를 로드하고나서 바로 테이블 자식요소(th태그) 담음
		obj.url = "./placeList"; //ajax bookList로 요청
		obj.data={ //같이 보낼 데이터
				"sNum":sNum,
				"eNum":eNum
		};
		obj.success=function(data){ //성공시의 함수
			console.log(data);
			//ajax로 받은 값이 msg라는 이름으로 null이 아니게 들어왔다면
			if(data.msg != null){ 
				msg = data.msg;//그 값을 msg변수에 담고
				alert(msg); //alert을 띄운다.
				location.href="./index.jsp" //그리고 login.jsp로 보냄
			}else{ //아니라면 리스트 출력
				listPrint(data.list);
				score_in(data.review_score);
			}
		};
		ajaxCall(obj); //아작스 보내는 함수 호출
	});
	
        $("#chart").click(function(){
            location.href="./chart.jsp";
        });
        
      //이전 목록 버튼
    	$("#pre").click(function(){
    		sNum -= 10; //페이징 시작 값 변수에서 -5를 하고 넣음
    		eNum -= 10; //페이징 끝 값 변수에서 -5를 하고 넣음
    		obj.url = "./placeList"; //placeList로 컨트롤러에 요청
    		obj.data={
    				"sNum":sNum,
    				"eNum":eNum
    		};
    		obj.success=function(data){
    			//console.log(data.list.length);
    			if(data.msg != null){
    				msg = data.msg;
    				alert(msg);
    				location.href="./index.jsp"
    			}else{
    				if(data.list.length == 0){ //list로 넘어온값이 크기가 0이면
    					alert("첫번째 목록입니다.") //alert을 띄우고
    					//초기값으로 되돌린다.
    					sNum = 1; 
    					eNum = 10; 
    				}else{
    					$("#listTable").empty(); //테이블 안에 있는 것을 비우고
    		    		$("#listTable").append(tableTh); //테이블 자식요소를 넣음
    					listPrint(data.list); //리스트를 뽑는 함수호출
    					score_in(data.review_score);//별점평균 넣는 함수 호출
    				}
    			}
    		};
    		ajaxCall(obj);
    	});
    	
    	//다음 목록 버튼
    	$("#next").click(function(){
    		sNum += 10; //페이징 시작 값변수에서 +5해줌
    		eNum += 10; //페이징 끝 값 변수에서 +5 해줌
    		obj.url = "./placeList";
    		obj.data={
    				"sNum":sNum,
    				"eNum":eNum
    		};
    		obj.success=function(data){
    			if(data.msg != null){
    				msg = data.msg;
    				alert(msg);
    				location.href="./index.jsp"
    			}else{
    				if(data.list.length == 0){//list로 넘어온값이 크기가 0이면
    					alert("마지막 목록입니다.")//alert 을 띄우고
    					//+5했던것을 다시 되돌린다.
    					sNum -= 5; 
    					eNum -= 5;
    				}else{
    					$("#listTable").empty(); //테이블 안에 있는 것을 비우고
    		    		$("#listTable").append(tableTh); //테이블 자식요소를 넣음
    					listPrint(data.list); //리스트를 뽑는 함수호출
    					score_in(data.review_score);//별점평균 넣는 함수 호출
    				}
    			}
    		};
    		ajaxCall(obj);
    	});
    	
    	//삭제 버튼
    	$(document).on("click", "button[id='del']", function(){
    		var del_no=$(this).val();
    		console.log(del_no);
    		obj.url="./placeDel"
    		obj.data={
    				"del_no":del_no
    		}
    		obj.success=function(data){
    			console.log(data);
    			if(data.success){
    				alert("장소 삭제 성공");
    				location.href="placeList.jsp";
    			}
    		}
    		ajaxCall(obj);
    	});
        
    	//list에서 값을 뽑아 테이블에 넣는 함수
    	function listPrint(list){
    		var content = ""; //자식요소로 넣을 변수 초기화
    		//book_no, place_name, info_id, book_date, book_start, book_end, book_custom, book_price
    		list.forEach(function (item, idx){
    			//console.log(item);
    			//console.log(item.book_no);
    			content += "<tr>";
    			content += "<td>"+item.rnum+"</td>";
    			content += "<td><a href='./placeDetailUp?place_no="+item.place_no+"&page=placeDetail.jsp'>"+item.place_name+"</a></td>";
    			content += "<td>"+item.info_id+"</td>";
    			content += "<td>"+item.place_date+"</td>";
    			content += "<td class='review_score'></td>";
    			content += "<td><button id='update' onclick='updatepage("+item.place_no+")'>수정</button></td>";
    			content += "<td><button id='del' value='"+item.place_no+"'>삭제</button></td>";
    			content += "</tr>";
    		});
    		$("#listTable").append(content);
    	}
    	
    	function updatepage(place_no) {
    		console.log(place_no);
    		location.href="./placeUpdate?place_no="+place_no+""
    	}
    	
    	//별점 평균 넣는 메서드
    	function score_in(review_score){
    		review_score.forEach(function (item, idx){
    			$(".review_score")[idx].append(item);
    		});
    	}
    	//ajax로 보내는 함수
    	function ajaxCall(param){
    		$.ajax(param)
    	}
    </script>
</html>