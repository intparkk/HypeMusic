<%@page import="com.study.springboot.dto.HjsmusicDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> --%>
<%@ page import="java.util.List" %>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장르음악</title>
<style>
table,th,td {
border: 1px solid lightgray;
}

</style>
</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<h1>장르음악</h1>

<form id="genreForm" action="/hjs_music_genre">
 <select id="preference" name="preference" onchange="submitForm()">
    <option value="">장르를 선택해주세요</option>
    <option value="발라드">발라드</option>
    <option value="드라마">드라마OST</option>
    <option value="영화">영화OST</option>
    <option value="댄스">댄스</option>
    <option value="POP">팝</option>
    <option value="포크">포크</option>
    <option value="Soul">알앤비&소울</option>
    <option value="재즈">재즈</option>
    <option value="메탈">메탈</option>
	<option value="NewAge">뉴에이지</option>
    <option value="인디">인디</option>
 </select>
 </form>
 <br><br>

<table>
		<tr>
					<th>♡</th>	
					<th>장르</th>
					<th>♬</th>
					<th>앨범이미지</th>
					<th>곡정보</th>
					<th>앨범</th>
					<th>앨범발매일</th>
		</tr>
		<c:forEach var="dto" items="${list}" begin="0" end="99" varStatus="loop">
			<tr>
					<td>${loop.index + 1}</td>
					<td>${dto.genre }</td>
					<td><a href="/music_info?track_id=${dto.track_id }">♬</a></td>
					<td><img src="${dto.album_img}" alt="album_image" style="width: 100px;height: 100px;"></td>
					<td>
					<P>${dto.title }</P>
					<P>${dto.artist }</P>
					</td>
					<td>${dto.album_name }</td>
					<td>${dto.release_date }</td>
			</tr>
		</c:forEach>
</table>
 
<script>
function submitForm(){
	document.getElementById("genreForm").submit();
}

</script>
</body>
</html>