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
        
            table {
                position: relative;
                width: 1000px;
                margin-top: 50px;
                border-collapse: collapse;
                font-family: 'Nanum Square', sans-serif;
            }
            
            th {
                border: 0.1px solid black;
                float: left;
                text-align: center;
                height: 30px;
                line-height: 30px;
               	border-collapse: collapse;
               	font-family: 'Nanum Square', sans-serif;
            }
            
            td {
                border: 0.1px solid black;
                float: left;
                text-align: center;
                height: 30px;
                line-height: 30px;
               	border-collapse: collapse;
               	font-family: 'Nanum Square', sans-serif;
            }
            
            hr {
            	width: 850px;
            	float: left;
            	align: left;
            }
            
            .td_height {
           		height: 90px;
           	}
            
            .review {
                position: relative;
                width: 1000px;
                margin-top: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_header {
                width: 150px;
                height: 30px;
                font-size: 30px;
                line-height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_table {
                width: 1000px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_id {
                width: 150px;
                height: 30px;
                line-height: 30px;
                border: 0.1px solid #222222;
                text-align: center;
                float: left;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_id_col {
                width: 150px;
                height: 90px;
                line-height: 90px;
                border: 0.1px solid #222222;
                text-align: center;
                float: left;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_textarea {
                width: 450px;
                height: 90px;
                line-height: 20px;
                float: left;
                margin: 0px;
                spacing: 0px;
                font-family: 'Nanum Square', sans-serif;
                border: 0.1px solid #222222;
            }
            
            .review_content {
                width: 450px;
                height: 30px;
                line-height: 30px;
                text-align: center;
                float: left;
                margin: 0px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_date {
                width: 150px;
                height: 30px;
                line-height: 30px;
                border: 0.1px solid #222222;
                text-align: center;
                float: left;
                font-family: 'Nanum Square', sans-serif;
            }
            
             .review_date_col {
                width: 150px;
                height: 90px;
                line-height: 90px;
                border: 0.1px solid #222222;
                text-align: center;
                float: left;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .btn {
                width: 50px;
                height: 90px;
                line-height: 30px;
                background-color: #343434;
                border: 0.1px solid black;
                color: white;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_writeForm {
                margin-top: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_content_write {
                width: 650px;
                height: 90px;
                float: left;
                border: 0.1px solid #222222;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_score_write {
                width: 100px;
                height: 60px;
                float: left;
                border: 0.1px solid #222222;
                text-align: center;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_score_header {
                width: 100px;
                height: 60px;
                float: left;
                border: 0.1px solid #222222;
                line-height: 60px;
                font-size: 14px;
                text-align: center;
                background-color: #222222;
                color: white;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_score {
                width: 100px;
                height: 30px;
                line-height: 30px;
                text-align: center;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .review_regist {
                width: 100px;
                height: 90px;
                border: 0.1px solid black;
                line-height: 90px;
                float: left;
                font-size: 14px;
                text-align: center;
                background-color: #222222;
                color: white;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #review_header {
            	background: #222222;
            	color: white;
            	font-family: 'Nanum Square', sans-serif;
            }
            
            .user_review_score {
                width: 100px;
                height: 90px;
                line-height: 90px;
                text-align: center;
                font-family: 'Nanum Square', sans-serif;
            }
            
        </style>
    </head>
    <body>
        <div class="review">
            <div class="review_header"><strong>이용 후기</strong></div>
            <div class="review_table"><table>
                <tr id="review_add">
                	<th class='review_id' id="review_header">작성자 ID</th>
					<th class='review_content' id="review_header">내용</th>
					<th class='review_date' id="review_header">작성일자</th>
					<th class='review_score' id="review_header">평점</th>
				</tr>
            </table></div>
            <br/><br/><hr/>
            <div class="review_writeForm">
           		<input type="hidden" name="place_no" value="${param.place_no}"/>
              		<input type="hidden" name="info_id" value="${sessionScope.loginId}"/>
                	<div class="review_content_write"><textarea class="review_content_write" placeholder=" 후기 내용을 입력해주세요. (최대 300자)" name="review_content"></textarea></div>
                	<div class="review_score_write">
                    <div class="review_score_header">평점</div> 
                    <select class="review_score" name="review_score">
                        <option value="1.0">1.0</option>
                        <option value="2.0">2.0</option>
                        <option value="3.0">3.0</option>
                        <option value="4.0">4.0</option>
                        <option value="5.0" selected="selected">5.0</option>
                    </select>
                </div>
                <input type="button" class="review_regist" onSubmit="return false;" onclick="reviewWrite()" value="후기 등록" />
            </div>
        </div>
    </body>
    <script>
    	var obj = {};
    	var isreadyed = false;
    	var place_no = 0;
    	var review_update_content = "";
		obj.type = "POST";
		obj.dataType = "JSON";
		obj.error = function(error){console.log(error)};

		// 'Q&A' 탭이 눌렸을 때,
		$(document).ready(function() {
			var loginId = "${sessionScope.loginId}";
			var loginDiv = "${sessionScope.loginDiv}";
			var msg = "${msg}";
			
			if(isreadyed) {
				return;
			}

			isreadyed = true;
			
			if(loginId == "") {
				alert("로그인이 필요합니다.");
				location.href="./placeDetailUp?place_no=${param.place_no}&page=placeDetail.jsp";
			} else {
				place_no = ${param.place_no};
				
				obj.url = "./reviewList";
				obj.data = {
					place_no: place_no
				};
				
				obj.success = function(data) {
					for(var i=data.list.length-1; i>=0; i--) {
						$("#review_add").next().remove();
					}
					
					for(var i=data.list.length-1; i>=0; i--) {
						var str = "<tr><td class='review_id_col'>"+data.list[i].info_id+"</td>";
						str += "<td class='review_textarea'><textarea class='review_textarea' readonly='readonly'>"+data.list[i].review_content+"</textarea></td>";
						str += "<td class='review_date_col'>"+data.list[i].review_date+"</td>";
						str += "<td class='user_review_score'>"+data.list[i].review_score+"</td>";
						
						if(data.list[i].info_id == loginId) {
							str += "<td class='td_height'><button class='btn' id='review_update"+data.list[i].review_no+"' onclick='updateInit("+data.list[i].review_no+")'>수정</button>";
							str += "<button class='btn' onclick='reviewDel("+data.list[i].review_no+")'>삭제</button></td></tr>";
						} else {
							str += "</tr>";
						}
						$("#review_add").after(str);
					}
				}
				ajaxCall(obj);
			}
		});    		 

		// '후기 등록' 버튼을 눌렀을 시,
		function reviewWrite() {
			obj.url = "./reviewWrite";		
			obj.data = {
				place_no: "${param.place_no}",
				info_id:  "${sessionScope.loginId}",
				review_content: $("textarea[name='review_content']").val(),
				review_score: $("select[name='review_score']").val()
			};
			
			obj.success = function(data) {
				alert(data.msg);	
				if(data.msg == "후기 내용이 300자가 넘습니다.") {
					console.log("후기후기");
				} else {
					location.href = "placeDetailUp?place_no="+place_no+"&page=review.jsp";
				}
			}
			ajaxCall(obj);
      	}
		
		function updateInit(review_no) {
			$("#review_update"+review_no).parent().prev().prev().prev().children($('.review_textarea')).attr('readonly', false);
			$("#review_update"+review_no).next().after("<button class='btn' id='completeBtn"+review_no+"' onclick='reviewUpdate("+review_no+")'>완료</button>");
			$("#review_update"+review_no).next().hide();
			$("#review_update"+review_no).hide();
		}
		
		// 후기 수정 후 '완료' 버튼을 눌렀을 시, 
		function reviewUpdate(review_no) {
			$("#review_update"+review_no).next().show();
			$("#review_update"+review_no).show();
			$("#completeBtn"+review_no).remove();
			review_update_content = $("#review_update"+review_no).parent().prev().prev().prev().children($('.review_textarea')).val();
			$("#review_update"+review_no).parent().prev().prev().prev().children($('.review_textarea')).attr('readonly', true);
			
			obj.url = "./reviewUpdate";		
			obj.data = {
				place_no: place_no,
				review_no: review_no,	
				review_content: $("#review_update"+review_no).parent().prev().prev().prev().children($('.review_textarea')).val()
			};
			
			obj.success = function(data) {
				alert(data.msg);
				location.href = "placeDetailUp?place_no="+place_no+"&page=review.jsp";
			}
			ajaxCall(obj);
		}  
		
		// 후기 삭제
		function reviewDel(review_no) {
			obj.url = "./reviewDel";		
			obj.data = {
				review_no: review_no,	
			};
			
			obj.success = function(data) {
				alert(data.msg);
				location.href = "placeDetailUp?place_no="+data.place_no+"&page=review.jsp";
			}
			ajaxCall(obj);
		}
		
		function ajaxCall(param) {
			$.ajax(param);
		} 
    </script>
</html>