<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>친구리스트</title>
</head>
<body>
	<%-- websocket이용해서 실시간 모니터링 친구리스트 불러오기 만들기 --%>
	<input type="hidden" value="A" id="mainId" class="mainId">
	<div id="friendList" class="friendList">
		
	</div>
	<script type="text/javascript" src="/js/friendList/friendList.js"></script>
</body>
</html>