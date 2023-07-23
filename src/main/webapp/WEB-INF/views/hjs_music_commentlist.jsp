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
padding-left: 15px;
padding-right: 15px;
}
table{
	border-collapse:collapse;
	margin: auto;
	width: 85%;
}
h1 {
text-align: center;
}	
.list {
text-align: center;
}
th {
padding-top: 10px;
padding-bottom: 10px;
background-color: rgb(204, 179, 166);
color: rgb(241, 241, 241);
}
tr:hover {
background-color:#f3f3f5; 
}

</style>
</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<h1>댓글리스트</h1>

<div class="list"><a href="/hjs_music_admin">관리자목록으로</a></div>
<br>
<table>

	<tr>
		<th>순번</th>
		<th>track_id</th>
		<th>comment_id</th>
		<th>user_id</th>
		<th>comment_content</th>
		<th>comment_time</th>
		<th>parent_id</th>
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