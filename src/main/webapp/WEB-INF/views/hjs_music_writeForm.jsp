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
<title>Insert title here</title>
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
<h3>답글</h3>
<form action="/write_comment" method="post">
<input type="hidden" name="track_id" value="${dto.track_id }">
<input type="hidden" name="user_id" value="${dto2.user_id }">
글내용:${dto2.comment_content}<br>
부모글:${dto2.comment_id}<input type="hidden" name="parent_id" value="${dto2.comment_id}"><br>
<!-- 작성자 : <input type="text" name="member_id"><br> -->
작성자 :${userInfo.user_id } <!-- <input type="text" name="user_id"><br> --><br>
답글 : <textarea class="text" name="comment_content"></textarea>
<input type="submit" value="저장하기">
</form>
<br><br>

<a href="/hjs_music_top100">목록으로</a><br><br>

</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>