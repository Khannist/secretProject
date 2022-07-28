/**
 * 
 */
 var ws;
window.onload = function() {
	console.log("로딩");
	getChannel();
	console.log("겟채널로딩");
	createServer();
	console.log("크리에이트서버 로딩");
}

function getChannel(){
	var msg = { userId : $('#userId').val()	};
	console.log("문제점 찾기");
	commonAjax('/getChannel', msg , 'post', function(result){
		createChatingChannel(result);
	});
}

function createServer(){
	$("#addChannel").click(function(){
		 var con = document.getElementById("channelNameInput");
        con.style.display = (con.style.display != 'none') ? "none" : "block";
	});
}
		
function channelCreateName(){
	$("#channelCreate").click(function(){
		console.log("채널생성 준비");
		var msg = {
			channelName : $('#channelName').val(),
			userId : $('#userId').val()
		};
		console.log("채널 생성 msg = " + msg);
		commonAjax('/createChannel', msg, 'post', function(result){
			createChatingChannel(result);
		});
		console.log("여긴가?");
		$("#channelName").val("");
		createServer().click;
	});
}
		


function goChannel(code, name){
	//location.href="/moveChannel?channelName="+name+"&"+"channelCode="+code;
}

function createChatingChannel(res){
	console.log("res = " + res);
	console.log(Object.keys(res).length);
	console.log("Object.keys(res) = " + Object.keys(res));
	console.log(res.list);
	console.log(res.list[0].channelCode);
	if(res != null){
		var tag = "";
		res.list.forEach(function(d, idx){
			var cn = d.channelName;
			console.log("d.channelCode = " + d.channelCode);
			tag += "<div onclick='goChannel(\""+d.channelCode+"\", \""+cn+"\")'>"+
						"<input type='hidden' value='"+d.channelCode+"'>"+
						"<span id='channelName' name='channelName' value='cn'>"+
					"</div>";	
		});
		$("#channelSpace").empty().append(tag);
	}
}

function commonAjax(url, parameter, type, calbak, contentType){
	$.ajax({
		url: url,
		data: parameter,
		type: type,
		contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
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