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
table,td {
border: 1px solid lightgray;
}

</style>
</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<h1>회원리스트</h1>
<table>

	<tr>
		<td>순번</td>
		<td>user_id</td>
		<td>id</td>
		<td>pw</td>
		<td>name</td>
		<td>email</td>
		<td>profile_img</td>
		<td>rank</td>
		<td>join_date</td>
	</tr>
<c:forEach var="userDTO" items="${list}">
	<tr>
		<td>${userDTO.rnum }</td>
		<td>${userDTO.user_id }</td>
		<td>${userDTO.id }</td>
		<td>${userDTO.pw }</td>
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