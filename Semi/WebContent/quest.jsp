<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
				/* text-align: center; */
				width: 1000px; 				
                max-width: none !important;
                margin: 0 auto;
			}
			#writeBtn{
				position: absolute;
				left: 830px;
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
			h1{
				text-align: center;
			}
			 #quest{
				color: white;	
				display: table-cell;
				vertical-align: middle;
				text-align: center;
				font-size: 15pt;
				font-weight: 900;
			}
			#searchDiv{
				position: absolute;
				left: 500px;
			} 
			#beforeList{
				position: absolute;
				left: 550px;
			}
			#afterList{
				position: absolute;
				left: 650px;
			}
		</style>
	</head>
<body>
	<div id="include">
		<jsp:include page="/menuBar.jsp" flush="false" />
	</div>
		<h1>문의사항</h1>
		<br/><br/>
		<table id="listTable">
			<tr>
				<th id="num">번호</th>
				<th id="subject">제목</th>
				<th>작성자 ID</th>
				<th>작성일자</th>
			</tr>
		</table>
		<br /> 
		<br /> 
		<div id="searchDiv">
		<input type="text" id="search" placeholder="검색할 제목을 입력해 주세요." />
		<button id="searchBtn">검색</button>
		</div>
		<button id="writeBtn">작성하기</button>
		<br />
		<br />
		<br />
		<button id="beforeList">이전 목록</button>
		<button id="afterList">다음 목록</button><br/><br/>

</body>

<script>
		/*java script area*/
		
		var tableTh = "";
       var msg = "";
       var sNum = 1;
       var eNum = 10;
        var obj = {};
        var tableTh = $("#listTable");		
		var obj={};
		obj.error = function(e){console.log(e)};
		obj.type="POST";
		obj.dataType="JSON";
		
		
		
		function ajaxCall(param){
			console.log(param);
			$.ajax(param);
		}
		
		$(document).ready(function(){
			tableTh = $("#listTable").children().html();
			obj.url="./boardList";
			obj.data={
					"search":$("#search").val(),
					"cate":"문의사항",
					"sNum":sNum,
		            "eNum":eNum
			};
			obj.success = function(data){
				//console.log(data);
					listPrint(data.list);
			}
			ajaxCall(obj);
		});
			
		var b=0;
		//리스트 출력
		function listPrint(list){
			console.log(list);
			var content = "";
				list.forEach(function(item, board_no){
					content+="<tr>";
					content+="<td>"+item.rnum+"</td>";
					content+="<td><a href='boardDetailView?board_no="+item.board_no+"'>"+item.board_title+"</a></td>";
					content+="<td>"+item.info_id+"</td>";
					content+="<td>"+item.board_date+"</td>";
					content+="</tr>";	
				});
				$("#listTable").append(content);			
		}
		
		//작성하기 버튼
		$("#writeBtn").click(function(){
			location.href="questWrite.jsp";
		});
		
		//검색버튼
		$("#searchBtn").click(function(){
			obj.url="./boardList";
			obj.data={
					"search":$("#search").val(),
					"cate":"문의사항",
					 "sNum":sNum,
		            "eNum":eNum 
			};
			obj.success = function(data){
				console.log(data.list);
				$("#listTable").empty();
			 	$("#listTable").append(tableTh);
				listPrint(data.list);
			}
			ajaxCall(obj);
		});
		//이전목록 버튼
		$("#beforeList").click(function(){
			sNum -= 10;
	        eNum -= 10;
			obj.url="./boardList";
			obj.data={
					"search":$("#search").val(),
					"cate":"문의사항",
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
					$("#listTable").empty();
					$("#listTable").append(tableTh);
					listPrint(data.list);
				}
			}
			ajaxCall(obj);
		});

		//다음 목록
		$("#afterList").click(function(){
			sNum += 10;
	        eNum += 10;
	        obj.url="./boardList";
			obj.data={
					"search":$("#search").val(),
					"cate":"문의사항",
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
					$("#listTable").empty();
					$("#listTable").append(tableTh);
					listPrint(data.list);
				}
			}
			ajaxCall(obj);
		});
	</script>
</html>