<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%> --%>
<%@page import="com.study.springboot.dto.UserDTO"%>
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
<h3>댓글달기</h3>
<form action="/write_comment" method="post">
<input type="hidden" name="track_id" value="${dto.track_id }">
글번호 : ${dto2.comment_id }<!-- <input type="text" name="comment_id"> --><br>
<!-- 원본 -->
<!-- 작성자 : <input type="text" name="member_id"><br> -->
<% 


%>

작성자 :${userInfo.user_id } <!-- <input type="text" name="user_id"><br> --><br>
댓글 : <textarea class="text" name="comment_content"></textarea>
<input type="submit" value="등록">
</form>
<br><br>
<table>
<thead>
	<tr>
		<th>글번호</th>
		<th>부모글</th>
		<th>작성자</th>
		<th>댓글</th>
		<th>작성시간</th>
		<th>답글</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
</thead>
<tbody>

	<c:forEach var="dto2" items="${list}">  
	 <tr>
		<td>${dto2.comment_id }</td>
		<td>${dto2.parent_id }</td>
	<%-- 	<td>${dto2.member_id }</td> --%>
		<td>${userInfo.user_id }</td>
		<td>${dto2.comment_content }</td>
		<td>${dto2.comment_time }</td>
		<td><a href="/reply?track_id=${dto.track_id }&comment_id=${dto2.comment_id }">답글</a></td>
		<td><a href="/modifyForm?track_id=${dto.track_id }&comment_id=${dto2.comment_id }">수정</a></td>
		<td><a href="/delete?track_id=${dto.track_id }&comment_id=${dto2.comment_id }">삭제</a></td>
	</tr> 
	</c:forEach>  
	
</tbody>

</table>
<br>
<%-- <a href="/modifyForm?id=${dto.track_id }">수정하기</a><br><br> --%>
<%-- <a href="/reply?track_id=${dto.track_id }">답글</a><br><br> --%>
<a href="/hjs_music_top100">목록으로</a><br><br>


</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>