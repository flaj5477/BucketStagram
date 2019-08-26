<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버킷스타그램 라이브러리 탭</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/styles.css" />
<style>


form[name="frm_Search"] {
	text-align: center;
	margin: 0 auto;
}

input[name="wordSearch"] {
	height: 2em;
	text-align: left
}
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
					style="display: block;"><a href="#" class="navigation__link">
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
	<div id="wrapper">
		<!-- Header -->
		<header id="header">

			<span class="logo"><img src="images/logo2.png" alt="" /></span>

			<ul class="topMenu">
				<li><a class="menuLink" href="LibraryForm.do">Library</a></li>
				<li><a class="menuLink" href="#">Popular</a></li>
				<li><a class="menuLink" href="MyBucket.do">MyBucket</a></li>
			</ul>
			<hr>

			<ul class="icons">
				<li><a href="#" class="icon style2 fa-twitter"><span
						class="label">전체</span></a></li>
				<li><a href="#" class="icon style2 fa-facebook"><span
						class="label">여행</span></a></li>
				<li><a href="#" class="icon style2 fa-instagram"><span
						class="label">운동</span></a></li>
				<li><a href="#" class="icon style2 fa-500px"><span
						class="label">음식</span></a></li>
				<li><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">배움</span></a></li>
				<li><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">문화</span></a></li>
				<li><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">야외</span></a></li>
				<li><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">쇼핑</span></a></li>
				<li><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">생활</span></a></li>
			</ul>
		</header>

		<!-- Main -->
		<div>


			<!-- Thumbnails -->
			<div class="thumbnails">
				<div>
					<c:forEach items="${libraryList}" var="library">
						<a href="DetailLibFrm.do?libId=${library.libId }" data-poptrox="iframe,1200x800"> <img
							id="${library.libId }" src="${library.libImagePath }"
							style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
				<div>
					<a href="assets/feed.html" data-poptrox="iframe,1200x800"><img
						src="images/thumbs/01.jpg" /></a> <a href="assets/feed.html"
						data-poptrox="iframe,1200x800"><img src="images/thumbs/01.jpg" /></a>
					<a href="assets/feed.html" data-poptrox="iframe,1200x800"><img
						src="images/thumbs/01.jpg" /></a>
				</div>
				<div>
					<a href="assets/feed.html" data-poptrox="iframe,1200x800"><img
						src="images/thumbs/01.jpg" /></a> <a href="assets/feed.html"
						data-poptrox="iframe,1200x800"><img src="images/thumbs/01.jpg" /></a>
					<a href="assets/feed.html" data-poptrox="iframe,1200x800"><img
						src="images/thumbs/01.jpg" /></a>
				</div>
				<div>
					<a href="assets/feed.html" data-poptrox="iframe,1200x800"><img
						src="images/thumbs/01.jpg" /></a> <a href="assets/feed.html"
						data-poptrox="iframe,1200x800"><img src="images/thumbs/01.jpg" /></a>
					<a href="assets/feed.html" data-poptrox="iframe,1200x800"><img
						src="images/thumbs/01.jpg" /></a>
				</div>
				<div>
					<a href="assets/feed.html" data-poptrox="iframe,1200x800"><img
						src="images/thumbs/01.jpg" /></a> <a href="assets/feed.html"
						data-poptrox="iframe,1200x800"><img src="images/thumbs/01.jpg" /></a>
					<a href="assets/feed.html" data-poptrox="iframe,1200x800"><img
						src="images/thumbs/01.jpg" /></a>
				</div>
		

			</div>


		</div>

	</div>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>