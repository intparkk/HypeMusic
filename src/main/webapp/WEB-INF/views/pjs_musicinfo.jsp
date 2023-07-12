<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HYPEMUSIC 곡 정보 ${trackInfo[0].title }</title>
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
</style>
<body>
    <header>
        <%@include file="header.jsp"%>
    </header>
    <h1>${trackInfo[0].title }</h1>
<section class="detailsong_section">
			<div class = "detailpage_img">			
            <a href="#" class="image_typeAll">
                <img width="282" height="282" src="${trackInfo[0].album_img}">
            </a>
            </div>
                <div class="song_name">
                    <strong>${trackInfo[0].title}</strong>
                </div>
                <dl class="list">
                	<dt>${trackInfo[0].artist}</dt>
                    <dt>앨범</dt>
                    <dd><a href="">${trackInfo[0].album_name}</a></dd>
                    <dt>발매일</dt>
                    <dd>${trackInfo[0].release_date}</dd>
                    <dt>장르</dt>
                    <dd>${trackInfo[0].genre}</dd>
                    <dt>좋아요</dt>
                    <dd>${trackInfo[0].like_count}</dd>
                </dl>
            <div class="detailpagebutton">
                <button type="button" title="담기" class="btn">
                    <span class="button_icons type03 scrap"></span>
                    <span class="cnt">담기</span>
                </button>                
            </div>
</section>

      <div class ="lyrics">
      	<a>${trackInfo[0].lyrics }</a>
      </div>     

</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>
