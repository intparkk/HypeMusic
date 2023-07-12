<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HYPEMUSIC 앨범 정보 ${albumInfo[0].album_name }</title>
</head>
<style>
    .detailsong_section {
        display: flex;
    }

    .detailpage_img {
        flex: 0 0 282px;
        margin-right: 20px;
    }

    .lyrics {
        clear: left;
        margin-top: 20px;
    }

    .list {
        margin-top: 20px;
    }

    .album_tracks {
        margin-top: 20px;
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
        width: 60px;
        height: 60px;
        margin-right: 10px;
    }
</style>
<body>
    <header>
        <%@include file="header.jsp"%>
    </header>
    <h1>${albumInfo[0].album_name }</h1>
<section class="detailsong_section">
			<div class = "detailpage_img">			
            <a href="#" class="image_typeAll">
                <img width="282" height="282" src="${albumInfo[0].album_img}">
            </a>
            </div>
                <div class="song_name">
                    <strong>${albumInfo[0].album_name}</strong>
                </div>
                <dl class="list">
                	<dt>${albumInfo[0].artist}</dt>
                    <dt>앨범</dt>
                    <dd><a href="">${albumInfo[0].album_name}</a></dd>
                    <dt>발매일</dt>
                    <dd>${albumInfo[0].release_date}</dd>
                </dl>
</section>
      
	  <div class="album_tracks">
	    <h2>앨범 수록곡</h2>
	    <ul>
	        <c:forEach var="track" items="${albumInfo}">
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
	
	  <div class ="album_brief">
	  	<h2>앨범 소개글</h2>
      	<a>${albumInfo[0].album_brief }</a>
      </div>

</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>
