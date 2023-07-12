<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.study.springboot.controller.pjs_top100controller" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>인기 차트 - TOP 100</title>
</head>

<header>
<jsp:include page="header.jsp"></jsp:include>
</header>
<link rel="stylesheet" href="/top100.css">
<style>
	.suffle_listen:hover,
	.all_listen:hover,
	.listen:hover,
	.put:hover,
	.down:hover,
	.FLAC:hover,
	.present:hover
	 {
	    background-color:#04aa6d;
	    color: white;
	    cursor: pointer;
	    background-size: 50%; /* Show only half of the background color */
	    background-position: right; /* Align the background to the right */
	}
	

body {
	
	width:85%;
	display: inline-block;
	margin-left: 120px;
}

h1 {
	color:gray;
	margin-left:40px;
	margin-bottom:0;
	padding-bottom:0;
}
h2 {
	text-align:center;
	color:gray;
	margin:0;
	padding:0;
}
.section_3 {
	margin-top:0;
	margin-bottom:0;
}

.music_btn {
	display:flex;
	gap:10px;
    background-color: white;
    color: gray;
    padding: 15px 15px;
    font-size: 20px;
    margin-top:0;
    margin-bottom:0;
  
    
}
.suffle_listen,
.all_listen,
.listen,
.put,
.down,
.FLAC,
.present
{
	width: 75px;
	height:35px;
	border: 1px solid gray;
	border-radius: 20px;
	color: gray;
	background-color: white;
	font-size: 13px;
	
}

.suffle_listen:hover,
.all_listen:hover,
.listen:hover,
.put:hover,
.down:hover,
.FLAC:hover,
.present:hover
 {
    background-color:#04aa6d;
    color: white;
    cursor: pointer;
}	
table{
	border-collapse:collapse;
	
}

table,th, td{
	border: none;
	border-bottom: 1px solid lightgray;
	border-top: 1px solid lightgray;
}
th, td{
	padding-left: 20px;
	padding-right: 20px;
	color: gray;
		
}

.checkmark {
    position: absolute;
    top: 0;
    left: 0;
    width: 20px;
    height: 20px;
    background-color: #eee;
}

.checkmark::after {
    content: '';   
    position: absolute;
    top: 3px;
    left: 7px;
    width: 4px;
    height: 8px;
    border: solid white;
    border-width: 0 3px 3px 0;  /* top right bottom left */
    transform: rotate(45deg);
    color: #04aa6d;
}


.track {
	display: inline-block;
	position: relative;
	overflow: hidden;
	width: 100px;
	height: 100px;
	margin:12px 12px 12px 12px;
	
}

.track img{
	width: 100px;
	height: 100px;
	margin:0px 5px 8px 1px;
	
}

.track .caption {
    position: absolute;
    top:0;
    bottom: 0;
    left: 0;
    width: 100px;
    background-color: rgba(0, 0, 0, 0.7);
    color: #fff;
    padding:0;
    margin:0;
    opacity: 0;
    transition: opacity 0.3s ease;
} 
.track .caption p{
	font-size: 10px;
	margin-top:15px;
	padding:5px;
	padding-top:0;
}       
.track:hover .caption {
    opacity: 1;
} 

.logo1,
.logo2,
.logo3,
.logo4
 {
	width:45px;
	height:45px;
}

		
</style>
<body>
    <section>
        <h1>인기 차트 - TOP 100</h1>
		<table>		
			<thead>				
					<th>순위</th>
					<th>ㅡ</th>
					<th></th>
					<th>곡정보</th>
					<th>앨범</th>
					<th>Like</th>
					<th>듣기</th>
					<th>담기</th>
					<th>다운</th>
					<th>뮤비</th>
				</tr>
			</thead>			
    	<tbody>    	
    	<c:forEach var="trackInfo_like" items="${top100_tracks}" begin="0" end="99" varStatus="loop">				
				<tr>	
					<td>
						${loop.index + 1}
					</td>					
					<!--  곡정보 이미지 추가 -->
					<td><a href="/musicInfo?track_id=${trackInfo_like.track_id }" id="info"><img src = "/img/music_info_icon2.jpg" style="border: none; width: 25px; height: 30px;"></a></td>
					<td>
						 <div class="track">
          				 <a href="/musicInfo?track_id=${trackInfo_like.track_id }"><img src="${trackInfo_like.album_img}"></a>
        				 	<div class="caption">
                			<p>${trackInfo_like.title}</p>
                			<p>${trackInfo_like.artist}</p>
            				</div>
        				 </div>
					</td>
					<td>
					<div class="caption1">
				      <p>${trackInfo_like.title}</p>
				      <p>${trackInfo_like.artist}</p>
				    </div>
					</td>
					<td>
					<div class="caption2">
      				<p>${trackInfo_like.album_name}</p>
      				</div>
					</td>
					<td>
					<div class="caption3">
     				<p>${trackInfo_like.like_count}</p>
					</td>
					<td><a href="#"><img src="img/hjs_play.png" class="logo1" style="border: none; width: 20px; height: 20px;"></a></td>
					<td>
					<!-- 담기 버튼 -->
					    <c:if test="${rank == null || rank < 1}">
					        <a href="#" onclick="showLoginAlert()">
					            <img src="/img/hjs_put.png" alt="담기" style="border: none; width: 20px; height: 20px;">
					        </a>
					    </c:if>
					    <c:if test="${rank != null && rank >= 1}">
					    		<!--  onclick 이벤트 jsp 불러오는 함수에 맞게 꼭 변경해주세요! -->
					        <a href="#" onclick="addTrack('${trackInfo_like.track_id}')">
					            <img src="/img/hjs_put.png" alt="담기" style="border: none; width: 20px; height: 20px;">
					        </a>
					        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
						    <script>
						        function showLoginAlert() {
						            alert("로그인이 필요합니다.");
						        }
						        // ajax 방식으로 변경
						        function addTrack(trackId) {
						            $.ajax({
						                url: '/addTrack',
						                type: 'POST',
						                data: { addTrack: trackId },
						                success: function(response) {
						                    alert("음악 담기 성공!"); // 음악 담기 성공시 알림창 띄우기
						                    console.log(response);  
						                },
						                error: function(error) {
						                    alert("이미 담겨 있는 음악입니다!"); // 이미 담겨 있는 음악일시 알림창 띄우기
						                    console.log(error);  
						                }
						            });
						        }
						    </script>
					    </c:if>
					<!-- 여기까지가 담기 버튼입니다 -->	
					</td>
					<td><a href="#"><img src="img/hjs_down.png" class="logo3" style="border: none; width: 20px; height: 20px;"></a></td>
					<td><a href="#"><img src="img/hjs_muve.png" class="logo4" style="border: none; width: 20px; height: 20px;"></a></td>					
				</tr>    	 
    	 </c:forEach>    	
				</tbody>
		</table>   
    </section>
</body>
<footer>
</footer>
</html>
    			
    			
 