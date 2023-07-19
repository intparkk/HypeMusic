<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPEMUSIC 이용권 구매</title>
</head>
<header>
	<jsp:include page="header.jsp"></jsp:include>
</header>
<style>
#ticket_page_body {
	width: 958px;
	margin-top: 60px;
    margin-left: 110px;
    margin-right: 110px;
    margin-bottom: 100px;
	display: flex;
	justify-content: center;
	flex-direction: column;
	font-family: Arial, sans-serif;
	color: #3f3f3f;
}
.ticket_img_section {
	display:flex;
	justify-content: center;
}

#ticket_buy_section {
	display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    margin-top: 50px;
}

#ticket_buy_section ul{
	list-style-type: none;
	margin: 0;
  	padding: 0;
}
#big_text{
	font-size: 37px;
}

#ticket_buy_left_blank{
	height: 150px;
}

#ticket_buy_right{
	display: flex;
    flex-direction: column;
    justify-content: flex-start;
    height: 192px;
    width:500px;
}

.buy-button{
    box-sizing: border-box;
    display: inline-block;
    min-width: 60px;
    height: 32px;
    padding: 0 17px;
    margin-left: 0px;
    font-size: 14px;
    line-height: 33px;
    color: #fff;
    text-align: center;
    background-color: #3f3fff;
    border-radius: 22px;
    cursor: pointer;
    outline: none;
    border: 1px solid #fff;
}

.cancel-button{
	box-sizing: border-box;
    display: inline-block;
    min-width: 60px;
    height: 32px;
    padding: 0 17px;
    margin-left: 20px;
    font-size: 14px;
    line-height: 33px;
    color: #fff;
    text-align: center;
    background-color: red;
    border-radius: 22px;
    cursor: pointer;
    outline: none;
    border: 1px solid #fff;
}

#ticket_buy_right_li{
	display: flex;
    flex-direction: row;
    justify-content: space-between;
}
#cancel_line {
    display: inline-block;
    margin-right: 10px;
    font-size: 13px;
    color: #bdbdbd;
    vertical-align: middle;
    text-decoration: line-through;
}

#real_price{
	color: #3f3fff;
	font-size: 20px;
	vertical-align: middle;
}
</style>
<body>
<div id="ticket_page_body">
	<!-- 티켓 이미지 -->
	<section id="ticket_img_section">
		<a href="/pjs_ticket"><img id="ticket_big" src="/img/ticketpage_ticket.jpg"></a>
	</section>
	<!--  구매 섹션 -->
	<section id="ticket_buy_section">
		<ul id="ticket_buy_left">
			<li><strong id ="big_text">무제한 듣기</strong></li>
			<li>기기제한 없음, 무제한 스트리밍</li>
			<li id ="ticket_buy_left_blank">
			</li>
		</ul>
		<ul id="ticket_buy_right">
			<li id="ticket_buy_right_li">정기결제
			<div id = "text&btn">
			<span id="cancel_line">정가 1,000,000 원</span>
			<span id="real_price">1원</span>
				<button class="buy-button">구매</button>
			</div>
			</li>
			<li id="ticket_buy_right_li">멤버쉽 최소 100원 6개월
			<div id = "text&btn">
			<span id="cancel_line">정가 1,234,567 원</span>
			<span id="real_price">1원</span>
				<button class="buy-button">구매</button>
			</div>
			</li>
			<li id="ticket_buy_right_li">1개월 이용권
			<div id = "text&btn">
			<span id="cancel_line">정가 10,000 원</span>
			<span id="real_price">1원</span>
				<button class="buy-button">구매</button>
			</div>
			</li>
			<li id="ticket_buy_right_li">구매 취소하기
				<button class="cancel-button">취소</button>
			</li>
		</ul>
	</section>
</div>

<script>
	// JavaScript code
	document.addEventListener("DOMContentLoaded", function() {
		const buyButtons = document.querySelectorAll(".buy-button");
		const cancelButtons = document.querySelectorAll(".cancel-button");
		const nowRank = '${userInfo.rank}'; // 현재 랭크값 가져오기
		console.log(nowRank); //확인용

		// "구매" 버튼 클릭 이벤트 처리
		buyButtons.forEach(function(button) {
			button.addEventListener("click", function() {
				const userId = '${userInfo.user_id}'; // user_id 값을 세션에서 가져옵니다.
				if (nowRank == '') {
					alert("로그인을 해주세요");
				} else if (nowRank === "ticket") {
					alert("이미 이용권이 있습니다")
				} else if (nowRank === "admin") {
					alert("관리자가 이걸 왜함?");
				} else {
					const xhr = new XMLHttpRequest();
					xhr.open("POST", "buyTicket", true);
					xhr
							.setRequestHeader("Content-Type",
									"application/json");
					xhr.send(JSON.stringify({
						user_id : userId
					}));
					xhr.onreadystatechange = function() {
						if (xhr.readyState === 4 && xhr.status === 200) {
							alert("이용권 구매 성공!");
						}
					};
				}
			});
		});

		// "취소" 버튼 클릭 이벤트 처리
		cancelButtons.forEach(function(button) {
			button.addEventListener("click", function() {
				const userId = '${userInfo.user_id}'; // user_id 값을 세션에서 가져옵니다.
				if (nowRank == '') {
					alert("로그인을 해주세요");
				} else if (nowRank === "normal") {
					alert("이용권이 없습니다")
				} else if (nowRank === "admin") {
					alert("관리자가 이걸 왜함?");
				} else {
					const xhr = new XMLHttpRequest();
					xhr.open("POST", "cancelTicket", true);
					xhr
							.setRequestHeader("Content-Type",
									"application/json");
					xhr.send(JSON.stringify({
						user_id : userId
					}));
					xhr.onreadystatechange = function() {
						if (xhr.readyState === 4 && xhr.status === 200) {
							alert("이용권 취소 성공!");
						}
					};
				}
			});
		});
	});
</script>
</body>
<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>
</html>