<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:: 내 정보 ::</title>
<link rel="stylesheet" href="/myInfo.css">
</head>
<header>
	<jsp:include page="header.jsp"></jsp:include>
</header>
<body>
	<div id="title">내 정보</div>
    <div id="myInfo-wrapper">
        <div id="myInfo-contents">
            <div id="profile-img">
                <img id="profileImage" src="${userDTO.profile_img}">
            </div>
            <div class="container1">
                <p class="id">
                    ${userDTO.id}
                </p>
                <p class="email">
                    ${userDTO.email}
                </p>
                <p class="rank">
                    ${userDTO.rank}
                </p>
                <label for="fileInput">
                    <span id="upload">사진 변경</span>
                    <input type="file" id="fileInput">
                </label>
            </div>
            <div class="container2">
                <p class="name">
                    &nbsp#${userDTO.name}
                </p>
            </div>
            <div class="container3">
                <label for="ticket-btn">
                    <span id="ticket">
                        <a class="ticket-link" href="#">
                            이용권 구매
                        </a>
                    </span>
                </label>
                <label for="update-pw-btn">
                    <span id="update-pw">
                        <a class="update-pw-link" href="/myInfo/checkPw">
                            비밀번호 변경
                        </a>
                    </span>
                </label>
            </div>
        </div>
    </div>
	
	<script>
		
	document.querySelector("#fileInput").onchange = () => {
		uploadFile();
		location.reload();
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