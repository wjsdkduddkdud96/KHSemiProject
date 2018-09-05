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
                position: relative;
                top: 10px;
                left: 550px;
            }
            #next{
                position: relative;
                top: 10px;
                left: 555px;
            }
            button{
                background-color: #212121;
                color: white;
                padding: 2px 7px;
                border: 0;
                font-size: 12pt;
            }
            .date{
                float: left;
                text-align: center;
            }
            select{
                width: 150px;
                height: 25px;
            }
            #search{
                position: absolute;
                left: 790px;
                
            }
            #date1{
                position: absolute;
            	left: 450px;
                
            }
            #date2{
                position: absolute;
                left: 650px;
                
            }
            #date3{
                position: absolute;
                left: 601px;
                font-size: 14pt;
                border: 1px solid gray;
                padding: 0 10px;
                font-weight: 600;
                
            }
            #menuBar{
            	height: 20px;
            }
        </style>
    </head>
    <body>
    	<div id="menuBar">
    		<jsp:include page="/menuBar.jsp" flush="false"/>
    	</div>
       <h1>통계</h1>
        <br/>
        <!-- <select class="date" id="date1"></select> -->
        <input type="date" id="date1"/>
        <div class="date" id="date3">~</div>
        <!--<select class="date" id="date2"></select>-->
        <input type="date" id="date2"/>
        <button id="search">검색</button>
        <br/>
        <br/>
        <table id="table1">
            <tr>
                <th>선택</th>
                <th>번호</th>
                <th style="padding: 5px 150px;">상호명</th>
                <th>총 예약자 수</th>
            </tr>
        </table>
        <h1>예약자통계</h1>
        <table id="table2">
            <tr>
                <th>번호</th>
                <th style="padding: 5px 50px;">예약일</th>
                <th style="padding: 5px 150px;">상호명</th>
                <th style="padding: 5px 30px;">예약자 ID</th>
                <th>예약인원</th>
            </tr>
        </table>
        <button id="pre">이전 목록</button>
        <button id="next">다음 목록</button>
    </body>
    <script>
		var tableTh = ""; //테이블 껍데기 담는 변수
		var msg = ""; //비로그인시 오는 값 담을 변수
		var sNum = 1; //페이징 시작 값
		var eNum = 5; //페이징 마지막 값
		
		var obj = {}; //ajax 실행시 보낼 오브젝트 초기화
		obj.error=function(e){console.log(e)}; //ajax 에러날 경우의 함수
		obj.type="POST"; //ajax로 보낼 타입
		obj.dataType="JSON"; //ajax 실행 후 받을 값 형태
    
		//페이지 로드되자마자 실행
        $(document).ready(function(){
        	//검색 버튼을 누르자마자 예약자 통계 부분의 테이블의 껍데기를 변수에 담음(페이징할때 사용)
			tableTh = $("#table2").children().html();
    	   obj.url="./total";
    	   obj.success=function(data){
    		   console.log(data);
    		   if(data.msg != null){ 
	   				msg = data.msg;//그 값을 msg변수에 담고
	   				alert(msg); //alert을 띄운다.
	   				location.href="./index.jsp" //그리고 login.jsp로 보냄
   				}else{
   					table1printlist(data.list);
   					bookCnt_in(data.bookCnt);
   				}
    		}
    	   	ajaxCall(obj);
    	});
		
		//검색버튼
		$("#search").click(function(){
			/* console.log($("#date1").val());
			console.log($("#date2").val());
			console.log($("input[name='chk']").val()); */
			if($("input[name='chk']:checked").val() == null){
				alert("장소를 선택 해 주세요");
			}else if($("#date1").val()=="" || $("#date2").val() == ""){
				alert("날짜를 선택 해 주세요");
			}else{
				obj.url="./totalDetail";
				obj.data={
						"date1":$("#date1").val(),
						"date2":$("#date2").val(),
						"plcae_no":$("input[name='chk']:checked").val(),
						"sNum":sNum,
	    				"eNum":eNum
				};
				obj.success=function(data){
					//console.log(data);
					$("#table2").empty(); //테이블 안에 있는 것을 비우고
    		    	$("#table2").append(tableTh); //테이블 자식요소를 넣음
					table2printlist(data.list);
				};
				ajaxCall(obj);
			}
		});
		
		//이전 목록 버튼
    	$("#pre").click(function(){
    		sNum -= 5; //페이징 시작 값 변수에서 -5를 하고 넣음
    		eNum -= 5; //페이징 끝 값 변수에서 -5를 하고 넣음
    		obj.url = "./totalDetail"; //bookList로 컨트롤러에 요청
    		obj.data={
    				"date1":$("#date1").val(),
					"date2":$("#date2").val(),
					"plcae_no":$("input[name='chk']:checked").val(),
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
    					$("#table2").empty(); //테이블 안에 있는 것을 비우고
    		    		$("#table2").append(tableTh); //테이블 자식요소를 넣음
    		    		table2printlist(data.list); //리스트를 뽑는 함수호출
    				}
    			}
    		};
    		ajaxCall(obj);
    	});
    	
    	//다음 목록 버튼
    	$("#next").click(function(){
    		sNum += 5; //페이징 시작 값변수에서 +5해줌
    		eNum += 5; //페이징 끝 값 변수에서 +5 해줌
    		obj.url = "./totalDetail";
    		obj.data={
    				"date1":$("#date1").val(),
					"date2":$("#date2").val(),
					"plcae_no":$("input[name='chk']:checked").val(),
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
    					$("#table2").empty(); //테이블 안에 있는 것을 비우고
    		    		$("#table2").append(tableTh); //테이블 자식요소를 넣음
    		    		table2printlist(data.list); //리스트를 뽑는 함수호출
    				}
    			}
    		};
    		ajaxCall(obj);
    	});
		
		//테이블1 값 넣기
		function table1printlist(list){
			var content = "";
			list.forEach(function (item, idx){
    			//console.log(item);
    			//console.log(item.book_no);
    			content += "<tr>";
    			content += "<td><input type='radio' name='chk' value='"+item.place_no+"'/></td>"
    			content += "<td>"+(idx+1)+"</td>";
    			content += "<td>"+item.place_name+"</td>";
    			content += "<td class='bookCnt'></td>";
    			content += "</tr>";
    		});
    		$("#table1").append(content);
		}
       
		//예약자 수 값 넣기
		function bookCnt_in(bookCnt){
			bookCnt.forEach(function (item, idx){
    			$(".bookCnt")[idx].append(item);
    		});
    	}
		
		//테이블2 값 넣기
		function table2printlist(list){
			var content = "";
			list.forEach(function (item, idx){
    			content += "<tr>";
    			content += "<td>"+item.rnum+"</td>"
    			content += "<td>"+item.book_date+"</td>"
    			content += "<td>"+item.place_name+"</td>";
    			content += "<td>"+item.info_id+"</td>"
    			content += "<td>"+item.book_custom+"</td>"
    			content += "</tr>";
    		});
    		$("#table2").append(content);
		}
		
	   	//ajax로 보내는 함수
	  	function ajaxCall(param){
	  		$.ajax(param)
	  	}
    </script>
</html>