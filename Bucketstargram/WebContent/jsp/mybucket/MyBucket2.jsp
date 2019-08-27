<%@page import="co.bucketstargram.dto.BucketDto"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버킷스타그램 라이브러리 탭</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/styles.css" />
<style>


form[name="frm_Search"] {
	text-align: center;
	margin: 0 auto;
}

input[name="wordSearch"] {
	height: 2em;
	text-align: left
}
</style>
</head>
<body>

	<div id="wrapper">
		<!-- Header -->
		<jsp:include page="../../jsp/category/MybucketHeader.jsp"/>

		<!-- Main -->
		<div>
			<!-- Thumbnails -->
			<div class="thumbnails">
				<div class = "bucket_view_column">
					<c:forEach items="${div1}" var="bucket">
						<a href="DetailMyBucket.do?bucketId=${bucket.bucketId }" data-poptrox="iframe,1200x805"> 
							<img id="${bucket.bucketId }" src="${bucket.bucketImagePath }"	style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
				<div class = "bucket_view_column">
					<c:forEach items="${div2}" var="bucket">
						<a href="DetailMyBucket.do?bucketId=${bucket.bucketId }" data-poptrox="iframe,1200x805"> 
							<img id="${bucket.bucketId }" src="${bucket.bucketImagePath }"	style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
				<div class = "bucket_view_column">
					<c:forEach items="${div3}" var="bucket">
						<a href="DetailMyBucket.do?bucketId=${bucket.bucketId }" data-poptrox="iframe,1200x805"> 
							<img id="${bucket.bucketId }" src="${bucket.bucketImagePath }"	style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
				<div class = "bucket_view_column">
					<c:forEach items="${div4}" var="bucket">
						<a href="DetailMyBucket.do?bucketId=${bucket.bucketId }" data-poptrox="iframe,1200x805"> 
							<img id="${bucket.bucketId }" src="${bucket.bucketImagePath }"	style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>				
				</div>
			</div>


		</div>

	</div>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>