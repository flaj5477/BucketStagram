<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	test
</body>
</html>


<%-- <%@page import="java.util.ArrayList"%>
<%@page import="co.bucketstargram.dto.BucketDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

#originalImgId {
	border-radius: 5px;
	cursor: pointer;
	transition: 0.3s;
}

#originalImgId:hover {
	opacity: 0.7;
}

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, .5); /* Black w/ opacity */
}

/* Modal Content (image) */
.modal-content {
	margin: 0px;
	display: block;
	width: 100%;
	height: 100%;
	max-width: 700px;
	vertical-align: middle;
}

/* Caption of Modal Image */
#caption {
	margin: auto;
	display: flex;
	width: 80%;
	max-width: 700px;
	text-align: center;
	color: #ccc;
	padding: 0;
	height: 150px;
}

/* Add Animation */
.modal-content, #caption {
	-webkit-animation-name: zoom;
	-webkit-animation-duration: 0.6s;
	animation-name: zoom;
	animation-duration: 0.6s;
}

@
-webkit-keyframes zoom {
	from {-webkit-transform: scale(0)
}

to {
	-webkit-transform: scale(1)
}

}
@
keyframes zoom {
	from {transform: scale(0)
}

to {
	transform: scale(1)
}

}

/* The Close Button */
.close {
	position: absolute;
	top: 15px;
	right: 35px;
	color: #f1f1f1;
	font-size: 40px;
	font-weight: bold;
	transition: 0.3s;
}

.close:hover, .close:focus {
	color: #bbb;
	text-decoration: none;
	cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px) {
	.modal-content {
		width: 100%;
	}
}
</style>
<style>
div#container
{
width:900px;
height: 500px;
/* border:1px solid red; */
vertical-align: middle;
margin: auto;
display: block;
}
#image-box
{
width: 65%;
height: 100%;
float:left;
background-color:black;
/* border:1px solid blue; */
/* margin: 5px 5px; */
}
#reply-box
{
width: 35%; 
height: 100%;
float:right;
/* border:1px solid green; */
margin:0px;
background-color:white;
}
</style>
</head>
<body>
	<section class="profile__photos">
 		<c:forEach items="${bucketList}" var="bucket" varStatus="index">
			<!-- bucket = dto -->
			<div class="profile__photo">
				<img id="originalImgId"src="${bucket.bucketImagePath }" style="width: 100%; max-width: 300px"  onmousedown="startModal(this)"/>
				<div class="profile__photo-overlay">
					<span class="overlay__item"> 
						<i class="fa fa-heart"></i> 
						${bucket.bucketLike }
					</span> 
					<span class="overlay__item"> <i class="fa fa-comment"></i>
						344
					</span>
				</div>
			</div>
		</c:forEach> 
	</section>
	<div id="modal" class="modal">
		<div id="container">
			<div id="image-box">
				<img class="modal-content" id="modalImg">
			</div>
			<div id="reply-box"></div> 
		</div>
	</div>
	<script>
		function startModal(element) {
			document.getElementById("modalImg").src = element.src;
			document.getElementById("modal").style.display = "block";
		}
	</script>
</body>
</html> --%>


<%-- <%@page import="java.util.ArrayList"%>
<%@page import="co.bucketstargram.dto.BucketList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

#originalImgId {
	border-radius: 5px;
	cursor: pointer;
	transition: 0.3s;
}

#originalImgId:hover {
	opacity: 0.7;
}

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, .5); /* Black w/ opacity */
}

/* Modal Content (image) */
.modal-content {
	margin: 0px;
	display: block;
	width: 100%;
	height: 100%;
	max-width: 700px;
	vertical-align: middle;
}

/* Caption of Modal Image */
#caption {
	margin: auto;
	display: flex;
	width: 80%;
	max-width: 700px;
	text-align: center;
	color: #ccc;
	padding: 0;
	height: 150px;
}

/* Add Animation */
.modal-content, #caption {
	-webkit-animation-name: zoom;
	-webkit-animation-duration: 0.6s;
	animation-name: zoom;
	animation-duration: 0.6s;
}

@
-webkit-keyframes zoom {
	from {-webkit-transform: scale(0)
}

to {
	-webkit-transform: scale(1)
}

}
@
keyframes zoom {
	from {transform: scale(0)
}

to {
	transform: scale(1)
}

}

/* The Close Button */
.close {
	position: absolute;
	top: 15px;
	right: 35px;
	color: #f1f1f1;
	font-size: 40px;
	font-weight: bold;
	transition: 0.3s;
}

.close:hover, .close:focus {
	color: #bbb;
	text-decoration: none;
	cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px) {
	.modal-content {
		width: 100%;
	}
}
</style>
<style>
div#container
{
width:900px;
height: 500px;
/* border:1px solid red; */
vertical-align: middle;
margin: auto;
display: block;
}
#image-box
{
width: 65%;
height: 100%;
float:left;
background-color:black;
/* border:1px solid blue; */
/* margin: 5px 5px; */
}
#reply-box
{
width: 35%; 
height: 100%;
float:right;
/* border:1px solid green; */
margin:0px;
background-color:white;
}
</style>
</head>
<body>
	<section class="profile__photos">
 		<c:forEach items="${bucketList}" var="bucket" varStatus="index">
			<!-- bucket = dto -->
			<div class="profile__photo">
				<img id="originalImgId"src="${bucket.bucketImagePath }" onmousedown="doit()"/>
				<div class="profile__photo-overlay">
					<span class="overlay__item"> 
						<i class="fa fa-heart"></i> 
						${bucket.bucketLike }
					</span> 
					<span class="overlay__item"> <i class="fa fa-comment"></i>
						344
					</span>
				</div>
			</div>
		</c:forEach> 
	</section>
	<div id="modal" class="modal">
		<div id="container">
			<div id="image-box">
				<img class="modal-content" id="modalImg">
			</div>
			<div id="reply-box"></div> 
		</div>
	</div>
	<script>
		function doit(){
			console.log("doit");
		}
		function startModal(element) {
			document.getElementById("modalImg").src = element.src;
			document.getElementById("modal").style.display = "block";
		}
	</script>
</body>
</html> --%>





<%-- <%@page import="java.util.ArrayList"%>
<%@page import="co.bucketstargram.dto.BucketList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="profile__photos">
 		<c:forEach items="${bucketList}" var="bucket">
			<!-- bucket = dto -->
			<div class="profile__photo">
				<img src="${bucket.bucketImagePath }" />
				<div class="profile__photo-overlay">
					<span class="overlay__item"> 
						<i class="fa fa-heart"></i> 
						${bucket.bucketLike }
					</span> 
					<span class="overlay__item"> <i class="fa fa-comment"></i>
						344
					</span>
				</div>
			</div>
		</c:forEach> 
	</section>
</body>
</html> --%>