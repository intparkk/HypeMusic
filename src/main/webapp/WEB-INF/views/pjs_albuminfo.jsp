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
	        <c:forEach var="track" items="${albumInfo}">
	            <li>
	                <a href="/albuminfo/${track.album_id}"><img src="${track.album_img}" alt="Album Image"></a>
	                <a href="/music_info?track_id=${track.track_id}">${track.title}</a> - <a href="/artistinfo/${track.artist_id}">${track.artist}</a> &nbsp;&nbsp;&nbsp;&nbsp;	                
                	<!--  재생 버튼 완성본 입니다 -->
                    <button type="button" title="재생" class="btn play-btn">
                        <a href="${track.youtube_url}" target="_blank"><img src="/img/hjs_play.png" alt="재생" style="width: 30px; height: 30px;"></a>
                    </button>
                    <button type="button" title="담기" class="btn add-btn" >
                    <img src="/img/hjs_put.png" alt="담기" style="width: 30px;  height: 30px;">
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
</script>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>
