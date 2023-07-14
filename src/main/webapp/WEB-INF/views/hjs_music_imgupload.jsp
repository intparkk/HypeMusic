<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입 이미지 업로드</title>
</head>
<body>
<form action="/hjs_img_uploadOk" method="post" enctype="multipart/form-data" accept-charset="utf-8">
		<br><input type="file" name="filename"><br><br>
		<input type="submit" value="사진저장">
</form>
<table border=1>
		<tr>
			<th>마이프로필</th>
		</tr>
		
 
<c:set var="lastFile" value="${fileList[fileList.size() - 1]}" />

<tr>
    <td><img src="/hjs_readMail?id=${lastFile.name}"></td>
</tr>

<%-- 	
	<c:forEach var="map" items="${fileList}">
		<tr>
			<td><img src="/hjs_readMail?id=${map.name }"></td>
		</tr>
	</c:forEach>
	
--%>
</table>
		
</body>
</html>