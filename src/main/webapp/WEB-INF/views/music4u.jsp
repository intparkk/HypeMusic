<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<style>
table,th,tr,td{border: 1px solid #000;}
*{text-align: center;}
*{margin: 0; padding: 0;}
body{display: flex; justify-content: center; height: 100vh;}
.f{display: flex; align-items: center;}
.middle{vertical-align: middle;}
.album{width: 200px; height: 250px; border-radius: 1em; }
.album_img{ height: 80%;}
.over{overflow-wrap: break-word;}
.eight{width: 80%;}
.concept_nav{display: flex; justify-content: space-around;}
.Attendance_table{width: 100%;}
</style>
<body>
    <header style="height: 200px;"></header>
    <section id="forU">
        <div class="" id="">
        <img src="https://via.placeholder.com/800x390" alt="">
        <h1>내가 듣던 노래 분석</h1>
        </div>
        <br><br>
        
        <div class="" id="">
            <div class="concept_nav" id="">
                <div style="visibility: hidden;"></div>
                <h1 class="" id="">요즈음 ${concept}</h1>
                <nav>
                    <button>${concept}</button> 
                    <button>${concept}</button> 
                    <button>${concept}</button> 
                </nav>
            </div>
            <div class="f" id="">
                <div class="album" id=""><img src="${album_img}" alt="" class="" id="" style="width: 200px; height: 190px;"><div class="" style="height: 22%;"><h3 class="over">${concept_word}</h3></div></div>
                <div class="album" id=""><img src="${album_img}" alt="" class="" id="" style="width: 200px; height: 190px;"><div class="" style="height: 22%;"><h3 class="over">${concept_word}</h3></div></div>
                <div class="album" id=""><img src="${album_img}" alt="" class="" id="" style="width: 200px; height: 190px;"><div class="" style="height: 22%;"><h3 class="over">${concept_word}</h3></div></div>
                <div class="album" id=""><img src="${album_img}" alt="" class="" id="" style="width: 200px; height: 190px;"><div class="" style="height: 22%;"><h3 class="over">${concept_word}</h3></div></div>
                <div class="album" id=""><img src="${album_img}" alt="" class="" id="" style="width: 200px; height: 190px;"><div class="" style="height: 22%;"><h3 class="over">${concept_word}</h3></div></div>
            </div>
        </div>
        <br><br>
        <div>
        <form action="/myinfo" method="get">
	        <table class="Attendance_table" id=""><h1>***출석 체크***</h1>
	            <tr class="" id="">
	                <th class="" id="">${day}</th>
	                <th class="" id="">${day}</th>
	                <th class="" id="">${day}</th>
	                <th class="" id="">${day}</th>
	                <th class="" id="">${day}</th>
	                <th class="" id="">${day}</th>
	                <th class="" id="">${day}</th>
	            </tr>
	            <tr class="" id="">
	                <td class="" id="">${date}</td>
	                <td class="" id="">${date}</td>
	                <td class="" id="">${date}</td>
	                <td class="" id="">${date}</td>
	                <td class="" id="">${date}</td>
	                <td class="" id="">${date}</td>
	                <td class="" id="">${date}</td>
	            </tr>
	        </table>
        </form>
    </div>
    </section>
</body>
<script>
    
</script>
</html>