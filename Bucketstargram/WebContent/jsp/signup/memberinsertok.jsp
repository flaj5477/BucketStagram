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
			<div id="wrapper" style = 'text-align: center; margin-top :25px;' >
 
		<span class="logo">
				<a href="Index.do">
				<img style= ' width :30%; height:auto;'  src="images/logo2.png" 
			 /></a>
			</span>			
	</div>  
	<div style ="margin-top:25px;"> 
	 <p><small>감사합니다.</small></p>
	 <p><small>로그인 페이지로 이동합니다.</small>
	</div>
			<meta http-equiv='refresh' content='2;url=LoginForm.do'>
			</c:if></h3><p></div>
		</div>
	</div>
</body>
</html>