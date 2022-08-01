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

function enterKey() {
	if (window.event.keyCode == 13) {
    	// 엔터키가 눌렸을 때
    	var con = document.getElementById("inputNameSpace");
    	if(con.style.display == 'inline-block'){
    		createRoomName();
		}
    	
    		
    }
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

		$("div#addViewRoom").click();
		$("div#addViewRoom").click();
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
	
}

function createChatingRoom(res){
	if(res != null){
		var tag = "";
		if(res.list.length >= 1) {
			$("#roomCode").val(res.list[0].roomCode);
		}
		res.list.forEach(function(d, idx){
			var rn = d.roomName;
			tag += "<li onclick='goRoom(\""+d.channelCode+"\",\""+d.userId+"\",\""+d.roomCode+"\")'>"+
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