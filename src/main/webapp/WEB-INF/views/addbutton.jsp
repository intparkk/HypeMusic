<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>담기 버튼입니다</title>
</head>
<style>

	.btn {
    display: inline-block;
    padding: 5px;
    background-color: transparent;
    border: none;
    outline: none;
    cursor: pointer;
	}
</style>
<body>
		<!--  담기 버튼 여기서 작업하시면 됩니다 -->
	   	<button type="button" title="담기" class="btn add-btn" >
	    <img src="/img/hjs_put.png" alt="담기" style="width: 30px;  height: 30px;">
		</button>
		<span id ="icon_nextword">담기</span>  
</body>
</html>