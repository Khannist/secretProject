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
    <div id="addViewRoom">
    		Add
    </div>
    <div>
    	<input type="text" name="roomName" id="roomName">
		<button id="createRoom">방 만들기</button>
    </div>
	
	
	
	
	
	
	
	
	
	
	
	
	<div class="container">
		<h1>채팅방</h1>
		<div id="roomContainer" class="roomContainer">
			<table id="roomList" class="roomList"></table>
		</div>
		<div>
			<table class="inputTable">
				<tr>
					<th>방 제목</th>
					<th><input type="text" name="roomName" id="roomName"></th>
					<th><button id="createRoom">방 만들기</button></th>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="/js/room/room.js"></script>
</body>
</html>