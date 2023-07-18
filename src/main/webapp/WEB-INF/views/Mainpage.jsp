<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:: HYPEMUSIC STUDIO ::</title>
<link rel="stylesheet" href="/Mainpage.css?after">
</head>
<!--  헤더  -->
<header>
<jsp:include page="header.jsp"></jsp:include>
</header>
<style>
	#mainpage_body {
        margin: 20px 120px;
        padding: 0;
        font-family: Arial, sans-serif;
        color: #3f3f3f;
    }
    
    #blackword{
    	color: black;
    }
    
    #boldword{
    	 font-weight: bold;
    }
	#body_top_section {
		display : flex;
		flex-direction : row;
		justify-content: space-between;	
		height: 491px;
	}	
	#top10_chart ol {
	    border: 1px solid #ccc;
	    padding: 10px;
	    margin: 0;
	    list-style: none;	    
	}

	#top10_chart ol li {
	    padding: 5px;
	    margin-bottom: 5px;
	    border-bottom: 1px solid #ccc;
	    white-space: nowrap;
    	transition: transform 0.3s ease-in-out;
    	overflow: hidden;
	    text-overflow: ellipsis;
	    width: 300px;
	}

	#top10_chart ol li:hover {
	    transform: scale(1.1);
	}

	#top10_chart ol li:hover img {
	    display: block;
	}
	
	#top10_chart ol li img {
	    display: none;
	    width: 50px;
	    height: 50px;
	}
	
	#top10_title {
    float: left;
   	overflow: hidden;
    text-overflow: ellipsis;
    max-width: 150px;
	}	
	#top10_artist {
	    float: right;
	}
	
	#top10_chart a {
    color: gray;
    text-decoration: none;
	}
	
	#top10_chart a:hover {
    color: black;
    text-decoration: none;
	}
	
	.grid_img_wrapper {
	  position: relative;
	  display: inline-block;
	}
	
	.grid_info {
	  position: absolute;
	  top: 0;
	  left: 0;
	  width: 86%;
	  height: 92%;
	  opacity: 0;
	  visibility: hidden;
	  background-color: rgba(0, 0, 0, 0.8);
	  padding: 5px 10px;
	  color: #fff;
	  transition: opacity 0.3s, visibility 0.3s;
	  display:flex;
	  flex-direction: column;
    flex-wrap: nowrap;
    justify-content: center;
    align-items: center;
	}
	
	.grid_title,
	.grid_artist {
	  white-space: nowrap;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  text-align: center;
	  width: 140px;
	}
	
	.grid_title:hover,
	.grid_artist:hover {
	  text-decoration: underline;
	}	
	.grid_title {
	  font-weight: bold;
	}
	#grid_states {
	 	font-weight: bold;
	 	font-size:16px;
	}
	
	#grid_click {
		color: white;
		text-decoration: none;
	}
	
	.grid_img_wrapper:hover .grid_info {
	  opacity: 1;
	  visibility: visible;
	}
	
	 .track_grid_container {
    display: flex;
    grid-template-columns: repeat(4, 1fr);
    flex-direction: column;
  	}

	.track_grid_item img {
	  width: 150px;
	  height: auto;
	  border: 1px solid gray;

	}
  .track_grid_item {
  	width: 637px;
  	/*margin-top: 58px;*/
	padding: 1px;
  }
  .grid_controller {  	
  	display:flex;
    flex-direction: row;
    justify-content: space-between;
    margin-right: 14px;
    margin-top: 58px;  
  }
  
	#grid_controller_button {
	  margin-right: 15px;
	}
	
	.circle_button {
	  width: 5px;
	  height: 14px;
	  background-color: white;
	  border: 1px solid gray;
	  border-radius: 50%;
	  margin-right: 0px;
	  cursor: pointer;
	}
	
	.circle_button.active {
	  background-color: black;
	}
	
	#body_bottom_section {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    grid-gap: 20px;
    justify-items: center;
    align-items: center;
    text-align: center;
    margin-top: 20px;
  }

  .bottom_artist_wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .bottom_artist_img {
    width: 100%;
    height: auto;
    max-width: 200px;
    transition: transform 0.3s ease;
  }
  
  .bottom_artist_img:hover {
    transform: scale(1.2);
  }

  .bottom_artist_info {
    margin-top: 10px;
  }

  .bottom_artist {
    font-size: 14px;
    font-weight: bold;
  }	
