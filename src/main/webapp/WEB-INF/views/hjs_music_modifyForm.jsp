<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수정하기</title>
<style>
.text {
width: 500px;
height: 40px;
}
table,th,td{
border: 1px solid lightgray;
}

</style>
</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
${dto.track_id}<br>
<img src="${dto.album_img}" alt="album_img" style="width: 100px;height: 100px;"><br>
${dto.title }<br><br>
${dto.artist }<br><br>
${dto.lyrics }<br><br>
<h3>수정</h3>
<form action="/modify" method="post">
<input type="hidden" name="track_id" value="${dto.track_id }">
<input type="hidden" name="comment_id" value="${dto2.comment_id }">
글내용:${dto2.comment_content}<br>
부모글:${dto2.comment_id}<br>
<!-- 원본 -->
<%-- 작성자:${dto2.member_id}<br> --%>
작성자:${userInfo.user_id}<br>
글내용: <textarea class="text" name="comment_content">${dto2.comment_content}</textarea><br>
<input type="submit" value="수정하기">
</form>
<br><br>

<a href="/hjs_music_top100">목록으로</a><br><br>


</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>