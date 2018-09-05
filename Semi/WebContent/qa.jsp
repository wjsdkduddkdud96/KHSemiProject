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
            	
            th, td {
                border: 0.1px solid black;
                float: left;
                text-align: center;
                line-height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .qa {
                position: relative;
                margin-top: 50px;
                width: 1000px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #qa_header {
                width: 150px;
                height: 30px;
                font-size: 30px;
                line-height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .qa_row_header {
                width: 1000px;
                height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .qa_row_content {
                width: 1000px;
                height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #no {
                width: 100px;
                height: 30px;
                line-height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #title {
                width: 400px;
                height: 30px;
                line-height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #writer {
                width: 200px;
                height: 30px;
                line-height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #write_date {
                width: 200px;
                height: 30px;
                line-height: 30px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #search_area {
                width: 200px;
                height: 30px;
                margin-top: 30px;
                margin-left: 350px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #search {
                height: 30px;
                line-height: 30px;
                background-color: #343434;
                color: white;
                border: 0;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .btn {
                width: 100px;
                height: 30px;
                background-color: #343434;
                color: white;
                border: 0;
                font-family: 'Nanum Square', sans-serif;
            }
            
            #qa_write {
                margin-top: -50px;
                margin-left: 250px;
                margin-bottom: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
            
            .page {
                margin-left: 350px;
                margin-bottom: 50px;
                font-family: 'Nanum Square', sans-serif;
            }
		</style>
	</head>
	<body>
        <div class="qa">
            <div id="qa_header"><strong>Q&A</strong></div>

            <table>
                <tr class="qa_row_header">
                    <th id="no" style="background-color: #343434; color: white;">번호</th>
                    <th id="title" style="background-color: #343434; color: white;">제목</th>
                    <th id="writer" style="background-color: #343434; color: white;">작성자 ID</th>
                    <th id="write_date" style="background-color: #343434; color: white;">작성일자</th>
                	<input id="hide" type="hidden"/>
                </tr>
            </table>

            <input id="search_area" type="text" placeholder=" 검색할 제목을 입력해주세요."/>
            <input id="search" type="button" value="검색"><br/><br/>
            
            <span class="page">
                <input class="btn" type="button" id="beforePage" value="이전 목록"/>
                <input class="btn" type="button" id="nextPage" value="다음 목록"/>
            </span>
            <input class="btn" id="qa_write" type="button" value="작성하기"/>
        </div>
	</body>
	<script>
		var isreadyed = false;
		var start_page = 1;
		var max_size = 0;	
		
		var obj = {};
		obj.type = "POST";
		obj.dataType = "JSON";
		obj.error = function(error){console.log(error)};

		// 'Q&A' 탭을 눌렀을 때, start_page를 1로 설정(end_page = start_page+4)
		$(document).ready(function() {
			var loginId = "${sessionScope.loginId}";
			var loginDiv = "${sessionScope.loginDiv}";
			maxSize();
			
			if(!isreadyed) {
				if(loginId == ""){
					alert("로그인이 필요합니다.");
					location.href="./placeDetailUp?place_no=${param.place_no}&page=placeDetail.jsp";					
				} else {
					start_page = 1;
					paging(start_page);
				}
				isreadyed = true;
			}
		});    		 

		// '이전 목록' 버튼 클릭 시, start_page = start_page-5
		$("#beforePage").click(function() {
			if(start_page > 5) {
				start_page -= 5;	
				paging(start_page);
			}
		}); 
		
		// '다음 목록' 버튼 클릭 시
		$("#nextPage").click(function() {
			if(start_page+5 < max_size) {
				start_page += 5;
				paging(start_page);
			}
		});
		
		// max_size 파악
		function maxSize() {
			var msg="${param.place_no}";
			obj.url = "./qaListSize";
			
			obj.data = {
				place_no: msg
			};
			
			obj.success = function(data) {
				max_size = data.max_size;
			}
			ajaxCall(obj);
		}
		
		function paging(start_page) {
			var msg="${param.place_no}";
			obj.url = "./qaList";
			
			obj.data = {
				start: start_page,
				end: start_page+4,
				place_no: msg
			};
			
			obj.success = function(data) {
				$(".qa_row_content").remove();
				
				for(var i=data.list.length-1; i>=0; i--) {
					var str = "<tr class='qa_row_content'>";
					str += "<td id='no'>"+data.list[i].rnum+"</td>";
					str += "<td id='title'><a href='./qaDetail?qa_no="+data.list[i].qa_no+"'>"+data.list[i].qa_title+"</a></td>";
					str += "<td id='writer'>"+data.list[i].info_id+"</td>";
					str += "<td id='write_date'>"+data.list[i].qa_date+"</td>";
					str += "</tr>";	
					$("#hide").after(str);
				}
			}
			ajaxCall(obj);
		}
		
		// 작성하기 버튼 클릭 시, qaWrite.jsp로 이동
		$("#qa_write").click(function() {
			location.href = "./qaWriteForm?place_no="+${param.place_no};
		});
		
		// Q&A 제목 검색
		$("#search").click(function() {
			obj.url = "./qaSearch";
			
			obj.data = {
				place_no: "${param.place_no}",
				search_keyword: $("#search_area").val()
			};
			
			obj.success = function(data) {
				$(".qa_row_content").remove();
				
				if(data.list.length == 0) {
					alert("키워드와 일치하는 Q&A가 없습니다.");
				} else {
					for(var i=data.list.length-1; i>=0; i--) {
						var str = "<tr class='qa_row_content'>";
						str += "<td id='no'>"+data.list[i].rnum+"</td>";
						str += "<td id='title'><a href='./qaDetail?qa_no="+data.list[i].qa_no+"'>"+data.list[i].qa_title+"</a></td>";
						str += "<td id='writer'>"+data.list[i].info_id+"</td>";
						str += "<td id='write_date'>"+data.list[i].qa_date+"</td>";
						str += "</tr>";	
						$("#hide").after(str);
					}
				} 
			}
			ajaxCall(obj);
		});
		
		function ajaxCall(param) {
			$.ajax(param);
		}
	</script>
</html>