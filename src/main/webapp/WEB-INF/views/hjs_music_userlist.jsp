<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userlist</title>
<style>
table{
	border-collapse:collapse;
	margin: auto;
	width: 100%;	
}
table,td {
border: 1px solid lightgray;
max-width: 400px;
padding-left: 15px;
padding-right: 15px;
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
max-width: 400px;
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
<h1>회원리스트</h1>

<div class="list"><a href="/hjs_music_admin">관리자목록으로</a></div>
<br>
<table>

	<tr>
		<th>순번</th>
		<th>user_id</th>
		<th>id</th>
		<th>pw</th>
		<th>name</th>
		<th>email</th>
		<th>profile_img</th>
		<th>rank</th>
		<th>join_date</th>
	</tr>
<c:forEach var="userDTO" items="${list}">
	<tr>
		<td>${userDTO.rnum }</td>
		<td>${userDTO.user_id }</td>
		<td>${userDTO.id }</td>
		<td><img src="/img/hjs_music_rnum.png" style="width: 15px;height: 15px;"></td>
		<td>${userDTO.name }</td>
		<td>${userDTO.email }</td>
		<td>${userDTO.profile_img }</td>
		<td>${userDTO.rank }</td>
		<td>${userDTO.join_date }</td>
	</tr>
</c:forEach>

</table>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>