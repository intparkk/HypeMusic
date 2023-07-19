<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table{
	border-collapse:collapse;
	margin: auto;
}
table,th, td{
	border: 1px solid lightgray;
	
/* 	border-bottom: 1px solid lightgray;
	border-top: 1px solid lightgray; */
}
h1, h2{
text-align: center;
}
.delete {
color: red;
font-weight: bold;
}
.delete:hover {
color: #FFA7A7;
}
</Style>

</head>
<header>
<jsp:include page="hjs_music_header2.jsp"></jsp:include> 
</header>
<body>
<table>

	<tr>
		<th>♡</th>
		<th>track_id</th>
		<th>artist_id</th>
		<th>album_img</th>
		<th>title</th>
		<th>artist</th>
		<th>album_name</th>
		<th>like_count</th>
		<th>genre</th>
		<th>release_date</th>
		<th>lyrics</th>
		<th>곡삭제</th>
	</tr>
<c:forEach var="dto" items="${list}" begin="0" end="200" varStatus="loop">
	<tr>
		<td>${loop.index + 1}</td>
		<td>${dto.track_id }</td>
		<td>${dto.artist_id }</td>
		<td><img src="${dto.album_img}" alt="album_image" style="width: 100px;height: 100px;"></td>
		<td>${dto.title }</td>
		<td>${dto.artist }</td>
		<td>${dto.album_name }</td>
		<td>${dto.like_count }</td>
		<td>${dto.genre }</td>
		<td>${dto.release_date }</td>
		<td>${dto.lyrics }</td>
		<td><a href="/admin_delete?track_id=${dto.track_id }" class="delete">곡삭제</a></td>
		
<!-- <a href="/delete?track_id=${trackInfo[0].track_id }&comment_id=${dto2.comment_id }">삭제</a> -->		
	</tr>
</c:forEach>
	
</table>
<br><br><br>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>