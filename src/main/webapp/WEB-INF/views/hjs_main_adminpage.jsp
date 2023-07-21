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
h3{
text-align: center;

}
.img {
text-align: center;
}
table {
margin: auto;
}
td {
padding-left: 30px;
padding-right: 30px;
}
</Style>

</head>
<header>
<jsp:include page="header.jsp"></jsp:include> 
</header>
<body>
<h3>관리자 페이지입니다</h3> 
<table>
<tr>
	<td>
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
	<div>&nbsp;</div>
	</td>
	<td>
	<div class="img"><img src="/img/hjs_TeamStructure.png"></a></div>
	</td>
</tr>
</table>



</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include> 
</footer>
</html>