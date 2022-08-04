<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>내 사이트임 ㅎㅇ</h1>
    <p id="page"></p>
    <img alt="" src="" id="ppp">
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" 
        crossorigin="anonymous">
    <!-- <script>
        $.ajax({
            method: "GET",
            url: "https://www.googleapis.com/youtube/v3/videos",
            data: { part: "snippet",
            	chart :"mostPopular",
            	
            	maxResults:"10", 
            	key :"AIzaSyBLGX74Zs1Yx0xUG_miWKA5Pz0As9mkz0o"}
        })
            .done(function (msg) {
                console.log(msg);
                console.log(msg.items[0].snippet.title);
                console.log(msg.items[0].snippet.thumbnails.default.url);
                alert("Data Saved: " + msg);
                $( "#page" ).append( "<strong>"+msg.items[0].snippet.title+"</strong>" );
                $( "#ppp" ).append( "<img src='"+msg.items[0].snippet.thumbnails.default.url+"'/>" );
            });
    </script> -->
    <!-- ------------------------------------- -->
    <h1>여기서부터</h1>
    <input type="button" value="Login"  id="LoginChapter" onclick="showLogin()">
    <input type="button" value="JoinUs" id="JoinChapter" onclick="showJoinUS()">

    <div onclick="showLogin()" style="border: 1px solid black;">
        <p> skdsufdfdfdfd</p>
    </div>
    <img src="musicPlay.png" class="KeyImg" id="top100Img_1" onclick="showLogin()">
    <img src="img/koreaMVTOP100.png" class="KeyImg" id="top100Img_1" onclick="showJoinUS()">

    <form action="#" class="form1">  
        <iframe 
            width="560"
            height="315" 
            src="https://www.youtube.com/embed/videoseries?list=PLX_q1hyeET2TQLU4PzpVoSVYxsUnhzKaW&feature=share" 
            frameborder="0" 
            allow="autoplay; encrypted-media" 
            allowfullscreen
            ></iframe>
    </form>
    <form class="form2" style="display: none;">
        <iframe 
			width="560" 
			height="315"  
			src="https://www.youtube.com/embed/videoseries?list=PLX_q1hyeET2Tbwcw6_aMvbCgv4HRtsaOh&feature=share" 
			frameborder="0" 
			allow="autoplay; encrypted-media" 
			allowfullscreen
			></iframe>
    </form>


<!-- ========================================================================= -->






<script>
//없어지는 거 꼭 해줘야함, 안해주면 안없어지고 옆에 있음
        function showLogin(){
            document.querySelector('.form1').style.display = "block";	// 로그인폼 부분을 화면에 표시
            document.querySelector('.form2').style.display = "none";    // 로그인폼 부분을 화면에서 감춤
        }
        function showJoinUS(){
            document.querySelector('.form2').style.display = "block";   // 회원가입폼 부분을 화면에 표시
            document.querySelector('.form1').style.display = "none";    // 회원가입폼 부분을 화면에서 감춤
        }
    </script>
</body>
</html>