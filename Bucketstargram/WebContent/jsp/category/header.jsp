<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
</head>
<body>
<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<header id="header">
			<div id="navigation_header" class="navigation__column">
				<div class="navigation__column">
					<a href="Index.do"> <img src="images/logo2.png"
						 style="width: 200px; height: 50px">
					</a>
				</div>
				<div class="navigation__column" style="margin: 0px 600px">
					<form name="frm_Search" action="GetSearch.do" method="get">
						<i class="fa fa-search"></i>
						<input type="text" placeholder="Search" name="word">
					</form>
				</div>
				<div class="navigation__column">
					<ul class="navigations__links">
						<li class="navigation__list-item" id="sign-in"
							style="display: inline-block;"><a href="LoginForm.do"
							class="navigation__link"> <i class="fa fa-sign-in"
								aria-hidden="true"></i>Login
						</a></li>
						<li class="navigation__list-item" id="sign-up"
							style="display: inline-block;"><a href="SignUp.do"
							class="navigation__link"> <i class="fa fa-user-plus"
								aria-hidden="true"></i>SignUp
						</a></li>
						<li class="navigation__list-item" id="sign-out"
							style="display: inline-block;"><a href="#"
							class="navigation__link" onclick="logOut()"> <i
								class="fa fa-sign-out" aria-hidden="true"></i>Logout
						</a></li>
					</ul>
				</div>
			</div>
			<div>
				<ul class="topMenu">
					<li>&nbsp;&nbsp;&nbsp;|</li>
					<li><a class="menuLink" href="LibraryForm.do">Library</a></li>
					<li>|</li>
					<li><a class="menuLink" href="PopMain.do">Popular</a></li>
					<li>|</li>
					<li><a class="menuLink" href="MyBucket.do">MyBucket</a></li>
					<li>|</li>
				</ul>
			</div>
			<br><br>
			<div>
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
							class="label">쇼핑</span></a></li>
					<li><a href="#" class="icon style2 fa-envelope-o"><span
							class="label">생활</span></a></li>
				</ul>
			</div>
			<%
				String userid = (String) session.getAttribute("userid");
			%>
			<%
				if (userid != null) {
			%>
			<script>
				document.getElementById("sign-in").style.display = 'none';
				document.getElementById("sign-up").style.display = 'none';
				document.getElementById("sign-out").style.display = 'inline-block';
			</script>
			<%
				} else {
			%>
			<script>
				document.getElementById("sign-in").style.display = 'inline-block';
				document.getElementById("sign-up").style.display = 'inline-block';
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
		</header>
	</div>
	<hr>
</body>
</html>