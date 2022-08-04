<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link  rel="stylesheet" type="text/css" href="./css/Login.css">
<style type="text/css">	
</style>
<title>Insert title here</title>
</head>
<body>
<form action="#" class="form1">
    <img src="img/KakaoTalk_20220725_163759866.jpg" alt="logo" id="logoImg">
    <p id="title">간편로그인</p>
    <ul>
        <li><input type="text" id="loginID" placeholder="아이디" required="required"></li>
        <li><input type="password" id="loginPW" placeholder="비밀번호" required="required"></li>
        <li><input type="button" id="submitButton" onclick="location.href='/MAIN'" value="제출하기"></li>
        <li>
            <p id="memo">
            	<a href="/JOIN" id="Tojoin">회원가입</a><br>
                <span id="spanInus" onclick="location.href='/INUS'">INUS</span> Copyright @Inus Crop.<br> All Right Reserved
            </p>
        </li>
    </ul> 
</form>
</body>
</html>