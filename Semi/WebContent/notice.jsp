<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			/*style area*/
			table,th,td{
				border: 1px solid black;
				border-collapse: collapse;
				text-align: center;
				padding: 3px 10px;
				margin:0 auto;

			}
			th{
				background-color: #212121;
				color: white;
				width: 80px;
			}
			#subject{
				width: 300px;
			}
			#num{
				width: 40px;
			}
			body{
				
				width: 1000px; 				
                max-width: none !important;
                margin: 0 auto;
			}
			#writeBtn{
				position: absolute;
				left: 780px;
			}
			button{
				background-color: #212121;
				color: white;
				border: 0px;
				height: 25px;
				text-align: center;
				padding-bottom: 3px;
			}
			#search{
				border: 0;
				border-bottom: 1px solid #212121;
				width: 220px;
				text-align: center;
			}
			#include{
				height: 60px;
			}
			
			#notice{
				color: white;	
				display: table-cell;
				vertical-align: middle;
				text-align: center;
				font-size: 15pt;
				font-weight: 900;
			}
			#searchDiv{
				position: absolute;
				left: 480px;
			}
			h1{
				text-align: center;
			}
			#noticeBefore{
				position: absolute;
				left: 550px;
			}
			#noticeAfter{
				position: absolute;
				left: 650px;
			}
		</style>
	</head>
	<body>
	<div id="include">
	<jsp:include page="/menuBar.jsp" flush="false"/>
	</div>
		<h1>공지사항</h1><br/>
		<table id="noticeTable">
			<tr>
				<th id="num">번호</th>
				<th id="subject">제목</th>
				<th>작성자 ID</th>
				<th>작성일자</th>
			</tr>
		</table><br/>
		<div id="searchDiv">
		<input type="text" id="search" placeholder="검색할 제목을 입력해주세요."/>
		<button id="noticeSearch">검색</button>
		</div>
		<button id="writeBtn">작성하기</button><br/><br/>
		<button id="noticeBefore">이전 목록</button>
		<button id="noticeAfter">다음 목록</button><br/><br/>
	</body>
	<script>
		/*java script area*/
		var tableTh = "";
       var msg = "";
       var sNum = 1;
       var eNum = 10;
        var obj = {};
        var tableTh = $("#noticeTable");		
		var obj={};
		obj.error = function(e){console.log(e)};
		obj.type="POST";
		obj.dataType="JSON";
		var loginId = "${sessionScope.loginId}";
		function ajaxCall(param){
			console.log(param);
			$.ajax(param);
		}
		
		$(document).ready(function(){
			tableTh = $("#noticeTable").children().html();
			obj.url="./boardList";
			obj.data={
					"search":$("#search").val(),
					"cate":"공지사항",
					"sNum":sNum,
		            "eNum":eNum
			};
			obj.success = function(data){
				//console.log(data);
					listPrint(data.list);
					if(loginId != "ADMIN"){
						$("#writeBtn").css("display","none");
					}
			}
			ajaxCall(obj);
		});
		//작성하기 버튼
		$("#writeBtn").click(function(){
			if(loginId == "ADMIN"){
				location.href="noticeWrite.jsp";
			}else{
				alert("공지사항을 작성 할 권한이 없는 아이디 입니다.")
			}
			
		});
		//리스트 출력
		function listPrint(list){
			console.log(list);
			var content = "";
				list.forEach(function(item, board_no){
					content+="<tr>";
					content+="<td>"+item.rnum+"</td>";
					content+="<td><a href='noticeDetailView?board_no="+item.board_no+"'>"+item.board_title+"</a></td>";
					content+="<td>"+item.info_id+"</td>";
					content+="<td>"+item.board_date+"</td>";
					content+="</tr>";	
				});
				$("#noticeTable").append(content);			
		}
		
		//검색버튼
		$("#noticeSearch").click(function(){
			obj.url="./boardList";
			obj.data={
					"search":$("#search").val(),
					"cate":"공지사항",
					 "sNum":sNum,
		            "eNum":eNum 
			};
			obj.success = function(data){
				console.log(data.list);
				$("#noticeTable").empty();
			 	$("#noticeTable").append(tableTh);
				listPrint(data.list);
			}
			ajaxCall(obj);
		});
		
		//이전목록 버튼
		$("#noticeBefore").click(function(){
			sNum -= 10;
	        eNum -= 10;
			obj.url="./boardList";
			obj.data={
					"search":$("#search").val(),
					"cate":"공지사항",
					"sNum":sNum,
		            "eNum":eNum
			};
			obj.success = function(data){
				console.log(data.list);
				console.log(data.list.length);
				if(data.list.length == 0){
					alert("첫번째 목록 입니다.");
					sNum = 1;
					eNum = 10;
				}else{
					var b = data.list.length;
					$("#noticeTable").empty();
					$("#noticeTable").append(tableTh);
					listPrint(data.list);
				}
			}
			ajaxCall(obj);
		});
		//다음 목록
		$("#noticeAfter").click(function(){
			sNum += 10;
	        eNum += 10;
	        obj.url="./boardList";
			obj.data={
					"search":$("#search").val(),
					"cate":"공지사항",
					"sNum":sNum,
		            "eNum":eNum
			};
			obj.success = function(data){
				console.log(data.list);
				console.log(data.list.length);
				if(data.list.length == 0){
					alert("마지막 목록 입니다.");
					sNum -= 10;
					eNum -= 10;
				}else{
					$("#noticeTable").empty();
					$("#noticeTable").append(tableTh);
					listPrint(data.list);
				}
			}
			ajaxCall(obj);
		});
	</script>
</html>