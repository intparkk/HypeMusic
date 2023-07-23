<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Collections"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPEMUSIC 최신음악</title>
</head>
<!-- 헤더 -->
<header><jsp:include page="header.jsp"></jsp:include></header>
<Style>
table {
	border-collapse: collapse;
	margin: auto;
	width: 90%;
}

table, th, td {
	border: none;
	border-bottom: 1px solid lightgray;
	border-top: 1px solid lightgray;
	color: #333333;
	text-align: center;
}

th, td {
	max-width: 250px;
}

h1, h2 {
	text-align: center;
	color: #333333;
}

a {
	color: #333333;
	text-decoration: none;
}

a:hover {
	color: #000000;
	font-weight: bold;
}

#paging_number, #paging_text_1, #paging_text_2 {
	text-decoration: none;
	font-weight: bold;
	color: gray;
	font-size: 20px;
	letter-spacing: 5px;
}
.add-btn {
    display: inline-block;
    padding: 5px;
    background-color: transparent;
    border: none; 
    outline: none;
    cursor: pointer;
	}
	
.add-btn:hover {
transform: scale(1.3);
}

</Style>
<body>
	<div id="nowmusic_body">
		<h1>최신음악(임시)</h1>

		<section id="nowmusic_table">
			<table>
				<thead>
					<!-- <th><input type="checkbox" id="selectAllCheckbox" onclick="selectAllCheckboxes()"></th> -->
					<th>No</th>
					<th></th>
					<th>앨범이미지</th>
					<th>곡정보</th>
					<th>앨범</th>
					<th>Like</th>
					<th>듣기</th>
					<th>담기</th>
				</thead>
				<tbody>
					<c:forEach var="tracks" items="${nowTracks}" varStatus="loopStatus">
						<tr>
							<!-- <td><input type="checkbox" id="selectCheckbox" onclick="selectCheckboxes()" ></td>	 -->
							<td>
								<!-- 인덱스  --> ${loopStatus.index+1}
							</td>
							<td><a href="/music_info?track_id=${tracks.track_id }">
									<img src="/img/music_info_icon2.jpg"
									style="border: none; width: 14px; height: 14px;">
							</a></td>
							<!-- 박정수 : dto 에 album_id,youtube_url이 필요합니다! -->
							<td>
								<div class="track">
									<img src="${tracks.album_img}" alt="album_image"
										style="width: 100px; height: 100px;">
								</div>
							</td>
							<td>
								<div class="caption1">
									<p>
										<a href="/music_info?track_id=${tracks.track_id}">${tracks.title }</a>
									</p>
									<p>
										<a href="/artistinfo/${tracks.artist_id}">${tracks.artist }</a>
									</p>
								</div>
							</td>
							<td>
								<div class="caption2">${tracks.album_name }</div>
							</td>
							<td>
								<div class="caption3">
									<p>${tracks.like_count }</p>
								</div>
							</td>
							<td>
								<!--  재생 버튼 완성본 입니다 -->
								<button type="button" title="재생" class="btn play-btn">
									<a href="${tracks.youtube_url}" target="_blank"><img
										src="/img/hjs_play.png" alt="재생"
										style="width: 30px; height: 30px;"></a>
								</button>
							</td>
							<td>
								<button type="button" title="담기" class="add-btn"
									data-track-id="${tracks.track_id }"
									onclick="showPlaylistPopup(this)">
									<img src="/img/hjs_music_put.png" alt="담기"
										style="width: 20px; height: 20px;">
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</section>
	</div>

	<!-- 담기 버튼의 스크립트 입니다 -->

	<script>	
	const showPlaylistPopup = (element) => {
		const trackId = element.dataset.trackId;
		
		const popup = document.createElement("div");
		popup.id = "playlistPopup";
		popup.style.position = "fixed";
		
		popup.style.top = event.clientY + "px";
		popup.style.left = event.clientX + "px";
		
		popup.style.backgroundColor = "white";
		popup.style.padding = "20px";
		popup.style.border = "1px solid #ccc";

		/* 팝업 내용을 구성하고 표시하는 코드 추가 */
		fetch("/myPlaylist/loadPlaylist")
			.then(
				response => response.json()
			)
			.then(playlists => {
				console.log(playlists);
				const playlistSelect = document.createElement("select");
				playlistSelect.id = "playlistSelect";
			
			   	/* 내가 가지고 있는 재생목록을 선택 */
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
					const selectedTrackId = trackId;
					addToPlaylist(selectedPlaylistId, selectedTrackId);
					popup.remove();
				});
				
				const closeButton = document.createElement("button");
				closeButton.textContent = "닫기";
				closeButton.addEventListener("click", () => {
					popup.remove();
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
		
    	const userInfo = "${userInfo.user_id}";
	    document.querySelector(".add-btn").addEventListener("click", (event) => {
			if (userInfo == ""){
				alert("로그인 후 이용 가능한 서비스입니다.");
				event.preventDefault();
			}
			showPlaylistPopup(event);
	    });
		
		/* 재생목록에 추가 */
		const addToPlaylist = (playlistId, trackId) => {
		    const data = {
		        playlist_id: playlistId,
		        track_id: trackId
		    };
		
		    fetch("/myPlaylist/addToPlaylist", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/json"
		        },
		        body: JSON.stringify(data)
		    })
		    .then(response => {
		        if (response.ok) {
		            alert("음악이 재생목록에 추가되었습니다.");
		        } else {
		            alert("음악 추가에 실패했습니다. 다시 시도해주세요.");
		        }
		    })
		    .catch(error => {
		        console.error("오류 발생:", error);
		    });
		};
</script>


<!-- 재생 버튼의 스크립트입니다 -->
<script>
  document.addEventListener('DOMContentLoaded', function () {
      // 재생 버튼 지정 (querySelectorAll로 변경)
      const playButtons = document.querySelectorAll('.btn.play-btn');
      const nowRank = '${userInfo.rank}'; // 현재 랭크값 가져오기
      //console.log(nowRank);

      // 재생 버튼 이벤트 등록 (for문으로 모든 버튼에 적용)
      for (let i = 0; i < playButtons.length; i++) {
          playButtons[i].addEventListener('click', function (event) {
              // 만약 rank가 null 또는 "normal"이면
              // 기본 링크 동작을 막고, 알림 메시지를 표시
              if (nowRank == '' || nowRank === "normal") {
                  event.preventDefault(); // 기본 링크 동작 막기
                  alert("로그인 또는 이용권을 구매해주세요.");
              }
              // 만약 rank가 "ticket" 또는 "admin"이면
              // 링크는 새 창에서 열립니다.
          });
      }
  });
</script>
</body>
<!-- 풋터 -->
<footer><jsp:include page="footer.jsp"></jsp:include></footer>
</html>