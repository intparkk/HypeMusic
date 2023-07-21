<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%-- <%@ page import="java.util.Collections" %> --%>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPEMUSIC Top100</title>
<link rel="stylesheet" href="/top100.css">
<Style>
table{
	border-collapse:collapse;
	margin: auto;
	width: 90%;	
}
th {
background-color: #EAEAEA;
}
table,th, td{
	border: none;
	border-bottom: 1px solid #F6F6F6;
	border-top: 1px solid #F6F6F6;
	color: #333333;
	text-align: center;
}
tr:hover {
background-color:#F6F6F6; 
}
th,td{
max-width: 250px;
}
h1, h2{
text-align: center;
color: #333333;
}

a {
	color : #333333;
	text-decoration : none;
}

a:hover {
	color: #000000;
    font-weight: bold;
    text-decoration: underline;
} 

#paging_number,
#paging_text_1,
#paging_text_2 {
text-decoration: none;
font-weight: bold;
color: gray;
font-size : 20px;
letter-spacing: 5px;
}

</Style>

</head>
<header>
<jsp:include page="header.jsp"></jsp:include>
</header>
<body>

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
			</thead>			
    	<tbody>    	
        <c:forEach var="dto" items="${list}" begin="0" end="99"> 	 			
				<tr>
					<td><input type="checkbox" name="check" id="checkbox">
                            <span class="checkmark"></span></td>					
					<td>
						<%-- &nbsp;${loop.index + 1} --%>
						${dto.rnum}
					</td>
					<td><a href="/music_info?track_id=${dto.track_id }"><img src = "/img/music_info_icon2.jpg" style="border: none; width: 14px; height: 14px;"></a></td>
					<!-- 박정수 : dto 에 album_id,youtube_url이 필요합니다! -->
					<td>
						 <div class="track">
          				 <img src="${dto.album_img}" alt="album_image" style="width: 100px;height: 100px;">
        				 	<div class="caption">
                			<p>${dto.title }</p>
                			<p>${dto.artist }</p>
            				</div>
        				 </div>
					</td>
					<td>
					<div class="caption1">
				     <p><a href="/music_info?track_id=${dto.track_id}">${dto.title }</a></p>
                	 <p><a href="/artistinfo/${dto.artist_id}">${dto.artist }</a></p>
				    </div>
					</td>
					<td>
					<div class="caption2">
				     ${dto.album_name }
				    </div>
					</td>
					<td>
					<div class="caption3">
     				<p>${dto.like_count }</p>
     				</div>
					</td> 
					<!-- target="_blank" -->
					<td><a href="${dto.youtube_url }"><img src="img/hjs_play.png" class="logo1" style="border: none; width: 20px; height: 20px;"></a></td>
					<td>
					<!-- 담기 버튼 -->
					    <c:if test="${rank == null || rank < 1}">
				            <img src="/img/hjs_put.png" alt="담기" style="border: none; width: 20px; height: 20px;">
					    </c:if>
					    <c:if test="${rank != null && rank >= 1}">
					        <a href="#" onclick="addTrack('${trackInfo_like.track_id}')">
					            <img src="/img/hjs_put.png" alt="담기" style="border: none; width: 20px; height: 20px;">
					        </a>
					    </c:if>
					</td>
				</tr>   
    	  </c:forEach>    	
				</tbody>
		</table>   
</div>

		<%

			int total = (int) request.getAttribute("total");
			int countPerPage = (int) request.getAttribute("countPerPage");
// 			ceil(101/10) == 11
			double lastPage = Math.ceil( (double)total / (double)countPerPage);

			// 페이징 그룹
			// 한 그룹당 보여줄 수
			int groupCount = 5;
			// 현재 페이지
			int pageNum = (int) request.getAttribute("pageNum");
			// 현재 속한 그룹
			double group = Math.floor((((double)pageNum-1) / groupCount) + 1);
			// 그룹의 시작 페이지, 끝 페이지
			int end = (int)group * groupCount;
			int begin = end - (groupCount - 1);
			System.out.println("group: "+ group);
			System.out.println("end: "+ end);
			System.out.println("begin: "+ begin);
			if(end > lastPage){
				end = (int)lastPage;
			}
			
			// 10보다 큰 숫자는 보이지 않도록 설정
		    if (end > 10) {
		        begin = 1;
		        end = Math.min(end, 10);
		    }
		    
			// scope 관련
			pageContext.setAttribute("a", 1);
			request.setAttribute("p", 2);
			session.setAttribute("test", 3);
			application.setAttribute("test2", 4);
		%>
		
	<!-- 화면 페이징에 대한 정보는 주석처리함 -->	
<%--  		total: <%= total%><br>
 		countPerPage: <%= countPerPage%><br>
 		lastPage: <%= lastPage%><br>
 --%> 		
		<div style="width:350px; margin: 0 auto; margin-top: 20px; margin-bottom: 20px;">
		<%
			if(begin != 1){
		%>				
				<a href="/hjs_music_top100?pageNum=<%= begin-1 %>" id="paging_text_1">[이전]</a>
		<%
			}
		%>
		<% 
			for(int i=begin; i<=end; i++){
		%>
			<a href="/hjs_music_top100?pageNum=<%= i %>"  id="paging_number">
				<c:set var="i2" value="<%= i %>" scope="page"></c:set>
				<c:if test="${pageNum eq i2}">
					<strong><%= i %></strong>
				</c:if>
				<c:if test="${pageNum ne i2}">
					<%= i %>
				</c:if>
			</a>
		<%
			}
		%>
		<%
			if(end != lastPage){
		%>				
				<a href="/hjs_music_top100?pageNum=<%= end+1 %>" id="paging_text_2">[다음]</a>
		<%
			}
		%>
			
		</div>
		
	</section>
	
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>