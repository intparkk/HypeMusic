<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>music4U</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<style>
*{margin: 0; padding: 0; text-align: center;}
section{display: flex; justify-content: center;}
.f{display: flex; align-items: center;}
.middle{vertical-align: middle;}
.album{width: 200px; height: 250px; border-radius: 1em; }
.album_img{ height: 80%;}
.over{overflow-wrap: break-word; }
.eight{width: 80%;}
.concept_nav{display: flex; justify-content: space-around;}
.Attendance_table{width: 100%; height: 90px; border: 8px solid black; border-radius: 50px;}
.graphForm{width: 500px; height: 300px;}
.musiclist{display: inline-block;}
.category{display: flex; justify-content: space-around;}
.check{display: block;}
.container{display: block;}
.canvasbox{display: flex; justify-content: center;}
.canvas{width: 50%;padding: 0 15%;  position: relative; display: inline-block;}
.genre{}
.musiclist{padding-right: 15px; }
.button{border-radius: 15px; width: 80px; height:40px; border: 0px;  background-color:rgba(255, 130, 207, 0.6); padding:7px; margin: 2px;}
.button:hover{background-color:red; border: none; font-weight: 1000}
</style>
<body onload="createBarChart()">
<jsp:include page="header.jsp"></jsp:include>
<section id="forU">
	<div class="container"><br><br><br>
		<div class="canvas">
	    	<canvas style=""id="myChart"></canvas>
	        	<h1 class="genre">${userInfo.id}님이<p>자주 듣는 장르는 <span id="genreValue"></span> 음악입니다.</h1>
        </div>

        <form action="music4u" method="get" >
	        <div><br><br>
	            <div class="category" id="">
	                <div class="concept_nav" style="visibility: hidden;"></div>
	                <h1 class="" id="">${concept} 음악은 어떠신가요??</h1>
	                <nav style="display: flex;">
	                	<h3 style="padding-top: 7px; padding-right:10px;">또 다른 추천</h1>
					    <button class="button" type="submit" name="run" value="0"><h3>밝은</h3></button>
					    <button class="button" type="submit" name="run" value="1"><h3>우울한</h3></button>
	                </nav>
	            </div>
	            <div style="display: flex;">
	            <c:forEach items="${musicList}" var="music" end="4">
		            <div class="musiclist" id="music_${status.index}">
		                <div class="album" id=""><img src="${music.album_img}" alt="" class="" id="" style="width: 200px; height: 190px;"><div class="" style="height: 22%;"><h3 class="over">${music.title}</h3></div></div>
		            </div>
	       		</c:forEach>
	            </div>
	        </div>
        </form>
        <br><br>
        <form action="music4u_attend" method="get">
    	    <div class="check">
		        <table class="Attendance_table" id=""><h1>${date} 출석체크</h1>
				      <tr>
			            <c:forEach items="${limitedRunresult}" var="music" varStatus="status" end="6">
			            
			                <c:choose>
			                    <c:when test="${music.runresult == 0 }">
			                    	
			                        <th>
			                        <button class="button" type="submit" name="check" value="1">출석하기</button></th>
			                        
			                    </c:when>
			                    <c:when test="${music.runresult == 1 }">
			                        <th style="background-color:blue; border-radius: 40px;">출석완료</th>
			                    </c:when>
			                </c:choose>
			            </c:forEach>
				      </tr>      
		        </table>
		    </div>
		     <button class="button" type="submit" name="check" value="2" style="width: 300px;"><h1>출석완료 선물받기</h1></button>
        </form>
    </div>
</section>
<jsp:include page="footer.jsp"></jsp:include>

  <c:set var="musicList" value="${0}" />
  
  
  
</body>
<script type="text/javascript">
function createDoughnutChart() {
    var data = [10, 40, 30, 30, 20];
    var genres = ['댄스', '발라드', '랩/힙합', 'R&B/Soul', '기타'];
    
    var sortedIndexes = data.map((v, i) => i).sort((a, b) => data[b] - data[a]);
    // 가장 높은 데이타와 그 인덱스를 찾습니다.
    var maxData = Math.max(data[0]);
    var maxIndex = data.indexOf(maxData);

    // 가장 높은 데이타에 해당하는 장르를 변수에 저장합니다.
    var genre = genres[maxIndex];
    var genreElement = document.getElementById('genreValue');
    genreElement.textContent = genre;
    
    var backgroundColors = ['rgba(255, 130, 207,0.5)', 'rgba(255, 130, 207,1.0)', 'rgba(255, 130, 207,0.7)', 'rgba(255, 130, 207,0.7)', 'rgba(255, 130, 207,0.4)'];

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: genres,
            datasets: [{
                data: data,
                backgroundColor: backgroundColors,
                borderWidth: 0
            }]
        },
        options: {
        	cutout: '30%',
            animation: {
                animateRotate: true,
                animateScale: true,
            },
            plugins: {
                legend: {
                    display: false,
                    position: 'right', // 범례 위치를 우측에 표시하도록 설정
                    labels: {
                        font: {
                            size: 12
                        }
                    }
                }
            }
        }
    });
}

// 도넛 차트 생성 함수 호출
createDoughnutChart();

    </script>
        
</html>