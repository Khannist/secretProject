<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link  rel="stylesheet" type="text/css" href="./css/ny/ServerPageCss.css">
<link href="js/music.js">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<link  rel="stylesheet" type="text/css" href="/css/room/room.css">
<title>Insert title here</title>
</head>
<body>
	<div class="container"> 
		<input type="hidden" name="userId" id="userId" value="${mVo.userId}">
		<input type="hidden" name="name" id="name" value="${mVo.name}">
		<input type="hidden" name="channelCode" id="channelCode">
		<input type="hidden" name="roomCode" id="roomCode">
        <header>
            <a href="/MAIN" id="Logo">
            	<img id="logo" src="img/icon/letter-m.png">
            </a>
        </header>

        <div class="Lbar">
			<jsp:include page="ServerLbar.jsp"></jsp:include>
        </div>

        <script type="text/javascript">
        // 친구리스트 열기
	        function FList(){
	            document.querySelector('.FriendList').style.display = "block";	
	            document.querySelector('.ChatList').style.display = "none";   
	
	        }
	     // 채팅리스트 열기
	        function CList(){
	            document.querySelector('.ChatList').style.display = "block"; 
	            document.querySelector('.FriendList').style.display = "none";   
	
	        }
        </script>
        
        <div class="Midbar">
        
        	<!--.ChatPage 여기에 채팅 jsp 넣으면 된담 -->
        	<div class="ChatPage">
        		<!-- 뮤직페이지 열고 닫는 아이콘 -->
        		<img src="img/icon/gogoIcon.png" class="pageIcon" id="OpenMusic" onclick="FMusicPage()">
        		<img src="img/icon/closeMusicIcon.png" class="pageIcon" id="CloseMusic" onclick="FC_MusicPage()">
        		<div>
        		
        		</div>
        		
        		<jsp:include page="../chat/chat.jsp"></jsp:include>
        		<div class="ChatInput">
	        		<input id="chatRealInput" type="text" placeholder="채팅" onkeydown="send(event)">
	        		<img src="img/icon/chatIcon/ghostIcon.png">
	        		<img src="img/icon/chatIcon/smilIecon.png">
        		</div>
        		<div class="ChatSubmit" onclick="sendChatSc()">
        			<input id="chatRealsubmit" type="button" value="보내기">
        		</div>
        		
        		
        		
        	</div>
        	
            <div class="MusicPage">
	            <img class="ToIMG" src="img/icon/ToSearch.png" onclick="F_ToSearch()">
	
	
	
				<!-- iframe 부분 -->		
				<div class="IframePart">
					<jsp:include page="MusicIframe.jsp"></jsp:include>
				</div>
		
				<!-- 추천 재생목록 -->
				<div class="RecommandPlayList">
					<jsp:include page="music.jsp"></jsp:include>
		        </div>
			</div>
			
			
			
			
			<div class="MusicSearch">
				
	            <jsp:include page="musicSearch.jsp"></jsp:include>
	        </div>
	        
	        
	        
		</div>
	</div>
 <script type="text/javascript" src="/js/event/event.js"></script>
 <script type="text/javascript" src="/js/room/room.js"></script>
 <script type="text/javascript" src="/js/room/roomdel.js"></script>
 <script type="text/javascript" src="/js/channel/channel.js"></script>
 <script type="text/javascript" src="/js/stomp/stompChat.js"></script>
<script type="text/javascript">



function F_ToSearch(){
    document.querySelector('.MusicSearch').style.display = "block";	// 메인채팅 부분을 화면에 표시
    document.querySelector('.MusicPage').style.display = "none";    // 일대일채팅 부분을 화면에서 감춤

}
function F_ToMusicList(){

    document.querySelector('.MusicPage ').style.display = "block";	// 메인채팅 부분을 화면에 표시
    document.querySelector('.MusicSearch').style.display = "none";    // 일대일채팅 부분을 화면에서 감춤

}






