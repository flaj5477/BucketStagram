<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$('form')
</script>
</head>
<body>
	<form action="BucketPost.do" method="post" enctype="multipart/form-data">
		<br>
		제목: <input type="text" name="bucketTitle">
		<br>
		내용: <input type="text" name="bucketContent">
		<br>
		사진: <input type="file" name="bucketImage">
		<br>
		
		<input type="submit" value="전송">
	</form>
</body>
</html>