<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버킷스타그램 좋아요 순위</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/styles.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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

}
div.asd{
	display: flow-root;
}

</style>


</head>
<body>
<jsp:include page = "../category/nav.jsp"/>
<jsp:include page = "../category/popheader.jsp"/>
			
	 

				
 	<div class="asd" >
		<c:forEach items="${list}" var="dto">
			 <div class="gallery" align="center">
				<a target="_blank" href="DetailMyBucket.do?bucketId=${dto.bucketId}"
						   data-poptrox="iframe,1200x800">
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
 
	 

		 	<!-- footer자리 -->
	<jsp:include page="../category/popFooter.jsp"/>
	 

    <script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>