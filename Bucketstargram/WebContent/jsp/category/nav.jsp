<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<nav class=navigation>
		<div class="navigation__column">
			<form name="frm_Search" action="GetSearch.do" onsubmit="return searchCond()" method="get">
				<input type="text" name="word" placeholder="Search">
			</form>

		</div>
		<div class="navigation__column"></div>
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
				function searchCond() {
					var word = document.frm_Search.word;
					if(word.value == '') {
						window.alert("검색어를 넣으세요.");
						return false;
					}
					return document.frm_Search.submit();
				}
				function logOut() {
					window.alert("로그아웃 하시겠습니까?");
					document.location.href = "LogOut.do";
				}
			</script>
		</div>
	</nav>
</body>
</html>