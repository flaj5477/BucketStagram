<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%	String word = (String) request.getAttribute("word"); %>
<title><%=word%></title>
</head>
<body>
	<div align = "center">
	<h2>Library</h2>
		<table border="1">
				<tr>
					<th width="100">제목</th>
					<th width="50">타입</th>
					<th width="50">좋아요</th>
					<th width="150">이미지</th>
				</tr>
			<c:forEach items="${getLibrarySearch}" var="dto">
				<tr onmouseover="this.style.background='#FAF082'" onmouseout="this.style.background='#FFFFFF'">
					<td align="center">${dto.libTitle}</td>
					<td align="center">${dto.libType}</td>
					<td align="center">${dto.libLike}</td>
					<td align="center">${dto.libImagePath}</td>
				</tr>
			</c:forEach>	
		</table>
	</div>
	<div align="center">
		<h2>Buckets</h2>
		<table border="1">
				<tr>
					<th width="50">작성자</th>
					<th width="100">제목</th>
					<th width="50">타입</th>
					<th width="100">챌린지</th>
					<th width="50">좋아요</th>
					<th width="150">이미지</th>
				</tr>
			<c:forEach items="${getBucketSearch}" var="dto">
				<tr onmouseover="this.style.background='#FAF082'" onmouseout="this.style.background='#FFFFFF'">
					<td align="center">${dto.bucketMemberId}</td>
					<td align="center">${dto.bucketTitle}</td>
					<td align="center">${dto.bucketType}</td>
					<td align="center">${dto.bucketCompliation}</td>
					<td align="center">${dto.bucketLike}</td>
					<td align="center">${dto.bucketImagePath}</td>
				</tr>
			</c:forEach>	
			</table>
	</div>
</body>
</html>