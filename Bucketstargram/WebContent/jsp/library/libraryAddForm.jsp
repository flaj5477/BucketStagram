<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>libraryAddForm.jsp</title>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<%
	String imagePath = (String)request.getAttribute("imagePath");
	String bucketTitle = (String)request.getAttribute("bucketTitle");
	String bucketContent = (String)request.getAttribute("bucketContent");
	String bucketMemberId = (String)request.getAttribute("bucketMemberId");
	
	System.out.println(imagePath);
	
	//자바스크립트가 백슬러시 하나 일경우 인식 못하고 깨지는 현상 때문에 치환함
	String replaceImagePath = imagePath.replace("\\", "\\\\");
%>
</head>
<body>

</body>
</html>