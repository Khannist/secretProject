stompClient = null;


function connect() {
	var socket = new SockJS('/ws');
	
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame){
		console.log("Connected : " + frame);
		stompClient.subscribe('/topic/ws', function(res) {
			console.log("res = " + res);
			console.log(JSON.parse(res.body));
		});
		stompClient.subscribe('/topic/a', function(res) {
			console.log("res = " + res);
			console.log(JSON.parse(res.body));
		});
	});
	
	
	
}
function send(e) {
	console.log("e = " + JSON.stringify(e));
	if(e.keyCode == 13){
		console.log("sending");
		var msg = {
			'name' : $("#name").val(),
			'userId' : $("#userId").val(),
			'roomCode' : $("#roomCode").val(),
			'channelCode' : $("#channelCode").val(),
			'chatData' : $("#chatInput").val()
		};
		stompClient.send("/app/user", {}, JSON.stringify(msg));
		$("#chatInput").val("");
	}
}











