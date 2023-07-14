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
</style>
<body>
<div id ="mainpage_body">
	<section id = "body_top_section">
		<!-- 최신 음악 그리드 -->
		<div id ="track_grid">
			<h1 id = "blackword">HYPEMUSIC STUDIO</h1>
			<div class="grid_controller">
				<div class="track_grid_container">
					<div class="track_grid_item">						
					
					</div>			
				</div>			
			</div>
		</div>
		
		<!-- Top 10  -->
		<div id ="top10_chart">
			<h1 id = "blackword">HYPEMUSIC CHART <span> > </span></h1>
			<ol id = "top10">
				<!-- 트랙별 -->
				<c:forEach var="top10tracks" items="${getTop10Tracks}" begin="0" end="9" varStatus="loop">
	            <li><a href="/musicinfo/${top10tracks.track_id }"><img src ="${top10tracks.album_img}" id = "top10track_img"></a>
		             <span id ="top10_title"><span id ="boldword">${loop.index + 1}.</span> <a href="/musicinfo/${top10tracks.track_id }" id = "blackword">${top10tracks.title }</a></span>
		             <span id ="top10_artist"><a href="/artustinfo/${top10tracks.artist_id }">${top10tracks.artist }</a></span>
		        </li>
	            </c:forEach>
	            <!-- 나머지 순위에 대한 항목을 추가하시면 됩니다 -->
        	</ol>
		</div>		
	</section>
</div>
</body>

<!-- 풋터 -->
<footer>
<jsp:include page="footer.jsp"></jsp:include>
</footer>
</html>