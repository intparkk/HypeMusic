<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my info</title>
<style>
#list-wrapper{
	display: flex;
	justify-content: flex-start;
	flex-wrap: wrap;
	margin: 0 auto;
	border: 1px solid red;
	width: 80%;
	min-height: 200px;
}

.playlist-wrapper{
	width: 200px;
	height: 200px;
}

.playlist-img-wrapper{
	width: 160px;
	height: 160px;
	margin: 0 auto;
}

#playlist-img{
	width: 160px;
	height: 160px;
}

.playlist-title-wrapper {
	display: flex;
	justify-contnet: center;
}

.playlist-title {
	margin: auto;
}
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
		window.onload = () => {
			
			loadPlaylist();
			
			// 추가 버튼에 이벤트리스너 추가
			document.querySelector("#add").addEventListener("click", (event) => {
				event.preventDefault();
				createNewPlaylist();
			})
		}
		
		const loadPlaylist = () => {
			fetch("/myPlaylist/loadPlaylist")
				.then((response) => response.json())
				.then((data) => {
					
				})
			 
		}
		
		// 재생목록 생성 & html 동적 생성
		const createNewPlaylist = () => {
			
			// ajax 요청 보내기
			fetch("/myPlaylist/createNewPlaylist", {
				method : "POST"
			})
			.then((response) => {
				return response.text();
			})
			.then((data) => {
				console.log("생성완료" + data);
				
				// JSON 문자열을 객체로 변환
				const playlistData = JSON.parse(data);
				
				// playlistData에서 필요한 값 꺼내서 사용
				const playlistId = playlistData.playList_id;
				const playlistName = playlistData.playList_name;
				
				// 새로운 playlist 요소 생성
				
				// id를 가지는 요소 생성
				// playlistWrapper.setAttribute("id", "playlist-wrapper");
				// classList.add(""); 로 생성하면 id가 아닌 class 속성을 가지는 요소 생성
				const playlistWrapper = document.createElement("div");
				playlistWrapper.classList.add("playlist-wrapper");
				
				const playlistImgWrapper = document.createElement("div");
				playlistImgWrapper.classList.add("playlist-img-wrapper");
				
				// <a> 태그 생성
				const playlistLink = document.createElement("a");
				playlistLink.classList.add("playlist-link");
				playlistLink.href = "/myPlaylist?id=" + playlistId;
				
				// <img> 태그 생성
				const playlistImg = document.createElement("img");
				playlistImg.id = "playlist-img";
				playlistImg.src = "/public/playlist_img.svg";
				
				// 부모-자식 관계 설정
				// playlistImg를 playlistLink의 자식으로 추가
				playlistLink.appendChild(playlistImg);
				// playlistLink를 playlistImgWrapper의 자식으로 추가
				playlistImgWrapper.appendChild(playlistLink);
				// playlistImgWrapper를 playlistWrapper의 자식으로 추가
				playlistWrapper.appendChild(playlistImgWrapper);
				
				const playlistTitleWrapper = document.createElement("div");
				playlistTitleWrapper.classList.add("playlist-title-wrapper");
				
				const playlistTitleLink = document.createElement("a");
				playlistTitleLink.classList.add("playlist-title");
				playlistTitleLink.href = "/myPlaylist?id=" + playlistId;
				playlistTitleLink.textContent = playlistName;// 새로운 playlist 제목 설정

/* 				const addBtn = document.createElement("button");
				addBtn.setAttribute("id", "add");
				addBtn.textContent = "추가";
				
				playlistWrapper.appendChild(addBtn); */
				playlistTitleWrapper.appendChild(playlistTitleLink);
				playlistWrapper.appendChild(playlistTitleWrapper);
				
				// 생성한 playlist 요소를 #list-wrapper에 추가
				document.querySelector("#list-wrapper").appendChild(playlistWrapper);
			})
		}
	</script>
</body>
</html>