<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <style>
        	/* 나눔 스퀘어 폰트 */
			@import url(//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css);
			@font-face { font-family: 'odibeeSans'; font-style: normal; src: url('OdibeeSans-Regular.eot'); src: url('OdibeeSans-Regular.woff'); }
        
            body{
                max-width: none !important;
            }
            h1{
                text-align: center;
            }
            table,tr,td,th{
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
                position: static;
                margin:0 auto;
            }
            th{
                background-color: #212121;
                color: white;
            }
            #pre{
                position: absolute;
                top: 535px;
                left: 500px;
            }
            #next{
                position: absolute;
                top: 535px;
                left: 600px;
            }
            #cancle{
                position: absolute;
                top: 535px;
                left: 1000px;
            }
            button{
                background-color: #212121;
                color: white;
                padding: 2px 7px;
                border: 0;
                font-size: 12pt;
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
    	<h1>예약 내역 확인</h1>
        <br/>
        <table id="listTable">
            <tr>
                <th><input type="checkbox" id="allckh"/></th>
                <th>번호</th>
                <th style="padding: 5px 150px">상호명</th>
                <th style="padding: 5px 30px">대표자 ID</th>
                <th>예약일</th>
                <th>예약 시작 시간</th>
                <th>예약 종료 시간</th>
                <th>예약 인원</th>
                <th style="padding: 5px 25px">금액</th>
            </tr>
        </table>
        <button id="pre">이전 목록</button>
        <button id="next">다음 목록</button>
        <button id="cancle">예약 취소</button>
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
    		obj.url = "./bookList"; //ajax bookList로 요청
    		obj.data={ //같이 보낼 데이터
    				"sNum":sNum,
    				"eNum":eNum
    		};
    		obj.success=function(data){ //성공시의 함수
    			//console.log(data);
    			//ajax로 받은 값이 msg라는 이름으로 null이 아니게 들어왔다면
    			if(data.msg != null){ 
    				msg = data.msg;//그 값을 msg변수에 담고
    				alert(msg); //alert을 띄운다.
    				location.href="./index.jsp" //그리고 login.jsp로 보냄
    			}else{ //아니라면 리스트 출력
    				listPrint(data.list);
    			}
    		};
    		ajaxCall(obj); //아작스 보내는 함수 호출
    	});
    	
    	//이전 목록 버튼
    	$("#pre").click(function(){
    		sNum -= 10; //페이징 시작 값 변수에서 -5를 하고 넣음
    		eNum -= 10; //페이징 끝 값 변수에서 -5를 하고 넣음
    		obj.url = "./bookList"; //bookList로 컨트롤러에 요청
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
    				}
    			}
    		};
    		ajaxCall(obj);
    	});
    	
    	//다음 목록 버튼
    	$("#next").click(function(){
    		sNum += 10; //페이징 시작 값변수에서 +5해줌
    		eNum += 10; //페이징 끝 값 변수에서 +5 해줌
    		obj.url = "./bookList";
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
    					sNum -= 10; 
    					eNum -= 10;
    				}else{
    					$("#listTable").empty(); //테이블 안에 있는 것을 비우고
    		    		$("#listTable").append(tableTh); //테이블 자식요소를 넣음
    					listPrint(data.list); //리스트를 뽑는 함수호출
    				}
    			}
    		};
    		ajaxCall(obj);
    	});
    	
    	//삭제 버튼
    	$("#cancle").click(function(){
    		//DB에서 값을 지우고, 다시 페이지를 불러온다
    		//console.log("cancle 클릭");
    		obj.url="./bookDel";
    		var checked = []; //체크된 값 담을 변수 초기화
    		$("input[name='delchk']:checked").each(function(){
    			//반복분을 통해서 담는다.
    			checked.push($(this).val());
    		});
    		//console.log(checked);
    		obj.data={
    				"delList":checked
    		};
    		obj.success = function(data){
    			console.log(data);
    			if(data.success){
    				location.href="./bookList.jsp";
    			}else{
    				alert("모두 삭제 실패");
    				location.href="./bookList.jsp";
    			}
    		}
    		ajaxCall(obj);
    	});
    	
    	//전체 체크or해제
    	$(document).on("click", "#allckh", function(){
    		if($("#allckh").prop("checked")){// th에 있는 체크박스에 체크가 되어있으면
    			$("input[type='checkbox']").prop("checked", true);
    		}else{
    			$("input[type='checkbox']").prop("checked", false);
    		}
    	});
    	
    	//체크에 따라 th의 checkbox checked 여부
    	$(document).on("click", "input[name='delchk']", function(){
    		var total = $("input[name='delchk']").length;
    		var chk = $("input[name='delchk']:checked").length;
    		if(chk == total){
    			$("#allckh").prop("checked", true);
    		}else{
    			$("#allckh").prop("checked", false);
    		}
    		
    	});
    	
    	//list에서 값을 뽑아 테이블에 넣는 함수
    	function listPrint(list){
    		var content = ""; //자식요소로 넣을 변수 초기화
    		//book_no, place_name, info_id, book_date, book_start, book_end, book_custom, book_price
    		list.forEach(function (item, idx){
    			//console.log(item);
    			//console.log(item.book_no);
    			content += "<tr>";
    			content += "<td><input type='checkbox' name='delchk' value='"+item.book_no+"'/></td>";
    			content += "<td>"+item.rnum+"</td>";
    			content += "<td>"+item.place_name+"</td>";
    			content += "<td>"+item.info_id+"</td>";
    			content += "<td>"+item.book_date+"</td>";
    			content += "<td>"+item.book_start+"</td>";
    			content += "<td>"+item.book_end+"</td>";
    			content += "<td>"+item.book_custom+"</td>";
    			content += "<td>"+item.book_price+"</td>";
    			content += "</tr>";
    		});
    		$("#listTable").append(content);
    	}
    	
    	//ajax로 보내는 함수
    	function ajaxCall(param){
    		$.ajax(param)
    	}
    </script>
</html>