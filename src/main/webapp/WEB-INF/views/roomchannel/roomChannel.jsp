<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	#addChannel {
		width: 250px;
		height: 250px;
		border: 1px solid black;
		background: black;
	}
	#channelSpace div {
		width: 100px;
		height: 100px;
		border: 1px solid black;
	}
	#channelNameInput {
		width: 200px;
		height: 60px;
		border: 1px solid black;
		display: none;
	}
}


</style>
<title>Insert title here</title>
</head>
<body>
	<div id="channelSpace"></div>
	
	
	<div id="addChannel" class="addChannel" onclick="createServer()"></div>
	<div id="channelNameInput">
		<input type="text" name="channelName" id="channelName">
		<input type="button" value="생성" name="channelCreate" id="channelCreate" onclick="channelCreateName()">
	</div>
	

	
</body>
</html>