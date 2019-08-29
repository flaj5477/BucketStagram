<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버킷스타그램 라이브러리 탭</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.gallery {
	display: inline;
	float: left;
	width: 20%;
	height: 400px;
}

img {
	width: 100%;
	height: 100%;
	margin: 10px;
	padding: 10px;
}

form[name="frm_Search"] {
	text-align: center;
	margin: 0 auto;
}
input[name="wordSearch"] {
	height: 2em;
	text-align: left
}
div.libList{
	display: flow-root;
}
#libInsert{
	font-size: 30px;
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="../category/nav.jsp"/>
	<jsp:include page="../category/header.jsp"/>
	
	<!-- 라이브러리 추가하는 버튼 -->
	<div id="libInsert">
		<a href="LibInsertForm.do">
			<i class="fa fa-plus-square-o" aria-hidden="true"></i>
		</a>
	</div>
	
	
	<!-- 라이브러리리스트 사진 출력하는 부분 -->
		<div class="libList">
			<c:forEach items="${libraryList}" var="library">
				<div class="gallery" align="center">
					<a target="_blank" href="DetailLibFrm.do?libId=${library.libId }"
						data-poptrox="iframe,1200x800"> <img id="${library.libId }"
						src="${library.libImagePath }" />
					</a>
				</div>
			</c:forEach>
		</div>

	<%-- 			<!-- Thumbnails -->
			<div class="thumbnails">
				<!-- 4*5 배열 -->
				<div>
					<c:forEach items="${libraryList}" var="library" begin="0" end="3">
						<a href="DetailLibFrm.do?libId=${library.libId }"
							data-poptrox="iframe,1200x800"> <img id="${library.libId }"
							src="${library.libImagePath }"
							style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
				<div>
					<c:forEach items="${libraryList}" var="library" begin="4" end="7">
						<a href="DetailLibFrm.do?libId=${library.libId }"
							data-poptrox="iframe,1200x800"> <img id="${library.libId }"
							src="${library.libImagePath }"
							style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
				<div>
					<c:forEach items="${libraryList}" var="library" begin="8" end="11">
						<a href="DetailLibFrm.do?libId=${library.libId }"
							data-poptrox="iframe,1200x800"> <img id="${library.libId }"
							src="${library.libImagePath }"
							style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
				<div>
					<c:forEach items="${libraryList}" var="library" begin="12" end="15">
						<a href="DetailLibFrm.do?libId=${library.libId }"
							data-poptrox="iframe,1200x800"> <img id="${library.libId }"
							src="${library.libImagePath }"
							style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
				<div>
					<c:forEach items="${libraryList}" var="library" begin="16" end="19">
						<a href="DetailLibFrm.do?libId=${library.libId }"
							data-poptrox="iframe,1200x800"> <img id="${library.libId }"
							src="${library.libImagePath }"
							style="width: 100%; max-width: 300px" />
						</a>
					</c:forEach>
				</div>
			</div>
		</div> --%>


	<!-- footer자리 -->
	<jsp:include page="../category/libFooter.jsp"/>


	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>