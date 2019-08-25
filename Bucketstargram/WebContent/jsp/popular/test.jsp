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
<style>



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
	text-align: left
}
</style>
</head>
<body>
<!-- Wrapper -->
	<div id="wrapper"> </div>
		<!-- Header -->
		<header id="header">
			<div class="navigation__column">
				<form name="frm_Search" action="SetSearch.do" method="get">
				<div>
					<input type="text" name="wordSearch" placeholder="Search">
					<i>검색</i>
					</div>
				</form>
			</div>

			<span class="logo"><img src="images/logo2.png" alt="" /></span>

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

<div align="center">
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
					<%-- <td align="center">${dto.bucketId }</td>
					</tr><tr>
					 <td align="center">${dto.bucketMemberId }</td> </tr> --%>
					<tr> 
					<td align="center">제목${dto.bucketTitle }</td></tr>
					<tr>
					<td align="center">카테고리 ${dto.bucketType }</td></tr>
					<tr>
					<td align="center">좋아요  ${dto.bucketLike}</td></tr>
					
			</c:forEach>					
			 	
		</table></form></div>
		<div> <p></div>


</div>
</div>
	 

		 
	 

    <script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>