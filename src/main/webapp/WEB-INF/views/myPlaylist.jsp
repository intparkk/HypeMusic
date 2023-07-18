<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my info</title>
<style>

.addBtn {
	background-color: rgb(162, 162, 162);
	color: white;
	border-radius: 3px;
	font-size: 20px;
	margin-left: 250px;
	padding: 3px;
	border-bottom: 3px solid grey;
	cursor: pointer;
}

.addBtn :hover {
	background-color: rgb(150, 150, 150);
	border-bottom: 3px solid rgb(102, 102, 102);
}

#add {
	display: none;
}

#list-wrapper{
	display: flex;
	justify-content: flex-start;
	flex-wrap: wrap;
	margin: 0 auto;
	margin-top: 40px;
	border: 1px solid red;
	min-width: 800px;
	width: 800px;
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

.playlist-img-wrapper :hover{
	filter: brightness(90%);
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
	text-decoration: none;
	color: black;
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
			<label for="add">
				<span class="addBtn">재생목록 추가 +</span>
				<button id="add"></button>
			</label>
			<div id="list-wrapper">
				<!-- JS로 생성할 영역 -->
			</div>
		</c:otherwise>
	</c:choose>
	
	<script>
		window.onload = () => {
			
			loadPlaylist();
			
			// 추가 버튼에 이벤트리스너 추가
			document.querySelector("#add").addEventListener("click", (event) => {
				event.preventDefault();
				createNewPlaylist();
				location.reload();
			})
		}
		
		// 재생목록 불러오기
		const loadPlaylist = () => {
			// ajax 요청 보내기
			fetch("/myPlaylist/loadPlaylist", {
				method : "GET"
			})
			.then((response) => {
			
				return response.json();
			})
			.then((data) => {
				console.log("로드 완료", data);
				
				// JSON 문자열을 객체로 변환
				const playlist = data;
				
				// data에서 받아온 재생목록 배열을 순회
				data.forEach((playlist) => {
					// playlistData에서 필요한 값 꺼내서 사용
					const playlistId = playlist.playList_id;
					const playlistName = playlist.playList_name;
					let playlistImage;
					
					if (playlist.length === 0) {
						playlistImage = '/public/playlist_img.svg';
					} else {
						playlistImage = playlist.playlist_img;
					}
					console.log(playlistImage);
					
					// 새로운 playlist 요소 생성
					const playlistWrapper = document.createElement("div");
					playlistWrapper.classList.add("playlist-wrapper");
					
					const playlistImgWrapper = document.createElement("div");
					playlistImgWrapper.classList.add("playlist-img-wrapper");
					
					const playlistLink = document.createElement("a");
					playlistLink.classList.add("playlist-link");
					playlistLink.href = "/myPlaylist/playlist?playlist_id=" + playlistId;
					
					const playlistImg = document.createElement("img");
					playlistImg.id = "playlist-img";
					playlistImg.src = playlistImage;
					
					playlistLink.appendChild(playlistImg);
					playlistImgWrapper.appendChild(playlistLink);
					playlistWrapper.appendChild(playlistImgWrapper);
					
					const playlistTitleWrapper = document.createElement("div");
					playlistTitleWrapper.classList.add("playlist-title-wrapper");
					
					const playlistTitleLink = document.createElement("a");
					playlistTitleLink.classList.add("playlist-title");
					playlistTitleLink.href = "/myPlaylist/playlist?playlist_id=" + playlistId;
					playlistTitleLink.textContent = playlistName;
					
					playlistTitleWrapper.appendChild(playlistTitleLink);
					playlistWrapper.appendChild(playlistTitleWrapper);
					
					document.querySelector("#list-wrapper").appendChild(playlistWrapper);
				});
			})
			.catch((error) => {
				console.error("Error", error);
			});
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
				playlistLink.href = "//myPlaylist/playlist?playlist_id=" + playlistId;
				
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
				playlistTitleLink.href = "//myPlaylist/playlist?playlist_id=" + playlistId;
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