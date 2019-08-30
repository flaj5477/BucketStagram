<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>버킷스타그램 좋아요 순위</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/styles.css" />
<link rel="stylesheet" href="assets/css/font-awesome.min.css" media="screen" title="no title" charset="utf-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>


/* .gallery{
 	display : inline;
 	float : left;
 	width:450px;
 	height:450px;
}  */


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
 
 body {
  padding: 20px;
  font-family: sans-serif;
 
  /* background: #f2f2f2; */
}
img {
  width: 100%; /* need to overwrite inline dimensions */
  height: auto;
}
h2 {
  margin-bottom: .5em;
}
.grid-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  grid-gap: 1em;
}

 
 /* hover styles */
.location-listing {
  position: relative;
}

.location-image {
  line-height: 0;
  overflow: hidden;
}

.location-image img {
  filter: blur(0px);
  transition: filter 0.3s ease-in;
  transform: scale(1.1);
}

.location-title {
  font-size: 1.5em;
  font-weight: bold;
  text-decoration: none;
  z-index: 1;
  position: absolute;
  height: 100%;
  width: 100%;
  top: 0;
  left: 0;
  opacity: 0;
  transition: opacity .5s;
  background: rgba(90,0,10,0.4);
  color: white;
   
  /* position the text in t’ middle*/
  display: flex;
  align-items: center;
  justify-content: center;
}

.location-listing:hover .location-title {
  opacity: 1;
}

.location-listing:hover .location-image img {
  filter: blur(2px);
}
 

/* for touch screen devices */
@media (hover: none) { 
  .location-title {
    opacity: 1;	
  }
  .location-image img {
    filter: blur(2px);
  }
}
 
form[name="frm_Search"] {
	text-align: center;
	margin: 0 auto;

}

input[name="wordSearch"] {
	height: 2em;
	text-align: left;

}
div.child-page-listing{
	display: flow-root;
}


</style>




</head>
<body>	
<jsp:include page = "../category/nav.jsp"/>
<jsp:include page = "../category/popheader.jsp"/>
			
	 

				
 	<div class="child-page-listing" >

			 <div class="grid-container">
			 
			 <c:forEach items="${list}" var="dto" varStatus="status">
			  <div class="gallery" align="center" >
			 	<article id="${dto.bucketId}" class="location-listing">
			 		 <span class="title" style="font-size:45px; color:skyblue	">${status.count}위</span>
				<a href="DetailMyBucket.do?bucketId=${dto.bucketId}"
						   data-poptrox="iframe,1200x800" class="location-title" style="color:white">
						   
						  <br><br><br><br>${dto.bucketTitle}<br><br>
						   ${dto.bucketMemberId}<br><br><br><Br>
						   좋아요  ${dto.bucketLike}개<br><br><br><br>
						  </a>
						   <div class="location-image">		
					<img width="400" height="169" id="${dto.bucketId}"
					 src="${dto.bucketImagePath}"
					 style="width: 350px; height:328px;" />  
					 </div>
					 
					<span class="type" style="text-align:center; font-size:25px">
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
						</article>
						</div>
				</c:forEach>
			</div>
		 
	</div>  
 
	 

		 	<!-- footer자리 -->
	<jsp:include page="../category/popFooter.jsp"/>
	 

    <script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>