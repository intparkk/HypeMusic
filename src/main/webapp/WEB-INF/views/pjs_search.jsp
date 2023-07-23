<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Collections" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPEMUSIC : ${keyword }에 대한 검색결과</title>
<link rel="stylesheet" href="/search.css?after">
</head>
<style>
      /* Apply specific styles for the "앨범" and "발매일" columns */
      th:nth-child(4),
      td:nth-child(4) {
          width: 140px; /* Adjust the width as needed */
      }

      th:nth-child(5),
      td:nth-child(5) {
          width: 130px; /* Adjust the width as needed */
      }

      /* Additional styling for the table */
      table {
          width: 100%;
          border-collapse: collapse;
      }
       thead {
       		border-bottom: 1px solid black;
       }

      th, td {
          padding: 8px;
          text-align: left;
      }

      th {
          background-color: #f2f2f2;
      }
      #ment {
      	margin-bottom:40px;
      }
      #search_track_result {
      	margin-bottom:80px;
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
<header>
<jsp:include page="header.jsp"></jsp:include>         
</header>
<body>
	<div id = "search_body">
	<h1 id="ment">"${keyword }"&nbsp에 대한 검색결과입니다.</h1>
	<!-- 트랙 검색결과 섹션 -->
	<section id="search_track_result">
	    <h2>관련 트랙 ></h2>
	    <table>
	        <thead>
	            <tr>
	                <th></th>
	                <th>곡 정보</th>
	                <th>아티스트</th>
	                <th>앨범</th>
	                <th>발매일</th>
	                <th>Like</th>
	                <th>듣기</th>
	                <th>담기</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="tracks" items="${search_all}">
	                <tr>
	                    <td>
	                        <a href="/music_info?track_id=${tracks.track_id}" id="atag_track_id" data-value="${tracks.track_id}">
	                            <img id="track_img" src="${tracks.album_img}" alt="${tracks.title}">
	                        </a>
	                    </td>
	                    <td>
	                        <a href="/music_info?track_id=${tracks.track_id}">
	                            ${tracks.title}
	                        </a>
	                    </td>
	                    <td>
	                        <a href="/artistinfo/${tracks.artist_id}">
	                            ${tracks.artist}
	                        </a>
	                    </td>
	                    <td>
	                        <a href="/albuminfo/${tracks.album_id}">
	                            ${tracks.album_name}
	                        </a>
	                    </td>
	                    <td>
	                        ${tracks.release_date }
	                    </td>
	                    <td>
	                        ${tracks.like_count }
	                    </td>
	                    <td>
	                    	<!--  재생 버튼 완성본 입니다 -->
	                        <button type="button" title="재생" class="btn play-btn">
	                            <a href="${tracks.youtube_url}" target="_blank"><img src="/img/hjs_play.png" alt="재생" style="width: 30px; height: 30px;"></a>
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
	
	<!--  아티스트 검색결과 섹션 -->
	<section id="search_artist_result">
	    <h2>관련 아티스트 ></h2>
	    <ul id="artist_ul">
	        <c:set var="previousArtistId" value="" />
	        <c:forEach var="artist" items="${search_relative_artist}">
	            <c:if test="${artist.artist_id ne previousArtistId}">
	                <c:set var="previousArtistId" value="${artist.artist_id}" />
	                <div id = "artist_package">
	                <li>
	                    <a href="/artistinfo/${artist.artist_id}">
	                        <img id="artist_img" src="${artist.artist_img}">
	                    </a>
	                </li>
	                <li id="artist_name_ul">
	                    <a href="/artistinfo/${artist.artist}">${artist.artist }</a>
	                </li>
	                </div>
	            </c:if>
	        </c:forEach>
	    </ul>
	</section>
			
	<!--  앨범 검색결과 섹션 -->
	<section id ="search_album_result">
		<h2>관련 앨범 ></h2>
		<ul id = "album_ul">
	        <c:set var="previousAlbumId" value="" />
	        <c:forEach var="album" items="${search_all}">
	        	<c:if test="${album.album_id ne previousAlbumId}">
	        	<c:set var="previousAlbumId" value="${album.album_id}" />
	        	<div id = "album_package">
	            <li>
	            <a href="/albuminfo/${album.album_id}">
	                <img id="album_img" src="${album.album_img}" >
	            </li>
	            <ul id = "album_name_ul">
	            	${album.album_name }
	            </a>
	            </ul>       
	            <ul id = "artist_name_ul">
	            <a href="/artistinfo/${album.artist_id}">	            
	            	${album.artist }
				</a>
	            </ul>
	            </div>
	        </c:if>
	        </c:forEach>
	    </ul>
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
	
<!-- <button type="button" onclick="openSmallWindow()">Open Small Window</button> -->	
	<script>
        /*function openSmallWindow() {
            // URL of the page you want to open in the small window
            const url = '${search_all[0].youtube_url}';

            // Specify the window features
            const windowFeatures = 'width=400,height=300,menubar=no,toolbar=no,resizable=no';

            // Open the small window
            window.open(url, '_blank', windowFeatures);
        }*/
    </script>
</body>
<jsp:include page="footer.jsp"></jsp:include>  
</html>