<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<%
	String userId = (String) session.getAttribute("userid");
%>
<style>
html {
	width: 1200px;
	height: 800px;
	
}
body {
	max-width: inherit;
	height: inherit;
	margin: 0;
	background-color: white;
	overflow: hidden;
}
img.photo__avatar{	/* 이미지 동그랗게 자르기 */
	width: 50px;
    height:50px;
    border-radius: 50px;
}
div.photo {			/* 화면전체 */
	width: 1200px;
	height: 800px;
}

header.photo__header {	/* 라이브러리 아이디, 타이틀 출력 부분 */
	height: 50px;
	width: 600px;
	display: inline-flex;
}

div.photo__info {		/*헤더를 제외한 나머지 공간*/
	width: 600px;
	height: 750px;
	display: inline-block;
}

div.lib_content {		/*라이브러리 내용 출력 공간*/
	font-size: 30px;
	width: 600px;
	height: 500px;
	overflow: auto;
}

div.photo__likes {		/*좋아요 갯수 표시 부분*/
	width: 600px;
	height: 20px;
	padding-left: 15px;
	padding-top: 5px;
    padding-bottom: 3px;
    font-size: 20px;
}

div.photo__actions {	/*좋아요, add, 삭제 버튼 공간*/
	width: 600px;
	height: 30px;
	font-size: 30px;
	padding: 5px;
}

div.libLikeMembs {		/*좋아요 한 사람들 리스트*/
	width: 590px;
	height: 170px;
	overflow: auto;
	padding: 5px;
}

a {						
	text-decoration: none;
	padding: 0 10px 0 10px;
	color: rgba(0, 106, 213);
}
p{
	margin: 3px 0 3px 10px;
	font-size: 18px;
}

</style>
</head>
<body>
	<!-- 주석   -->
	<div class="photo">
		<img src="${library.libImagePath }" align="left" width="600"
			, height="800">
		<header class="photo__header">
			<img src="images/avatar.jpg" class="photo__avatar">
			<div class="photo__user-info">
				<span class="photo__author">라이브러리 아이디: ${library.libId}</span> <br>
				<span
					class="photo__location">${library.libTitle}</span>
			</div>
		</header>
		<div class="photo__info">
			<div class="lib_content">
				${library.libContents }</div>

			<div class="photo__actions">
				<span class="photo__action"> <!-- 좋아요  -->
					<i class="fa fa-heart-o fa-lg"></i>
				</span> 
				
				<span class="photo__action"> <!-- 버킷으로 추가 -->
					<a href="javascript:addBucket()" id="add" > 
						<i class="fa fa-plus" aria-hidden="true"></i>
					</a> 
				</span> 
				<span class="photo__action"> <!-- 라이브러리 수정 -->
					<a href="javascript:updateLibrary()" id="update" > 
						<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
					</a> 
				</span>
				<span class="photo__action"> <!-- 라이브러리 삭제 -->
					<a href="javascript:removeLibrary()" id="remove"> 
						<i class="fa fa-trash" aria-hidden="true"></i>
					</a> 
				</span>
			</div>

			<form name="addFrm">
				<input type="hidden" name="imagePath"
					value="${library.libImagePath }"> <input type="hidden"
					name="bucketTitle" value="${library.libTitle }"> <input
					type="hidden" name="bucketContent" value="${library.libContents }">
				<input type="hidden" name="bucketMemberId" value="<%=userId%>">
			</form>


			<div class="photo__likes">${library.libLike} likes</div>
			<div class="libLikeMembs">
				<c:forEach items="${library.libLikeMembList}" var="likeMemb">
					<p class="likeMembs">${likeMemb }</p>
				</c:forEach>
			</div>
		</div>
	</div>

	<script>
		var form = document.addFrm;
		function addBucket() {
			//document.addFrm.submit();
			if(confirm("버킷리스트에 추가하시겠습니까?")){
				
				$(top.document).find(".poptrox-popup").css({"width":"400px", "height":"400px"});
				form.action = "LibraryAddForm.do";	//경로 설정
				form.submit();

				return true;
			} else {
				return false;
			}
		};
		
		function removeLibrary(){
			//request.getParameter에 library.libId를 보내야 함
			parent.document.location.href="libraryRemove.do?deletelibId="+"${library.libId}";
			//부모창에서 실행하기!
			
		};
		
		function updateLibrary() {
			if (confirm("라이브러리를 수정하겠습니까?")) {

				$(top.document).find(".poptrox-popup").css({
					"width" : "400px",
					"height" : "400px"
				});	//팝업창 사이즈 바꾸기
				form.action = "LibraryUpdateForm.do" // 수정 화면으로 이동
				form.submit();

				return true;
			} else {
				return false;
			}
		}

		$(document).ready(function() { //로그인 해야 add(+)버튼 보이게 하는 함수	
			console.log("로그인 아이디 = " + "
	<%=userId%>");
		
			$("#add").hide();//add태그 숨기기
			$("#remove").hide();//trash태그 숨기기
			$("#update").hide();
			if("<%=userId%>" != "null") {
				$("#add").show();//add태그 보이기
				if("<%=userId%>" == "owner") {		//관리자로 로그인 해야 삭제 버튼 보임
					$("#remove").show();//trash태그 보이기
					$("#update").show();
				}	
			}
		});
	</script>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>



</body>
</html>