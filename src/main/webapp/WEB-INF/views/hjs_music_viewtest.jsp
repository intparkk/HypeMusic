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
	width: 85%;
}
table,th, td{
	border: 1px solid lightgray;
}
th {
background-color: #E4E4E4;
}
tr:hover {
background-color:#f3f3f5; 
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
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<div style="text-align:right; padding-right:260px;"><a href="/hjs_music_admintest">곡추가</a></div><br>
<div style="text-align:right; padding-right:260px;"><a href="/hjs_music_admin">관리자목록으로</a></div><br>
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
	</tr>
</c:forEach>
	
</table>
<br><br><br>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>