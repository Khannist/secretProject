/**
 * 
 */
 var ws;
window.onload = function(){
	getRoom();
	createRoom();
}

function getRoom(res){
	console.log("res.channelCode = " + res.channelCode);
	var msg = { 
		
		userId : $('#userId').val(),
		channelCode : res.channelCode
			};
	commonAjax('/getRoom', msg , 'post', function(result){
		createChatingRoom(result);
	});
}

function enterKey() {
	console.log("엔터입력");
	if (window.event.keyCode == 13) {
    	// 엔터키가 눌렸을 때
    	console.log("눌린 엔터");
    	var con = document.getElementById("inputNameSpace");
    	if(con.style.display == 'inline-block'){
    		console.log("반응없는곳 찾기");
    		createRoomName();
			console.log("반응이있나?");
		}
    	
    		
    }
}

function createRoom(){
	console.log("1번");
	$("#addViewRoom").click(function(){
		console.log("2번");
		var con = document.getElementById("inputNameSpace");
		console.log("3번");
		con.style.display = (con.style.display != 'none') ? "none" : "inline-block";
		console.log("4번");
		
	});
}


function createRoomName() {
	var msg = {
			channelCode : $('#channelCode').val(),	
			roomName : $('input#roomName').val(),
			userId : $('#userId').val()	
			};
		console.log("msg = " +JSON.stringify(msg));
		commonAjax('/createRoom', msg, 'post', function(result){
			createChatingRoom(result);
		});

		$("input#roomName").val("");
}


function goRoom(code, name){
	location.href="/moveChating?roomName="+name+"&"+"roomCode="+code;
}

function createChatingRoom(res){
	if(res != null){
		console.log("res = " + JSON.stringify(res));
		console.log("res.list = " + res.list);
		console.log("res[0] = " + res[0]);
		console.log("res.list[0].userId = " + res.list[0].userId);
		var tag = "";
		res.list.forEach(function(d, idx){
			var rn = d.roomName;
			console.log("d.roomCode = " + d.roomCode);
			tag += "<li>"+
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