/*페이지 이동 JS*/
function showMainChatRoom(){
    document.querySelector('.MainChatRoom').style.display = "block";	// 메인채팅 부분을 화면에 표시
    document.querySelector('.OneToOneChatRoom').style.display = "none";    // 일대일채팅 부분을 화면에서 감춤
}
function showOneToOneChatRoom(){
    document.querySelector('.OneToOneChatRoom').style.display = "block";   // 일대일채팅 부분을 화면에 표시
    document.querySelector('.MainChatRoom').style.display = "none";    // 메인채팅 부분을 화면에서 감춤
}





//채팅 옆으로 밀고 뮤직 페이지 등장
function FMusicPage(){
	//document.querySelector('.OpenMusic').style.display = "none"; 
    document.querySelector('.MusicPage').style.display = "block";   
    //document.getElementById('.CloseMusic').style.display = "block";	//뮤직페이지 열리는 아이콘 누르면 닫히는 아이콘으로 바뀜
    document.querySelector('.ChatPage').style.width = "50%";    
}
//채팅 옆으로 밀고 뮤직 페이지 등장
function FC_MusicPage(){
	//document.querySelector('.CloseMusic').style.display = "none"; 
    document.querySelector('.MusicPage').style.display = "none";   
    //document.getElementById('.OpenMusic').style.display = "block";	//뮤직페이지 열리는 아이콘 누르면 닫히는 아이콘으로 바뀜
    document.querySelector('.ChatPage').style.width = "100%";    
}
//뮤직페이지 없애고 음악검색 페이지 생김
function FMusicSearch(){
    document.querySelector('.MusicSearch').style.display = "block";   
    document.querySelector('.MusicPage').style.display = "none";    
}
//음악 검색없애고 뮤직페이지 등장
function FMusicSearch(){
    document.querySelector('.MusicSearch').style.display = "block";   
    document.querySelector('.MusicPage').style.display = "none";    
}
/* function PageReconstruction(){
	 document.querySelector('.MainChatRoom').style.display = "block";
} */



/* 비디오 출력 부분 */


	/*top100*/
	function showVideo01(){
		document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.koreatop100_v').style.display = "block";	//화면에 표시
	       document.querySelector('.koreamvtop100_v').style.display = "none";    
	       document.querySelector('.globaltop100_v').style.display = "none"; 
	       document.querySelector('.globalmvtop100_v').style.display = "none"; 
	   }
	function showVideo02(){
		document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.koreamvtop100_v').style.display = "block";	//화면에 표시
	       document.querySelector('.koreatop100_v').style.display = "none";    
	       document.querySelector('.globaltop100_v').style.display = "none"; 
	       document.querySelector('.globalmvtop100_v').style.display = "none"; 
	   }
	function showVideo03(){
		document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.globaltop100_v').style.display = "block";	//화면에 표시
	       document.querySelector('.koreamvtop100_v').style.display = "none";    
	       document.querySelector('.koreatop100_v').style.display = "none"; 
	       document.querySelector('.globalmvtop100_v').style.display = "none"; 
	   }
	function showVideo04(){
		document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.globalmvtop100_v').style.display = "block";	//화면에 표시
	       document.querySelector('.koreamvtop100_v').style.display = "none";    
	       document.querySelector('.globaltop100_v').style.display = "none"; 
	       document.querySelector('.koreatop100_v').style.display = "none"; 
	   }

	
	
		/*hiphop _쿼리셀렉터*/
	
	function F_hiphopList_1(){
		   document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.IF_hiphopList_1').style.display = "block";	//화면에 표시

	   }
	function F_hiphopList_2(){
		   document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.IF_hiphopList_2').style.display = "block";	//화면에 표시

	   }
	function F_hiphopList_3(){
		   document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.IF_hiphopList_3').style.display = "block";	//화면에 표시

	   }
	function F_hiphopList_4(){
		   document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.IF_hiphopList_4').style.display = "block";	//화면에 표시

	   }
	function F_hiphopList_5(){
		   document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.IF_hiphopList_5').style.display = "block";	//화면에 표시

	   }
	function F_hiphopList_6(){
		  document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.IF_hiphopList_6').style.display = "block";	//화면에 표시

	   }
	function F_hiphopList_7(){
		document.querySelector('.firstvideo').style.display = "none"; //화면에서 감춤
	       document.querySelector('.IF_hiphopList_7').style.display = "block";	//화면에 표시

	   }
	
	
		