</style>
<body>
<div id ="mainpage_body">
	<section id = "body_top_section">
		<!-- 최신 음악 그리드 -->
		<div id ="track_grid">
			<h1 id = "blackword">HYPEMUSIC STUDIO</h1>
				<div class="track_grid_container">
					<div class="grid_controller">
						<span id="grid_states"></span>
							<span id="grid_controller_button">
								<!-- <button id="btn1" class="circle_button" alt="최신"></button> -->
								<button id="btn4" class="circle_button" alt="댄스"></button>
								<button id="btn2" class="circle_button" alt="POP"></button>
								<!-- <button id="btn3" class="circle_button" alt="R&B/SOUL"></button> -->
								<button id="btn5" class="circle_button" alt="랩/힙합"></button>
								<button id="btn6" class="circle_button" alt="록/메탈"></button>
								<button id="btn7" class="circle_button" alt="발라드"></button>
								<button id="btn8" class="circle_button" alt="인디"></button>
								<button id="btn9" class="circle_button" alt="국내"></button>
							</span>
					</div>			
					<div class="track_grid_item">
					  <c:forEach var="grid" items="${randomTracks}" begin="0" end="7">
					    <div class="grid_img_wrapper">
					      <img class="grid_img" src="${grid.album_img}" alt="앨범 이미지">
					      <div class="grid_info">
					        <span class="grid_title"><a id ="grid_click" href="/music_info?track_id=${grid.track_id }">${grid.title}</a></span>
					        <span class="grid_artist"><a id ="grid_click" href="/artistinfo/${grid.artist_id }">${grid.artist}</a></span>
					      </div>
					    </div>
					  </c:forEach>
					</div>			
				</div>
			</div>
		
		<!-- Top 10  -->
		<div id ="top10_chart">
			<h1 id = "blackword">HYPEMUSIC CHART <span> > </span></h1>
			<ol id = "top10">
				<!-- 트랙별 -->
				<c:forEach var="top10tracks" items="${getTop10Tracks}" begin="0" end="9" varStatus="loop">
	            <li><a href="/music_info?track_id=${top10tracks.track_id }"><img src ="${top10tracks.album_img}" id = "top10track_img"></a>
		             <span id ="top10_title"><span id ="boldword">${loop.index + 1}.</span> <a href="/music_info?track_id=${top10tracks.track_id }" id = "blackword">${top10tracks.title }</a></span>
		             <span id ="top10_artist"><a href="/artistinfo/${top10tracks.artist_id }">${top10tracks.artist }</a></span>
		        </li>
	            </c:forEach>
	            <!-- 나머지 순위에 대한 항목을 추가하시면 됩니다 -->
        	</ol>
		</div>		
	</section>
	
	<!-- 중단 이용권 구매 -->
    <section id="body_middle_section" style="display: flex; justify-content: center; margin-top:50px;">
        <a href = "#"><img src="/img/mainpage_ticket_logo.png" style="max-width: 100%;"></a>
    </section>
    
    <!--  하단 아티스트 항목 -->
    <section id="body_bottom_section">
    <h1>NOW ARTISTS</h1>
	 <c:forEach var="artist" items="${getRandomArtists}" begin ="0" end="13">
	    <div class="bottom_artist_wrapper">
	      <a href="/artistinfo/${artist.artist_id }"><img class="bottom_artist_img" src="${artist.artist_img}"></a>
	      <div class="bottom_artist_info">
	        <span class="bottom_artist"><a href="/artistinfo/${artist.artist_id }">${artist.artist}</a></span>
	      </div>
	    </div>
	  </c:forEach>
    </section>
    
