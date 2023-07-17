<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>담기 버튼입니다</title>
</head>
<style>

	.btn {
    display: inline-block;
    padding: 5px;
    background-color: transparent;
    border: none;
    outline: none;
    cursor: pointer;
	}
</style>
<body>
	<!--  담기 버튼 여기서 작업하시면 됩니다 -->
   	<button type="button" title="담기" class="btn add-btn" onclick="showPlaylistPopup()">
    <img src="/img/hjs_put.png" alt="담기" style="width: 30px;  height: 30px;">
	</button>
	<span id ="icon_nextword">담기</span>
	<script>
	// 현재 url에서 TrackId 추출
	const url = window.location.href;
	const trackId = url.split("/").pop();
	console.log(trackId);
	
	const showPlaylistPopup = () => {
		const popup = document.createElement("div");
		popup.id = "playlistPopup";
		popup.style.position = "fixed";
		popup.style.top = "50%";
		popup.style.left = "50%";
		popup.style.transform = "translate(-50%, -50%)";
		popup.style.backgroundColor = "white";
		popup.style.padding = "20px";
		popup.style.border = "1px solid #ccc";

		// 팝업 내용을 구성하고 표시하는 코드 추가
		fetch("/myPlaylist/loadPlaylist")
			.then(response => response.json())
			.then(playlists => {
				console.log(playlists);
				const playlistSelect = document.createElement("select");
				playlistSelect.id = "playlistSelect";
			
			   // 내가 가지고 있는 재생목록을 선택할 수 있는 옵션들을 생성합니다.
				playlists.forEach(playlists => {		
					const option = document.createElement("option");
					option.value = playlists.playList_id;
					option.textContent = playlists.playList_name;
					playlistSelect.appendChild(option);
				});
			
				const addButton = document.createElement("button");
				addButton.textContent = "추가";
				addButton.addEventListener("click", () => {
					const selectedPlaylistId = playlistSelect.value;
					const selectedTrackId = trackId; // 음악 ID를 설정하세요
					addToPlaylist(selectedPlaylistId, selectedTrackId);
					popup.remove(); // 팝업을 제거합니다.
				});
				
				const closeButton = document.createElement("button");
				closeButton.textContent = "닫기";
				closeButton.addEventListener("click", () => {
					popup.remove(); // 팝업을 제거합니다.
				});
				
				popup.appendChild(playlistSelect);
				popup.appendChild(addButton);
				popup.appendChild(closeButton);
				
				document.body.appendChild(popup);

			    })
		    .catch(error => {
		      console.error("팝업 내용을 가져오는 중 오류가 발생했습니다:", error);
		    });
		};
		
		// 재생목록에 추가
		const addToPlaylist = (playlistId, trackId) => {
			const xhr = new XMLHttpRequest();
			xhr.open("POST", "/myPlaylist/addToPlaylist", true);
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.onreadystatechange = () => {
				if (xhr.readyState === XMLHttpRequest.DONE) {
					if (xhr.status === 200) {
						alert("음악이 재생목록에 추가되었습니다.");
					} else {
						alert("음악 추가에 실패했습니다. 다시 시도해주세요.");
					}
				}
			};

			const data = {
				playlist_id: playlistId,
				track_id: trackId
			};
			const stringData = JSON.stringify(data);
			console.log(stringData);
			xhr.send(stringData);
		};
	</script>
</body>
</html>