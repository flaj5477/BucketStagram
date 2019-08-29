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
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%
	String userId = (String)session.getAttribute("userid");
	String ownerId = (String)session.getAttribute("ownerId");
%>
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
<script>
//위시리스트 JSON 저장 변수
let wishJson;
//버킷의 갯수 저장 변수
let bucketCtn;
//myBucketList 출력해주는 태그 저장 변수
let myBucketCloneTag;

let request = new XMLHttpRequest();

function wishList(){
	console.log("--- wishList() 호출 ---");
	//document.getElementById("loading").style.display = "block";
	//wishList 호출 시 mybucketList 이미지 태그들 복사
	//myBucketCloneTag = $('#bucket_list_container').html();
	//console.log("myBucketCloneTag = " + myBucketCloneTag);
	request.open("Post", "WishListAction.do");
	//성공적으로 요청이 끝났으면 getWishListProcess 실행
	request.onreadystatechange = getWishListProcess;
	request.send(null);
}

function getWishListProcess() {
	
	if (request.readyState == 4 && request.status == 200) {
		console.log("--- wishList Ajax 응답 성공 ---")
		//document.getElementById("loading").style.display = "none";
		wishJson = request.responseText;
		//console.log("wishJson = " + wishJson);
		
		//서버로 부터 받은 string 형태의 json 데이터를 json객체로 파싱
		wishBucketJson = JSON.parse(wishJson);
		//버킷 갯수 저장
		wishBucketCtn = wishBucketJson.bucket.length;
		//태그 초기화
		tag = "";
		
		for (var key=0 ; key<wishBucketCtn ; key++){
			tag += '<div class="gallery" align="center">' +
			'<a href="DetailMyBucket.do?bucketId=' + wishBucketJson.bucket[key].bucketId +'" data-poptrox="iframe,1200x805">' +
			'<img src="' + wishBucketJson.bucket[key].bucketImagePath + '" style="width: 350px; height:328px;" />' +  '</a>' +
			'<div>' + wishBucketJson.bucket[key].bucket_title + '</div>' +
			'<div class="'+ wishBucketJson.bucket[key].bucket_type +'">' + wishBucketJson.bucket[key].bucket_type + '</div>' +
			'<div>' + wishBucketJson.bucket[key].bucket_like + '</div>' + 
			'</div>';
		}
		//console.log("tag = " + tag)
		
		
		document.getElementById("bucket_list_container").innerHTML = tag;
		modal();
	}
}

function bucketList(){
	console.log("--- bucketList() 호출 ---");
	let bucketJson;
	//document.getElementById("loading").style.display = "block";\
	request.open("Post", "MyBucketListAction.do");
	request.onreadystatechange = getBucketListProcess;
	request.send(null);
}

function getBucketListProcess() {
	
	if (request.readyState == 4 && request.status == 200) {
		console.log("--- bucketList Ajax 응답 성공 ---")
		//document.getElementById("loading").style.display = "none";
		result = request.responseText;
		//console.log("result = " + result);
		
		//서버로 부터 받은 string 형태의 json 데이터를 json객체로 파싱
		var bucketJson = JSON.parse(result);
		//버킷 갯수 저장
		var bucketCtn = bucketJson.length;
		//태그 초기화
		tag = "";
		var i=0
		for (i=0 ; i<bucketCtn ; i++){
			//댓글 정보 태크 생성 작업 부분
			tag += '<div class="gallery" align="center">' +
			'<a href="DetailMyBucket.do?bucketId=' + bucketJson[i].bucketId +'" data-poptrox="iframe,1200x805">' +
			'<img src="' + bucketJson[i].bucketImagePath + '" style="width: 350px; height:328px;" />' +  '</a>' +
			'<div>' + bucketJson[i].bucket_title + '</div>' +
			'<div class="'+ bucketJson[i].bucket_type +'">' + bucketJson[i].bucket_type + '</div>' +
			'<div>' + bucketJson[i].bucket_like + '</div>' + 
			'</div>';
		}
		//console.log("bucketJson[0].bucketId = " + bucketJson[0].bucketId)
		//console.log(tag);
		
		document.getElementById("bucket_list_container").innerHTML = tag;
		modal();
	}
}