</div>
<script>
    var genreMap = {
        "댄스": "댄스",
        "POP": "POP",
        "랩/힙합": "랩/힙합",
        "록/메탈": "록/메탈",
        "발라드": "발라드",
        "인디": "인디",
        "국내": "국내"
    };
    
    // window.onload 이벤트 리스너 추가
    window.onload = function() {
        // "댄스" 버튼 요소를 가져옴
        var danceButton = document.querySelector('button[alt="댄스"]');

        // "댄스" 버튼을 클릭하는 함수
        function clickDanceButton() {
            // 클릭 이벤트 생성
            var clickEvent = new Event('click');
            console.log(clickEvent);
            
            // "댄스" 버튼에 클릭 이벤트 발생시킴
            danceButton.dispatchEvent(clickEvent);
        }

        // "댄스" 버튼 클릭 함수 호출
        clickDanceButton();
    }
    
    // 첫 번째 실행 여부를 나타내는 변수
    var isFirstExecution = true;

    // 장르 체인지 버튼
    function changeGenre(event,genre) {
        console.log('genre:', genre); // 콘솔에 출력

        // 현재 선택된 장르 텍스트 표시용
        document.getElementById("grid_states").textContent = genreMap[genre];

        // 클릭시 다른 버튼은 active 제거용
        var buttons = document.getElementsByClassName("circle_button");
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].classList.remove("active");
        }
        // 선택된 버튼에 active 클래스 추가
        event.currentTarget.classList.add("active");

         // Ajax를 사용하여 서버로 genre 전송
         var xhr = new XMLHttpRequest();
         // POST 요청
         xhr.open('POST', '/getRandomTracks', true);
         xhr.setRequestHeader('Content-Type', 'application/json'); // 요청 헤더
         xhr.onreadystatechange = function () {
             if (xhr.readyState === 4 && xhr.status === 200) {
                 var response = JSON.parse(xhr.responseText);
                 // 랜덤 그리드 함수 호출
                 renderRandomTracks(response);
             }
         };
         // genre 값을 JSON 형식으로 변환하여 요청 본문에 설정하고 전송
         xhr.send(JSON.stringify({ genre: genre }));

    }

    // 버튼 클릭 이벤트 리스너 등록용
    var buttons = document.getElementsByClassName("circle_button");
    for (var i = 0; i < buttons.length; i++) {
        buttons[i].addEventListener("click", function (event) {
            var genre = this.getAttribute("alt");
            changeGenre(event, genre); // event 값을 전달
        });
    }
    
 // 서버로부터 받은 randomTracks 데이터를 활용하여 출력
    function renderRandomTracks(randomTracks) {
      var trackGridItem = document.querySelector(".track_grid_item");
      
      console.log("trackGridItem:", trackGridItem); // trackGridItem 출력
      
      trackGridItem.innerHTML = ""; // 기존의 내용을 지우고 시작

      // 최대 8개까지만 출력
      for (var i = 0; i < Math.min(randomTracks.length, 8); i++) {
        var grid = randomTracks[i];
        var gridItem = document.createElement("div");
        gridItem.className = "grid_img_wrapper";
        var img = document.createElement("img");
        img.className = "grid_img";
        img.src = grid.album_img;
        img.alt = "앨범 이미지";
        var gridInfo = document.createElement("div");
        gridInfo.className = "grid_info";
        var gridTitle = document.createElement("span");
        gridTitle.className = "grid_title";
        var titleLink = document.createElement("a");
        titleLink.id = "grid_click";
        titleLink.href = "/music_info?track_id=" + grid.track_id;
        titleLink.textContent = grid.title;
        
        // 출력되는 title 확인용 로그 출력
        console.log("Title:", grid.title);
        
        var gridArtist = document.createElement("span");
        gridArtist.className = "grid_artist";
        var artistLink = document.createElement("a");
        artistLink.id = "grid_click";
        artistLink.href = "/artistinfo/" + grid.artist_id;
        artistLink.textContent = grid.artist;

        // 요소들을 계층적으로 구성
        gridTitle.appendChild(titleLink);
        gridArtist.appendChild(artistLink);
        gridInfo.appendChild(gridTitle);
        gridInfo.appendChild(gridArtist);
        gridItem.appendChild(img);
        gridItem.appendChild(gridInfo);
        trackGridItem.appendChild(gridItem);
      }
    }
</script>


</body>

<!-- 풋터 -->
<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>
</html>