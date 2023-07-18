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
	<div id="my-info-wrapper">
		<div class="contents">
			아이디 : ${userDTO.id}
		</div>
		<div class="contents">
			이름 : ${userDTO.name}
		</div>
		<div class="contents">
			이메일 : ${userDTO.email}
		</div>
		<form action="/upload" method="post" enctype="multipart/form-data" accept-charset="utf-8">
			<div class="contents">
				프로필 사진    
				<img id="profileImage" src="${userDTO.profile_img}" style="width: 64px; height: 64px; border-radius: 32px;">
			</div>
			<div class="contents">
				<input type="file" name="filename" id="fileInput" value="파일 선택">
			</div>
		</form>
		<div class="contents">
			회원등급 : ${userDTO.rank}
		</div>
		<div class="contents">
			<a href="/myInfo/checkPw">
				비밀번호 변경
			</a>
		</div>
		<br>
	</div>
	
	<script>
		
	document.querySelector("#fileInput").onchange = () => {
		uploadFile();
	};

	const uploadFile = () => {
		const fileInput = document.querySelector("#fileInput");
		const file = fileInput.files[0];
		
		const formData = new FormData();
		formData.append('file', file);
		
		fetch('/upload', {
			method: 'POST',
			body: formData
		})
		.then(response => {
			if (response.ok){
				return response.text();
			} else {
				throw new Error('Error: ' + response.status);
			}
		})
		.then(imageUrl => {
			const profileImage = document.querySelector("#profileImage");
			profileImage.src = imageUrl;
		})
		.catch(error => {
			console.error(error);
		});
	};
	</script>
</body>
</html>