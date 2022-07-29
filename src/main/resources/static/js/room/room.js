/**
 * 
 */
 var ws;
window.onload = function(){
	getRoom();
	createRoom();
}

function getRoom(){
	var msg = { userId : $('#userId').val()	};
	commonAjax('/getRoom', msg , 'post', function(result){
		createChatingRoom(result);
	});
}

function createRoom(){
	$("#createRoom").click(function(){
		var msg = {	
			roomName : $('#roomName').val(),
			userId : $('#userId').val()	
			};

		commonAjax('/createRoom', msg, 'post', function(result){
			createChatingRoom(result);
		});

		$("#roomName").val("");
	});
}

function goRoom(code, name){
	location.href="/moveChating?roomName="+name+"&"+"roomCode="+code;
}

function createChatingRoom(res){
	if(res != null){
		var tag = "<tr><th class='num'>순서</th><th class='room'>방 이름</th><th class='go'></th></tr>";
		res.forEach(function(d, idx){
			var rn = d.roomName.trim();
			console.log("d.roomCode = " + d.roomCode);
			tag += "<li>"+
						"<p class='go' value='"+d.roomCode+"'>"+
							"<a onclick='goRoom(\""+d.roomCode+"\", \""+rn+"\">" + rn + "</a>" +
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
		contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
		success: function (res) {
			calbak(res);
		},
		error : function(err){
			console.log('error');
			calbak(err);
		}
	});
}