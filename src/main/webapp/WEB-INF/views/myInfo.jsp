<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:: 내 정보 ::</title>
<style>
#title {
	font-size: 30px;
	font-weight: bold;
	margin-top: 40px;
	margin-left: 270px;
}

#myInfo-wrapper {
    margin: 0 auto;
    min-width: 700px;
    width: 900px;
    height: 550px;
    border-left: 1px solid lightgrey;
    border-right: 1px solid rgb(210, 210, 210);
}

#myInfo-contents {
    margin:0 auto;
    margin-top: 20px;
    border-radius: 10px;
    background-color: rgb(230, 230, 230);
    min-width: 700px;
    width: 760px;
    height: 360px;
    display: flex;
    
}

#profileImage {
    margin-top: 10px;
    margin-left: 10px;
    width: 160px;
    height: 160px;
    border-radius: 80px;
}

#upload {
    padding: 3px;
    border-radius: 3px;
    background-color: grey;
    color: white;
    cursor: pointer;
}

#fileInput {
    display: none;
}

.container1 {
    width: 240px;
    text-align: right;
}

.container2 {
    width: 160px;
}

.container3 {
    width: 190px;
    margin-top: 260px;
    margin-right: 20px;
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: flex-end;
    gap: 14px
}

.id {
    text-align: right;
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 14px;
}

.email {
    font-size: 18px;
}

.name {
    margin-top: 46px;
    color: grey;
}

#ticket {
    background-color: grey;
    padding: 2px 10px 2px 10px;
    color: black;
    border: 1px solid grey;
    border-radius: 3px;
}

#ticket :hover {
	color: white;
	font-weight: normal;
}

.ticket-link {
    text-decoration: none;
    color: white;
}

#update-pw {
    background-color: grey;
    padding: 2px;
    border: 1px solid  gray;
    border-radius: 3px;
}

#update-pw :hover {
	color: white;
	font-weight: normal;
}

.update-pw-link {
    text-decoration: none;
    color: white;
}

</style>
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