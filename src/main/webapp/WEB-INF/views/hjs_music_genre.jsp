<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> --%>
<%@ page import="java.util.List" %>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPEMUSIC 장르음악</title>
<style>

body{
	
	width:85%;
	/* display: inline-block; */
	/* margin-left: 120px; */
	margin: auto;
}


#genre_title {
	/* margin-left:123px; */
	margin: auto;
	margin-top: 20px;
}

 #genre_body {
        margin: 20px ;
        padding: 0;
        font-family: Arial, sans-serif;
        color: #3f3f3f;
        } 
        
 #form_btn
 {
 	margin: 15px;
    background-color: white;
    border: none;
    color: gray;
    padding: 8px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
 /*    margin: 4px 2px; */
    cursor: pointer;
    border-radius: 8px;
}  
   
   #form_btn:hover
{
     background-color: #ffffff;
     color: #000000;
     font-weight: bold;
}

 .active {
    border: 2px solid #000000;
    font-weight: bold;
    color: black;
  }
  h1{
  text-align: center;
  }

table{
    width: 100%; 
	border-collapse:collapse;
	margin: auto;
	border: none;
	border-bottom: 1px solid lightgray;
	border-top: 1px solid lightgray;
	color: #333333;	
	/* width:950px; */
}
th, td{
	border: none;
	border-bottom: 1px solid lightgray;
	border-top: 1px solid lightgray;
	color: #333333;
	margin-left:20px;
	margin-right:20px;
	padding-top: 15px;
	padding-bottom: 15px;
	text-align: center;
}


  td {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 250px;
  }
  
  .text_over{
  	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 100px; /* 텍스트가 표시될 최대 너비를 지정합니다 */
    width:100px;
  }   

  #genreForm {
  display: flex;
  justify-content: center;
  align-items: center;
  	margin-bottom:30px;
  }
  
#table_img {
   transition: transform 0.5s ease;
 }

 #table_img:hover {
   transform: scale(1.1);
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
		<h1 id ="genre_title">장르음악</h1>
	<div id ="genre_body">
		<!--  상단 부분 -->
		<section id ="genre_body_top">
		
		<!-- 버튼 방식으로 변경하였습니다. -->
		<!-- 재즈, 뉴에이지는 한두곡 밖에 없어서 주석처리하여 제외하였습니다 -->		
		<form id="genreForm" action="/hjs_music_genre">
		  <!-- <button type="submit" name="preference" value="">장르를 선택해주세요</button> -->
		  <button id="form_btn" type="submit" name="preference" value="발라드">발라드</button>
		  <button id="form_btn" type="submit" name="preference" value="드라마">드라마OST</button>
		  <button id="form_btn" type="submit" name="preference" value="영화">영화OST</button>
		  <button id="form_btn" type="submit" name="preference" value="댄스">댄스</button>
		  <button id="form_btn" type="submit" name="preference" value="POP">팝</button>
		  <button id="form_btn" type="submit" name="preference" value="포크">포크</button>
		  <button id="form_btn" type="submit" name="preference" value="Soul">알앤비&amp;소울</button>
		  <!--<button type="submit" name="preference" value="재즈">재즈</button>  -->
		  <button id="form_btn" type="submit" name="preference" value="메탈">메탈</button>
		  <!-- <button type="submit" name="preference" value="NewAge">뉴에이지</button>  -->
		  <button id="form_btn" type="submit" name="preference" value="인디">인디</button>
		</form>
		</section>
		
		<!--  차트 부분 -->
		<section id ="genre_body_middle">
			<table>			
			  <tr class ="table_header">
			    <th>No</th>
			    <th>장르</th>
			    <th>앨범이미지</th>
			    <th>곡정보</th>
			    <th>앨범</th>
			    <th>앨범발매일</th>
			    <th>듣기</th>
			    <th>담기</th>
			  </tr>
			  <div id ="table_header_blank"></div>
			    <tr class = "table_contents">
			  	  <c:forEach var="tracks" items="${list}" begin="0" end="99" varStatus="loop">
			      <td>${loop.index + 1}</td>
			      <td class ="text_over">${tracks.genre}</td>
			      <td><a href="/music_info?track_id=${tracks.track_id}" id="atag_track_id" data-value="${tracks.track_id}"><img id="table_img" src="${tracks.album_img}" alt="album_image" style="width: 100px; height: 100px;"></a></td>
			      <td>
			        <p><a href="/music_info?track_id=${tracks.track_id}">${tracks.title}</a></p>
			        <p><a href="/artistinfo/${tracks.artist_id}">${tracks.artist}</a></p>
			      </td>
			      <td><a href="/albuminfo/${tracks.track_id}">${tracks.album_name}</a></td>
			      <td class ="text_over">${tracks.release_date}</td>
			      <td>
			      <!--  재생 버튼 -->
			      <a href=""><button type="button" title="재생" class="btn play-btn" >
                    <img src="/img/hjs_play.png" alt="재생" style="width: 30px;  height: 30px;">
                	</button>
                	</a>
                </td>
                <td><jsp:include page="addbutton.jsp"></jsp:include> </td>
			    </tr>
			  </c:forEach>
			</table>
		</section> 
	</div>	
<!--  장르 선택 스크립트 -->	
<script>
function submitForm(){
	document.getElementById("genreForm").submit();
}

// 클릭 효과 (클릭시 해당 장르 버튼 볼드, 테두리 처리)
// 클릭 효과 주고싶었으나 페이지를 다시  불러오는 방식이라 계속 초기화가 되네요... 
// 굳이 하려면 redirect 방식에서 바꿔야 할듯요

/*window.onload = function() {
    var buttons = document.querySelectorAll("#genreForm button");
    var initialButton = document.querySelector("#genreForm button[value='발라드']");
    
    // 페이지 최초 진입 시 "발라드" 버튼 클릭
    initialButton.classList.add("active");
    
    buttons.forEach(function(button) {
      button.addEventListener("click", function() {
        // 클릭된 버튼에 active 클래스 추가
        buttons.forEach(function(btn) {
          btn.classList.remove("active");
        });
        this.classList.add("active");
      });
    });
  };*/

</script>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>