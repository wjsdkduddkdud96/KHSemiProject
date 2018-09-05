<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			div#listDiv{ position: absolute; border: 1.5px solid #A4A4A4; width: 1000px; height: 400px;
	            left: 100px; top: 80px; text-align: center; }
	        table{ position: absolute; left:155px; top: 100px; }
	        table{ text-align: center; font-size: 13px; border: 1px solid black; border-collapse: collapse; 
	        	width: 700px; height: 20px; }
 	        th{ text-align: center; font-size: 15px; border: 1px solid black; border-collapse: collapse; }
	        td{ text-align: center; font-size: 15px; border: 1px solid black; border-collapse: collapse; }	 
	        
	        th#th_sel{width: 30px; height: 20px;}
	        td#td_sel{width: 30px; height: 20px;}
	        
	        th#th_id{width: 150px; height: 20px;}
	        td#td_id{width: 150px; height: 20px;}
	        
	        th#th_name{width: 60px; height: 20px;}
	        td#td_name{width: 60px; height: 20px;}
	        
	        th#th_gender{width: 30px; height: 20px;}
	        td#td_gender{width: 30px; height: 20px;}
	        
	        th#th_email{width: 180px; height: 20px;}
	        td#td_email{width: 180px; height: 20px;}
	        
	        th#th_div{width: 60px; height: 20px;}
	        td#td_div{width: 60px; height: 20px;}
	        
	        th{ color: white; background-color: black;}

	        input[type='text']{ border-top: none; border-right: none; border-left: none; border-bottom: 1px solid black; }
	        
	        button#pre{ position:absolute; left: 450px; top: 360px; 
	        	background-color: #212121; color: white; padding: 2px 7px; border: 0; font-size: 10pt;}
	        	
	        button#next{ position:absolute; left: 500px; top: 360px;  
	        	background-color: #212121; color: white; padding: 2px 7px; border: 0; font-size: 10pt;}
	        
	        
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
		<div id="listDiv">
          	<h3>회원 리스트</h3>
          	<input id="search" type="text" placeholder="검색"/>
          	<button id="searchBtn">검색</button>
          	<button id="userDel">삭제</button>
            <table id="userListTable">
                <tr>
                	<th id="th_sel">선택</th>
                    <th id="th_id">아이디</th>
                    <th id="th_name">이름</th>
                    <th id="th_gender">성별</th>
                    <th id="th_email">이메일</th>
                    <th id="th_div">구분</th>
                </tr>
            </table>
            
	        <button id="pre">이전</button>
	        <button id="next">다음</button>   
        </div>
	</body>
	<script>
		var sNum = 1; //페이징 시작 값
		var eNum = 10; //페이징 마지막 값
	
		$(document).ready(function() {
			$.ajax({
				type : "post",
				url : "./userList",
				data : {
    				sNum : sNum,
    				eNum : eNum
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					if(data.login == false){
						alert("권한 없음");
						//location.href="index.jsp";
					}else{
						if(data.userList != null){//BoardService 에서 받은 list 값이 true 면은
							//방법1
	 						for(var i=0; i<data.userList.length; i++){
								if(data.userList[i].info_div != "관리자") {
		 							$("#userListTable").append("<tr>"+
										"<td id='td_sel'><input  type='checkbox' value='"+data.userList[i].info_id+"'></td>"+	
										"<td id='td_id'>"+data.userList[i].info_id+"</td>"+
										"<td id='td_name'>"+data.userList[i].info_name+"</td>"+
										"<td id='td_gender'>"+data.userList[i].info_gender+"</td>"+
										"<td id='td_email'>"+data.userList[i].info_email+"</td>"+
										"<td id='td_div'>"+data.userList[i].info_div+"</td>"+
										"</tr>");
								}
							}
						}
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		});
		
		//검색 onkeypress 이벤트
		$("#search").keydown(function (key) {
			if(key.keyCode==13){
				$.ajax({
					type : "post",
					url : "./userList",
					data : {
						idSearch : $("#search").val(),
	    				sNum : sNum,
	    				eNum : eNum
					},
					dataType : "json",
					success : function(data) {
						$("#userListTable").empty();
						$("#userListTable").append("<tr><th id='th_sel'>선택</th><th id='th_id'>아이디</th><th id='th_name'>이름</th><th id='th_gender'>성별</th><th id='th_email'>이메일</th><th id='th_div'>구분</th></tr>");
						for(var i=0; i<data.userList.length; i++){
							if(data.userList[i].info_div != "관리자") {
								$("#userListTable").append("<tr>"+
									"<td id='td_sel'><input type='checkbox' value='"+data.userList[i].info_id+"'></td>"+
									"<td id='td_id'>"+data.userList[i].info_id+"</td>"+
									"<td id='td_name'>"+data.userList[i].info_name+"</td>"+
									"<td id='td_gender'>"+data.userList[i].info_gender+"</td>"+
									"<td id='td_email'>"+data.userList[i].info_email+"</td>"+
									"<td id='td_div'>"+data.userList[i].info_div+"</td>"+
									"</tr>");
							}
						}
					},
					error : function(error) {
						console.log(error);
					}
				});
			}
		});
		
		//회원 검색
		$("#searchBtn").click(function() {
			$.ajax({
				type : "post",
				url : "./userList",
				data : {
					idSearch : $("#search").val(),
    				sNum : sNum,
    				eNum : eNum
				},
				dataType : "json",
				success : function(data) {
					$("#userListTable").empty();
					$("#userListTable").append("<tr><th id='th_sel'>선택</th><th id='th_id'>아이디</th><th id='th_name'>이름</th><th id='th_gender'>성별</th><th id='th_email'>이메일</th><th id='th_div'>구분</th></tr>");
					
					for(var i=0; i<data.userList.length; i++){
						if(data.userList[i].info_div != "관리자") {
							$("#userListTable").append("<tr>"+
								"<td id='td_sel'><input type='checkbox' value='"+data.userList[i].info_id+"'></td>"+
								"<td id='td_id'>"+data.userList[i].info_id+"</td>"+
								"<td id='td_name'>"+data.userList[i].info_name+"</td>"+
								"<td id='td_gender'>"+data.userList[i].info_gender+"</td>"+
								"<td id='td_email'>"+data.userList[i].info_email+"</td>"+
								"<td id='td_div'>"+data.userList[i].info_div+"</td>"+
								"</tr>");
						}
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		});
		
		//회원삭제
		$("#userDel").click(function() {
			var checked = [];
			$("input[type='checkbox']:checked").each(function() {
				checked.push($(this).val())
			});
			console.log(checked);
			$.ajax({
				type : "post",
				url : "./userDel",
				data : {
					userDel : checked
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					alert("삭제 완료");
					location.href="userList.jsp";
				},
				error : function(error) {
					console.log(error);
				}
			});
		});
		
		//페이징 이전
		$("#pre").click(function() {
    		sNum -= 10; //페이징 시작 값 변수에서 -5를 하고 넣음
    		eNum -= 10; //페이징 끝 값 변수에서 -5를 하고 넣음
			$.ajax({
				type : "post",
				url : "./userList",
				data : {
					sNum : sNum,
					eNum : eNum
				},
				dataType : "json",
				success : function(data) {
					if(data.userList.length == 0){ //list로 넘어온값이 크기가 0이면
    					alert("첫번째 목록입니다.") //alert을 띄우고
    					//초기값으로 되돌린다.
    					sNum = 1; 
    					eNum = 10; 
    				}else{
    					$("#userListTable").empty();
    					$("#userListTable").append("<tr><th id='th_sel'>선택</th><th id='th_id'>아이디</th><th id='th_name'>이름</th><th id='th_gender'>성별</th><th id='th_email'>이메일</th><th id='th_div'>구분</th></tr>");
    					
    					for(var i=0; i<data.userList.length; i++){
							if(data.userList[i].info_div != "관리자") {
	    						$("#userListTable").append("<tr>"+
	    							"<td id='td_sel'><input type='checkbox' value='"+data.userList[i].info_id+"'></td>"+
	    							"<td id='td_id'>"+data.userList[i].info_id+"</td>"+
	    							"<td id='td_name'>"+data.userList[i].info_name+"</td>"+
	    							"<td id='td_gender'>"+data.userList[i].info_gender+"</td>"+
	    							"<td id='td_email'>"+data.userList[i].info_email+"</td>"+
	    							"<td id='td_div'>"+data.userList[i].info_div+"</td>"+
	    							"</tr>");
							}
    					}
    				}
				},
				error : function(error) {
					console.log(error);
				}
			});
		});
		
		$("#next").click(function() {
    		sNum += 10; //페이징 시작 값 변수에서 -5를 하고 넣음
    		eNum += 10; //페이징 끝 값 변수에서 -5를 하고 넣음
			$.ajax({
				type : "post",
				url : "./userList",
				data : {
					sNum : sNum,
					eNum : eNum
				},
				dataType : "json",
				success : function(data) {
					if(data.userList.length == 0){ //list로 넘어온값이 크기가 0이면
    					alert("마지막 목록입니다.") //alert을 띄우고
    					//초기값으로 되돌린다.
    					sNum -= 10; 
    					eNum -= 10; 
    				}else{
    					$("#userListTable").empty();
    					$("#userListTable").append("<tr><th id='th_sel'>선택</th><th id='th_id'>아이디</th><th id='th_name'>이름</th><th id='th_gender'>성별</th><th id='th_email'>이메일</th><th id='th_div'>구분</th></tr>");
    					
    					for(var i=0; i<data.userList.length; i++){
							if(data.userList[i].info_div != "관리자") {
	    						$("#userListTable").append("<tr>"+
	    							"<td id='td_sel'><input type='checkbox' value='"+data.userList[i].info_id+"'></td>"+
	    							"<td id='td_id'>"+data.userList[i].info_id+"</td>"+
	    							"<td id='td_name'>"+data.userList[i].info_name+"</td>"+
	    							"<td id='td_gender'>"+data.userList[i].info_gender+"</td>"+
	    							"<td id='td_email'>"+data.userList[i].info_email+"</td>"+
	    							"<td id='td_div'>"+data.userList[i].info_div+"</td>"+
	    							"</tr>");
							}
    					}
    				}
				},
				error : function(error) {
					console.log(error);
				}
			});
		});
	</script>
</html>