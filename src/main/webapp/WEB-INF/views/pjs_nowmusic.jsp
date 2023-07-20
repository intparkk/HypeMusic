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
<title>HYPEMUSIC 최신음악</title>
</head>
<!-- 헤더 -->
<header><jsp:include page="header.jsp"></jsp:include></header>
<Style>
table{
	border-collapse:collapse;
	margin: auto;
	width: 90%;	
}
table,th, td{
	border: none;
	border-bottom: 1px solid lightgray;
	border-top: 1px solid lightgray;
	color: #333333;
	text-align: center;
}
th,td{
max-width: 250px;
}
h1, h2{
text-align: center;
color: #333333;
}

a {
	color : #333333;
	text-decoration : none;
}

a:hover {
	color: #000000;
    font-weight: bold;
} 
#paging_number,
#paging_text_1,
#paging_text_2 {
text-decoration: none;
font-weight: bold;
color: gray;
font-size : 20px;
letter-spacing: 5px;
}

</Style>
<body>
<div id="nowmusic_body">
	
	<section id="nowmusic_table">
	<table>		
	<thead>				
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
	     <c:forEach var="nowmusic" items="${nowTracks}" varStatus="loopStatus"> 	 			
		<tr>		
			<td>
				${loopStatus.index}
			</td>
			<td><a href="/music_info?track_id=${nowmusic.track_id }" >
			<img src = "/img/music_info_icon2.jpg" style="border: none; width: 14px; height: 14px;">
			</a>
			</td>
			<!-- 박정수 : dto 에 album_id,youtube_url이 필요합니다! -->
			<td>
			 <div class="track">
				 <img src="${nowmusic.album_img}" alt="album_image" style="width: 100px;height: 100px;">
			 </div>
			</td>
			<td>
			<div class="caption1">
		     <p><a href="/music_info?track_id=${nowmusic.track_id}">${nowmusic.title }</a></p>
	             	 <p><a href="/artistinfo/${nowmusic.artist_id}">${nowmusic.artist }</a></p>
		    </div>
			</td>
			<td>
			<div class="caption2">
		     ${nowmusic.album_name }
		    </div>
			</td>
			<td>
			<div class="caption3">
	  				<p>${nowmusic.like_count }</p>
	  				</div>
			</td>
           	<td><!--  재생 버튼 완성본 입니다 -->
            <button type="button" title="재생" class="btn play-btn">
                <a href="${track.youtube_url}" target="_blank"><img src="/img/hjs_play.png" alt="재생" style="width: 30px; height: 30px;"></a>
            </button>
            </td>
			<td>
				<!--담기 -->
				<jsp:include page="addbutton.jsp"></jsp:include>
			</td>
		</tr>   
	 	  </c:forEach>    	
			</tbody>
	</table>
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
<!-- 풋터 -->
<footer><jsp:include page="footer.jsp"></jsp:include></footer>
</html>