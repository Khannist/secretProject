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
		display: inline-block;
	}
	#channelNameInput {
		width: 100px;
		border: 1px solid black;
		display: none;
	}
	input#channelName {
		width: 100px;
	}
	#channelSpace li{
		overflow: hidden;
	}
}


</style>
</head>
<body>
	<ul id="channelSpace">
  
	</ul>
	<div class="add">
		<p>
			<a id="addChannel" onclick="createServer()">Add</a>
		</p>
	</div>
	<div id="channelNameInput">
		<input type="text" name="channelName" id="channelName">
		<input type="button" name="inputChannelName" id="inputChannelName" onclick="channelCreateName();">
	</div>
	

	
</body>
</html>