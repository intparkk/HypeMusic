<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자권한연습</title>
<style>

table {
	margin: auto;
}

 #trackpage_button {
            padding: 10px 20px;
            background-color: rgb(204, 179, 166);
			color: rgb(241, 241, 241);
            border: none;
            cursor: pointer;
            width: 390px;
        }
 #list-button {
 			padding: 0;
            background-color: rgb(204, 179, 166);
			color: rgb(241, 241, 241);
            border: none;
            cursor: pointer;
            width: 390px;
            text-decoration: none;
 } 
 
 td {
 font-weight: bold;
 font-size: 20px;
 color: gray;
 max-width: 300px;
 }      
 h1 {
 margin: auto;
 background-color: rgb(204, 179, 166);
 color: rgb(241, 241, 241);
 font-weight: bold;
 padding: 0 px;
 display: inline-bolck;
 margin: 0 px;
 width: 380px;
 text-align: center;
 } 
 
input[type="text"] {
            width: 250px; /* 원하는 가로 크기로 지정 */
            height: 22px; /* 원하는 세로 크기로 지정 */
        	border: 2px solid lightgray;
        }
        
#preference {
width: 257px;
height: 27px;
border: 2px solid lightgray;
color: gray;
}    

#admin_button {
margin: 0 auto;
}    
</style>

</head>
<header>
<jsp:include page="header.jsp"></jsp:include>
</header>
<body>
<br>
<h1>곡정보등록</h1>
<br>
<table>
<form action="/hjs_music_admininsert" method="post">
        <tr>
            <td>track_id:</td>
            <td><input type="text" name="track_id" required></td>
        </tr>
        <tr>
            <td>artist_id:</td>
            <td><input type="text" name="artist_id" required></td>
        </tr>
        <tr>
            <td>album_img:</td>
            <td><input type="text" name="album_img" required></td>
        </tr>
        <tr>
            <td>title:</td>
            <td><input type="text" name="title" required></td>
        </tr>
        <tr>
            <td>artist:</td>
            <td><input type="text" name="artist" required></td>
        </tr>
        <tr>
            <td>album_name:</td>
            <td><input type="text" name="album_name" required></td>
        </tr>
        <tr>
            <td>like_count:</td>
            <td><input type="text" name="like_count" required></td>
        </tr>
        <tr>
            <td>preference:</td>
            <td>
           
 				<select id="preference" name="genre">
    				<option value="">장르를 선택해주세요</option>
    				<option value="발라드">발라드</option>
    				<option value="드라마">드라마OST</option>
    				<option value="영화">영화OST</option>
    				<option value="댄스">댄스</option>
    				<option value="POP">팝</option>
    				<option value="포크">포크</option>
    				<option value="Soul">알앤비&소울</option>
    				<option value="재즈">재즈</option>
    				<option value="메탈">메탈</option>
					<option value="NewAge">뉴에이지</option>
    				<option value="인디">인디</option>
 				</select>
 			
 			</td>
        </tr>
        <tr>
            <td>release_date:</td>
            <td><input type="text" name="release_date" required></td>
        </tr>
        <tr>
            <td>lyrics:</td>
            <td><input type="text" name="lyrics" required></td>
        </tr>
        <tr>
            <td></td>
            <td>&nbsp</td>
        </tr>
         <tr>
            <td colspan="2"><button id ="trackpage_button" type="submit">등록하기</button></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td>&nbsp</td>
        </tr>
        <tr >
            <td colspan="2">
            
            <div id="list-button">
    		
        <button id ="trackpage_button" onclick="location.href='/hjs_music_viewtest?track_id=${musicDto2.track_id }'" class="list-button">추가곡확인</button>
    		
			</div>
            </td>
           
        </tr>
         
</form>
</table>
<br>
<div style="text-align:center">
<a href="/hjs_music_admin" id="admin_button">관리자목록으로</a></div>	


<br><br><br><br>


</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>