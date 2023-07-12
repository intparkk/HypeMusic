<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main test</title>

<Style>
table, th, td{
border: 1px solid lightgray;
}
table {
margin: auto;
}
h1, h2{
text-align: center;
}
</Style>

</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
테스트용 페이지 입니다. 
<!-- 타이틀 로고 -->
<div class="section_1"></div>
	<h1>Top100</h1>

<!-- 날짜 -->
<div class="section_2">
<%
        Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd a h:mm");
        String formattedDateTime = dateFormat.format(currentDate);
    %>
</div>
	<h2><%= formattedDateTime %></h2>
	
<!-- 차트 top100 -->
<div class="section_3">
	<div class="music_btn">
	
	</div>		
		<table>		
			<thead>				
					<th><input type="checkbox" name="check" id="checkbox">
                            <div class="checkmark"></div></th>
					<th>순위</th>
					<th>ㅡ</th>
					<th>앨범이미지</th>
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
        <c:forEach var="dto" items="${list}" begin="0" end="99" varStatus="loop"> 	 			
				<tr>
					<td><input type="checkbox" name="check" id="checkbox">
                            <span class="checkmark"></span></td>					
					<td>
						${loop.index + 1}
					</td>
					<td><a href="/music_info?track_id=${dto.track_id }">lyrics</a></td>					
					<!--  곡정보 이미지 추가 -->
					<td><img src="${dto.album_img}" alt="album_image" style="width: 100px;height: 100px;"></td>
					<td>
						 <div class="track">
          				 
        				 	<div class="caption">
                			<p>${dto.title }</p>
                			<p>${dto.artist }</p>
            				</div>
        				 </div>
					</td>
					<td>
					<div class="caption1">
				     ${dto.album_name }
				    </div>
					</td>
					<td>
					<div class="caption3">
     				<p>${dto.like_count }</p>
     				</div>
					</td>
					<td>듣기</td>
					<td>담기</td>
					<td>다운</td>
					<td>뮤비</td>					
				</tr>    	 
    	  </c:forEach>    	
				</tbody>
		</table>   
</div>	
</body>
</html>