/*[keywordList]ul 나타나고 없애게 하는 스크립트*/

//힙합
	function F_hiphopList(){
		document.querySelector('.aloneloveList').style.display = "none"; 
        document.querySelector('.hiphopList').style.display = "block";	//화면에 표시
        document.querySelector('.PopArtistList').style.display = "none";
        document.querySelector('.RelaxList').style.display = "none";
        document.querySelector('.AniOSTList').style.display = "none";
        document.querySelector('.ExerciseList').style.display = "none";
        document.querySelector('.leaveworkList').style.display = "none";
    }
//짝사랑
	function F_aloneloveList(){ 
		document.querySelector('.hiphopList').style.display = "none"; 
        document.querySelector('.aloneloveList').style.display = "block";	//화면에 표시
        document.querySelector('.PopArtistList').style.display = "none";
        document.querySelector('.RelaxList').style.display = "none";
        document.querySelector('.AniOSTList').style.display = "none";
        document.querySelector('.ExerciseList').style.display = "none";
        document.querySelector('.leaveworkList').style.display = "none";
    }
//팝스타
	function F_PopArtistList(){
		document.querySelector('.hiphopList').style.display = "none"; 
        document.querySelector('.PopArtistList').style.display = "block";	//화면에 표시
        document.querySelector('.aloneloveList').style.display = "none";
        document.querySelector('.RelaxList').style.display = "none";
        document.querySelector('.AniOSTList').style.display = "none";
        document.querySelector('.ExerciseList').style.display = "none";
        document.querySelector('.leaveworkList').style.display = "none";
    }   
//편안한 F_hiphopList
	function F_Relax(){
		document.querySelector('.hiphopList').style.display = "none"; 
        document.querySelector('.RelaxList').style.display = "block";	//화면에 표시
        document.querySelector('.PopArtistList').style.display = "none";
        document.querySelector('.aloneloveList').style.display = "none";
        document.querySelector('.AniOSTList').style.display = "none";
        document.querySelector('.ExerciseList').style.display = "none";
        document.querySelector('.leaveworkList').style.display = "none";
    }
//애니
	function F_AniOST(){
		document.querySelector('.hiphopList').style.display = "none"; 
        document.querySelector('.AniOSTList').style.display = "block";	//화면에 표시
        document.querySelector('.PopArtistList').style.display = "none";
        document.querySelector('.RelaxList').style.display = "none";
        document.querySelector('.aloneloveList').style.display = "none";
        document.querySelector('.ExerciseList').style.display = "none";
        document.querySelector('.leaveworkList').style.display = "none";
    }
//운동
	function F_Exercise(){
		document.querySelector('.hiphopList').style.display = "none"; 
        document.querySelector('.ExerciseList').style.display = "block";	//화면에 표시
        document.querySelector('.PopArtistList').style.display = "none";
        document.querySelector('.RelaxList').style.display = "none";
        document.querySelector('.AniOSTList').style.display = "none";
        document.querySelector('.aloneloveList').style.display = "none";
        document.querySelector('.leaveworkList').style.display = "none";
    }
	
//퇴근
	function F_Leavework(){
		document.querySelector('.hiphopList').style.display = "none"; 
        document.querySelector('.leaveworkList').style.display = "block";	//화면에 표시
        document.querySelector('.PopArtistList').style.display = "none";
        document.querySelector('.RelaxList').style.display = "none";
        document.querySelector('.AniOSTList').style.display = "none";
        document.querySelector('.ExerciseList').style.display = "none";
        document.querySelector('.aloneloveList').style.display = "none";
    }
</script>
</body>
</html>