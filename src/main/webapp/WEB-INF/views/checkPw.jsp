<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkPw</title>
</head>
<body>
	<h1>비밀번호 확인</h1><hr>
		<form id="boxes" method="post" action=/doCheckPw>
		<input type="hidden" name="id" value="${dto.id }">
		<p>
			비밀번호 확인 : <input type="password" name="fpw" onkeyup="updatePw(this.value)"><br>
						 <input type="hidden" name="pw" value="">
		</p>
		<input type="submit" id="submit" value="확인">
	</form>
	
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
			const hashedPW = CryptoJS.SHA256(pw).toString();
			
			document.querySelector("#boxes").onsubmit = () => {
				document.querySelector('input[name="pw"]').value = hashedPW;
			}
		}
			
	</script>
</body>
</html>