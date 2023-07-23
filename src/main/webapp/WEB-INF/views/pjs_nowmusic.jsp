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
table{
	border-collapse:collapse;
	margin: auto;
	width: 80%;	
	background-color:rgb(255, 243, 230); 
	
}
table,th, td{
	border: none;
	border-bottom: 1px solid rgb(237, 233, 221);
	border-top: 1px solid rgb(237, 233, 221);
	text-align: center;
}
th {
padding-top: 15px;
padding-bottom: 15px;
max-width: 250px;
/*background-color: #E4E4E4;*/
/*background-color: rgb(62, 67, 157);*/
background-color: rgb(204, 179, 166);
color: rgb(241, 241, 241);
}
td{
max-width: 250px;
padding-left: 10px;
padding-right: 10px;
color: gray;
}
tr:hover {
background-color:#f3f3f5; 
}

a:hover {
	color:rgb(171, 105, 78);
    font-weight: bold;
    text-decoration:underline;
}
.section_1 {
	text-align: center;
}
#genreForm {
  text-align: center;
}
#preference {
  margin: 0 auto;
  width: 265px;
  height: 35px;
  border: 2px solid rgb(163, 121, 103);;
  color: rgb(163, 121, 103);;
}
.music_info_icon2{
	width:20px;
	height:20px;
}
.music_info_icon2:hover,
.logo1:hover {
	transform: scale(1.3);
}
.track_2 {
	display: inline-block;
	position: relative;
	overflow: hidden;
	width: 100px;
	height: 100px;
	margin:12px 12px 12px 12px;
	
}
.track_2 .caption_2 {
    position: absolute;
    top:0;
    bottom: 0;
    left: 0;
    width: 100px;
    background-color: rgba(0, 0, 0, 0.7);
    color: #fff;
    padding:0;
    margin:0;
    opacity: 0;
    transition: opacity 0.3s ease;
} 
.track_2 .caption_2 p{
	font-size: 10px;
	margin-top:15px;
	padding:5px;
	padding-top:0;
}       
.track_2:hover .caption_2 {
    opacity: 1;
} 
    #trackTable thead {
        position: sticky;
        top: 0;        
    }
</Style>
<body>
	<div id="nowmusic_body">
	<div class="section_1">
		<img src="/img/hjs_music_newalbum_logo.png">
	</div>
	<section id ="nowmusic_selector">
        <%-- 여기에 최신 연도부터 2011년까지의 버튼을 생성합니다 --%>
        <% for (int year = 2023; year >= 2011; year--) { %>
            <button type="submit" class="yearButton" value="<%= year %>"><%= year %></button>
        <% } %>    
	</section>

		<section id="nowmusic_table">
		<div id ="trackTableWrapper">
			<table id="trackTable">
					<thead>
					<th><input type="checkbox" name="check" id="checkbox">
                           <div class="checkmark"></div></th>
					<th>
					<img src="/img/hjs_music_rnum.png" style="width: 20px;height: 20px;">
					</th>	
					<th>장르</th>
					<th>ㅡ</th>
					<th>앨범이미지</th>
					<th>곡정보</th>
					<th>앨범</th>
					<th>앨범발매일</th>
					<th>듣기</th>
					<th>담기</th>
				</thead>
		<c:forEach var="tracks" items="${nowTracks}" varStatus="loop">
			<tr>
					<td><input type="checkbox" name="check" id="checkbox">
                            <span class="checkmark"></span></td>
					<td>${loop.index + 1}</td>
					<td>${tracks.genre }</td>
					<td><a href="/music_info?track_id=${tracks.track_id }">
					<img src = "/img/hjs_music_musicinfo.png" class="music_info_icon2"></a></td>
					<td>
						<div class="track_2">
						<img src="${tracks.album_img}" alt="album_img" style="width: 100px;height: 100px;">
							<div class="caption_2">
                			<p>${tracks.title }</p>
                			<p>${tracks.artist }</p>
            				</div>
						</div>
					</td>	
					<td>
					<P><a href="/music_info?track_id=${tracks.track_id}">${tracks.title }</a></P> 
					<P><a href="/artistinfo/${tracks.artist_id}">${tracks.artist }</a></p>
					</td>
					<td><a href="/albuminfo/${tracks.album_id}">${tracks.album_name }</a></td>
					<td>${tracks.release_date }</td>
					<td><a href="${tracks.youtube_url }"><img src="img/hjs_music_play.png" class="logo1" style="border: none; width: 17px; height: 15px;"></a></td>
					<td></td>
			</tr>
		</c:forEach>
		</table>
		</div>
		</section>
	</div>
	
