<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
	<c:when test="${fn:length(mVo.userId) > 0}">
		<input type="hidden" value="${mVo.userId}" id="userId" class="userId">
		<input type="text" value="${mVo.userId}님 환영합니다." style="border:none;">
		<jsp:include page="friend/friendList"></jsp:include>
		<input type="button" value="채팅방" onclick="location.href='room'">
	</c:when>
	<c:otherwise>
		<input type="button" value="로그인" onclick="location.href='login'">
	</c:otherwise>
</c:choose>

</body>
</html>