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
<title>${keyword }에 대한 검색결과</title>
<link rel="stylesheet" href="/Mainpage.css?after">
</head>
<header>
<jsp:include page="header.jsp"></jsp:include>         
</header>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
    }

    h1 {
        margin: 20px;
        font-size: 24px;
    }

    #search_track_result {
        margin: 20px;
    }
    
    #search_artist_result {
        margin: 20px;
    }

    h2 {
        font-size: 20px;
        margin-bottom: 10px;
    }

    ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }
    
    #artist_ul {
    	display : flex;
        flex-direction: row;
    }

    li {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }

    #album_img {
        width: 80px;
        height: 80px;
        margin-right: 10px;
    }
    
    #artist_img {
        width: 120px;
        height: 120px;
        margin-right: 10px;
    }

</style>

<body>
	<h1 id="ment">"${keyword }"&nbsp에 대한 검색결과입니다.</h1>
	<section id ="search_track_result">
		<h2>관련 트랙</h2>
		<ul>
	        <c:forEach var="track" items="${searchbytrack}">
	            <li>
	                <img id = "album_img" src="${track.album_img}">
	                ${track.title} - ${track.artist} - ${track.album_name } - ${track.release_date } - ${track.like_count }
	                <button type="button" title="재생" class="btn">
	                    <span class="cnt">재생</span>
	                </button>    
		            <button type="button" title="담기" class="btn">
	                    <span class="cnt">담기</span>
	                </button>
	            </li>
	        </c:forEach>
	    </ul>
	</section>
	
		<section id ="search_artist_result">
		<h2>관련 아티스트</h2>
		<ul id = "artist_ul">
	        <c:forEach var="artist" items="${searchbyartist}">
	            <li>
	                <img id="artist_img" src="${artist.artist_img}" >
	            </li>
	            <ul id = "artist_name_ul">
	            	${artist.artist }
	            </ul>	            
	        </c:forEach>
	    </ul>
	</section>
</body>
<jsp:include page="footer.jsp"></jsp:include>  
</html>