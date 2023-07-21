<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%> --%>
<%@page import="com.study.springboot.dto.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<%@ page import="com.study.springboot.controller.pjs_detailpagecontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>HYPEMUSIC : ${trackInfo[0].title}</title>
<style>
/* 진서님 CSS*/
.text {
width: 700px;
height:60px;
font-size: 15px;
background-color: rgb(255, 243, 230);
border: none;
}
#submit_button {
border: none;
background-color: white;
font-size: 17px;
font-weight: bold;
color:#5D5D5D;
cursor:pointer;
}
#submit_button:hover,
#list_button:hover {
color: #030303;
}
#list_button {
border: none;
background-color: white;
color: #5D5D5D;
}
table {
    border-collapse:collapse;
    width: 800px;
    border: none;
    border-top: 1px solid rgb(255, 243, 230);
    border-bottom: 1px solid rgb(255, 243, 230);
}

th ,td{
border-top: 1px solid rgb(212, 193, 177);
border-bottom: 1px solid rgb(212, 193, 177);
}
th {
background-color : rgb(204, 179, 166);
}
th,td {
max-width: 250px;
}

td {
padding-left: 25px;
}
tr:hover {
background-color:rgb(237, 233, 221); 
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

<!-- 진서님 댓글 파트 -->
<section id = "reply_section">
<c:choose>
<c:when test="${not empty userInfo }">
<h3 id ="blackword">댓글달기</h3>
<form action="/write_comment" method="post">
<input type="hidden" name="track_id" value="${trackInfo[0].track_id }">
글번호 : ${dto2.comment_id }<br>
작성자 :${userInfo.name }<br>
댓글&nbsp;&nbsp;&nbsp; : <textarea class="text" name="comment_content"></textarea>
<input type="submit" value="등록" id="submit_button">
</form>
</c:when>
<c:otherwise>

</c:otherwise>

</c:choose>
<br>
<br>
<table>
<thead>
	<tr>
		<th>글번호</th>
		<th>부모글</th>
		<th>작성자</th>
		<th>댓글</th>
		<th>작성시간</th>
<c:choose>
<c:when test="${not empty userInfo }">	
		<th>&nbsp; &nbsp; 답글</th>
		<th>&nbsp; &nbsp; 수정</th>
		<th>&nbsp; &nbsp; 삭제</th>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>				
	</tr>
</thead>
<tbody>

	<c:forEach var="dto2" items="${list}">  
	 <tr>
		<td>${dto2.comment_id }</td>
		<td>${dto2.parent_id }</td>
		<td>${dto2.name }</td>
		<td>${dto2.comment_content }</td>
		<td>${dto2.comment_time }</td>
<c:choose>
<c:when test="${not empty userInfo }">
		<td><a href="/reply?track_id=${trackInfo[0].track_id }&comment_id=${dto2.comment_id }">답글</a></td>
	<c:choose>
	<c:when test="${userInfo.user_id eq dto2.user_id}">
		<td><a href="/modifyForm?track_id=${trackInfo[0].track_id }&comment_id=${dto2.comment_id }">수정</a></td>
		<td><a href="/delete?track_id=${trackInfo[0].track_id }&comment_id=${dto2.comment_id }">삭제</a></td>
	</c:when>
	<c:otherwise>
		<td><a href="#" class="edit-link">수정</a></td>
		<td><a href="#" class="delete-link">삭제</a></td>
		
	</c:otherwise>
	</c:choose>	
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>		
	</tr> 
	</c:forEach>  	
</tbody>

</table>
<br>
<a href="javascript:history.back()"  id="list_button">이전으로</a><br><br>
</section>
</div>
<script>
    // 로그인 경고창을 띄우는 함수
    function showLoginAlert() {
        alert("권한이 없습니다! 관리자에게 문의해주세요.");
    }

    // "수정" 링크에 클릭 이벤트 리스너 추가
    const editLinks = document.querySelectorAll('.edit-link');
    editLinks.forEach((editLink) => {
        editLink.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 동작(링크 이동) 방지
            showLoginAlert();
        });
    });

    // "삭제" 링크에 클릭 이벤트 리스너 추가
    const deleteLinks = document.querySelectorAll('.delete-link');
    deleteLinks.forEach((deleteLink) => {
        deleteLink.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 동작(링크 이동) 방지
            showLoginAlert();
        });
    });
</script>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>