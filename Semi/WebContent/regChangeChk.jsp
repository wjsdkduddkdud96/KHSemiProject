<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	var loginId = "${sessionScope.loginId}";
	var loginDiv = "${sessionScope.loginDiv}";
	
	
	if(loginId == ""){
		alert("로그인을 해주세요.");
		location.href="login.jsp";
	}else if(loginId != null && loginDiv =="사용자"){
		location.href="regChange.jsp";
	}else if(loginId != null && loginDiv =="등록자"){
		alert("등록 가능한 아이디 입니다.");
		history.back();
	}else if(loginId != null &&loginDiv =="관리자"){
		alert("등록이 불가능한 아이디 입니다.");
		history.back();
	}
</script>
