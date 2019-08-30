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


.gallery{
 	display : inline;
 	float : left;
 	width:450px;
 	height:450px;
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
<jsp:include page = "../category/nav.jsp"/>
<jsp:include page = "../category/popheader.jsp"/>
			
	 

				
 	<div class="asd" >
		<c:forEach items="${list}" var="dto">
			 <div class="gallery" align="center">
				<a target="_blank" href="DetailMyBucket.do?bucketId=${dto.bucketId}&bucketMemberId=${dto.bucketMemberId}"
						   data-poptrox="iframe,1200x803">
					<img id="${dto.bucketId}" src="${dto.bucketImagePath}"
					 style="width: 350px; height:328px;" />  
					<span class="type">
							<c:if test="${dto.bucketType == '여행'}">
								<p style="color:#00C5BC">TRAVEL</p>
							</c:if>
							<c:if test="${dto.bucketType == '운동'}">
								<p style="color:#231815">SPORTS</p>
							</c:if>
							<c:if test="${dto.bucketType == '음식'}">
								<p style="color:#FD8B42">FOOD</p>
							</c:if>
							<c:if test="${dto.bucketType == '배움'}">
								<p style="color:#C78646">STUDY</p>
							</c:if>
							<c:if test="${dto.bucketType == '문화'}">
								<p style="color:#9F7ED7">CULTURE</p>
							</c:if>
							<c:if test="${dto.bucketType == '야외'}">
								<p style="color:#6FC073">OUTDOOR</p>
							</c:if>
							<c:if test="${dto.bucketType == '쇼핑'}">
								<p style="color:#EFC648">SHOPPING</p>
							</c:if>
							<c:if test="${dto.bucketType == '생활'}">
								<p style="color:#87ADF8">LIFESTYLE</p>
							</c:if>
						</span>	
						<span class="title">${dto.bucketTitle}</span>
						</a>
						<div class="contents">${dto.bucketLike}</div>
				
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