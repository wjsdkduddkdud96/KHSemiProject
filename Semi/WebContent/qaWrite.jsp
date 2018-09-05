<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
            .qa_write {
                width: 1000px;
                margin-top: 50px;
                margin-left: 50px;
            }
            
            #qa_header {
                width: 1000px;
                margin-top: 50px;
                font-size: 30px;
                text-align: center;
                
            }
            
            table {
                border-collapse: collapse;
                width: 1000px;
                border: 1px solid black;
                margin-top: 50px;
            }
            
            th {
                height: 30px;    
                border: 1px solid black;
                background-color: #222222;
            }
            
            #title_header {
                width: 100px;
                color: white;
            }
            
            #content_header {
            	color: white;
            }
            
            #regist {   
                width: 50px;
                height: 30px;
                margin-left: 950px;
            }
            
            #title {
                width: 900px;
            }
            
            #content {
                width: 1000px;
                height: 400px;
            }
		</style>
	</head>
	<body>
        <div class="qa_write">
            <div id="qa_header"><strong>Q&A</strong></div>
            
            <form action="qaWrite" method="post">
	            <table>
	            	<input type="hidden" name="place_no" value="${place_no}"/>
	                <tr>
	                    <th id="title_header">제목</th>
	                    <td><textArea id="title" name="qa_title"></textArea></td>
	                </tr>
	                <tr>
	                    <th id="content_header" colspan="2">내용</th>
	                </tr>
	                <tr>
	                    <td colspan="2"><textArea id="content" name="qa_content"></textArea></td>
	                </tr>
	            </table><br/>
	            <button id="regist">등록</button>
            </form>
        </div>
	</body>
	<script>
		var obj = {};
	 	var list = [];
		var loginId = "${sessionScope.loginId}";
		
		if(loginId == ""){
			alert("로그인이 필요합니다.");
			history.back();
		} else {
			obj.type = "POST";
			obj.dataType = "JSON";
			obj.error = function(error){console.log(error)};
			
			var msg = "${msg}";
			console.log(msg);
			if(msg != "") {
				alert(msg);
			} 
			
			if(msg == "Q&A 작성에 성공했습니다.") {
				location.href = "./qaDetail?qa_no=${qa_no}";
			} else if(msg == "Q&A 제목이 20자가 넘습니다.") {
				$("#title").focus();
				$("#title").text("${qa_title}");
				$("#content").text("${qa_content}");
			} else if(msg == "Q&A 내용이 300자가 넘습니다.") {
				$("#content").focus();
				$("#title").text("${qa_title}");
				$("#content").text("${qa_content}");
			} else if(msg == "Q&A 제목을 입력해주세요.") {
				$("#title").focus();
				$("#title").text("${qa_title}");
				$("#content").text("${qa_content}");
			} else if(msg == "Q&A 내용을 입력해주세요.") {
				$("#content").focus();
				$("#title").text("${qa_title}");
				$("#content").text("${qa_content}");
			}
		}
	</script>
</html>