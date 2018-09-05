<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
            /* 나눔 스퀘어 폰트 */
            @import url(//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css);
            
            .qa_detail {
                width: 1000px;
                margin-top: 50px;
                margin-left: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .qa_header {
                width: 1000px;
                margin-top: 50px;
                font-size: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            table {
                border-collapse: collapse;
                width: 1000px;
                margin-top: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            tr {
            	width: 900px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            th {
                width: 150px;
                height: 30px;    
                line-height: 30px;
                border: 1px solid black;
                background-color: #222222;
                color: white;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #title {
                width: 850px;
                height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #write_date {
                width: 350px;
                height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #writer {
                width: 200px;
                height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #content {
                width: 1000px;
                height: 200px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .btn_list {
                margin-left: 830px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            
            .qa_reply {
                margin-top: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .reply_content {
                width: 800px;
                float: left;
                border: 0.1px solid #222222;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #qa_reply_write {
                width: 100px;
                height: 100px;
                float: left;
                border: 1px solid black;
                background-color: #222222;
                font-size: 18px;
                color: white;
                margin-bottom: 100px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .reply {
                margin-top: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .btn {
            	width: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .reply_regist_content {
                width: 900px;
                height: 100px;
                float: left;
                border: 0.1px solid #222222;
                margin-bottom: 100px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .qa_reply_writer {
            	height: 100px;
            	border: 0.1px solid black;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .reply_content {
            	height: 100px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .table_border {
            	border: 0.1px solid #222222;
                font-family: 'Nanum Square', sans-serif;
            }
            
            
		</style>
	</head>
	<body>
		<jsp:include page="menuBar.jsp"/>
        <div class="qa_detail">
            <div class="qa_header" style='text-align: center;'><strong>Q&A</strong></div>
            <table>
                <tr class="table_border">
                    <th id="title_header">제목</th>
                    <td colspan="3" id="title">${dto.qa_title}</td>
                </tr>
                <tr class="table_border">
                    <th>작성일자</th>
                    <td id="write_date">${dto.qa_date}</td>
                    <th>작성자 ID</th>
                    <td id="writer">${dto.info_id}</td>
                </tr>
                <tr class="table_border">
                    <td colspan="4" id="content" colspan="2">${dto.qa_content}</td>
                </tr>
            </table><br/>
            <div class="btn_list">
                <input class="btn" id="list" type="button" value="목록" onclick="qaDetail_list(${dto.place_no})"/>
            </div>
            
            <div class="qa_reply">
                <div class="qa_header"><strong>답변</strong></div>
                <table>
                	<tr id="reply_add"></tr>
                </table><br/><br/><hr/>
                
                <div class="reply">
                	<input id="logId" type="hidden" value="${sessionScope.loginId}"/>
                    <span><textarea class="reply_regist_content" id="repl_content"></textarea></span>
                    <input id="qa_reply_write" type="button" value="답변 작성"/>
                </div>
            </div>
        </div>
	</body>
	<script>
	 	var obj = {};
	 	var list = [];
		var loginId = "${sessionScope.loginId}";
		
		obj.type = "POST";
		obj.dataType = "JSON";
		obj.error = function(error){console.log(error)};
		
		// qaDetail.jsp가 로드되면, 해당 qa에 대한 후기를 전부 가져옴
		$(document).ready(function() {
			if(loginId == ""){
				alert("로그인이 필요합니다.");
				history.back();
			} 
			
			// 작성자가 아닌 사람의 경우, 수정/삭제 버튼이 안 보이게 함
			if($("#writer").text() == loginId) {
				var str = "<a href='./qaUpdateForm?qa_no=${dto.qa_no}'><input class='btn' id='chg' type='button' value='수정'/></a>&nbsp;";
            	str += "<a href='./qaDel?qa_no=${dto.qa_no}'><input class='btn' id='del' type='button' value='삭제'/></a>";
				$(".btn_list").append(str);
			} else {
				var str = "";
				$(".btn_list").css("margin-left", "950px");
			}
			
			obj.url = "./qaReplyList";
			
			obj.data = {
				qa_no: "${dto.qa_no}"
			};
			
			obj.success = function(data) {
				list = data.list;
				
				for(var i=0; i<list.length; i++) {				
					var str = "<tr><th class='qa_reply_writer'>"+list[i].info_id+"</th><td style='border: 0.1px solid black;'><textarea class='reply_content' readonly='readonly'>"+list[i].qareply_content+"</textarea></td>";
					
					if(list[i].info_id == loginId) {
						str += "<td><button class='btn' id='updatebtn"+list[i].qareply_no+"' onclick='updateInit("+list[i].qareply_no+")'>수정</button>"
						str += "<button class='btn' id='replyDel' onclick='replyDelete("+list[i].qareply_no+")'>삭제</button></td></tr>";
					} else {
						str += "</tr>";
					}
					$("#reply_add").append(str);
				}
			};
			ajaxCall(obj);
		});
		
		// '답변 작성' 버튼 클릭 시, qaReplyWrite 요청
		$("#qa_reply_write").click(function() {
			obj.url = "./qaReplyWrite";		
			obj.data = {
				qa_reply_content: $("#repl_content").val(),
				qa_no: "${dto.qa_no}",
				info_id: $("#logId").val()
			};
			obj.success = function(data) {
				console.log(data.msg);
				alert(data.msg);
				
				if(data.msg == "Q&A 답변 작성에 성공했습니다.") {
					var str = "<tr><th class='qa_reply_writer'>"+data.dto.info_id+"</th><td style='border: 0.1px solid black;'><textarea class='reply_content' readonly='readonly'>"+data.dto.qareply_content+"</textarea></td>"
									
					if(data.dto.info_id == loginId) {
						str += "<td><button class='btn' id='updatebtn"+data.dto.qareply_no+"' onclick='updateInit("+data.dto.qareply_no+")'>수정</button>";
						str += "<button class='btn' id='replyDel' onclick='replyDelete("+data.dto.qareply_no+")'>삭제</button></td></tr>";
					} else {
						str += "</tr>"
					}
					$("#reply_add").append(str);
				}
			};
			ajaxCall(obj);
			$("#repl_content").val("");
		});
		
		// Q&A 답글 수정 버튼을 눌렀을 시, textarea를 수정 가능한 상태로 만들고 완료 버튼 추가
		function updateInit(qareply_no) {
			$("#updatebtn"+qareply_no).parent().prev().children($('.reply_content')).attr('readonly', false);
			$("#updatebtn"+qareply_no).next().after("<button class='btn' id='completeBtn"+qareply_no+"' onclick='replyUpdate("+qareply_no+")'>완료</button>");
			$("#updatebtn"+qareply_no).next().hide();
			$("#updatebtn"+qareply_no).hide();	
		}
		
		// Q&A 답글 수정 후 '완료' 버튼을 눌렀을 시, 
		function replyUpdate(qareply_no) {
			$("#updatebtn"+qareply_no).next().show();
			$("#updatebtn"+qareply_no).show();
			$("#completeBtn"+qareply_no).remove();
			$("#updatebtn"+qareply_no).parent().prev().children($('.reply_content')).attr('readonly', true);
		
			obj.url = "./qaReplyUpdate";		
			obj.data = {
				qareply_no: qareply_no,	// 되나 확인
				qareply_content: $("#updatebtn"+qareply_no).parent().prev().children($('.reply_content')).val(),
			};
			
			obj.success = function(data) {
				alert(data.msg);
			};
			ajaxCall(obj);
		}
		
		function replyDelete(qareply_no) {
			obj.url = "./qaReplyDel";		
			obj.data = {
				qareply_no: qareply_no,	
			};
			
			obj.success = function(data) {
				alert(data.msg);
				location.href = "./qaDetail?qa_no="+data.qa_no;
			};
			ajaxCall(obj);
		}
		
		function qaDetail_list(place_no) {
			location.href="./placeDetailUp?place_no="+place_no+"&page=qa.jsp";
		}
		
		function ajaxCall(param) {
			$.ajax(param);
		} 
	</script>
</html>