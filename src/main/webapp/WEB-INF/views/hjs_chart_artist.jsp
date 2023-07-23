<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가수별 좋아요 수 변화</title>
</head>
<body>
 <h1>가수별 좋아요 수 변화</h1>
  
 <form id="chartForm">
 <label for="artist">가수이름:</label>
 <input type="text" id="artist" name="artist" required>
 <button type="submit">조회</button>
 </form>
<br><br>
<img id="chartImage" src="" alt="" style="width: 500px; height: 500px;">

<script>
  // 폼과 이미지 엘리먼트를 가져옵니다.
  var form = document.getElementById("chartForm");
  var chartImage = document.getElementById("chartImage");

 // 폼의 제출 이벤트에 대한 이벤트 리스너를 추가합니다.
 form.addEventListener("submit", function(event) {
    event.preventDefault(); // 폼의 기본 제출 동작을 막습니다.

    // 입력 필드에서 가수 값을 가져옵니다.
    var artist = document.getElementById("artist").value;

    // 이미지의 src 속성을 해당 가수 값으로 업데이트합니다.
    chartImage.src = "/hjs_chart_artist?artist=" + encodeURIComponent(artist);
});

</script> 
</body>
</html>