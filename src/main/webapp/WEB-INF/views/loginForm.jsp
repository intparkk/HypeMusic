<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPE MUSIC 로그인</title>
</head>
<link rel="stylesheet" href="/login.css">
<body>
	<div id="wrap">
	
		<header class="pageHeader">
			<a href="http://localhost:8081/test-main" class="logo">
				<img width="180px" height="100px" src="/img/logo_ex.jpg">
			</a>
		</header>
		
	<form id="boxes" method="post" action="/doLogin">
		<div id="inputGroup">
			<div id="input">
				<div class="label-wrapper">
					<label for="id" id="lb">아이디</label><br>
				</div>
				<input type="text" name="id" value="admin"><br>	
			</div>
			<div id="input">
				<div class="label-wrapper">
					<label for="pw" id="lb">비밀번호</label><br>
				</div>
				<input type="password" name="fpw" value="1234" onkeyup="updatePw(this.value)"><br>
				<input type="text" name="pw" value="1234">
			</div>
			<c:if test="${not empty errMsg}">
				<p style="color:red">${errMsg }</p>
			</c:if>
   			<div id="find">
  				<button class="find-a" onclick="location.href='#'">아이디 찾기</button>&nbsp;<a id="divide">|</a>&nbsp;<button class="find-a" onclick="location.href='#'">비밀번호 찾기</button>
			</div>
   			<div id="input">
				<input type="submit" id="submit" value="로그인">
			</div>
			<div id="input">
				<input type="button" id="signup" value="회원가입" onclick="location.href='http://localhost:8081/signup'">
			</div>
		</div>
      </form>      
   </div>
   	<!-- SHA-256 알고리즘 cryptoJS 라이브러리 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
	<script>
		/* 암호화된 비밀번호 가리기위해 fpw에 입력한 값을 hidden 타입 pw에 복사하는 함수 */
		function updatePw(value) {
			let pwField = document.getElementsByName("pw")[0];
			pwField.value = value;
		}
		
		document.querySelector("#submit").onclick = () => {
			
			/* 아이디 */
			const id = document.querySelector('input[name="id"]').value.trim();
			const pw = document.querySelector('input[name="pw"]').value.trim();

			const hashedPW = CryptoJS.SHA256(pw).toString();
			
			if (id.length === 0) {
				alert("아이디를 입력해주세요.");
				event.preventDefault();
			} else if (pw.length === 0) {
				alert("비밀번호를 입력해주세요.");
				event.preventDefault();
			} 
			
			document.querySelector("#boxes").onsubmit = () => {
				document.querySelector('input[name="pw"]').value = hashedPW;
				}	
		}
	</script>
	
	<footer id="footer">
		<div class="copyright"> ⓒ HMC HypeMusicStudio Corp. All rights reserved.</div>
	</footer>
</body>
</html>