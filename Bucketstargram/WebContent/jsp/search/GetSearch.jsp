<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 값 반환</title>
<link rel="stylesheet" href="assets/css/search.css">
<link rel="stylesheet" href="assets/css/styles.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="assets/js/searchSlide.js"></script>
</head>
<body>
	<jsp:include page = "../category/header.jsp"/>
	<hr>
	<h3>Library</h3>
  	<div class="libSlider" align ="center">
		<c:forEach items="${getLibrarySearch}" var="dto">
			<div class="gallery">
				<a target="_blank" href="#">
					<img src="${dto.libImagePath}">
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
	<div class="bucketSlider" align ="center">
		<c:forEach items="${getBucketSearch}" var="dto">
			<div class="gallery">
				<a target="_blank" href="#">
					<img src="${dto.bucketImagePath}">
				</a>
				<div class="type">${dto.bucketType}</div>
				<div class="title">${dto.bucketTitle}</div>
				<div class="like">${dto.bucketLike}</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>