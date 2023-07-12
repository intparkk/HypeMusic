<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPEMUSIC 스타매거진</title>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
</head>
<body>
<!-- CSS 그다지 길지 않어서 jsp에서 처리하였습니다 -->
<style>
    .news-item {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        cursor: pointer;
    }

    .news-item:hover {
        background-color: #ffe5e5;
    }

    .news-item img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        margin-right: 10px;
    }

    .news-item h3 {
        font-weight: bold;
        margin-bottom: 5px;
    }

    .news-item p {
        margin-top: 5px;
    }

    .news-item a {
        display: none;
    }

    .news-item:hover a {
        display: inline;
        text-decoration: none;
        color: inherit;
    }
    
    #news_section {
        margin: 0 110px;
    }
    
    #loadMoreButton {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        padding: 10px;
        background-color: transparent;
        border: none;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        position: relative;
        z-index: 1;
    }

    #viewmore {
        width: 100%;
        margin: -10px auto 10px;
        border: none;
        border-top: 1px solid #ccc;
    }
</style>

<script>
    var newsIndex = 10; // 초기 기사 인덱스

    function loadMoreNews() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    var newsItems = document.getElementById("news-slider");

                    // 다음 10개 기사 동적으로 추가하기
                    response.forEach(function(news) {
                        var newsItem = document.createElement("div");
                        newsItem.classList.add("news-item");
                        newsItem.onclick = function() {
                            window.location.href = news.news_url;
                        };

                        var img = document.createElement("img");
                        img.src = news.news_img;
                        img.alt = "News Image";
                        newsItem.appendChild(img);

                        var contentDiv = document.createElement("div");
                        var title = document.createElement("h3");
                        title.textContent = news.news_title;
                        var brief = document.createElement("p");
                        brief.textContent = news.news_brief;
                        contentDiv.appendChild(title);
                        contentDiv.appendChild(brief);

                        newsItem.appendChild(contentDiv);

                        newsItems.appendChild(newsItem);
                    });

                    newsIndex += 1; // 기사 인덱스 업데이트

                    // 모든 기사를 다 보여줬을 경우 버튼 숨기기
                    if (newsIndex >= Math.ceil(response.length / 10)) {
                        var loadMoreButton = document.getElementById("loadMoreButton");
                        //loadMoreButton.style.display = "none";
                    }
                } else {
                	// 더보기 에러 처리
                    console.error("AJAX request failed with status: " + xhr.status);
                }
            }
        };

        // AJAX 요청 보내기
        xhr.open("GET", "/api/news?page=" + newsIndex, true);
        xhr.send();
    }
</script>

<section id="news_section">
    <h1>NOW</h1>
    <h2>스타들의 소식을 알아보세요!</h2>

    <div id="news-container">
        <div id="news-slider">
            <c:forEach var="news" items="${newsList}" varStatus="status">
                <c:if test="${status.index < 10}">
                    <div class="news-item" onclick="window.location.href='${news.news_url}'">
                        <img src="${news.news_img}" alt="News Image">
                        <div>
                            <h3>${news.news_title}</h3>
                            <p>${news.news_brief}</p>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <button id="loadMoreButton" onclick="loadMoreNews()">▽더 보기</button>
    </div>
    <hr id="viewmore">
</section>

</body>
<jsp:include page="footer.jsp"></jsp:include>
</html>
