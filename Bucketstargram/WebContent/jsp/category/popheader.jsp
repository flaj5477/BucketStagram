<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<%
	String userId = (String)session.getAttribute("userid");
	//String ownerId = (String)session.getAttribute("ownerId");
%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
	function login(){
		if(confirm("로그인이 필요합니다. 로그인  하시겠습니까?")){
			document.location.href = "LoginForm.do";
			return true;
		} else {
			return false;
		}
	}
</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/styles.css" />
<style>
	.icons .fa{
	width: 50px;
    height: 50px;
    border-radius: 50px;
    background-color: #00b8ff9c;
    color: white;
    font-size: 25px;
    text-align: center;
    line-height: 50px;
	}
	
	.icons .fa:hover {
	background-color: #10b2cc;
	}
	
	.icons .active {
	background-color: #10b2cc;
	}
	
	.category{
		display: grid;
	}
</style>
</head>
<body>
<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<header id="header">

			<span class="logo">
				<a href="Index.do">
				<img src="images/logo2.png"/></a>
			</span>

			<ul class="topMenu">
				<li><a class="menuLink" href="LibraryForm.do">Library</a></li>
				<li><a class="menuLink" href="PopMain.do">Popular</a></li>
				<%if(userId == null) {%>
					<li><a class="menuLink" href="#" onclick="login();">MyBucket</a></li>
				<%} else{%>
					<li><a class="menuLink" href="MyBucket.do">MyBucket</a></li>
				<%} %>
			</ul>
			<hr>
			<ul class="icons">
				<li><a href="PopMain.do" class="category"><i class="fa fa-slack" aria-hidden="true"></i><span
						class="label">전체</span></a></li>
				<li><a href="PopMain.do?type=여행"
					class="category"><i class="fa fa-plane" aria-hidden="true"></i><span class="label">여행</span></a></li>
				<li><a href="PopMain.do?type=운동"
					class="category"><i class="fa fa-child" aria-hidden="true"></i><span class="label">운동</span></a></li>
				<li><a href="PopMain.do?type=음식"
					class="category"><i class="fa fa-cutlery" aria-hidden="true"></i><span class="label">음식</span></a></li>
				<li><a href="PopMain.do?type=배움"
					class="category"><i class="fa fa-graduation-cap" aria-hidden="true"></i><span class="label">배움</span></a></li>
				<li><a href="PopMain.do?type=문화"
					class="category"><i class="fa fa-paint-brush" aria-hidden="true"></i><span class="label">문화</span></a></li>
				<li><a href="PopMain.do?type=야외"
					class="category"><i class="fa fa-envira" aria-hidden="true"></i><span class="label">야외</span></a></li>
				<li><a href="PopMain.do?type=쇼핑"
					class="category"><i class="fa fa-shopping-bag" aria-hidden="true"></i><span class="label">쇼핑</span></a></li>
				<li><a href="PopMain.do?type=생활"
					class="category"><i class="fa fa-home" aria-hidden="true"></i><span class="label">생활</span></a></li>
			</ul>
		</header>
	</div>
	
	<script>
		var type =  "${param.type}";
		var classname = "";
		
		switch(type){
		case "":
			classname = "fa-slack";
			break;
		case "여행":
			classname = "fa-plane";
			break;
		case "운동":
			classname = "fa-child"
			break;
		case "음식":
			classname = "fa-cutlery"; 
			break;
		case "배움":
			classname = "fa-graduation-cap";
			break;
		case "문화":
			classname = "fa-paint-brush";
			break;
		case "야외":
			classname = "fa-envira";
			break;
		case "쇼핑":
			classname = "fa-shopping-bag";
			break;
		case "생활":
			classname = "fa-home";
			break;
		}
		
		$("."+classname).addClass("active");
	</script>
</body>
</html>