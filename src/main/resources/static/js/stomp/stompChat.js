stompClient = null;


function connect() {
	var socket = new SockJS('/ws');
	
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame){
		console.log("Connected : " + frame);

		stompClient.subscribe('/topic/' + $("#channelCode").val() + '/' + $("#roomCode").val(), function(res) {
			console.log("출력 테스트중");
			console.log("res = " + res);
			console.log("res code = " + res.channelCode);
			console.log(JSON.parse(res.body));
			console.log("채널 출력 테스트중");
			console.log(JSON.parse(res.body).list.channelCode);
			createChat(JSON.parse(res.body));
		});
	});
	
	
	
}
function send(e) {
	console.log("e = " + JSON.stringify(e));
	if(e.keyCode == 13){
		if($("input#chatInput").val() == null || $("input#chatInput").val() == "") {
			console.log("빈값");
		}else {
			console.log("sending");
			var msg = {
				'name' : $("#name").val(),
				'userId' : $("#userId").val(),
				'roomCode' : $("#roomCode").val(),
				'channelCode' : $("#channelCode").val(),
				'chatData' : $("input#chatInput").val()
			};
			console.log("msg = " + msg);
			stompClient.send("/app/user", {}, JSON.stringify(msg));
			$("#chatInput").val("");
			
		}
		$("#chatInput").focus();
	}
}



function disconnect() {
	if(stompClient !== null) {
		stompClient.disconnect();
	}
}







