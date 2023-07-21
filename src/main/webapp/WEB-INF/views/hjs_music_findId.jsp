<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h1,p {
text-align: center;
}
p {
font-size: 20px;
}
.email_find {
text-align: center;
font-size: 22px;
color: gray;
}
.submit {
text-align: center;

}
.submit_button {
display: block;
margin: 0 auto;
width: 260px;
height: 55px;
font-size: 20px;
color: white;
background-color: #fec5e5;
}
.submit_button:hover {
background-color: #faaad8;
cursor: pointer;
font-weight: bold;
border: 2px solid grey;
}
input[type="text"] {
width: 250px;
height: 45px;
border: 1px solid lightgray;
font-size: 25px;
}
#user_id{
color: #03C75A;
}
</style>
</head>
<link rel="stylesheet" href="/login.css">

<body>

	<header class="pageHeader">
			<a href="http://localhost:8081/Mainpage" class="logo">
				<img width="180px" height="100px" src="/img/logo_ex.jpg">
			</a>
	</header>
	
		<form id="boxes" action="/hjs_find_id" method="POST">
			<div class="email_find">
				이메일을 입력을 입력해주세요<br><br>
					<input type="text" name="email"><br>
			</div><br>
				<p style="color: #F361A6;">${message}</p>
				<p style="color: #03C75A; font-size: 25px;">${message_1 }</p>	
				<br>
			<div class="submit">
				<input type="submit" value="입력하기" class="submit_button">
			</div>
		</form>
	
	<br><br>
	 <div id="body_middle_section" style="display: flex; justify-content: center; margin-top:50px;">
         <div style="display: flex; justify-content: center;">
        <img src="/img/mainpage_ticket_logo.png" style="width:33%;height: 60%;">
         </div>
    </div>
<footer id="footer">
		<div class="copyright"> ⓒ HMC HypeMusicStudio Corp. All rights reserved.</div>
</footer>
</body>

</html>