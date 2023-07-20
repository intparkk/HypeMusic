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
	border-radius: 8px 0px 0px 8px;
	min-width: 800px;
	width: 70%;
	height: 264px;
	margin: 0 auto;
	position: relative;
	margin-bottom: 20px;
}

.playlistImg {
	border-radius: 6px;
}
.playlist-title {
	padding: 20px 30px 10px 30px;
	font-weight: bold;
	font-size: 32px;
}

.playlist-track-quantity {
	padding: 36px 30px 0px 30px;
	font-size: 18px;
}

#playlist-title-update-btn {
	display: none;
}

.title-update {
	position: absolute;
	margin-left: 30px;
	border-bottom: 2px solid lightgrey;
	border-radius: 3px;
	background-color: grey;
	color: white;
	font-size: 14px;
	cursor: pointer;
	padding: 2px;
}

.playlist-delete-btn-wrapper {
	position: absolute;
	right: 0;
	bottom: 0;
	margin-bottom: 8px;
	margin-right: 10px;
}

#playlist-delete-btn {
	display: none;
}

.playlist-delete {
	border-bottom: 2px solid lightgrey;
	border-radius: 3px;
	background-color: grey;
	color: white;
	font-size: 14px;
	cursor: pointer;
	padding: 2px;
}

#list-wrapper{
	border-top: 1px solid lightgrey;
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

#img-update-btn {
	color: white;
	font-size: 0;
	opacity: 0;
	cursor: pointer;
}

.img-update {
	position: absolute;
	bottom: 0;
	margin-bottom: 8px;
	margin-left: 30px;
	border-bottom: 2px solid lightgrey;
	border-radius: 3px;
	background-color: grey;
	color: white;
	font-size: 14px;
	cursor: pointer;
	padding: 2px;
}


</style>
</head>
<header>
	<jsp:include page="header.jsp"></jsp:include>
