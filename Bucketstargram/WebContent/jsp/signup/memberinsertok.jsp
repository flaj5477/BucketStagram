<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
<div class="alert alert-info" role="alert">
  <h4 class="alert-heading">환영합니다!</h4>
  <p>버킷스타그램에 가입해주셔서 감사합니다.</p>
  <hr>
  <p class="mb-0"> 로그인 페이지로 이동합니다.</p>
   <div class="spinner-grow text-success" role="status">
  <span class="sr-only">Loading...</span>
</div>
<div class="spinner-grow text-danger" role="status">
  <span class="sr-only">Loading...</span>
</div>
<div class="spinner-grow text-warning" role="status">
  <span class="sr-only">Loading...</span>
</div></div>
	</div>
			<meta http-equiv='refresh' content='2;url=LoginForm.do'>
			</c:if></h3><p></div>
		</div>
	</div>
</body>
</html>