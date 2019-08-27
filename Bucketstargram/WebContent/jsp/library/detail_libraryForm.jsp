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
<link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
	<div class="photo">
		<img src="${library.libImagePath }" align="left" width="600"
			, height="800">
		<header class="photo__header">
			<img src="../images/avatar.jpg" class="photo__avatar">
			<div class="photo__user-info">
				<span class="photo__author">라이브러리 아이디</span> <span
					class="photo__location">${library.libId}</span>
			</div>
		</header>
		<div class="photo__info">
			<div class="lib_content" style="font-size: 30px">
				라이브러리 내용 <br><br><br>
				${library.libContents }
			</div>
			<br><br><br><br><br><br><br><br>
			
			<div class="photo__actions">
				<span class="photo__action"> <i class="fa fa-heart-o fa-lg"></i>
				</span> <span class="photo__action"> <i
					class="fa fa-comment-o fa-lg"></i>
				</span>
			</div>
			<span class="photo__likes">45 likes</span> <span
				class="photo__time-ago">2 hours ago</span>
			<div class="photo__add-comment-container">
				<textarea name="comment" placeholder="Add a comment..."></textarea>
				<i class="fa fa-ellipsis-h"></i>
			</div>
		</div>
	</div>
</body>
</html>