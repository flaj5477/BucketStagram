<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 값 반환</title>
<link rel="stylesheet" href="css/search.css">
</head>
<body>
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