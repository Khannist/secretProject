<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link  rel="stylesheet" type="text/css" href="/css/ServerPageCss.css">
<title>Insert title here</title>
</head>
<body>
<div class="container"> 
		<input type="hidden" name="userId" id="userId" value="${mVo.userId}">
		<input type="hidden" name="name" id="name" value="${mVo.name}">
		<input type="hidden" name="channelCode" id="channelCode">
		<input type="hidden" name="roomCode" id="roomCode">
        <header>
            <img src="img/superMarch.PNG" alt="로고" id="Logo" onclick="location.href='#'">
            <nav>
                <ul>
                    <li><p><a href="#">Posting    |   </a></p></li>
                    <li><p><a href="#">Buddy    |   </a></p></li>
                    <li><p><a href="#">ProFile</a></p></li>
                </ul>
            </nav>
        </header>
        <div class="Lbar">
			<jsp:include page="roomchannel/roomChannel.jsp"></jsp:include>
        </div>
        <div class="Midbar">
            <jsp:include page="room/room.jsp"></jsp:include>
            <div class="MainChat">
                <img src="img/changeicon.png" alt="OpenMusic" id="OpenMusic" onclick="PageReconstruction()">
                <div class="MainChatRoom">메인채팅방</div>
                <div class="OneToOneChatRoom" style="display: none;">일대일채팅방</div>
            	<jsp:include page="chat/chat.jsp"></jsp:include>
            </div>
            <input type="text" name="" id="chatInput" placeholder="보내실 메시지를 입력하세요." onkeyup="send()">
        </div>
        
    </div>
    <script>
        function showMainChatRoom(){
            document.querySelector('.MainChatRoom').style.display = "block";	// 메인채팅 부분을 화면에 표시
            document.querySelector('.OneToOneChatRoom').style.display = "none";    // 일대일채팅 부분을 화면에서 감춤
        }
        function showOneToOneChatRoom(){
            document.querySelector('.OneToOneChatRoom').style.display = "block";   // 일대일채팅 부분을 화면에 표시
            document.querySelector('.MainChatRoom').style.display = "none";    // 메인채팅 부분을 화면에서 감춤
        }
        /* function PageReconstruction(){
        	 document.querySelector('.MainChatRoom').style.display = "block";
        } */
    </script>
    <script type="text/javascript" src="/js/room/room.js"></script>
    <script type="text/javascript" src="/js/channel/channel.js"></script>
    <script type="text/javascript" src="/js/chat/chat.js"></script>
</body>
</html>