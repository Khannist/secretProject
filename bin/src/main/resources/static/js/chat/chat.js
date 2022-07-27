var ws;

function wsOpen(){
	ws = new WebSocket("ws://" + location.host + "/chating");
	wsEvt();
}
	
function wsEvt() {
	ws.onopen = function(data){
		//소켓이 열리면 동작
	}
	
	ws.onmessage = function(data) {
		//메시지를 받으면 동작
		var msg = data.data;
		if(msg != null && msg.trim() != ''){
			var d = JSON.parse(msg); // 서버에서 JSON형태로 전달하기 떄문에 JSON.parse를 이용해 파싱
			if(d.type == "getId"){ // 파싱한 값이 getId 값이면 초기설정값이므로 추가한 태그에 값 세팅
				var si = d.sessionId != null ? d.sessionId : ""; // d.session이 null이 아니라면 그값 그대로 null이면 "" 로 초기화
				if(si != ''){
					$("#sessionId").val(si); 
				}
			}else if(d.type == "message"){ // type이 메시지인 경우 채팅이 발생한 경우
				if(d.sessionId == $("#sessionId").val()){
					$("#chating").append("<p class='me'>나 :" + d.msg + "</p>");	
				}else{
					$("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
				}
					
			}else{
				console.warn("unknown type!")
			}
		}
	}

	document.addEventListener("keypress", function(e){
		if(e.keyCode == 13){ //enter press
			send();
		}
	});
}

function chatName(){
	var userName = $("#userName").val();
	if(userName == null || userName.trim() == ""){
		alert("사용자 이름을 입력해주세요.");
		$("#userName").focus();
	}else{
		wsOpen();
		$("#yourName").hide();
		$("#yourMsg").show();
	}
}

function send() {
	var option ={
		type: "message",
		sessionId : $("#sessionId").val(),
		userName : $("#userName").val(),
		msg : $("#chatting").val()
	}
	ws.send(JSON.stringify(option))
	$('#chatting').val("");
}