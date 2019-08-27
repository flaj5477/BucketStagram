<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/styles.css" />
<link rel="stylesheet" href="css/test.css" />
<style>


.gallery{
 	display : inline;
 	float : left;
 	width:450px;
 	height:450px;
} 
.navigation__column input {
	border: 1px solid #e6e6e6;
	border-radius: 3px;
	font-size: 10px;
}

form[name="frm_Search"] {
	text-align: center;
	margin: 0 auto;

}

input[name="wordSearch"] {
	height: 2em;
	text-align: left;



</style>


</head>
<body>
	<nav class=navigation>
		<div class="navigation__column">
			&nbsp;&nbsp;&nbsp;
		</div>
		<div class="navigation__column">
			<form name="frm_Search" action="GetSearch.do" method="get">
				<input type="text" name="word" placeholder="Search">
			</form>
		
		</div>
		<div class="navigation__column">
			<ul class="navigations__links">
				<li class="navigation__list-item" id="sign-in"
					style="display: block;"><a href="LoginForm.do"
					class="navigation__link"> <i class="fa fa-sign-in"
						aria-hidden="true"></i>Login
				</a></li>
				<li class="navigation__list-item" id="sign-up"
					style="display: block;"><a href="SignUp.do" class="navigation__link">
						<i class="fa fa-user-plus" aria-hidden="true"></i>SignUp
				</a></li>
				<li class="navigation__list-item" id="sign-out"
					style="display: none;"><a href="#" class="navigation__link"
					onclick="logOut()"> <i class="fa fa-sign-out"
						aria-hidden="true"></i>Logout
				</a></li>
			</ul>
			
			<%
				String userid = (String) session.getAttribute("userid");
			%>
			<%
				if (userid != null) {
			%>
			<script>
				document.getElementById("sign-in").style.display = 'none';
				document.getElementById("sign-up").style.display = 'none';
				document.getElementById("sign-out").style.display = 'block';
			</script>
			<%
				} else {
			%>
			<script>
				document.getElementById("sign-in").style.display = 'block';
				document.getElementById("sign-up").style.display = 'block';
				document.getElementById("sign-out").style.display = 'none';
			</script>
			<%
				}
			%>
			<script>
				function logOut() {
					window.alert("로그아웃 하시겠습니까?");
					document.location.href = "LogOut.do";
				}
			</script>
		</div>
	</nav>
<!-- Wrapper -->
	<div id="wrapper"> </div>
		<!-- Header -->
		<header id="header">
		

			<span class="logo"><a href="LibraryForm.do"><img src="images/logo2.png" alt="" /></a></span>

			<ul class="topMenu">
				<li><a class="menuLink" href="LibraryForm.do">Library</a></li>
				<li><a class="menuLink" href="PopMain.do">Popular</a></li>
				<li><a class="menuLink" href="MyBucket.do">MyBucket</a></li>
			</ul>
			<hr>
			
			<ul class="icons">
				<li><a href="PopMain.do" class="icon style2 fa-twitter"><span
						class="label">전체</span></a></li>
				<li><a href="Travel.do" class="icon style2 fa-facebook"><span
						class="label">여행</span></a></li>
				<li><a href="Sport.do" class="icon style2 fa-instagram"><span
						class="label">운동</span></a></li>
				<li><a href="Food.do" class="icon style2 fa-500px"><span
						class="label">음식</span></a></li>
				<li><a href="NewSkill.do" class="icon style2 fa-envelope-o"><span
						class="label">배움</span></a></li>
				<li><a href="Culture.do" class="icon style2 fa-envelope-o"><span
						class="label">문화</span></a></li>
				<li><a href="Shopping.do" class="icon style2 fa-envelope-o"><span
						class="label">쇼핑</span></a></li>
				<li><a href="LifeStyle.do" class="icon style2 fa-envelope-o"><span
						class="label">생활</span></a></li>
			</ul>
		</header>


				
 		<!-- <div class="thumbnails" >  -->
		<c:forEach items="${list}" var="dto">
			 <div class="gallery" align="center">
				<a target="_blank" href="assets/feed.html">
					<img src="${dto.bucketImagePath}"
					 style="width: 350px; height:328px;" />  
				</a>
				
				<div>${dto.bucketTitle}</div>
				<div>${dto.bucketType}</div>
				<div>${dto.bucketLike}</div> 
			</div>
		 </c:forEach>
	</div>  
 


<%-- <div align="center">
	<div><p></div>
	<div align="center">
		<div>
		<form name="frm_list"  method="post">
			<input type="hidden" name="id">  <!-- 레코드에 pk값을 전달할 변수 -->
		<table border = "1">
			 
			<c:if test="${isList == true}">
				<tr><td align="center" colspan="6">등록된 글이 없습니다.</td></tr>
			</c:if>
			<c:forEach items="${list }" var="dto">			
			<tr>
					<td align="center">${dto.bucketId }</td>
					</tr><tr>
					 <td align="center">${dto.bucketMemberId }</td> </tr>
					<tr> 
					<td align="center">제목${dto.bucketTitle }</td></tr>
					<tr>
					<td align="center">카테고리 ${dto.bucketType }</td></tr>
					<tr>
					<td align="center">좋아요  ${dto.bucketLike}</td></tr>
					
			</c:forEach>	 --%>				
			 	
		<!-- </table></form></div>
		<div> <p></div>


</div>
</div> -->
	 

		 
	 

    <script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>