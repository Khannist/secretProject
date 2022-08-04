/**
 * 
 */
 var ws;
var numTrigger;
window.onload = function(){
	getRoom();
	createRoom();
}

function getRoom(res){
	var msg = { 
		userId : $('#userId').val(),
		channelCode : res.channelCode
	};
	if($("#roomCode").val() != null || $("#roomCode").val() != "") {
		"roomCode = " + $("#roomCode").val("");
	}
	console.log("roomNumber = " + JSON.stringify(res));
	if(res.roomNumber == 1) {
		numTrigger = 1;
		console.log("트리거 on");
	}
	console.log("roomCode = " + $("#roomCode").val() );
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
	var roomName;
	if($('input#roomName').val() == null || $('input#roomName').val() == "") roomName = "main";
	else roomName = $('input#roomName').val(); 
	
	console.log("roomName = " + roomName);
	
	var msg = {
			channelCode : $('#channelCode').val(),	
			roomName : roomName ,
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
	var msg = {
		channelCode : code,
		userId : id,
		roomCode : room
	}
	
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
	$("#chatRealInput").empty();
}

function createChat(res) {
	if(res != null){
		//console.log("res = " + JSON.stringify(res));
		var tag = "";
		if(res.list) {
			if(res.list.length >= 0) {
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
		}
		$("#chating").append(tag);
		let chat = document.querySelector('#chating');
        chat.scrollTop = chat.scrollHeight;		
	}
}

function createChatingRoom(res){
	if(res != null){
		var tag = "";
		if(res.list){
			if(res.list.length >= 1) {
				$("#roomCode").val(res.list[0].roomCode);
				console.log("abc = " + res.list[0].channelName);
				$("#ChatName").innerText = (res.list[0].channelName);
				res.list.forEach(function(d, idx){
					var rn = d.roomName;
					tag += "<li onclick='goRoom(\""+d.channelCode+"\",\""+d.userId+"\",\""+d.roomCode+"\")'" + 
					"id='connect' name='connect'>"+
								"<img src='https://source.unsplash.com/random'>"+
								"<p class='go' value='"+d.roomCode+"'>"+
									rn +
								"</p>"+
								"<span class='roomdel' name='roomdel' value='"+d.roomCode+"' onclick='delRoom()'>X</span>" + 
							"</li>";
				});
			}			
		}
		$("#roomList").empty().append(tag);
		if(numTrigger == 1) {
			goRoom($("#channelCode").val(), $("#userId").val(), $("#roomCode").val());
			numTrigger = 0;
		}
	}
}

function checkRoom(res) {
	if(res.list) {
		var num = res.list.length - 1;
		var msg = {
			userId : res.list[num].userId,
			channelCode : res.list[num].channelCode
		}
		console.log("룸코드 생성");
		console.log("msg = " + msg);
		$.ajax({
			url: "/checkRoom",
			data: msg,
			type: "POST",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (res) {
				res = JSON.parse(res);
				console.log("res msg = " + res.msg);
				if(res.msg == "yes") {
					createRoomName();
				}
				
			}
		});
			
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