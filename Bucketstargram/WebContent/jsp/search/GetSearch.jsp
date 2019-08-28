<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">	
<title>검색 값 반환</title>
<link rel="stylesheet" href="assets/css/search/search-main.css">
<link rel="stylesheet" href="assets/css/styles.css">
<link rel="stylesheet" href="assets/css/search/search.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="assets/js/searchSlide.js"></script>
<script src="assets/js/all.js"></script>
<script src="assets/js/main.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/jquery.poptrox.min.js"></script>
</head>
<body>
	<% String word = request.getParameter("word"); %>
	<jsp:include page = "../category/nav.jsp"/>
	<jsp:include page = "../category/header.jsp"/>
	<div class="border">
		<h2><strong style="color:#1A99EE">'<%=word%>'</strong>에 대한 검색 결과입니다.</h2>
		<div class="slide1">
			<h2>Library</h2>
		  	<div class="libSlider" align ="center">
				<c:forEach items="${getLibrarySearch}" var="dto">
					<div class="gallery">
						<a target="_blank" href="DetailLibFrm.do?libId=${dto.libId}"
						   data-poptrox="iframe,1200x800">
							<img id="${dto.libId}" src="${dto.libImagePath}"/>
						</a>
						<div class="type">${dto.libType}</div>
						<div class="title">${dto.libTitle}</div>
						<div class="contents">${dto.libLike}</div>
						<div>${dto.libId}</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="slide2">
			<div style="clear:both"></div> <!-- css, float속성 clear -->
			<hr>
			<h2>Bucket</h2>
			<div class="bucketSlider" align ="center">
				<c:forEach items="${getBucketSearch}" var="dto">
					<div class="gallery">
						<a target="_blank" href="DetailMyBucket.do?bucketId=${dto.bucketId}"
						   data-poptrox="iframe,1200x800">
							<img src="${dto.bucketImagePath}">
						</a>
						<div class="type">${dto.bucketType}</div>
						<div class="title">${dto.bucketTitle}</div>
						<div class="contents">${dto.bucketLike}</div>
						<div>${dto.bucketId}</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>