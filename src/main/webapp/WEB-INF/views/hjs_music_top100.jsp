<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPEMUSIC Top100</title>
<link rel="stylesheet" href="/top100.css">
</head>
<header>
<jsp:include page="header.jsp"></jsp:include>
</header>
<body>

<!-- 타이틀 로고 -->
<div class="section_1">
	<img src="/img/hjs_music_top100_logo.png">
</div>

<!-- 날짜 -->
<div class="section_2">
<%
        Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd a h:mm");
        String formattedDateTime = dateFormat.format(currentDate);
    %>
</div>
	<h2><%= formattedDateTime %></h2>
	
<!-- 차트 top100 -->
<div class="section_3">
	<div class="music_btn">
	
	</div>		
		<table>		
			<thead>				
				<th><input type="checkbox" name="check" id="checkbox">
                           <div class="checkmark"></div></th>
				<th>순위</th>
				<th>ㅡ</th>
				<th>앨범이미지</th>
				<th>곡정보</th>
				<th>앨범</th>
				<th>Like</th>
				<th>듣기</th>
				<th>담기</th>
			</thead>			
    	<tbody>    	
        <c:forEach var="tracks" items="${list}" begin="0" end="99"> 	 			
				<tr>
					<td><input type="checkbox" name="check" id="checkbox">
                            <span class="checkmark"></span></td>					
					<td>

					<div class="rnum">
						${tracks.rnum} 
					</div>
					</td>
					<td><a href="/music_info?track_id=${tracks.track_id }" id="atag_track_id" data-value="${tracks.track_id}">
					<img src = "/img/hjs_music_musicinfo.png" class="music_info_icon2"></a></td>
					<!-- 박정수 : dto 에 album_id,youtube_url이 필요합니다! -->
					<td>
						 <div class="track">
          				 <img src="${tracks.album_img}" alt="album_image" style="width: 100px;height: 100px;">
        				 	<div class="caption">
                			<p>${tracks.title }</p>
                			<p>${tracks.artist }</p>
            				</div>
        				 </div>
					</td>
					<td>
					<div class="caption1">
				     <p><a href="/music_info?track_id=${tracks.track_id}">${tracks.title }</a></p>
                	 <p><a href="/artistinfo/${tracks.artist_id}">${tracks.artist }</a></p>
				    </div>
					</td>
					<td>
					<div class="caption2">
				     ${tracks.album_name }
				    </div>
					</td>
					<td>
					<div class="caption3">
     				<p>${tracks.like_count }</p>
     				</div>
					</td> 
					<!-- target="_blank" -->
					<td><a href="${tracks.youtube_url }"><img src="img/hjs_music_play.png" class="logo1" style="border: none; width: 17px; height: 15px;"></a></td>
					<td>
					<!-- 담기 버튼 -->
					 <%--    <c:if test="${rank == null || rank < 1}">
				            <img src="/img/hjs_music_put.png" alt="담기" style="border: none; width: 20px; height: 20px;">
					    </c:if>
					    <c:if test="${rank != null && rank >= 1}">
					        <a href="#" onclick="addTrack('${trackInfo_like.track_id}')">
					            <img src="/img/hjs_music_put.png" alt="담기" style="border: none; width: 20px; height: 20px;">
					        </a>
					    </c:if> --%>
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
</div>

		<%

			int total = (int) request.getAttribute("total");
			int countPerPage = (int) request.getAttribute("countPerPage");
			double lastPage = Math.ceil( (double)total / (double)countPerPage);

			// 페이징 그룹
			// 한 그룹당 보여줄 수
			int groupCount = 5;
			// 현재 페이지
			int pageNum = (int) request.getAttribute("pageNum");
			// 현재 속한 그룹
			double group = Math.floor((((double)pageNum-1) / groupCount) + 1);
			// 그룹의 시작 페이지, 끝 페이지
			int end = (int)group * groupCount;
			int begin = end - (groupCount - 1);
			System.out.println("group: "+ group);
			System.out.println("end: "+ end);
			System.out.println("begin: "+ begin);
			if(end > lastPage){
				end = (int)lastPage;
			}
			
			// 10보다 큰 숫자는 보이지 않도록 설정
		    if (end > 10) {
		        begin = 1;
		        end = Math.min(end, 10);
		    }
		    
			// scope 관련
			pageContext.setAttribute("a", 1);
			request.setAttribute("p", 2);
			session.setAttribute("test", 3);
			application.setAttribute("test2", 4);
		%>

		<div style="width:350px; margin: 0 auto; margin-top: 20px; margin-bottom: 20px;">
		<%
			if(begin != 1){
		%>				
				<a href="/hjs_music_top100?pageNum=<%= begin-1 %>" id="paging_text_1">[이전]</a>
		<%
			}
		%>
		<% 
			for(int i=begin; i<=end; i++){
		%>
			<a href="/hjs_music_top100?pageNum=<%= i %>"  id="paging_number">
				<c:set var="i2" value="<%= i %>" scope="page"></c:set>
				<c:if test="${pageNum eq i2}">
					<strong><%= i %></strong>
				</c:if>
				<c:if test="${pageNum ne i2}">
					<%= i %>
				</c:if>
			</a>
		<%
			}
		%>
		<%
			if(end != lastPage){
		%>				
				<a href="/hjs_music_top100?pageNum=<%= end+1 %>" id="paging_text_2">[다음]</a>
		<%
			}
		%>
			
		</div>
		
	</section>
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
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>