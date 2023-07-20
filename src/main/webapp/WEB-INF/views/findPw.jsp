<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="/login.css">
</head>
<body>
	<div id="wrap">
		<header class="pageHeader">
			<a href="http://localhost:8081/Mainpage" class="logo">
				<img width="180px" height="100px" src="/img/logo_ex.jpg">
			</a>
		</header>
		
	<form id="boxes" method="POST" action="/doFindPw">
		<div id="inputGroup">
			<div id="input">
				<div class="label-wrapper">
					<label for="id" id="lb">아이디</label><br>
				</div>
				<input type="text" name="id" value="admin"><br>	
			</div>
			<div id="input">
				<div class="label-wrapper">
					<label for="pw" id="lb">이메일</label><br>
				</div>
				<input type="text" name="email"><br>
			</div>
			<c:if test="${not empty errMsg}">
				<p style="color:red">${errMsg }</p>
			</c:if>
   			<div id="input">
				<input type="submit" id="submit" value="비밀번호 찾기">
			</div>
		</div>
      </form>      
	</div>
	<script>
		document.querySelector("#submit").onclick = () => {
			
			/* 아이디 */
			const id = document.querySelector('input[name="id"]').value.trim();
			const pw = document.querySelector('input[name="email"]').value.trim();

			if (id.length === 0) {
				alert("아이디를 입력해주세요.");
				event.preventDefault();
			} else if (email.length === 0) {
				alert("이메일을 입력해주세요.");
				event.preventDefault();
			} 
			
		}
	</script>
	<footer id="footer">
		<div class="copyright"> ⓒ HMC HypeMusicStudio Corp. All rights reserved.</div>
	</footer>
</body>
</html>