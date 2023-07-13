<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HYPEMUSIC 곡 정보 ${trackInfo[0].title }</title>
</head>
<style>
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
	
</style>
    <header>
        <%@include file="header.jsp"%>
    </header>
<body>
<div id = "detailsong_body">
    <h1 id = "blackword">${trackInfo[0].title }</h1>
<section class="detailsong_section">
			<!-- 자켓 커버  -->
			<div class = "detailpage_img">			
            <a href="#" class="image_typeAll">
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
                    
                    <button type="button" title="재생" class="btn play-btn" >
                    <img src="/img/hjs_play.png" alt="재생" style="width: 30px;  height: 30px;">
                	</button> &nbsp;
                	<span id ="icon_nextword">듣기</span> &nbsp; 
                    <button type="button" title="담기" class="btn add-btn" >
                    <img src="/img/hjs_put.png" alt="담기" style="width: 30px;  height: 30px;">
                	</button>
                	<span id ="icon_nextword">담기</span>  
                	</dt>         
                </dl>   
</section>
<!-- 가사 -->
<section id ="lyrics_section">
	<h2 id = "blackword">lyrics</h2>
      <div class ="lyrics">
      	<a>${trackInfo[0].lyrics }</a>
      </div>     
</section>
<!-- 만약 진서님 댓글작업 하신다면 이 섹션안에서 작업하시면 됩니다 -->

<!-- 댓글 작업을 하려고 하니, .... 경로 설정이 모호하게 되어 있어서 
경로 설정을 조금더 분명하게 지정해야 하는 것으로 나옵니다. 컨트롤러에 @RequestMapping("/여기이부분에")
경로 설정을 구체적으로 하라고 하는데, 만약에 지금의 경로설정을 유지하고 싶으시면, @RequestMapping대신에 
@GetMapping이나 @PostMapping을 사용하라고 나오네요. .... 
 -->

<section>

</section>
</div>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>
