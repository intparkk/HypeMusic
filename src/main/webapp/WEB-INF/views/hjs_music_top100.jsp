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
<Style>
table{
	border-collapse:collapse;
	margin: auto;	
}
table,th, td{
	border: none;
	border-bottom: 1px solid lightgray;
	border-top: 1px solid lightgray;
	color: #333333;
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
</Style>

</head>
<header>
<jsp:include page="hjs_music_header2.jsp"></jsp:include> 
</header>
<body>

<!-- 타이틀 로고 -->
<div class="section_1"></div>
	<h1>Top100</h1>

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
				<th>앨범이미지</th>
				<th>곡정보</th>
				<th>앨범</th>
				<th>Like</th>
				<th>듣기</th>
				<th>담기</th>
			</thead>			
    	<tbody>    	
        <c:forEach var="dto" items="${list}" begin="0" end="99" varStatus="loop"> 	 			
				<tr>
					<td><input type="checkbox" name="check" id="checkbox">
                            <span class="checkmark"></span></td>					
					<td>
						&nbsp;${loop.index + 1}
					</td>
					<!-- 박정수 : dto 에 album_id,youtube_url이 필요합니다! -->
					<td>
						 <div class="track">
          				 <img src="${dto.album_img}" alt="album_image" style="width: 100px;height: 100px;">
        				 	<div class="caption">
                			<p>${dto.title }</p>
                			<p>${dto.artist }</p>
            				</div>
        				 </div>
					</td>
					<td>
					<div class="caption1">
				     <p><a href="/music_info?track_id=${dto.track_id}">${dto.title }</a></p>
                	 <p><a href="/artistinfo/${dto.artist_id}">${dto.artist }</a></p>
				    </div>
					</td>
					<td>
					<div class="caption2">
				     ${dto.album_name }
				    </div>
					</td>
					<td>
					<div class="caption3">
     				<p>${dto.like_count }</p>
     				</div>
					</td>
					<td><a href="#"><img src="img/hjs_play.png" class="logo1" style="border: none; width: 20px; height: 20px;"></a></td>
					<td>
					<!-- 담기 버튼 -->
					    <c:if test="${rank == null || rank < 1}">
				            <img src="/img/hjs_put.png" alt="담기" style="border: none; width: 20px; height: 20px;">
					    </c:if>
					    <c:if test="${rank != null && rank >= 1}">
					        <a href="#" onclick="addTrack('${trackInfo_like.track_id}')">
					            <img src="/img/hjs_put.png" alt="담기" style="border: none; width: 20px; height: 20px;">
					        </a>
					    </c:if>
					</td>
				</tr>   
    	  </c:forEach>    	
				</tbody>
		</table>   
</div>	
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>