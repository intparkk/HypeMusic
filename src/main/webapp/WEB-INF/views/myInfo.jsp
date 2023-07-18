<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my info</title>
<style>

#my-info-wrapper {
	margin: 0 auto;
	border: 1px solid lightgrey;
	min-width: 800px;
	width: 50%;
	min-height: 600px;
	justify-content: space-evenly;
	flex-direction: column;
}

.contents {
	display: flex;
	align-items: center;
	padding-left: 40px;
	border-bottom: 1px solid grey;
	height: 80px;
}

#profileImage {
	margin-left: 20px;
}

</style>
</head>
<body>
	<h1> 내 정보 </h1>
	<a href="/test-main">테스트 메인페이지</a>
	<a href="/Mainpage">진짜 메인페이지</a>
	<a href="#">내가 쓴 댓글</a>
	<a href="#">좋아요</a>
	<a href="/myPlaylist">나의 재생목록</a>
	<a href="/logout">로그아웃</a>
	<hr>
	<c:choose>
		<c:when test="${isLoggedIn ne 'ok'}">
			<h2>로그인이 필요한 서비스입니다.</h2><br>
			<a href="/login">로그인</a>
		</c:when>
		<c:otherwise>
			<div id="my-info-wrapper">
				<div class="contents">
					아이디 : ${dto.id}
				</div>
				<div class="contents">
					이름 : ${dto.name}
				</div>
				<div class="contents">
					이메일 : ${dto.email}
				</div>
				<form action="/upload" method="post" enctype="multipart/form-data" accept-charset="utf-8">
					<div class="contents">
						프로필 사진    
						<img id="profileImage" src="${dto.profile_img}" style="width: 64px; height: 64px; border-radius: 32px;">
					</div>
					<div class="contents">
						<input type="file" name="filename" id="fileInput" value="파일 선택">
					</div>
				</form>
				<div class="contents">
					회원등급 : ${dto.rank}
				</div>
				<div class="contents">
					<a href="/myInfo/checkPw">
						비밀번호 변경
					</a>
				</div>
				<br>
				<div class="contents">
					<a href="#">
						회원 탈퇴
					</a>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	
	<script>
		
		document.querySelector("#fileInput").onchange = function(){
			uploadFile();
		}
		// ajax로 프로필 사진 변경 바로 적용
		function uploadFile(){
			const fileInput = document.querySelector("#fileInput");
			const file = fileInput.files[0];
			
			const formData = new FormData();
			formData.append('file', file);
			
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function(){
				if (xhr.readyState === 4 && xhr.status === 200){
					// 요청이 완료되고 응답 상태 코드가 200(성공)인 경우 처리할 로직 작성
					const response = xhr.responseText;
					// 응답 데이터 처리
					const imageUrl = response; // 이미지 주소
					
					// 이미지 표시하기
					const profileImage = document.querySelector("#profileImage");
					profileImage.src = imageUrl;
					
				}
			};
			
			xhr.open('POST', '/upload'); // POST 요청
			xhr.send(formData); // FormData 전송
		}
	</script>
</body>
</html>