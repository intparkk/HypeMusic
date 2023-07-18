<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>아이디 찾기</h1>
	<form action="/hjs_find_id" method="POST">
	이메일 입력 : <input type="text" name="email"><br>
	<input type="submit" value="입력">
	</form>
	<br><br>
	
	<p>${message}</p>
	<p>당신의 아이디는 ${id }입니다.	</p>

</body>
</html>