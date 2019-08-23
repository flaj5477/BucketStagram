<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 값 반환</title>
<link rel="stylesheet" href="css/search.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style media="screen">
      *{
        margin: 0; padding: 0;
      }
      .slide{
        width: 350px;
        height: 375px;
        overflow: hidden;
        position: relative;
        margin: 0 auto;
      }
      .slide ul{
        width: 1400px;
        position: absolute;
        top:0;
        left:0;
        font-size: 0;
      }
      .slide ul li{
        display: inline-block;
      }
      #back{
        position: absolute;
        top: 250px;
        left: 0;
        cursor: pointer;
        z-index: 1;
      }
      #next{
        position: absolute;
        top: 250px;
        right: 0;
        cursor: pointer;
        z-index: 1;
      }
</style>
<script type="text/javascript">
    $(document).ready(function(){
      var imgs;
      var img_count;
      var img_position = 1;

      imgs = $(".slide ul");
      img_count = imgs.children().length;

      //버튼을 클릭했을 때 함수 실행
      $('#back').click(function () {
        back();
      });
      $('#next').click(function () {
        next();
      });

      function back() {
        if(1<img_position){
          imgs.animate({
            left:'+=350px'
          });
          img_position--;
        }
      }
      function next() {
        if(img_count>img_position){
          imgs.animate({
            left:'-=350px'
          });
          img_position++;
        }
      }
    });
  </script>
</head>
<body>
 	<div class="slide">
      <img id="back" src="images/back.png" alt="" width="100">
      <ul>
        <li><img src="images/feedPhoto3.jpg" alt="" width="350" height="375"></li>
        <li><img src="images/feedPhoto3.jpg" alt="" width="350" height="375"></li>
        <li><img src="images/feedPhoto3.jpg" alt="" width="350" height="375"></li>
        <li><img src="images/feedPhoto3.jpg" alt="" width="350" height="375"></li>
        <li><img src="images/feedPhoto3.jpg" alt="" width="350" height="375"></li>
      </ul>
      <img id="next" src="images/next.png" alt="" width="100">
    </div>
	<hr>
	<h3>Library</h3>
	<div align="center">
		<c:forEach items="${getLibrarySearch}" var="dto">
			<div class="gallery">
				<a target="_blank" href="#">
					<img src="${dto.libImagePath}"width="600" height="400">
				</a>
				<div class="type">${dto.libType}</div>
				<div class="title">${dto.libTitle}</div>
				<div class="like">${dto.libLike}</div>
			</div>
		</c:forEach>
	</div>
	<div style="clear:both"></div> <!-- css, float속성 clear -->
	<hr>
	<h3>Bucket</h3>
	<div align="center">
		<c:forEach items="${getBucketSearch}" var="dto">
			<div class="gallery">
				<a target="_blank" href="#">
					<img src="${dto.bucketImagePath}"width="600" height="400">
				</a>
				<div class="type">${dto.bucketType}</div>
				<div class="title">${dto.bucketTitle}</div>
				<div class="like">${dto.bucketLike}</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>