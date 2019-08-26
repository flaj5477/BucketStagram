<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
</head>
<body>
	<main id="profile"> <header class="profile__header">
		<div class="profile__column">
			<img src="images/avatar.jpg" />
		</div>
		<div class="profile__column">
			<div class="profile__title">
				<h1 class="profile__username">${userid}</h1>
				<a href="jsp_test/AjaxTest.jsp">Edit profile</a> <i
					class="fa fa-cog fa-lg"></i>
			</div>
			<ul class="profile__stats">
				<li class="profile__stat"><span class="stat__number">333</span>
					posts</li>
				<li class="profile__stat"><span class="stat__number">1234</span>
					followers</li>
				<li class="profile__stat"><span class="stat__number">36</span>
					following</li>
			</ul>
			<p class="profile__bio">
				<span class="profile__full-name"> Nicolás Serrano Arévalo </span>
				Doing whatever and eating Pho Lorem ipsum dolor sit amet
				consectetur, adipisicing elit. Ducimus suscipit praesentium eveniet
				quibusdam ipsam omnis fugit. Tempore voluptates ratione recusandae
				natus illo perspiciatis suscipit, odio consequuntur quasi obcaecati
				minus! Omnis. <a href="#">serranoarevalo.com</a>
			</p>
		</div>
	</header> </main>
</body>
</html>