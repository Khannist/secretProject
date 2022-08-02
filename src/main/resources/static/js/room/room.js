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
	$("#addViewRoom").click(function(){
		var con = document.getElementById("inputNameSpace");
		con.style.display = (con.style.display != 'none') ? "none" : "inline-block";
		
	});
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
	connect();
	
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
}

function createChat(res) {
	if(res != null){
		//console.log("res = " + JSON.stringify(res));
		console.log("res.list = " + res.list);
		console.log("res[0] = " + res[0]);
		console.log("res.list[0].userId = " + res.list[0].userId);
		console.log("res.length = " + res.list[0].roomCode);
		var tag = "";
		if(res.list.length >= 1) {
			$("#roomCode").val(res.list[0].roomCode);
		}
		res.list.forEach(function(d, idx){
			console.log("d.roomCode = " + d.roomCode);
			if(d.userId == $("#userId")){
				tag +=  "<p class='me'>나 :" + d.chatData + "</p>";
			}else {
				tag += "<p class='others'>" + d.name + " :" + d.chatData + "</p>";
			}
		});
		$("#chating").empty().append(tag);
	}
}

function createChatingRoom(res){
	if(res != null){
		var tag = "";
		if(res.list.length >= 1) {
			$("#roomCode").val(res.list[0].roomCode);
		}
		res.list.forEach(function(d, idx){
			var rn = d.roomName;
			tag += "<li onclick='goRoom(\""+d.channelCode+"\",\""+d.userId+"\",\""+d.roomCode+"\")'" + 
			"id='connect' name='connect'>"+
						"<p class='go' value='"+d.roomCode+"'>"+
							rn +
						"</p>"+
					"</li>";
		});
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