<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>playlist</title>
<style>
#playlist-info-wrapper {
	display: flex;
	border: 1px solid lightgrey;
	min-width: 800px;
	width: 70%;
	margin: 0 auto;
}

.playlist-title {
	padding: 30px 30px 10px 30px;
	font-weight: bold;
	font-size: 32px;
}

.playlist-track-quantity {
	padding: 0px 30px 0px 30px;
	font-size: 20px;
}

#playlist-img-btn {
	margin-top: 130px;
}

.playlist-delete-btn-wrapper {
	margin-left: auto;
	margin-top: auto;
}
#list-wrapper{
	margin: 0 auto;
	min-width: 800px;
	width: 70%;
	min-height: 200px;
	}
	
#playlist-table {
	width: 100%;
	margin: 0 auto;
}

.playlist-thead {
	height: 30px;
}

.playlist-tr {
	height: 64px;
	justify-content: center;
	text-align: center;
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
			<input type="hidden" id="playlist-id" value="${playlist_id}">
			<div id="playlist-info-wrapper">
				<div class="playlist-img">
					<img src="${playlistImg}" width="264px" height="264px">
				</div>
				<div class="playlist-text-wrapper">
					<div class="playlist-title">
						${playlistName}
					</div>
					<button id="playlist-title-update-btn">
						이름 변경
					</button>
					<div class="playlist-track-quantity">
						${trackQuantity} 곡
					</div>
					<button id="playlist-img-btn">
						재생목록 사진 변경
					</button>
				</div>
				<div class="playlist-delete-btn-wrapper">
					<button id="playlist-delete-btn">
						재생목록 삭제
					</button>
				</div>
			</div>
			<hr>
			<div id="list-wrapper">
				<table id="playlist-table">
					<thead class="playlist-thead">
						<th class="playlist-th"></th>
						<th class="playlist-th">제목</th>
						<th class="playlist-th">앨범</th>
						<th class="playlist-th">아티스트</th>
						<th class="playlist-th"></th>
					</thead>
					<!-- JS로 동적으로 생성할 영역 테스트 -->
<!-- 					<tbody class="playlist-tbody"> -->
<!-- 							<tr class="playlist-tr"> -->
<!-- 								<td class="playlist-td"> -->
<!-- 									<img class="track-img" src="https://i.namu.wiki/i/GXR7tlVhYbYXvfwk37u5cKm2bA_vcpI0eN9_POSPCzC0ZdCcIBQgAwmZ-dvN-UwyZCVh-lMNKN8NeIxusd7urg.webp" width="64px" height="64px"> -->
<!-- 								</td> -->
<!-- 								<td class="playlist-td">제목</td> -->
<!-- 								<td class="playlist-td">앨범</td> -->
<!-- 								<td class="playlist-td">아티스트</td> -->
<!-- 								<td class="playlist-td"> -->
<!-- 									<button id="delete-btn">삭제</button> -->
<!-- 								</td> -->
<!-- 							</tr> -->
<!-- 					</tbody>	 -->
				</table>
			</div>
		</c:otherwise>
	</c:choose>
	
	<script>
	/* DOMContentLoaded */
	window.addEventListener("DOMContentLoaded", () => {
		loadPlaylistTracks();
		
		/* 재생목록 삭제 버튼에 이벤트 리스너 추가 */
		const playlistDeleteBtn = document.querySelector("#playlist-delete-btn");
		playlistDeleteBtn.addEventListener("click", (event) => {
			event.preventDefault();
			deletePlaylist();
		})
		
		/* 곡 삭제 버튼에 이벤트리스너 추가 
		   cannot read properties of null 에러 발생
		*/
		const deleteBtn = document.querySelector("#delete-btn");
		deleteBtn.addEventListener("click", (event) => {
			event.preventDefault();
		    deleteTrack();
		});
	});
	
	const playlistId = document.querySelector("#playlist-id").value.trim();
	console.log(playlistId);
	
	/* 재생목록 삭제 */
	const deletePlaylist = (playlistId) => {
		
		/* ajax 요청 보내기 */
		fetch("/myPlaylist/playlist/deletePlaylist?playlist_id=" + playlistId, {
			method : "DELETE"
		})
			.then((response) => {
				if (response.ok) {
					alert("재생목록이 삭제되었습니다.");
					console.log("재생목록 삭제");
				} else {
					console.log("재생목록 삭제 실패");
				}
			})
			.catch((error) => {
				console.log("Error", error);
			})
	}
	
	/* 곡 삭제 */
	const deleteTrack = () => {
		const trackId = document.querySelector("#track-id");
		/* ajax 요청 보내기 */
		fetch("/myPlaylist/playlist/deleteTrack?track_id=" + trackId, {
			method : "DELETE"
		})
			.then((response) => {
				if (response.ok) {
					console.log("삭제성공");
				} else {
					console.log("삭제실패");
				}
			})
			.catch((error) => {
				console.log("Error", error);
			});
	}
	
	/* 곡 불러오기 */
	const loadPlaylistTracks = () => {
		
		const playlistId = document.querySelector("#playlist-id").value.trim();
		/* ajax 요청 보내기 */
		fetch("/myPlaylist/playlist/loadPlaylistTracks?playlist_id=" + playlistId, {
			method : "GET"
		})
		.then((response) => {
			
			return response.json();
		})
		.then((data) => {
			console.log("로드 완료", data);
			
			/* JSON 문자열을 객체로 변환 */
			const TrackData = data;
			
			/* data에서 받아온 재생목록 배열을 순회 */
			data.forEach((TrackData) => {
				/* TrackData에서 필요한 값 꺼내서 사용 */
				const trackId = TrackData.track_id;
				const trackTitle = TrackData.title;
				const albumImg = TrackData.album_img;

				/* 새로운 playlist 요소 생성 */
				const playlistTbody = document.createElement("tbody");
				playlistTbody.classList.add("playlist-tbody");

				/* Tr */
				const playlistTr = document.createElement("tr");
				playlistTr.classList.add("playlist-tr");

				/* 앨범 이미지 */
				const imgTd = document.createElement("td");
				imgTd.classList.add("playlist-td");

				const albumImage = document.createElement("img");
				albumImage.id = "album-img";
				albumImage.src = albumImg;
				albumImage.style.width = "64px";
				albumImage.style.height = "64px";
				
				/* 트랙 id */
				const trackIdContainer = document.createElement("input");
				trackIdContainer.id = "track-id";
				trackIdContainer.type = "hidden";
				trackIdContainer.value = trackId;
				
				/* 제목 */
				const trackTitleTd = document.createElement("td");
				trackTitleTd.classList.add("playlist-td");
				trackTitleTd.textContent = trackTitle;

				/* 앨범 */
				const albumTitleTd = document.createElement("td");
				albumTitleTd.classList.add("playlist-td");
				albumTitleTd.textContent = TrackData.album_name;

				/* 아티스트 */
				const artistTd = document.createElement("td");
				artistTd.classList.add("playlist-td");
				artistTd.textContent = TrackData.artist;
				
				/* 재생 버튼 */
				const playBtnTd = document.createElement("td");
				playBtnTd.classList.add("playlist-td");
				
				const playBtn = document.createElement("button");
				playBtn.id = "play-btn";
				playBtn.textContent = "재생";
				
				/* 뮤직비디오 버튼 */
				const mvBtnTd = document.createElement("td");
				mvBtnTd.classList.add("playlist-td");
				
				const mvBtn = document.createElement("button");
				mvBtn.id = "mv-btn";
				mvBtn.textContent = "M/V";
				
				/* 곡 삭제 버튼 */
				const deleteBtnTd = document.createElement("td");
				deleteBtnTd.classList.add("playlist-td");
				
				const deleteBtn = document.createElement("button");
				deleteBtn.id = "delete-btn";
				deleteBtn.textContent = "삭제";

				imgTd.appendChild(albumImage);
				playBtnTd.appendChild(playBtn);
				mvBtnTd.appendChild(mvBtn);
				deleteBtnTd.appendChild(deleteBtn);
				playlistTr.appendChild(trackIdContainer);
				playlistTr.appendChild(imgTd);
				playlistTr.appendChild(trackTitleTd);
				playlistTr.appendChild(albumTitleTd);
				playlistTr.appendChild(artistTd);
				playlistTr.appendChild(playBtnTd);
				playlistTr.appendChild(mvBtnTd);
				playlistTr.appendChild(deleteBtnTd);
				playlistTbody.appendChild(playlistTr);
				document.querySelector("#playlist-table").appendChild(playlistTbody);
			});
		})
		.catch((error) => {
			console.error("Error", error);
		});
	}
	</script>
</body>
</html>