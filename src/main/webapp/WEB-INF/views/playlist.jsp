<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>playlist</title>
<style>
#list-wrapper{
	display: flex;
	justify-content: flex-start;
	flex-wrap: wrap;
	margin: 0 auto;
	border: 1px solid red;
	width: 80%;
	min-height: 200px;

</style>
</head>
<body>
	<h1> 내 재생목록 </h1>
	<a href="/test-main">메인페이지</a>
	<a href="#">내가 쓴 댓글</a>
	<a href="#">좋아요</a>
	<a href="/myPlaylist">나의 재생목록</a>
	<a href="/logout">로그아웃</a>
	<hr>
	<c:choose>
		<c:when test="${isLoggedIn ne 'ok'}">
			<h2>로그인이 필요한 서비스입니다.</h2><br>
			<a href="/login">로그인</a>
		</c:when>
		<c:otherwise>
			<p>아이디 : ${userInfo.user_id}</p>
			<div id="list-wrapper">
			<!-- JS로 동적으로 생성할 영역 테스트 -->
<%-- 				<div id="playlist-wrapper">				
					<div class="playlist-img-wrapper">
						<a class="playlist-link" href="#">
							<img id="playlist-img" src="/public/playlist_img.svg">
						</a>
						
					</div>
					<div class="playlist-title-wrapper" >
						<a class="playlist-title" href="#">
							${myPlaylistDTO.playlist_title }
						</a>
					</div>
				</div> --%>
			</div>
			<!-- todo : 추가 버튼이 플레이리스트 오른쪽에 뜨게 하기 -->
			<button id="add">추가</button>
		</c:otherwise>
	</c:choose>
	
	<script>

	</script>
</body>
</html>