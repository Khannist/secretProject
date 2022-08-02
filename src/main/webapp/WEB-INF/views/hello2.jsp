<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1> Test Page</h1>
	<h3 th:text="${uname}"></h3>
	
	<div class="well">
       <input type="text" id="msg" value="1212" class="form-control" />
       <button id="btnSend" class="btn btn-primary">Send Message</button>
    </div>
	
	<p th:text="'Name: ' + ${name}"></p>
    <form method="POST" action="korean">
        <input type="text" name="name" value="세종대왕" />
        <button type="submit">KOREAN</button>
    </form>
	
	<div th:if="${user}">
		<div th:text="${user}"></div>
		<div th:object="${user}">Thymeleaf Test : <span th:text="|*{uname}|"/></div>
		<div th:text="${user.uname}"></div>
	</div>
	<div th:unless="${user}">
	   <div>No User!!</div>
	</div>
	
	<ul>
	   <li th:each="data: ${users}" th:text="${data}"></li>
	   <li th:each="data: ${users}" th:text="${data.uid} + '. ' + ${data.uname}"></li>
	   <li th:each="data: ${users}" th:object="${data}">
	       <span th:text="|*{uid}|"></span>
	       <strong th:text="|*{uname}|"></strong>
	   </li>
	</ul>
	
	<a th:href="@{http://localhost:9090/hello}">HELLO</a>
	
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>	
  
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
$(document).ready(  function() {
	//connectWS();
	//connectSockJS();
	connectStomp();
	
	$('#btnSend').on('click', function(evt) {
        evt.preventDefault();
        if (!isStomp && socket.readyState !== 1) return;
        
        let msg = $('input#msg').val();
        console.log("mmmmmmmmmmmm>>", msg)
        if (isStomp)
        	socket.send('/TTT', {}, JSON.stringify({roomid: 'message', id: 124, msg: msg}));
        else
            socket.send(msg);
    });
});

var socket = null;
var isStomp = false;

function connectStomp() {
	var sock = new SockJS("/stompTest"); // endpoint
    var client = Stomp.over(sock);
	isStomp = true;
	socket = client;
    
    client.connect({}, function () {
        console.log("Connected stompTest!");
        // Controller's MessageMapping, header, message(자유형식)
        client.send('/TTT', {}, "msg: Haha~~~");

        // 해당 토픽을 구독한다!
        client.subscribe('/topic/message', function (event) {
            console.log("!!!!!!!!!!!!event>>", event)
        });
    });

}

function connectSockJS() {
	console.log("eeeeeeeeeeeeeeeeeeeee")
	var sock = new SockJS("/replyEcho"); 
	socket = sock;
    sock.onopen = function () {
        console.log('Info: connection opened.');
        sock.send("hi~");
        
        sock.onmessage = function (event) {
            console.log("ReceivedMessage:", event.data);
        };
        sock.onclose = function (event) {
            console.log('Info: connection closed.');
        };
    };
}

// pure web-socket
function connectWS() {
    console.log("tttttttttttttt")
    var ws = new WebSocket("ws://localhost:9090/replyEcho");
    socket = ws;

    ws.onopen = function () {
        console.log('Info: connection opened.');
    };

    ws.onmessage = function (event) {
        console.log("ReceiveMessage:", event.data+'\n');
        /* let $socketAlert = $('div#socketAlert');
        $socketAlert.html(event.data);
        $socketAlert.css('display', 'block'); */
        
        /* setTimeout( function() {
            $socketAlert.css('display', 'none');
        }, 3000); */
    };

    ws.onclose = function (event) { 
        console.log('Info: connection closed.');
        //setTimeout( function(){ connect(); }, 1000); // retry connection!!
    };
    ws.onerror = function (err) { console.log('Error:', err); };
}
</script>
</body>
</html>