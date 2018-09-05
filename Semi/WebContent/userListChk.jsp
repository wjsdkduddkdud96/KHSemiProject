<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	var loginId = "${sessionScope.loginId}";
	var loginDiv = "${sessionScope.loginDiv}";
	
	if(loginId == ""){
		alert("관리자 권한");
		history.back();
	}else if(loginId != null && loginDiv == "사용자"){
		alert("관리자 권한");
		//location.href="index.jsp";
		history.back();
	}else if(loginId != null && loginDiv == "등록자"){
		alert("관리자 권한");
		//location.href="index.jsp";
		history.back();
	}else if(loginId != null && loginDiv == "관리자"){
		location.href="userList.jsp";
	}
</script>
