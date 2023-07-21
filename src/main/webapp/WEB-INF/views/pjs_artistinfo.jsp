<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>HYPEMUSIC 아티스트 정보 ${artistInfo[0].artist }</title>
</head>
<header>
	<jsp:include page="header.jsp"></jsp:include>
</header>
<style>

	.detailsong_section {
	position: relative;
	overflow: hidden;
	padding-top: 30px;
	background-color: #ffffff;
	width: 950px;
	height: 870px;	
	}
		
	.detailpage_img {
	position: relative;	
	}
	
	#artist_img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
    background-image: linear-gradient(to top, rgba(255, 255, 255, 0) 0%, rgba(255, 255, 255, 1) 50%, rgba(255, 255, 255, 1) 100%);
    opacity: 1.2;
    -webkit-mask-image: linear-gradient(to top, transparent, white);
    -webkit-mask-size: 100% 100%;
    mask-image: linear-gradient(to top, transparent, white);
    mask-size: 100% 100%;
	}
	
	.artist_brief {
	position: absolute;
	top: 50%;
	left: 50%;
	width:100%;
	transform: translate(-50%, 0%);
	z-index: 2;
	padding: 20px;
	color: #3f3f3f;
	font-size: 18px;
	text-align: center;
	max-height: 80%;
	overflow: hidden;
	white-space: normal;
	text-overflow: ellipsis;
	}

	
    #artist_body {
        margin: 20px 120px;
        padding: 0;
        font-family: Arial, sans-serif;
        color: #3f3f3f;
    }
    
    #blackword{
    	color: black;
    }
	ul {
	  list-style-type: none;
	  padding-inline-start: 10px;
	}
	
	li {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }	
  
    #song_img {
    	width: 80px;
        height: 80px;
    }
    
    #album_img,
    #relative_artist_img {
        width: 120px;
        height: 120px;
        margin-right: 10px;
    }
    
    #album_package,
    #relative_package {
	  margin-right: 30px;
	  margin-bottom: 30px;
	}        
   
    #song_img:hover,
	#album_img:hover,
	#relative_artist_img:hover {
    transform: scale(1.3); /* Enlarge the image by 10% on hover */
    transition: transform 0.2s ease-in-out; /* Add a smooth transition effect */
	}
	
	#album_ul,
	#relative_ul {
	    display: flex;
	    flex-wrap: wrap;
	    justify-content: flex-start
	}
	
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
<div id ="artist_body">
    <h1 id = "blackword">${artistInfo[0].artist }</h1>
	<!-- 아티스트 이름, 아티스트 사진 섹션 -->
	<section class="detailsong_section">
	    <div class="detailpage_img">
	        <img id="artist_img" src="${artistInfo[0].artist_img}" alt="Artist Image" style="width: 650px; height: 650px;">
	    </div>
	    <div class="artist_brief">
	        <h2 id="blackword">아티스트 소개</h2>
	        <span>${artistInfo[0].artist_brief}</span>
	    </div>
	</section>
	
	<!-- 아티스트 관련곡 섹션 -->
	<section id="track_package">
	<div class = "artist_tracks">
		    <h2 id = "blackword">아티스트의 최신곡</h2>
	    <ul>
			<c:forEach var="tracks" items="${artistInfo}" varStatus="loop">
			    <c:if test="${loop.index < 10}">
			        <li> 
			        	<a href="/albuminfo/${tracks.album_id }">
			            <img id="song_img" src="${tracks.album_img}" alt="Album Image">
			            </a>&nbsp;&nbsp;&nbsp;&nbsp;
			            <a href="/music_info?track_id=${tracks.track_id}" id="atag_track_id" data-value="${tracks.track_id}">${tracks.title}</a>&nbsp; - &nbsp;<a href="/artistinfo/${tracks.artist_id}">${tracks.artist}</a>
                    	<!--  재생 버튼 완성본 입니다 -->
                        <button type="button" title="재생" class="btn play-btn">
                            <a href="${tracks.youtube_url}" target="_blank"><img src="/img/hjs_play.png" alt="재생" style="width: 30px; height: 30px;"></a>
                        </button>
			            &nbsp;
						<jsp:include page="addbutton.jsp"></jsp:include>
			        </li>
			    </c:if>
			</c:forEach>
	    </ul>	
	</div>
	</section><br><br>
	
	<!--  앨범 섹션 -->
	<section id ="album_package">
		<h2 id = "blackword">발매 앨범</h2>
		<ul id = "album_ul">
	        <c:set var="previousAlbumId" value="" />
	        <c:forEach var="album" items="${artistInfo}">
	        	<c:if test="${album.album_id ne previousAlbumId}">
	        	<c:set var="previousAlbumId" value="${album.album_id}" />
	        	<div id = "album_package">
	            <li>
	            <a href="/albuminfo/${album.album_id}">
	                <img id="album_img" src="${album.album_img}" >
	                <div>${album.album_name }</div>
				</a>
	            </li>
	            </div>
	        </c:if>
	        </c:forEach>
	    </ul>
	</section><br>
	
	<!--  관련 아티스트 섹션 -->
	<section id ="relative_package">
		<h2 id = "blackword">관련 아티스트</h2>
		<ul id = "relative_ul">
	        <c:forEach var="relative_artist" items="${relativeArtistInfo}">
	        	<div id = "relative_package">
	            <li>
	            <a href="/artistinfo/${relative_artist.artist_id}">
	                <img id="relative_artist_img" src="${relative_artist.artist_img}" >
	                <div>${relative_artist.artist }</div>
				</a>
	            </li>
	            </div>
	        </c:forEach>
	    </ul>
	</section>
	
	<!-- 진서님 댓글 작업시 밑 섹션에 코드 짜시면 됩니다 -->
	<section>
	
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
</script>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>
</html>