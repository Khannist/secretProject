<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="text" id="input01">
<input type="text" id="input02">
<input type="submit" id="input03">
<script type="text/javascript">


function getYouTube() {
    $.ajax({
         type : "GET",
         dataType : "JSON",
         url : "https://www.googleapis.com/youtube/v3/search?channelId=UCpEIT1Do8qfsQ0IhhmkaGhA&part=snippet&maxResults=6&key=AIzaSyBLGX74Zs1Yx0xUG_miWKA5Pz0As9mkz0o",
         contentType : "application/json",
         success : function(jsonData) {
             for (var i = 0; i < jsonData.items.length; i++) {
                 var items = jsonData.items[i];
                 console.log(items);
             }
         },
         complete : function(data) {

         },
         error : function(xhr, status, error) {
             console.log("유튜브 요청 에러: "+error);
         }
    });
}
</script>


</body>
</html>