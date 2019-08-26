<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/styles.css">
<style>
div.img-container {
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	width: 50%;
	height: 800px;
	float: left;
}

.img-container img{
position: absolute; top:0; left: 0;
width: 50%;
height: 100%;
}

div.info-container {
	width: 50%;
	max-height: 800px;
	float: left;
}

.photo__info{
	max-height: 500px;
}

.lib_content{
	font-size: 30px; 
	height: 550px;
	overflow:auto;
}
.photo__add-comment-container{
	height: 100px;
	overflow:auto;
}

</style>
</head>
<body>
	<div class="photo">
		<div class="img-container">
			<img src="${library.libImagePath }" align="left">
		</div>
		<div class="info-container">
		<div class="photo__header">
			<img src="images/avatar.jpg" class="photo__avatar">
			<div class="photo__user-info">
				<span class="photo__author">라이브러리 아이디</span> <span
					class="photo__location">${library.libId}</span>
			</div>
		</div>
		<div class="photo__info">
			<div class="lib_content">
			 <br>
				<br>
				<br> ${library.libContents }
			</div>

			<div class="photo__actions">
				<span class="photo__action"> <i class="fa fa-heart-o fa-lg"></i>
				</span> 
				
				<span>
					<a href="assets/feed.html" data-poptrox="iframe,600x800">add</a>
					<!-- add 버튼 누르면 버킷 작성페이지로 가기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
				</span>
			</div>
			<span class="photo__likes">${library.libLike } likes</span>
			<div class="photo__add-comment-container">
				이 게시물을 좋아요 한 사람들 
				
			</div>
		</div>
		</div>
	</div>
</body>
</html>