//카테고리별 출력 함수
function categoryAction(category){
	console.log(category);
	if(category == "전체"){
		$('.gallery').css('display', 'inline-block');
	}else{
		$('.gallery').css('display', 'none');
		//클래스가 카테고리 값인 모든 div의 부모 div중 class이름이 galley인 태그의 스타일을 변경
		$("div[class='"+ category + "']").parent("div.gallery").css("display", "inline-block");		
	}
}

function bucketPost(){
	location.href = "BucketPostForm.do";
}

</script>
<script>

function modal(){
	var	$window = $(window),
	$body = $('body'),
	$wrapper = $('#wrapper');

	$('.gallery').poptrox({
		onPopupClose: function() { $body.removeClass('is-covered'); },
		onPopupOpen: function() { $body.addClass('is-covered'); },
		baseZIndex: 10001,
		useBodyOverflow: false,
		usePopupEasyClose: true,
		overlayColor: '#000000',
		overlayOpacity: 0.75,
		popupLoaderText: '',
		fadeSpeed: 500,
		usePopupDefaultStyling: false,
		windowMargin: (skel.breakpoint('small').active ? 5 : 50)
	});
	
	$('#post').poptrox({
		onPopupClose: function() { $body.removeClass('is-covered'); },
		onPopupOpen: function() { $body.addClass('is-covered'); },
		baseZIndex: 10001,
		useBodyOverflow: false,
		usePopupEasyClose: true,
		overlayColor: '#000000',
		overlayOpacity: 0.75,
		popupLoaderText: '',
		fadeSpeed: 500,
		usePopupDefaultStyling: false,
		windowMargin: (skel.breakpoint('small').active ? 5 : 50)
	});
}
</script>
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
	<hr style="margin:0px;">
<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<header id="header">
			<span class="logo" style="margin:0px;"><a href="Index.do"><img src="images/logo2.png" alt="" /></a></span>

			<ul class="topMenu">
				<li><a class="menuLink" href="LibraryForm.do">Library</a></li>
				<li><a class="menuLink" href="PopMain.do">Popular</a></li>
				<li><a class="menuLink" href="MyBucket.do">MyBucket</a></li>
			</ul>
			<ul class="topMenu" style="margin:15px;">
				<li id = "myBucket" onclick="bucketList()" style="cursor:pointer;" >버킷리스트</li>
				<li id ="wishBucket" onclick="wishList()" style="cursor:pointer;" >위시리스트</li>
				<li id ="post" style="cursor:pointer;" onclick="modal()">
				<a href="BucketPostForm.do" data-poptrox="iframe,400x400" >등록</a>
				</li>
			</ul>
			<br>
			<ul class="icons">
				<li onclick="categoryAction('전체')"><a href="#" class="icon style2 fa-twitter"><span
						class="label">전체</span></a></li>
				<li onclick="categoryAction('여행')"><a href="#" class="icon style2 fa-facebook"><span
						class="label">여행</span></a></li>
				<li onclick="categoryAction('운동')"><a href="#" class="icon style2 fa-instagram"><span
						class="label">운동</span></a></li>
				<li onclick="categoryAction('음식')"><a href="#" class="icon style2 fa-500px"><span
						class="label">음식</span></a></li>
				<li onclick="categoryAction('배움')"><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">배움</span></a></li>
				<li onclick="categoryAction('문화')"><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">문화</span></a></li>
				<li onclick="categoryAction('쇼핑')"><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">쇼핑</span></a></li>
				<li onclick="categoryAction('생활')"><a href="#" class="icon style2 fa-envelope-o"><span
						class="label">생활</span></a></li>
			</ul>
		</header>
		<div id="bucket_list_container">
			<c:forEach items="${bucketList}" var="bucket">
				 <div class="gallery" align="center">
					<a href="DetailMyBucket.do?bucketId=${bucket.bucketId }" data-poptrox="iframe,1200x805">
						<img src="${bucket.bucketImagePath }" style="width: 350px; height:328px;" />  
					</a>
					<div>${bucket.bucketTitle }</div>
					<div class="${bucket.bucketType}">${bucket.bucketType}</div>
					<div>${bucket.bucketLike}</div> 
				</div>
			 </c:forEach>
		 </div>
	</div> 
    <script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>