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
<
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
				라이브러리 내용 <br> <br> <br> ${library.libContents }
			</div>

			<div class="photo__actions">
				<span class="photo__action"> <i class="fa fa-heart-o fa-lg"></i>
				</span> <span class="photo__action"> <i
					class="fa fa-comment-o fa-lg"></i>
				</span> <span class="addBucket"> <a href="javascript:addBucket()"
					data-poptrox="iframe,600x800">버킷으로 추가(ADD)</a>
				</span>
			</div>

			<form name="addFrm" action="BucketAddForm.do">
				<input type="hidden" name="imagePath"
					value="${library.libImagePath }"> <input type="hidden"
					name="bucketTitle" value="${library.libTitle }"> <input
					type="hidden" name="bucketContent" value="${library.libContents }">
				<input type="hidden" name="bucketMemberId" value="">
			</form>


			<span class="photo__likes">${library.libLike} likes</span>
			<div class="photo__add-comment-container">
				<c:forEach items="${library.libLikeMembList}" var="likeMemb">
					<span>${likeMemb }</span>
				</c:forEach>
			</div>
		</div>
	</div>


	<script>
		function addBucket() {
			document.addFrm.submit();
		}
	</script>
	<script src="assets/js/jquery.poptrox.min.js"></script>

</body>
</html>