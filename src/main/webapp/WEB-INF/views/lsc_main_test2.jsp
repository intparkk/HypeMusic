<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>Main test</title>
</head>
<body>
	<c:choose>
		<c:when test="${isLoggedIn ne 'ok' }">
			<a href="/login">로그인</a>
			<a href="/signup">회원가입</a>
		</c:when>
		<c:otherwise>
			<p>${dto.name }님 환영합니다</p>
			<a href="/logout">로그아웃</a>	
			<a href="/myInfo">내 정보</a>
		</c:otherwise>
	</c:choose>
	<p>id : ${dto.id }</p>
	<p>pw : ${dto.pw }</p>
	<p>rank : ${dto.rank}</p>
	<p>email : ${dto.email}</p>
	<p>user_id : ${dto.user_id}</p>
	<p>profile_img : <img src="${dto.profile_img }" style="width:64px; border-radius: 32px;"></p>
	<p>join date : ${dto.join_date }</p>
	
</body>
</html>