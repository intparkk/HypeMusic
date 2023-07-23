<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HYPEMUSIC 앨범 정보 ${albumInfo[0].album_name }</title>
</head>
    <header>
        <%@include file="header.jsp"%>
    </header>
<style>

    #detailalbum_body {
        margin: 20px 120px;
        padding: 0;
        font-family: Arial, sans-serif;
        color: #3f3f3f;
    }
    
    #blackword{
    	color: black;
    }
    .detailalbum_section {
        display: flex;
    }

    .detailpage_img {
        flex: 0 0 282px;
        margin-right: 20px;
    }

    .album_list_blank {
	    margin-left: 25px;
	    margin-right: 25px;
	}

    .list {
        margin-top: 0px;
    }

    .album_tracks {
        margin-top: 0px;
    }   

    .album_tracks ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .album_tracks li {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }

    .album_tracks img {
        width: 80px;
        height: 80px;
        margin-right: 10px;
    }
    
    .album_tracks img:hover {
    transform: scale(1.3); /* Enlarge the image by 10% on hover */
    transition: transform 0.2s ease-in-out; /* Add a smooth transition effect */
	}
    
    .btn {
    display: inline-block;
    padding: 5px;
    background-color: transparent;
    border: none;
    outline: none;
    cursor: pointer;
	}
	
	#icon_nextword{
		vertical-align: super;
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
	
</style>
<body>
<div id ="detailalbum_body">
    <h1 id="blackword">${albumInfo[0].album_name }</h1>
<section class="detailalbum_section">
			<div class = "detailpage_img">			
            <a href="#" class="image_typeAll">
                <img width="282" height="282" src="${albumInfo[0].album_img}">
            </a>
            </div>
                <!-- 자켓 커버와 리스트 사이에 공백용 -->
                <div class="album_list_blank">                    
                </div>
                <dl class="list">
                	<dt><strong id="blackword">${albumInfo[0].album_name}</strong></dt>
                	<br>
                	<dt><a href="/artistinfo/${albumInfo[0].artist_id}">${albumInfo[0].artist}</a></dt><br>
                    <dt>앨범 &nbsp;&nbsp; <a href="/albuminfo/${albumInfo[0].album_id}">${albumInfo[0].album_name}</a></dt><br>
                    <dt>발매일 &nbsp;&nbsp; ${albumInfo[0].release_date}</dt>
                </dl>
</section>
      
<!-- 수록곡 섹션 -->
<section>
	  <div class="album_tracks">
	    <h2 id="blackword">앨범 수록곡</h2>
	    <ul>
	        <c:forEach var="tracks" items="${albumInfo}">
	            <li>
	                <a href="/albuminfo/${tracks.album_id}"><img src="${tracks.album_img}" alt="Album Image"></a>
	                <a href="/music_info?track_id=${tracks.track_id}" id="atag_track_id" data-value="${tracks.track_id}">${tracks.title}</a> - <a href="/artistinfo/${tracks.artist_id}">${tracks.artist}</a> &nbsp;&nbsp;&nbsp;&nbsp;	                
                	<!--  재생 버튼 완성본 입니다 -->
                    <button type="button" title="재생" class="btn play-btn">
                        <a href="${tracks.youtube_url}" target="_blank"><img src="/img/hjs_play.png" alt="재생" style="width: 30px; height: 30px;"></a>
                    </button>
					<button type="button" title="담기" class="add-btn"
						data-track-id="${tracks.track_id }"
						onclick="showPlaylistPopup(this)">
						<img src="/img/hjs_put.png" alt="담기"
							style="width: 30px; height: 30px;">
					</button>
						</li>
	        </c:forEach>
	    </ul>
	</div>
</section>

<!-- 앨범 소개글 섹션 -->
<section>
	  <div class ="album_brief">
	  	<h2>앨범 소개글</h2>
      	<p>${albumInfo[0].album_brief }</p>
      </div>
</section>
</div>
<!-- 재생 버튼의 스크립트입니다 -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // 재생 버튼 지정 (querySelectorAll로 변경)
        const playButtons = document.querySelectorAll('.btn.play-btn');
        const nowRank = '${userInfo.rank}'; // 현재 랭크값 가져오기
        console.log(nowRank);

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
    
    <!-- 재생목록에 추가 -->
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
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>