</header>
<body>
	<input type="hidden" id="user-id" value="${userInfo.user_id}">
	<input type="hidden" id="playlist-id" value="${playlist_id}">
	<div id="playlist-info-wrapper">
		<div class="playlist-img-container">
			<img class ="playlistImg" src="${playlistImg}" width="264px" height="264px">
		</div>
		<div class="playlist-text-wrapper">
			<div class="playlist-title">
				${playlistName}
			</div>
			<label for="playlist-title-update-btn">
				<span class="title-update">
					이름 변경
				</span>
				<button id="playlist-title-update-btn">
				</button>
			</label>
			<div class="playlist-track-quantity">
				${trackQuantity} 곡
			</div>
			<label for="img-update-btn">
				<span class="img-update">
					변경
				</span>
				<input type="file" id="img-update-btn">
			</label>
		</div>
		<div class="playlist-delete-btn-wrapper">
			<label for="playlist-delete-btn">
				<span class="playlist-delete">
					재생목록 삭제
				</span>
				<button id="playlist-delete-btn">
				</button>
			</label>
		</div>
	</div>
	<div id="list-wrapper">
		<table id="playlist-table">
			<thead class="playlist-thead">
				<th class="playlist-th"></th>
				<th class="playlist-th">제목</th>
				<th class="playlist-th">앨범</th>
				<th class="playlist-th">아티스트</th>
				<th class="playlist-th"></th>
			</thead>
			<!-- JS로 동적으로 생성할 영역 -->
		</table>
	</div>
	<script>
	/* DOMContentLoaded */
	window.addEventListener("DOMContentLoaded", () => {
		
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
					deleteBtn.dataset.trackId = trackId;
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
					
					/* 곡 삭제 버튼에 이벤트리스너 추가 */
					const deleteBtns = document.querySelectorAll("#delete-btn");
					deleteBtns.forEach((deleteBtn) => {
					    deleteBtn.addEventListener("click", (event) => {
					        event.preventDefault();
					        deleteTrack(event.currentTarget);
					    });
					});
				});
			})
			.catch((error) => {
				console.error("Error", error);
			});
		}
		
		loadPlaylistTracks();
		
		/* 재생목록 삭제 버튼에 클릭 이벤트 추가 */
		const playlistDeleteBtn = document.querySelector("#playlist-delete-btn");
		playlistDeleteBtn.addEventListener("click", (event) => {
			event.preventDefault();
			deletePlaylist();
		})
		
		/* 재생목록 이름 변경 버튼에 클릭 이벤트 추가 */
		const playlistTitleUpdateBtn = document.querySelector("#playlist-title-update-btn");
		playlistTitleUpdateBtn.addEventListener("click", (event) => {
		    event.preventDefault();
		    updatePlaylistName();
		});
		
		/* 이미지 변경 버튼에 클릭 이벤트 추가 */
		const imgUpdateBtn = document.querySelector("#img-update-btn");
		imgUpdateBtn.addEventListener("change", updatePlaylistImage);
		
	});
	
	/* 재생목록 이미지 변경 */
	const updatePlaylistImage = () => {
		const playlistId = document.querySelector("#playlist-id").value.trim();
		const imageUpload = document.querySelector("#img-update-btn");
		
		const formData = new FormData();
		formData.append("playlist_id", playlistId);
 		formData.append("file", imageUpload.files[0]);
		
		fetch("/myPlaylist/playlist/updatePlaylistImage",{
			method: "POST",
			body: formData
		})
		.then((response) => {
			if (response.ok) {
				alert("이미지 변경 완료");
				console.log("이미지 변경")
				
				location.reload();
			} else {
				console.log("이미지 변경 실패");
			}
		})
		.catch((error) => {
			console.log("Error", error);
		})
	}
	
	/* 재생목록 이름 변경 */
	const updatePlaylistName = () => {
	    const playlist = {
	        playlist_id: document.querySelector("#playlist-id").value.trim(),
	        playlist_name: prompt("새로운 재생목록 이름을 입력하세요:")
	    };
	    
	    if (playlist.playlist_name) {
	        fetch("/myPlaylist/playlist/updatePlaylistName", {
	            method: "PUT",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            body: JSON.stringify(playlist)
	        })
	        .then((response) => {
	            if (response.ok) {
	                alert("재생목록 이름이 변경되었습니다.");
	                console.log("재생목록 이름 변경");
	                // 페이지 새로고침 또는 필요한 작업 수행
 	                location.reload();
	            } else {
	                console.log("재생목록 이름 변경 실패");
	            }
	        })
	        .catch((error) => {
	            console.log("Error", error);
	        });
	    }
	};
	

	
	/* 재생목록 삭제 */
	const deletePlaylist = () => {
		const playlistId = document.querySelector("#playlist-id").value.trim();
		console.log(playlistId);
		
		const confirmation = confirm("재생목록을 삭제하시겠습니까?");
		
		if (confirmation) {
		/* ajax 요청 보내기 */
		fetch("/myPlaylist/playlist/deletePlaylist?playlist_id=" + playlistId, {
			method : "DELETE"
		})
			.then((response) => {
				if (response.ok) {
					alert("재생목록이 삭제되었습니다.");
					console.log("재생목록 삭제");
					window.location.href = "/myPlaylist";
				} else {
					console.log("재생목록 삭제 실패");
				}
			})
			.catch((error) => {
				console.log("Error", error);
			})
		}
	};
	
	/* 곡 삭제 */
	const deleteTrack = (deleteBtn) => {
		const playlistId = document.querySelector("#playlist-id").value.trim();
		const trackId = deleteBtn.parentNode.parentNode.querySelector("input[type='hidden']").value.trim();
		console.log(trackId);
		/* ajax 요청 보내기 */
		fetch("/myPlaylist/playlist/deleteTrack?playlist_id=" + playlistId + "&track_id=" + trackId, {
			method : "DELETE"
		})
			.then((response) => {
				if (response.ok) {
					
					console.log("삭제성공");
		            
 		            // 페이지 새로고침
					location.reload();
		            
				} else {
					console.log("삭제실패");
				}
			})
			.catch((error) => {
				console.log("Error", error);
			});
	}
	
	</script>
</body>
</html>