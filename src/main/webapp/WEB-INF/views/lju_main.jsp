<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="common.css">
<link rel="stylesheet" type="text/css" href="section.css">

<style>
/* test 도구 모음*/
* {border: 0.1px solid #000;}
@media screen and(max-width:600px) {body {    }}
@font-face {
	font-family: 'webFont';
	src: url('') format();
}
</style>
<body>

	<header class="mainHeader">
		<nav class="topNav">
			<button>
				<h4>이용권구매</h4>
			</button>
		</nav>
		<form action="" class="headerCenter">
			<div class="searchBox">
				<img class="logo" src="/img/search_icon3.jpg" alt="샘플이미지"> <input
					class="search" type="text" value="" placeholder="검색어를 입력하세요">
				<button class="search-button" type="submit">
					<img src="/img/search_icon3.jpg" alt="검색">
				</button>
			</div>
		</form>

		<nav class="mainNav">
			<div class="wrapper">
				<div class="buttonContainer">
					<button class="mainButton">
						<h3>음악차트</h3>
					</button>
					<div class="subButtons">
						<button class="subButton">111</button>
						<button class="subButton">12312312312</button>
						<button class="subButton">312312321</button>
					</div>
				</div>
				<div class="buttonContainer">
					<button class="mainButton">
						<h3>음악차트</h3>
					</button>
					<div class="subButtons">
						<button class="subButton">111</button>
						<button class="subButton">12312312312</button>
						<button class="subButton">312312321</button>
					</div>
				</div>

			</div>
			<div class="">
				<button type="menu" class="" id="">
					<h3>뮤직4U</h3>
				</button>
				<button type="menu" class="" id="">
					<h3>마이뮤직</h3>
				</button>
			</div>
		</nav>
	</header>
	<section class="mainSection">
		<div class="mainShow" id="">
			<div class="stage" id=""></div>
			<div class="stage" id=""></div>
		</div>
		<div class="mainChart" id="mainChart">
			<h2>${chartName}</h2>
			<ol>
				<c:forEach var="chart" items="list">
					<li>${list}</li>
				</c:forEach>
			</ol>
		</div>
	</section>
	<footer class="mainFooter">
		<div class="footerContent" id="">1</div>
		<div class="footerContent" id="">2</div>
		<div class="footerContent" id="">3</div>
	</footer>

	<!-- fixed item -->
	<div class="enterBox">
		<form action="" class="" id="">
			<br> <br>
			<div class="">
				<input type="text" class="" placeholder="아이디를 입력해주세요."> <input
					type="text" class="" placeholder="비밀번호를 입력해주세요.">
			</div>
			<button class="login_box" type="submit" name="" value="">로그인</button>
			<br> <br>
			<h2 style="color: yellow;">로그인을 해주세요.</h2>
		</form>
	</div>
	<div class="loginBox">
		<div class="">${id}님환영합니다.</div>
	</div>



</body>
<script>
	var searchButton = document.querySelector('.searchButton');
	searchButton.addEventListener('click', function() {
		var searchInput = document.querySelector('.search');
		var searchTerm = searchInput.value;
		// 검색어에 대한 처리 로직을 작성하세요
		alert('검색어: ' + searchTerm);
	});
</script>

<script>
	function toggleLoginBox() {
		var loginBox = document.querySelector('.loginBox');
		loginBox.style.display = (loginBox.style.display === 'none') ? 'block'
				: 'none';
	}
</script>

</html>