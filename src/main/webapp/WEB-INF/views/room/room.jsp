<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
</head>
<body>
	<input type="hidden" name="userId" class="userId" value="${userId}">
	<ul id="roomList">
    </ul>
    <div id="addViewRoom" onclick="createRoom()">
    	<p>
    		<a>Add</a>
    	</p>
    </div>
    <div id="inputNameSpace" style="display: none;">
    	<input type="text" name="roomName" id="roomName">
    	<input type="button" name="inputRoomName" id="inputRoomName" value="입력" onclick="createRoomName()">
	</div>
	
</body>
</html>