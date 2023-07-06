<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main test</title>
</head>
<body>
	<a href="/login">로그인</a>
	<a href="/signup">회원가입</a>
	<a href="/logout">로그아웃</a>
	<p>id : ${dto.id }</p>
	<p>pw : ${dto.pw }</p>
	<p>rank : ${dto.rank}</p>
	<p>email : ${dto.email}</p>
	<p>user_id : ${dto.user_id}</p>
	<p>profile_img : ${dto.profile_img }</p>
	<p>join date : ${dto.join_date }</p>
	
</body>
</html>