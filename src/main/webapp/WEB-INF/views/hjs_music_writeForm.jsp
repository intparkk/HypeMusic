<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>HYPEMUSIC : 답글쓰기</title>
<style>
.text {
width: 500px;
height: 40px;
}
table,th,td{
border: 1px solid lightgray;
}
	/* 박정수 CSS*/
    #detailsong_body {
        margin: 20px 120px;
        padding: 0;
        font-family: Arial, sans-serif;
        color: #3f3f3f;
    }
    
    #blackword{
    	color: black;
    }
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
    
    .album_list_blank {
	    margin-left: 25px;
	    margin-right: 25px;
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
	
	a {
		color : #333333;
		text-decoration : none;
	}
	
	a:hover {
		color: #000000;
     	 font-weight: bold;
	}	
		

</style>
</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<!--  박정수 곡 정보 파트 -->
<div id = "detailsong_body">
    <h1 id = "blackword">${trackInfo[0].title }</h1>
<section class="detailsong_section">
			<!-- 자켓 커버  -->
			<div class = "detailpage_img">			
            <a href="/music_info?track_id=${trackInfo[0].track_id }" class="image_typeAll" id="atag_track_id" data-value="${trackInfo[0].track_id}">
                <img width="255" height="255" src="${trackInfo[0].album_img}">
            </a>
            </div>
            <!-- 자켓 커버와 리스트 사이에 공백용 -->
                <div class="album_list_blank">                    
                </div>
            <!-- 트랙 상세정보 -->
                <dl class="list">
                	<strong id ="blackword">${trackInfo[0].title}</strong>
                	<br>
                	<br>
                	<dt> <a href="/artistinfo/${trackInfo[0].artist_id}"> ${trackInfo[0].artist}</a></dt>
                	<br>                	
                    <dt><span>앨범</span> 
                    &nbsp; &nbsp; 
                    <a href="/albuminfo/${trackInfo[0].album_id}">${trackInfo[0].album_name}</a>
                    </dt>                    
                    <br>
                    <dt>발매일 &nbsp; ${trackInfo[0].release_date}</dt>
                    <br>
                    <dt>장르 &nbsp; &nbsp; &nbsp;${trackInfo[0].genre}</dt>
                    <br>
                    <dt>
                    <img width="30" height="25" src = "/img/pink_heart1.jpg"> &nbsp;
                    <span id ="icon_nextword">${trackInfo[0].like_count} &nbsp; &nbsp;</span>
                    
                	<!--  재생 버튼 완성본 입니다 -->
                    <button type="button" title="재생" class="btn play-btn">
                        <a href="${trackInfo[0].youtube_url}" target="_blank"><img src="/img/hjs_play.png" alt="재생" style="width: 30px; height: 30px;"></a>
                    </button> &nbsp;
                	<jsp:include page="addbutton.jsp"></jsp:include>                	
                	</dt>         
                </dl>   
</section>
<!-- 가사 -->
<section id ="lyrics_section">
	<h2 id = "blackword">lyrics</h2>
      <div class ="lyrics">
      	<p>${trackInfo[0].lyrics }</p>
      </div>     
</section>
<h3>답글</h3>
<form action="/write_comment" method="post">
<input type="hidden" name="track_id" value="${dto.track_id }">
<input type="hidden" name="user_id" value="${dto.user_id }">
글내용:${dto2.comment_content}<br>
부모글:${dto2.comment_id}<input type="hidden" name="parent_id" value="${dto2.comment_id}"><br>
<br>
작성자 :${userInfo.name }<br>
답글 : <textarea class="text" name="comment_content"></textarea>
<input type="submit" value="저장하기">
</form>
<br><br>
<!-- 박정수 : 무조건 이전페이지로 이동하게 수정하였습니다 -->
<a href="javascript:history.back()">이전으로</a><br><br>
</div>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>