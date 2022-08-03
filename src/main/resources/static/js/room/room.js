/**
 * 
 */
 var ws;
window.onload = function(){
	getRoom();
	createRoom();
	goRoom(
		$("#channelCode"),
		$("#userId"),
		$("#roomCode")
	);
}

function getRoom(res){
	var msg = { 
		
		userId : $('#userId').val(),
		channelCode : res.channelCode
			};
	commonAjax('/getRoom', msg , 'post', function(result){
		createChatingRoom(result);
	});
}

function createRoom(){
	var con = document.getElementById("inputNameSpace");
	con.style.display = (con.style.display != 'none') ? "none" : "inline-block";
	// $("#addViewRoom").click(function(){});
}


function createRoomName() {
	var msg = {
			channelCode : $('#channelCode').val(),	
			roomName : $('input#roomName').val(),
			userId : $('#userId').val()	
			};
		commonAjax('/createRoom', msg, 'post', function(result){
			createChatingRoom(result);
		});
	var con = document.getElementById("inputNameSpace");
	con.style.display = "none";
	$("input#roomName").val("");
}


function goRoom(code, id, room){
	//location.href="/moveChating?roomName="+name+"&"+"roomCode="+code;
	$("#roomCode").val(room);
	$("#chating").empty();
	console.log("goRoom");
	console.log("channelCode = " + code);
	console.log("userId = " + id);
	console.log("roomCode = " + room);
	var msg = {
		channelCode : code,
		userId : id,
		roomCode : room
	}
	
	console.log("msg = " + JSON.stringify(msg));
	
	commonAjax('/moveChating', msg , 'post', function(result){
		getChat(result);
	});
	disconnect();
	connect();
	$("#chatInput").focus();
	
}

function getChat(res) {
	console.log("getChat.res = " + JSON.stringify(res));
	var msg = { 
		name : $("#name").val(),
		userId : $('#userId').val(),
		channelCode : res.channelCode,
		roomCode : res.roomCode
			};
	commonAjax('/getChat', msg , 'post', function(result){
		createChat(result);
	});
	$("#chating").empty();
}

function createChat(res) {
	if(res != null){
		//console.log("res = " + JSON.stringify(res));
		console.log("반복 출력 테스트");
		var tag = "";
		if(res.list.length >= 1) {
			res.list.forEach(function(d, idx){
				console.log("d.roomCode = " + d.roomCode);
				if(d.userId == $("#userId").val()){
					tag +=  "<p class='me'>나 :" + d.chatData + "</p>";
				}else {
					tag += "<p class='others'>" + d.name + " :" + d.chatData + "</p>";
				}
			});			
		}else {
			console.log("길이가 0 인 리스트");
			var d = res.list;
			if(d.userId == $("#userId").val()){
				tag +=  "<p class='me'>나 :" + d.chatData + "</p>";
			}else {
				tag += "<p class='others'>" + d.name + " :" + d.chatData + "</p>";
			}
		}
		$("#chating").append(tag);
		let chat = document.querySelector('#chating');
        chat.scrollTop = chat.scrollHeight;		
	}
}

function createChatingRoom(res){
	if(res != null){
		var tag = "";
		if(res.list.length >= 1) {
			$("#roomCode").val(res.list[0].roomCode);
			res.list.forEach(function(d, idx){
				var rn = d.roomName;
				tag += "<li onclick='goRoom(\""+d.channelCode+"\",\""+d.userId+"\",\""+d.roomCode+"\")'" + 
				"id='connect' name='connect'>"+
							"<p class='go' value='"+d.roomCode+"'>"+
								rn +
							"</p>"+
							"<span class='roomdel' name='roomdel'>X</span>" + 
						"</li>";
			});
		}
		$("#roomList").empty().append(tag);
	}
}


function commonAjax(url, parameter, type, calbak, contentType){
	$.ajax({
		url: url,
		data: parameter,
		type: type,
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		success: function (res) {
			res = JSON.parse(res);
			calbak(res);
		},
		error : function(err){
			console.log('error');
			calbak(err);
		}
	});
}