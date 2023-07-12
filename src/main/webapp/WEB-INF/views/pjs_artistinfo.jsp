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
    .artist_tracks img {
        width: 60px;
        height: 60px;
        margin-right: 10px;
    }
</style>
<body>
    <h1>${artistInfo[0].artist }</h1>
	<section class="detailsong_section">
				<div class = "detailpage_img">			
	            <a href="#" class="image_typeAll">
	                <img width="282" height="282" src="${artistInfo[0].artist_img}">	                
	            </a>
	            </div>
            	<div class = "artist_brief">
					<h2>아티스트 소개</h2>
					<a>${artistInfo[0].artist_brief }</a>
				</div>
	</section>
	
	<div class = "artist_tracks">
		    <h2>아티스트 수록곡</h2>
	    <ul>
	        <c:forEach var="track" items="${artistInfo}">
	            <li>
	                <img src="${track.album_img}" alt="Album Image">
	                ${track.title} - ${track.artist}
	                <button type="button" title="재생" class="btn">
	                    <span class="cnt">재생</span>
	                </button>    
		            <button type="button" title="담기" class="btn">
	                    <span class="cnt">담기</span>
	                </button>
	            </li>
	        </c:forEach>
	    </ul>	
	</div>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>
</html>