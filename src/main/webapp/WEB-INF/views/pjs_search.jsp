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
<header>
<jsp:include page="header.jsp"></jsp:include>         
</header>
<body>
	<div id = "search_body">
	<h1 id="ment">"${keyword }"&nbsp에 대한 검색결과입니다.</h1>
	<!-- 트랙 검색결과 섹션 -->
	<section id ="search_track_result">
		<h2>관련 트랙</h2>
		<ul>
	        <c:forEach var="track" items="${search_all}">
	            <li>
	             	<a href="/music_info?track_id=${track.track_id}">
	                <img id = "track_img" src="${track.album_img}">
	                </a>
		            <a href="/music_info?track_id=${track.track_id}">
	                    ${track.title}
	                </a>
	                -
	                <a href="/artistinfo/${track.artist_id}">
	                    ${track.artist}
	                </a>
	                -
	                <a href="/albuminfo/${track.album_id}">
	                    ${track.album_name}
	                </a>
	                - ${track.release_date } - ${track.like_count }
		            <button type="button" title="재생" class="btn play-btn">
		                <img src="/img/hjs_play.png" alt="재생" style="width: 30px; height: 30px;">
		            </button>
		            &nbsp;
		            <button type="button" title="담기" class="btn add-btn">
		                <img src="/img/hjs_put.png" alt="담기" style="width: 30px; height: 30px;">
		            </button>
	            </li>
	        </c:forEach>
	    </ul>
	</section>
	<!--  아티스트 검색결과 섹션 -->
	<section id="search_artist_result">
	    <h2>관련 아티스트</h2>
	    <ul id="artist_ul">
	        <c:set var="previousArtistId" value="" />
	        <c:forEach var="artist" items="${search_all}">
	            <c:if test="${artist.artist_id ne previousArtistId}">
	                <c:set var="previousArtistId" value="${artist.artist_id}" />
	                <div id = "artist_package">
	                <li>
	                    <a href="/artistinfo/${artist.artist_id}">
	                        <img id="artist_img" src="${artist.artist_img}">
	                    </a>
	                </li>
	                <li id="artist_name_ul">
	                    ${artist.artist}
	                </li>
	                </div>
	            </c:if>
	        </c:forEach>
	    </ul>
	</section>
			
	<!--  앨범 검색결과 섹션 -->
	<section id ="search_album_result">
		<h2>관련 앨범</h2>
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
</body>
<jsp:include page="footer.jsp"></jsp:include>  
</html>