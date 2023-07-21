<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/header.css?after">
</head>
<style>
	a {
		color : #333333;
		text-decoration : none;
	}
	
	a:hover {
		color: #000000;
     	 font-weight: bold;
	}
	 .admin_btn
     {
        background-color: white;
        border: none;
        color: gray;
        padding: 8px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 8px;
    }
     .admin_btn:hover {
      background-color: #ffffff;
      color: #000000;
      font-weight: bold;
	}  	
</style>
<header>
<div id="header">
	<div class = head_top>
		<div class="head_top_left">
			<a title="이용권구매" href = "/pjs_ticket"><button class="buy_ticket_btn">이용권구매</button></a>
		</div>
		<div class="head_top_right">
		<!-- rank 수정 부탁드립니다! -->
			<span title="환영코드">
			  <c:choose>
			    <c:when test="${empty userInfo.id}">
			      <span class="user_states">방문객</span>
			    </c:when>
			    <c:otherwise>
			      <c:choose>
			        <c:when test="${userInfo.rank eq 'ticket'}">
			          <img src="/img/ticket_icon.png" alt="이용권 아이콘" style="width: 20px; height: 20px;"/>
			        </c:when>
			        <c:when test="${userInfo.rank eq 'admin'}">
			          <img src="/img/admin_icon.png" alt="관리자 아이콘" style="width: 20px; height: 20px; margin-left: 20px; margin-top: -5px;" />
			        </c:when>
			      </c:choose>
			      <span class="user_states">${userInfo.id}</span>
			    </c:otherwise>
			  </c:choose>
			  님 환영합니다!
			</span>
		</div>
	</div>
	<!-- 로고 클릭시 메인페이지 이동 -->
	<!--  메인페이지 변경 시 href 변경요망 -->
	<div class="head_middle">
        <a href="/Mainpage" title="Go_Mainppge">
        	<img src="/img/logo2.jpg" alt="로고" class="logo">
        </a>
        <!--  검색 기능  -->
        <div class="search-input-container">
        	<form action="/search" method="get" id="search-form">
				<input type="text" name="keyword" placeholder="곡 또는 가수를 입력하세요" class="search_box">
		  		<div class="search-icon-container">
					<button type="submit" class="search-btn"><img src="/img/search_icon3.jpg" width="35px" height="35px" alt="검색아이콘" class="search-btn-img"></button>
		  		</div>
		  	</form>
		  	<pre id="search-results"></pre>
		 </div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		const form = document.querySelector('#search-form'); // form 태그 가져오기
		const input = document.querySelector('input[name=keyword]'); // input 태그 가져오기
	
		form.addEventListener('submit', function(event) { // form submit 이벤트 리스너 등록
		    event.preventDefault(); // 기본 동작(새로고침) 막기
	
		    const keyword = input.value; // 검색어 가져오기
	
		    if (keyword.trim().length === 0) {
		        alert("검색어를 입력해주세요.");
		        event.preventDefault();
		    } else {
		        const url = '/search/' + keyword; // URL 생성
		        window.location.href = url; // URL 변경
		    }
		});		
	</script>	
	<div class="head_bottom">
	<!-- 메뉴 부분 -->
	    <div class="head_bottom_left">
	      <a href="/hjs_music_top100" title="top100"><button class="music_chart_btn">음악차트</button></a>
	      <a href="/nowmusic" title="newmusic"><button class="new_music_btn">최신음악</button></a>
	      <a href="hjs_music_genre" title="genremusic"><button class="genre_music_btn">장르음악</button></a>
	      <a href="/pjs_news" title="starmagazine"><button class="star_magazine_btn">스타매거진</button></a>
	      <a href="" title="music4u"><button class="music_4u_btn">뮤직4U</button></a>
	      <a href="/myPlaylist" title="mymusic"><button class="my_music_btn">마이뮤직</button></a>	      
	    </div> 
	    <div class="head_bottom_right">
	    <!-- 내정보 부분 -->
	    <!-- 등급에 따른 조건 수정해야함(수정함) -->
			<c:choose>
			  <c:when test="${empty userInfo.id}">
			    <a href="/login" title="로그인"><button class="login_btn">로그인</button></a>
			    <a href="/signup" title="회원가입"><button class="signup_btn">회원가입</button></a>
			  </c:when>
			  <c:when test="${userInfo.rank eq 'normal'}">
			    <a href="/myInfo" title="내정보"><button class="myInfo_btn">내정보</button></a>
			    <a href="/logout" title="로그아웃"><button class="logout_btn">로그아웃</button></a>
			  </c:when>
			  <c:when test="${userInfo.rank eq 'ticket'}">
			    <a href="/myInfo" title="내정보"><button class="myInfo_btn">내정보</button></a>
			    <a href="/logout" title="로그아웃"><button class="logout_btn">로그아웃</button></a>
			  </c:when>
			  <c:when test="${userInfo.rank eq 'admin'}">
			    <a href="/myInfo" title="내정보"><button class="myInfo_btn">내정보</button></a>
			    <a href="/logout" title="로그아웃"><button class="logout_btn">로그아웃</button></a>
			    <a href="/admin" title="관리자"><button class="admin_btn">관리자</button></a>
			  </c:when>
			</c:choose>
	    </div>
	   </div>	
	</div>
	        <hr class="header_line">        
</header>
<body>

</body>
</html>