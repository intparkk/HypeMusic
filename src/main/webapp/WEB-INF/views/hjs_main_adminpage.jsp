<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.study.springboot.controller.hjs_musiccontroller" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 권한모드</title>

<Style>
.img {
text-align: center;
}
table {
margin: auto;
}
td {
padding-left: 60px;
padding-right: 60px;
}
</Style>

</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<br>
<table>
	<tr>
		<td>
		    <div style="font-weight: bold; font-size: 18px;">관리자</div><br>
			<div><a href="/hjs_music_admintest">곡추가</a></div><br>
			<div><a href="/hjs_music_viewtest">곡추가리스트</a></div><br>
			<div><a href="/hjs_music_userlist">회원리스트</a></div><br>
			<div><a href="/hjs_music_commentlist">댓글리스트</a></div><br>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
		</td>
		<td>
			<div class="img"><img src="/img/hjs_TeamStructure.png"></a></div>
		</td>
	</tr>
</table>
<br><br>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>