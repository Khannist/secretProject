/**
 * 
 */
 var ws;
window.onload = function() {
	getChannel();
	createServer();
}

function getChannel(){
	var msg = { userId : $('#userId').val()	};
	commonAjax('/getChannel', msg , 'post', function(result){
		createChatingChannel(result);
	});
}
function enterkey() {
	if (window.event.keyCode == 13) {
    	// 엔터키가 눌렸을 때
    	var con = document.getElementById("channelNameInput");
    	if(con.style.display == 'inline-block')
    		channelCreateName();
    }
}
function createServer(){
	$("#addChannel").click(function(){
		var con = document.getElementById("channelNameInput");
        con.style.display = (con.style.display != 'none') ? "none" : "inline-block";
	});
}
		
function channelCreateName(){
	var msg = {
		channelName : $('input#channelName').val(),
		userId : $('#userId').val()
	};
	commonAjax('/createChannel', msg, 'post', function(result){
		createChatingChannel(result);
	});
	$("div#addChannel").click();
	$("div#addChannel").click();
	$("input#channelName").val("");
}
		


function goChannel(code, name, id){
	$("#roomList").empty();
	var msg = {
		channelCode : code,
		channelName : name,
		userId : id
	}
	
	//location.href="/moveRoom?channelName="+name+"&"+"channelCode="+code+"&userId="+id;
	
	$("#channelCode").val(code);
	
	commonAjax('/moveRoom', msg, 'post', function(result){
		getRoom(result);
	});
	
}

function createChatingChannel(res){
	if(res != null){
		var tag = "";
		res.list.forEach(function(d, idx){
			var cn = d.channelName;
			tag += "<li onclick='goChannel(\""+d.channelCode+"\", \""+cn+"\",\""+d.userId+"\")'>"+
						"<p type='hidden' value='"+d.channelCode+"'>"+
							"<img src='' alt='' id='channelName' name='channelName'>"+ cn + "</img>" + 
						"</p>" +
					"</li>";	
		});
		$("#channelSpace").empty().append(tag);
	}
}

function commonAjax(url, parameter, type, calbak, contentType){
	$.ajax({
		url: url,
		data: parameter,
		type: type,
		contentType :'application/x-www-form-urlencoded; charset=UTF-8',
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