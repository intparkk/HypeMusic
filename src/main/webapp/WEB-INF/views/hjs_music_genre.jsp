<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> --%>
<%-- <%@ page import="java.util.List" %>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장르음악</title>
<style>
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
</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<div class="section_1">
	<img src="/img/hjs_music_genre_logo.png">
</div>
<form id="genreForm" action="/hjs_music_genre">
 <select id="preference" name="preference" onchange="submitForm()">
    <option value="">장르를 선택해주세요</option>
    <option value="발라드">발라드</option>
    <option value="드라마">드라마OST</option>
    <option value="영화">영화OST</option>
    <option value="댄스">댄스</option>
    <option value="POP">팝</option>
    <option value="포크">포크</option>
    <option value="Soul">알앤비&소울</option>
    <option value="재즈">재즈</option>
    <option value="메탈">메탈</option>
	<option value="NewAge">뉴에이지</option>
    <option value="인디">인디</option>
 </select>
 </form>
 <br><br>

<table>
		<tr>
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
		</tr>
		<c:forEach var="dto" items="${list}" begin="0" end="99" varStatus="loop">
			<tr>
					<td><input type="checkbox" name="check" id="checkbox">
                            <span class="checkmark"></span></td>
					<td>${loop.index + 1}</td>
					<td>${dto.genre }</td>
					<td><a href="/music_info?track_id=${dto.track_id }">
					<img src = "/img/hjs_music_musicinfo.png" class="music_info_icon2"></a></td>
					<td>
						<div class="track_2">
						<img src="${dto.album_img}" alt="album_img" style="width: 100px;height: 100px;">
							<div class="caption_2">
                			<p>${dto.title }</p>
                			<p>${dto.artist }</p>
            				</div>
						</div>
					</td>	
					<td>
					<P><a href="/music_info?track_id=${dto.track_id}">${dto.title }</a></P> 
					<%-- <p>${dto.title }</p> --%>
					<P>${dto.artist }</P>
					</td>
					<td>${dto.album_name }</td>
					<td>${dto.release_date }</td>
					<td><a href="${dto.youtube_url }"><img src="img/hjs_music_play.png" class="logo1" style="border: none; width: 17px; height: 15px;"></a></td>
					<td>							
						<button type="button" title="담기" class="add-btn"
								data-track-id="${dto.track_id }"
								onclick="showPlaylistPopup(this)">
							<img src="/img/hjs_music_put.png" alt="담기"
								style="width: 20px; height: 20px;">
						</button></td>
			</tr>
		</c:forEach>
</table>
 
<script>
	function submitForm(){
		document.getElementById("genreForm").submit();
	}

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