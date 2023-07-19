<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 권한모드</title>

<Style>

</Style>

</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
테스트용 페이지입니다. <br><br>
<div><a href="/hjs_music_userlist">회원리스트</a></div><br>
<div><a href="/hjs_music_commentlist">댓글리스트</a></div>


</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>