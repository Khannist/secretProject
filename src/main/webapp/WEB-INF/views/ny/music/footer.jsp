<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.List"%>
<%-- <%@page import="dao.PlayerDAO"%>
<%@page import="bean.ReviewListbean"%>
<%@page import="basic.ThumbJsonParser"%> --%>
<%-- <%
	//기본요소
	//한글 꺠지지 않기 위해
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idkey");
	
	//플레이리스트 관련 요소
	//ThumbJsonParser thumb = new ThumbJsonParser();
	
	//플레이리스트 재생되면 playlist_member 에 추가
	//pDAO.setListenInfo(playlisturl, id, playlisttitle);
	
	//playerloadaction
		//플레이리스트 객체 생성
		String playlisturl = (String)session.getAttribute("playlisturl");
		String playlisttitle = (String)session.getAttribute("playlisttitle");
		
		String thumburl = null;
		String desc= null;
		String dataurl="https://www.googleapis.com/youtube/v3/playlists?id="+playlisturl
				+"&part=snippet&key=AIzaSyBLGX74Zs1Yx0xUG_miWKA5Pz0As9mkz0o";
		String dataurlitems = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=" + playlisturl
				+ "&part=snippet&key=AIzaSyBLGX74Zs1Yx0xUG_miWKA5Pz0As9mkz0o&maxResults=50";
		
		//제목영역 정보 받아오기.
		ThumbJsonParser thumbjsonparser = new ThumbJsonParser();
		
		try {
			thumburl = thumbjsonparser.getJson("https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl
					+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4");
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			desc = thumbjsonparser.getDesc("https://www.googleapis.com/youtube/v3/playlists?id=" + playlisturl
					+ "&part=snippet&key=AIzaSyAsVcJ5GPv9TsnxV_PGNQkRe368-2hujQ4");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String dataurl = (String)request.getAttribute("dataurl");
		String dataurlitems = (String)request.getAttribute("dataurlitems");
		
		String playlisturl = null;
		String playlisttitle = null;
		if(request.getAttribute("playlisturl") == null && request.getAttribute("playlisttitle") == null){//직접넘어온 url및 title없을경우
			playlisturl = (String)session.getAttribute("mostrecommendedurl");
			playlisttitle = (String)session.getAttribute("mostrecommendedtitle");
		}else{
			playlisturl = (String)request.getAttribute("playlisturl");
			playlisttitle = (String)request.getAttribute("playlisttitle");
		}
		String thumburl = (String)request.getAttribute("thumburl");
		String desc = (String)request.getAttribute("desc");
		int totalrating = (int)request.getAttribute("totalrating");

%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer부분</title>
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet"
	href="css/text.css" />
<link rel="stylesheet"
	href="css/portfolio_common.css" />
<link rel="stylesheet"
	href="css/portfolio_player_style.css" />
<link rel="stylesheet"
	href="css/portfolio_main.css" />
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">

</head>
<body>
	<!-- 곡 넘기기(왼쪽 중앙 오른쪽) -->
	<div id="footer">
		<div id="left-controller">
			<button onclick="prevsong();"><img src="css/imgs/next.png"></button>
			<button onclick="playsong();"><img id=play-image src="css/imgs/pause.png"></button>
			<button onclick="nextsong();"><img src="css/imgs/next.png"></button>
		</div>
		<div id="middle-controller">
			<img src="<%=thumburl%>">
			<p><%=playlisttitle %></p>
		</div>
	    <div id="right-controller">
		   <button onclick="shuffle();"><img src="css/imgs/shuffle.png"></button>
		   <button onclick="mutesong();"><img id=volume-image src="css/imgs/volume.png"></button>
		   <button onclick="playerOpen()"><img src="css/imgs/expand.png"></button>
	    </div>
    </div>
    <script src="script/star.js" charset="utf-8"></script>
    <script>
    </script>
</body>
</html>