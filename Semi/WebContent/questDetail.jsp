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
				padding: 5px 10px;
				margin:0 auto;

			}
			table{
				width:700px;
			}
			th{
				width: 80px;
				background-color: #212121;
				color: white;
			}
			td{
				width: 200px;
			}
			body{
				 
				 width: 900px; 
                 max-width: none !important; 
                 margin: 0 auto;
			}
			#content{
				height: 200px;
			}
			button{
				width: 55px;
				height: 30px;
				background-color: #212121;
				color: white;
				border: 0;
			}
			#list{
				position: absolute;
				left: 775px;
			}
			#update{
				position: absolute;
				left: 835px;
			}
			#delete{
				position: absolute;
				left: 895px;
			}
			#updateOk{
				position: absolute;
				left: 895px;
				display: none; 
			}
			#cancel{
				position: absolute;
				left: 835px;
				 display: none;
			}
			
			.anserContent{
				width: 520px;
				height: 100px;
			}
			#answerWrite{
				background-color: lightgray;
				color:black;
				font-size: 12pt;
				width: 80px;
				height: 100px;
				font-weight: bold;
			}
			input{
				width:100%;
				text-align: center; 
				border:0px;
			}
			textarea{
				width: 100%;
				height: 100%;
				border: 0px;
			}
			#replyContent{
				width: 450px;
				height: 40px;
			}
			#replyBtn{
				width: 20px;
			}
			#include{
				height: 60px;
			}
			#replyUpdateOk{
				display: none;
			}
			#answerTitle{
				position: absolute;
				left: 393px;
				width: 80px;
				height: 50px;
				background-color: gray;
				display: table;
			}			
			
			.answerBtn{
				background-color: lightgray;
				
			}
			.replyInfo{
				background-color: lightgray;
				color:black;
				font-size: 12pt;
				width: 80px;
			}
			#answerTxt{
				width:100%
			}
			#categoryP{
				color: white;	
				display: table-cell;
				vertical-align: middle;
				text-align: center;
				font-size: 15pt;
				font-weight: 900;
			}
			#replyTable{
				height: 110px;
			}
			h1{
				text-align: center;
			}
		</style>
	</head>
	<body>
	<div id="include">
	<jsp:include page="/menuBar.jsp" flush="false"/>
	</div>
		<h1>문의사항</h1>
		<br/><br/>
		<table>
			<tr>
				<th>제목</th>
				<td colspan="3">
					<input type="text" name="board_title" id="board_title" onKeyup="len_chk()" readonly/>
					<input type="hidden" id="board_no" />
				</td>
			</tr>
			
			<tr>
				<th>작성일자</th>
				<td id="board_date"></td>
				<th>작성자 ID</th>
				<td id="info_id"></td>
			</tr>
			<tr>
				<th colspan="4">내용</th>
			</tr>
			<tr>
				<td colspan="4" id="content">
					<textarea id="board_content" onKeyup="len_chk()" readonly></textarea>
				</td>
			</tr>
		</table>
		<br/>
		<button id="cancel">취소</button>
		<button id="updateOk">완료</button>
		<button id="list">목록</button>
		<button id="update">수정</button>
		<button id="delete">삭제</button>
		
		<br/><br/><br/><br/>
		<h1>답변</h1>
		<div id="answerDiv">
			
		</div>
		<!-- <table>
			<tr>
				<th id="name">관리자</th>
				<td class="anserContent"></td>
			</tr>
		</table><br/><hr/><br/> -->
		<hr/>
		<table>
			<tr>
				<td class="anserContent">
					<textarea id="answerTxt" onKeyup="len_chk()" placeholder="답변을 입력해주세요 (최대 300자)"></textarea>
				</td>
				<th class="answerBtn"><button id="answerWrite">등록</button></th>
			</tr>
		</table><br/>

	</body>
	<script>
		/*java script area*/		
		
		//ajax
		var tableTh = "";
		var obj={};
		var idx;
		obj.type="POST";
		obj.dataType="JSON";
		obj.error=function(e){console.log(e)};
		var loginId = "${sessionScope.loginId}";
		

		/* $("#answerWrite").click(function(){
			location.href="./boardReplyWrite?board_no=${board.board_no}";
		}); */
		$(document).ready(function(){
			
			tableTh = $("#answerDiv").children().html();
			obj.url="./boardDetail?board_no=${board_no}";
			obj.data={
					"board_no":$("#board_no").val(),
					"board_title":$("#board_title").val(),
					"board_content":$("#board_content").val()
			};
			obj.success=function(data){
				console.log(data);
				//성공/실패 : 상세보기 페이지
				$("#board_no").val(data.dto.board_no);
				$("#board_title").val(data.dto.board_title);
				$("#board_date").text(data.dto.board_date);
				$("#info_id").text(data.dto.info_id);
				$("#board_content").val(data.dto.board_content);
				//$("#answerDiv").append(tableTh);
				if($("#info_id").text() != "${loginId}" && "${loginId}" != "ADMIN"){
					$("#update").css("display","none");
					$("#delete").css("display","none");
					$("#list").css("left","1080px");
				}
				replyPrint(data.list);

				 for(var i=0; i<data.list.length; i++){
					 console.log($(".replyInfo"+data.list[i].rnum).text());
					 if($(".replyInfo"+data.list[i].rnum).text() != "${loginId}"){
						$("td[name='replyBtn"+data.list[i].rnum+"']").css("display","none");
						$(".replyContent"+data.list[i].rnum).css("width","470px");
					}
					if("${loginId}" == "ADMIN"){
						$("td[name='replyBtn"+data.list[i].rnum+"']").css("display","");
						$(".replyContent"+data.list[i].rnum).css("width","450px");
					}
				}
								
			};
			ajaxCall(obj);
		});
		
		
		$("#list").click(function() {
			location.href="quest.jsp";
		});
		$("#update").click(function(){
			console.log("click");
			if($("#info_id").text() == "${loginId}" || "${loginId}" == "ADMIN"){
					console.log("OK");
					$("#board_title").attr("readonly",false);
					$("#board_title").focus();
					$("#board_content").attr("readonly",false);
					$("#list").css("display","none");
					$("#update").css("display","none");
					$("#delete").css("display","none");
					$("#updateOk").css("display","block");
					$("#cancel").css("display","block"); 
					
				}else if(loginId == ""){					
					console.log(loginId);
						alert("로그인이 필요한 서비스 입니다.");
						location.href="login.jsp";
				} else{
					alert("글을 수정할 권한이 없는 아이디 입니다.");
				}
		});
		
		$("#cancel").click(function(){
			/* location.href="boardDetail?board_no=${board.board_no}"; */
			location.href="questDetail.jsp";
		});
		
		$("#updateOk").click(function(){
			console.log("click");
			if($("#board_title").val() == ""){
				alert("제목을 입력해 주세요.");
				$("#board_title").focus();
			}else if($("#board_content").val() == ""){
				alert("내용을 입력해 주세요.");
				$("#board_content").focus();
			}else{
				obj.url="./boardUpdate?board_no="+$("#board_no").val();
				obj.data={
						"board_no":$("#board_no").val(),
						"board_title":$("#board_title").val(),
						"board_content":$("#board_content").val()
				};
				obj.success=function(data){
					console.log(data);
					//성공/실패 : 상세보기 페이지
					if(data.success == 1){
						alert("수정 완료");
						location.href="questDetail.jsp";
					}else{
						alert("수정 실패");
					}
				};
				ajaxCall(obj);
			}			
		});
		function ajaxCall(param){
			console.log(param);
			$.ajax(param);
		}
		
		//문의사항 삭제
		$("#delete").click(function(){			
			if($("#info_id").text() == "${loginId}" || "${loginId}" == "ADMIN"){
				console.log("OK");
				location.href="./boardDel?board_no="+$("#board_no").val();				
			}else if(loginId == ""){					
				console.log(loginId);
				alert("로그인이 필요한 서비스 입니다.");
				location.href="login.jsp";
			}else{
				alert("글을 삭제할 권한이 없는 아이디 입니다.");
			}
		});
		
		var msg="${msg}";
		
		if(msg!=""){
			   alert(msg);
			   location.href="quest.jsp";
		}
		
		function len_chk(){  
			  var frm = $("#board_content");
			  var title = $("#board_title");
			  var answerTxt = $("#answerTxt");
			 
			  console.log("문의 내용 : "+frm.val().length);
			  console.log("문의 제목 : "+title.val().length);
			  console.log("답글 내용 : "+answerTxt.val().length);
			 
			  if(frm.val().length > 1000){  
			       alert("내용 글자수는 1000자로 제한됩니다.!");  
			       frm.val(frm.val().substring(0,1000));  
			       frm.focus();  
			  }
		       if(title.val().length > 50){
		    	   alert("제목 글자수는 50자로 제한됩니다!");
		    	   title.val(title.val().substring(0,50));  
		    	   title.focus(); 			    	   
		       }
		       if(answerTxt.val().length > 300){
		    	   alert("답글 글자수는 300자로 제한됩니다!");
		    	   answerTxt.val(answerTxt.val().substring(0,300));  
		    	   answerTxt.focus(); 			    	   
		       }
		       
			}
		function len_chk2(data){  
			 var reply = $("textarea[name='"+data+"']");
			 console.log("답글 내용 수정 : "+$("textarea[name='"+data+"']").val().length);
			 if(reply.val().length > 300){
		    	   alert("답글 글자수는 300자로 제한됩니다!");
		    	   reply.val(reply.val().substring(0,300));  
		    	   reply.focus(); 			    	   
		       } 
		}
		
		//문의사항 답글쓰기
		$("#answerWrite").click(function(){
			console.log("click");
			 if($("#info_id").text() == "${loginId}" || "${loginId}" == "ADMIN"){
				 
			 if($("#answerTxt").val() == ""){
				alert("내용을 입력해 주세요.");
				$("#answerTxt").focus();
			}else{
				obj.url="./boardReplyWrite?board_no="+$("#board_no").val();
				obj.data={
						"board_no":$("#board_no").val(),
						"answerTxt":$("#answerTxt").val()
				};
				obj.success=function(data){
					console.log(data);
					//성공/실패 : 상세보기 페이지
					if(data.result >0){
						alert("답글 등록 성공");
						location.href="questDetail.jsp";
					}else{
						alert("답글 등록 실패");
					}
				};
				ajaxCall(obj);
				}
			 }else{
				 alert("답글을 작성할 권한이 없는 아이디 입니다.");
				 $("#answerTxt").val("");
			 }
		});
		//리스트 출력
		function replyPrint(list){
			console.log(list);
			var content = "";
				list.forEach(function(item, board_no){
					 if(item.info_id == "ADMIN"){
						item.info_id = "관리자";
					} 
					content+="<table id='replyTable'>"
					content+="<tr id='replyTr'>";
					content+="<th id='replyInfo' class='replyInfo"+item.rnum+"'  name='replyInfo"+item.reply_no+"'><input type='hidden' id='rnum' value='"+item.rnum+"'/>"+item.info_id+"</th>";
					content+="<td id='replyContent' class='replyContent"+item.rnum+"'><textarea id='reply' onKeyup='len_chk2("+item.reply_no+")' name="+item.reply_no+"  readonly>"+item.reply_content+"</textarea></td>";
					content+="<td id='replyBtn' class='replyBtn'"+item.reply_no+" name='replyBtn"+item.rnum+"'><button id='replyUpdate'  value='"+item.reply_no+
					"' name='"+item.reply_no+"' onclick='replyUp.call(this)'>수정</button><br/><br/><button  name='"+item.reply_no+
					"' onclick='replyDel.call(this)'  value='"+item.reply_no+"'>삭제</button><button id='replyUpdateOk'  value='"+item.reply_no+
					"' class='"+item.reply_no+"' onclick='replyUpok.call(this)'>완료</button></td>";
					content+="</tr>";
					content+="</table><br/>"					
						
				});
				$("#answerDiv").append(content);			
		}
		
		//답글 수정페이지 요청(수정버튼)
		function replyUp(){
			var replyUp = $(this).val();
			console.log(replyUp);
		    /* if(replyUp == $("#reply"+replyUp+"")){
				console.log($("#reply").val());
			}  */
			console.log($("th[name='replyInfo"+$(this).val()+"']").text());
			console.log("${loginId}");
			if($("th[name='replyInfo"+$(this).val()+"']").text() == "${loginId}" || "${loginId}" == "ADMIN"){
				console.log("OK");
				$("textarea[name='"+replyUp+"']").attr("readonly",false);
				$("textarea[name='"+replyUp+"']").focus();
				//$("#replyUpdate").css("display","none");
				$("button[name='"+replyUp+"']").css("display","none");
				$("button[class='"+replyUp+"']").css("display","block");
				
			}else if(loginId == ""){					
				console.log(loginId);
					alert("로그인이 필요한 서비스 입니다.");
					location.href="login.jsp";
			} else{
				alert("답글을 수정할 권한이 없는 아이디 입니다.");
			} 
			
		}
		
		//답글 수정(완료버튼)
		function replyUpok(){
			var updateOk = $(this).val();
			console.log(updateOk);
			
			 if($("textarea[name='"+updateOk+"']").val() == "" ){
				alert("댓글을 입력해 주세요.");
				$("textarea[name='"+updateOk+"']").focus();
			}else{
				obj.url="./boardReplyUdate?reply_no="+$(this).val();
				obj.data={
						"reply_no":$(this).val(),
						"reply":$("textarea[name='"+updateOk+"']").val()
				};
				
				obj.success=function(data){
					console.log(data);
					//성공/실패 : 상세보기 페이지
					if(data.success == 1){
						alert("댓글 수정 완료");
						location.href="questDetail.jsp";
					}else{
						alert("댓글 수정 실패");
					}
				};
				ajaxCall(obj);
			}			 
		}
		
		//답글 삭제
		function replyDel(){
			console.log($("th[name='replyInfo"+$(this).val()+"']").text());
			 if($("th[name='replyInfo"+$(this).val()+"']").text() == "${loginId}" || "${loginId}" == "ADMIN"){
				console.log("OK");
				obj.url="./boardReplyDel?reply_no="+$(this).val();	
				obj.data={
						"reply_no":$(this).val()
				};				
				obj.success=function(data){
					console.log(data.success);
					//성공/실패 : 상세보기 페이지
					if(data.success > 0){
						alert("댓글 삭제 완료");
						location.href="questDetail.jsp";
					}else{
						alert("댓글 삭제 실패");
					}
				};
				ajaxCall(obj);
			}else if(loginId == ""){					
				console.log(loginId);
				alert("로그인이 필요한 서비스 입니다.");
				location.href="login.jsp";
			}else{
				alert("글을 삭제할 권한이 없는 아이디 입니다.");
			} 
		}
		
	</script>
</html>