<!-- 최초 진입 시 2023년 버튼이 클릭되도록 추가 -->
<script>
    /*window.onload = function() {
        var year2023Button = document.querySelector('button[value="2023"]');
        year2023Button.click(); // 2023년 버튼을 클릭하여 최초 데이터 출력
    };*/
</script>
<!-- 연도별 음악 -->
<script>
	// Ajax로 서버로부터 받은 데이터를 테이블에 출력하는 함수
	function renderTracksTable(tracksData) {
        var trackTable = document.getElementById("trackTable");
        var trackTableWrapper = document.getElementById("trackTableWrapper");

        // 테이블이 존재하지 않을 경우 예외 처리
        if (!trackTable || !trackTableWrapper) {
            console.error("테이블이 존재하지 않습니다.");
            return;
        }

        trackTable.innerHTML = ""; // 기존의 내용을 지우고 시작
	    for (var i = 0; i < tracksData.length; i++) {
	        var track = tracksData[i];
	
	        // 테이블 새로운 행 추가
	        var row = trackTable.insertRow(-1);
	
	        // 셀 생성 및 데이터 추가
	        var cellCheckbox = row.insertCell(0);
	        var cellIndex = row.insertCell(1);
	        var cellGenre = row.insertCell(2);
	        var cellMusicInfo = row.insertCell(3);
	        var cellTrackInfo = row.insertCell(4);
	        var cellAlbumName = row.insertCell(5);
	        var cellReleaseDate = row.insertCell(6);
	        var cellYoutube = row.insertCell(7);
	        //var cellAddButton = row.insertCell(8);
	
        cellIndex.textContent = i + 1; // 인덱스 1부터 시작
        cellGenre.textContent = track.genre || "장르 정보 없음"; // 장르 정보가 없을 경우 "장르 정보 없음" 표시
        cellMusicInfo.innerHTML = '<a href="/music_info?track_id=' + track.track_id + '">' +
            '<img src="/img/hjs_music_musicinfo.png" class="music_info_icon2"></a>'; // 음악 정보 링크
        cellTrackInfo.innerHTML = '<div class="track_2">' +
            '<img src="' + track.album_img + '" alt="album_img" style="width: 100px;height: 100px;">' +
            '<div class="caption_2">' +
            '<p>' + track.title + '</p>' +
            '<p>' + track.artist + '</p>' +
            '</div>' +
            '</div>'; // 곡 정보 디자인
        cellAlbumName.textContent = track.album_name || "앨범 이름 없음"; // 앨범 이름 정보가 없을 경우 "앨범 이름 없음" 표시
        cellReleaseDate.textContent = track.release_date || "발매일 정보 없음"; // 발매일 정보가 없을 경우 "발매일 정보 없음" 표시
        cellYoutube.innerHTML = '<a href="' + track.youtube_url + '">' +
            '<img src="img/hjs_music_play.png" class="logo1" style="border: none; width: 17px; height: 15px;"></a>'; // 유튜브 링크 아이콘
	    }
	}
    // 버튼 클릭 이벤트 리스너 등록
    var yearButtons = document.getElementsByClassName("yearButton");
    for (var i = 0; i < yearButtons.length; i++) {
        yearButtons[i].addEventListener("click", function(event) {
            var year = this.value;
            console.log("클릭한 연도:", year);

            // Ajax를 사용하여 서버로 년도 전송
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/getYearTracks', true);
            xhr.setRequestHeader('Content-Type', 'application/json'); // 요청 헤더
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    // 서버로부터 받은 데이터를 활용하여 원하는 기능 수행
                    renderTracksTable(response);
                    console.log("서버 응답:", response);
                }
            };
            // 년도 값을 JSON 형식으로 변환하여 요청 본문에 설정하고 전송
            xhr.send(JSON.stringify({ year: year }));
        });
    }
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