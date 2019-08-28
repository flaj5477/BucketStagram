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
<script src="assets/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.js"></script>
<script type="text/javascript" src="assets/js/searchSlide.js"></script>
<script src="assets/js/all.js"></script>
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
						<span class="type">
							<c:if test="${dto.libType == '여행'}">
								<p style="color:#00C5BC">TRAVEL</p>
							</c:if>
							<c:if test="${dto.libType == '운동'}">
								<p style="color:#231815">SPORTS</p>
							</c:if>
							<c:if test="${dto.libType == '음식'}">
								<p style="color:#FD8B42">FOOD</p>
							</c:if>
							<c:if test="${dto.libType == '배움'}">
								<p style="color:#C78646">STUDY</p>
							</c:if>
							<c:if test="${dto.libType == '문화'}">
								<p style="color:#9F7ED7">CULTURE</p>
							</c:if>
							<c:if test="${dto.libType == '야외'}">
								<p style="color:#6FC073">OUTDOOR</p>
							</c:if>
							<c:if test="${dto.libType == '쇼핑'}">
								<p style="color:#EFC648">SHOPPING</p>
							</c:if>
							<c:if test="${dto.libType == '생활'}">
								<p style="color:#87ADF8">LIFESTYLE</p>
							</c:if>
						</span>
						<span class="title">${dto.libTitle}</span>
						</a>
						<div class="contents">${dto.libLike}</div>
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
							<img id="${dto.bucketId}" src="${dto.bucketImagePath}"/>
						<span class="type">
							<c:if test="${dto.bucketType == '여행'}">
								<p style="color:#00C5BC">TRAVEL</p>
							</c:if>
							<c:if test="${dto.bucketType == '운동'}">
								<p style="color:#231815">SPORTS</p>
							</c:if>
							<c:if test="${dto.bucketType == '음식'}">
								<p style="color:#FD8B42">FOOD</p>
							</c:if>
							<c:if test="${dto.bucketType == '배움'}">
								<p style="color:#C78646">STUDY</p>
							</c:if>
							<c:if test="${dto.bucketType == '문화'}">
								<p style="color:#9F7ED7">CULTURE</p>
							</c:if>
							<c:if test="${dto.bucketType == '야외'}">
								<p style="color:#6FC073">OUTDOOR</p>
							</c:if>
							<c:if test="${dto.bucketType == '쇼핑'}">
								<p style="color:#EFC648">SHOPPING</p>
							</c:if>
							<c:if test="${dto.bucketType == '생활'}">
								<p style="color:#87ADF8">LIFESTYLE</p>
							</c:if>
						</span>	
						<span class="title">${dto.bucketTitle}</span>
						</a>
						<div class="contents">${dto.bucketLike}</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
<!-- script -->
<script src="assets/js/jquery.poptrox.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/main.js"></script>
</body>
</html>