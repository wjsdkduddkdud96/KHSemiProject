<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	var loginId = "${sessionScope.loginId}";
	var loginDiv = "${sessionScope.loginDiv}";
	
	if(loginId == ""){
		alert("로그인이 필요한 서비스입니다.");
		history.back();
	}else if(loginId != null && loginDiv == "사용자"){
		location.href="userDetail.jsp";
	}else if(loginId != null && loginDiv == "등록자"){
		location.href="regDetail.jsp";
	}else if(loginId != null && loginDiv =="관리자"){
		alert("수정 할 수 없는 아이디");
		history.back();
	}
</script>
