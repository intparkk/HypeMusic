<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update my info</title>
</head>
<body>
	<h1>비밀번호 변경</h1>
	<a href="/test-main">메인페이지</a>
	<hr>
	<c:choose>
		<c:when test="${isLoggedIn ne 'ok'}">
			<h2>로그인이 필요한 서비스입니다.</h2><br>
			<a href="/login">로그인</a>
		</c:when>
		<c:otherwise>
			<form id="boxes" method="POST" action=/doUpdatePw>
				<input type="hidden" name="id" value="${dto.id}">
				새 비밀번호 입력 : 
				<input type="password" name="fpw" onkeyup="updatePw(this.value)">
				<input type="hidden" name="pw" value="">
				<br>
				비밀번호 확인 : <input type="password" name="pw-confirm" id="pw-confirm">
				<br>
				<input type="submit" id="submit" value="변경하기">
			</form>
			<a href="/myInfo">취소</a>	
		</c:otherwise>
	</c:choose>
	
	<!-- SHA-256 알고리즘 cryptoJS 라이브러리 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
	<script>
		/* 암호화된 비밀번호 가리기위해 fpw에 입력한 값을 hidden 타입 pw에 복사하는 함수 */
		function updatePw(value) {
			let pwField = document.getElementsByName("pw")[0];
			pwField.value = value;
		}
		
		document.querySelector("#submit").onclick = () => {
			
			const pw = document.querySelector('input[name="pw"]').value.trim();
			const pwConfirm = document.querySelector('input[name="pw-confirm"]').value.trim();
			
			const hashedPW = CryptoJS.SHA256(pw).toString();
			
			if (pw.length === 0) {
				alert("비밀번호를 입력해주세요.");
				event.preventDefault();
			} else if (pw !== pwConfirm) {
				alert("비밀번호가 일치하지 않습니다.");
				event.preventDefault();
			}
			
			document.querySelector("#boxes").onsubmit = () => {
				document.querySelector('input[name="pw"]').value = hashedPW;
				}	
		}
	</script>
</body>
</html>