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
	<div class="photo" >
		<div  style="display:inline-block;">
			<img src="${bucket.bucketImagePath }" align="left" width="600" height="800">
		</div>
		<div style="margin-left:10px;height:780px;width:560px;display:inline-block;font-size: 30px;overflow-y: scroll;">
			<div class="photo__header">
				<img src="images/avatar.jpg" class="photo__avatar">
				<div class="photo__user-info">
					<span class="photo__author">사용자 아이디</span> 
					<span class="photo__location">${bucket.bucketMemberId}</span>
				</div>
			</div>
			<div>
				<div class="lib_content">
					<c:forEach items="${replyList}" var="reply">
						<span>${reply.reMemberId }</span>
						<span>${reply.reReplyContents }</span>
						<div>${reply.reWriteDate }</div><br>
					</c:forEach>
				</div>
			</div>
		</div>
		<div>
			<div class="photo__actions">
				<span class="photo__action"><i class="fa fa-heart-o fa-lg"></i></span> 
				<span class="photo__action"><i class="fa fa-comment-o fa-lg"></i></span>
				<span class="photo__likes">45 likes</span> 
				<span class="photo__time-ago">2 hours ago</span>
			</div>
		</div>
		<div>
			<div class="photo__add-comment-container">
				<textarea name="comment" placeholder="Add a comment..."></textarea>
				<i class="fa fa-ellipsis-h"></i>
			</div>
		</div>
	</div>
</body>
</html>