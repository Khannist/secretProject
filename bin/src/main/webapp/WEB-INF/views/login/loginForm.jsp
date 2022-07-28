<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
</head>
<body>
	<form action="loginCheck">
		아이디 : <input type="text" name="userId">
		<c:choose>
        	<c:when test="${fn:length(msg) > 0}">
        		<input type="text" value="${msg}" style="border:none;">
        	</c:when>
        	<c:otherwise>
        		
        	</c:otherwise>
        </c:choose>
        <br>
		비밀번호 : <input type="password" name="userPw">
		<br>
		<input type="submit" value="로그인">
		<input type="button" value="메인화면" onclick="location.href='/'">
	</form>
</body>
</html>