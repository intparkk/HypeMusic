<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>commentlist</title>
<style>
table,td {
border: 1px solid lightgray;
}
</style>
</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<h1>댓글리스트</h1>
<br>
<div><a href="/hjs_music_admin">관리자목록으로</a></div>
<br>
<table>

	<tr>
		<td>순번</td>
		<td>track_id</td>
		<td>comment_id</td>
		<td>user_id</td>
		<td>comment_content</td>
		<td>comment_time</td>
		<td>parent_id</td>
	</tr>
<c:forEach var="hjscommentDTO" items="${list}">
	<tr>
		<td>${hjscommentDTO.rnum }</td>
		<td>${hjscommentDTO.track_id }</td>
		<td>${hjscommentDTO.comment_id }</td>
		<td>${hjscommentDTO.user_id }</td>
		<td>${hjscommentDTO.comment_content }</td>
		<td>${hjscommentDTO.comment_time }</td>
		<td>${hjscommentDTO.parent_id }</td>
	</tr>
</c:forEach>

</table>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>