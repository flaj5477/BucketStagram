<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		 
		<div><p></div>
		<div align="center">
			<div> <h3><c:if test="${n != 1}" >
			회원가입 실패 했습니다. 다시가입 해주세요 <br> 
			<button type="button" onclick="location.href='SignUp.do'">확인</button>
			</c:if></h3><p></div>
			<div> <h3>
			<c:if test="${n == 1}" >
				 성공 <br>
				<button type="button" onclick="location.href='LoginForm.do'">확인</button>
			</c:if></h3><p></div>
		</div>
	</div>
</body>
</html>