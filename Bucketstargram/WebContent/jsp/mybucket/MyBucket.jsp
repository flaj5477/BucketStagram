<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%
	String userid = (String)session.getAttribute("userid");
%>
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
<style>
ul{width:200px;}
li{
    height:50px;
    line-height: 50px;
    text-align: center;
    border-bottom: 1px solid blue;
    background-color: yellow;
}
.scrollBlind{
    width:100%;
    height:100%;
/*     width:230px;
    height:100%; */
    /* 스크롤 생성 위치 */
    overflow-y:scroll;
    background-color: white;
} 
.reple-view{
    width:100%;
    height:50%;
/*     width:200px;
    height:260px;
    position: absolute; */
    /* border:1px solid red; */
    border-bottom:1px solid #f1f1f1;
    
    overflow: hidden;
}
.repl{
    margin-bottom: 20px;
    margin-top: 5px;
    height: 10%;
}
.repl-id{
	display:inline;
	margin:5px;
}
.add-view{
	width:100%;
    height:25%;
    border-bottom:1px solid #f1f1f1;
}
.add-view-child{
    display: block;
    margin: 5px;
}
.add-view-child i{
    font-size: x-large;
    margin: 0px 5px;	 
}
#total-like-view{
    display: block;
    margin: 10px;
}
#reply-post-up textarea{
	width:100%;
	height:10%;
    padding: 0;
    border: 0;
    resize: none;
}
.repl-wDate {
   	display: block;
    margin: 5px;
}
#bucket-wDate{
	display: block;
    margin: 10px;
}
</style>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script src="js/bootstrap.js"></script>
<script>
	//클릭한 버킷의 id값 
	var imageId = "";
	//리플 개수 저장 변수
	var replyCnt;
	//좋아요 개수 저장 변수
	var likeCnt;
	//서버로부터 전송받은 String으로 변환된 bucketJson 데이터를 저장할 변수
	var result;
	//해당 사용자가 보려는 버킷에 좋아요 유무 판단 변수(Y/N)
	var likeYN;
	//stirng으로 넘어온 데이터를 json객체로 파싱 후 저장할 변수
	var bucketJson;
	var request = new XMLHttpRequest();
	
	function startModal(element) {
		//modal창 사진으로 클릭한 사진이 올라오도록 작업
		document.getElementById("modalImg").src = element.src;
		//버킷의 id 저장
		imageId = element.id;
		console.log(imageId);
		request.open("Post", "GetBucketInfo.do?imageId="+encodeURIComponent(imageId, true));
		//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.onreadystatechange = searchProcess;
		request.send(null);
	}
	function searchProcess() {
		//댓글 내용 html에 생성하기 위해 사용될 태크 저장 변수
		var tag = "";
		var result = "";
		//4: request finished and response is ready
		//Returns the status-number of a request 200: "OK"		
		if (request.readyState == 4 && request.status == 200) {
			console.log("Ajax Request 호출 성공");
			
			//서버의 string 타입 결과 데이터 저장
			result = request.responseText;
			//Stirng -> JSON객체 파싱
			bucketJson = JSON.parse(result);
			//댓글 갯수 세팅
			replyCnt = bucketJson.reply.length;
			//좋아요 갯수 세팅
			likeCnt = Number(bucketJson.bucket.bucket_like);
			//좋아요 유무 세팅
			likeYN = bucketJson.bucket.likeYN;
			
			for (var key=0 ; key<replyCnt ; key++){
				//댓글 정보 태크 작업 부분
				tag += '<div class="repl"><h3 class = "repl-id">' + bucketJson.reply[key].reMemberId  + '</h3><span class = "repl-content">' + bucketJson.reply[key].reReplyContents + '</span>' + '<span class = "repl-wDate">' + bucketJson.reply[key].reWriteDate + '</span></div>';
			}
			//리플 태그 실제로 넣는 부분
			document.getElementById("ajax-repl").innerHTML = tag;
			//리플 개수 정보 태그에 삽입
			document.getElementById("total-reply-view").innerHTML = "댓글 " + replyCnt + "개";
			//좋아요 개수 정보 태그에 삽입
			document.getElementById("total-like-view").innerHTML = "좋아요 " + likeCnt + "개";
			//로그인한 사용자가 해당 버킷에 이미 좋아요를 했을 경우 빨간색으로 표시
			if(likeYN == "Y"){
				$("#like").css("color", "red");			
			}else{
				$("#like").css("color", "black");
			}
			//모달창 실행
			document.getElementById("modal").style.display = "block";
			
			
			console.log("--- Modal Up ---");
		}
	}
		
	window.onclick = function(event) {
		if (event.target == modal) {
			console.log("--- Modal Close ---");
			
		/* 	DB의 댓글 갯수로 구한게 아니라 모달창 띄웠을 때 댓글 개수에 댓글 추가 시킬때마다 해당 변수를 증감시키면서 임시적으로 댓글 개수를 계산 했기 때문에 
			모달창을 닫으면 0개로 초기화 시키고 새로운 모달창을 열때 다시 DB의 댓글 갯수 계산에 구함 */
			replyCnt = 0;
			likeCnt = 0;
			tagAppend = true;
			//댓글 입력시 text창에 입력된 댓글 내용 공백으로 변환
			document.getElementById("reply-textArea").value='';
			//
			modal.style.display = "none";
			$('.repl').remove();
		}
	}
</script>
<script>
///////////////현재 시간 출력을 위한 함수////////////////////////
	function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
	}

	function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
	}
////////////////////////////////////////////////////

	var tagAppend = false;
	var tag = "";
	var insertSuccess = false;
	
	//댓글 엔터혹은 게시 버튼 클릭시 댓글 추가 ; 쉬프트+엔터는 줄바꿈
	$(function() {
		$('textarea').off().on('keydown', function(event) {
	        if (event.keyCode == 13 && !event.shiftKey){
	        	//엔터키 입력시에만 tag추가 허용
	        	tagAppend=true;
	        	console.log("--- Enter ---");
	        	appendReply();
	        }else if(event.keyCode == 13 && event.shiftKey){
	        	console.log("--- Shift + Enter ---");
	        }
		});
	});

 	function appendReply(){
		request.open("Post", "AppendReply.do?imageId="+encodeURIComponent(imageId, true)+"&replyCotent="+$('#reply-textArea').val());
		//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.onreadystatechange = appendProcess;
		request.send(null);
	}
	function appendProcess() {
		tag = "";
		insertSuccess = request.responseText;
		console.log("DB작업 성공(T)실패(F) => " + insertSuccess);
		
		if (request.readyState == 4 && request.status == 200) {
			if(insertSuccess == "true"){
				tag += '<div class="repl"><h3 class = "repl-id">' + '<%=userid%>'  + '</h3><span class = "repl-content">' + $('#reply-textArea').val() + '</span>' + '<span class = "repl-wDate">' + getTimeStamp() + '</span></div>';
				// replyCnt : 댓글 입력시 총 댓글 갯수 증가 시키기 위해 존재
				replyCnt = replyCnt+1;
				document.getElementById("total-reply-view").innerHTML = "댓글 " + replyCnt + "개";
				console.log("tag = " + tag);
				tagAppend = false; 
				document.getElementById("reply-textArea").value='';
				insertSuccess = false;
			}
			$('#ajax-repl').append(tag);
		}
	}
</script>
<script>
	function likeAction(){
		//처음 모달창에 접속시 좋아요를 했다고 판단 했을 경우 좋아요 버튼 클릭시 불필요한 request요청 방지를 위해 존재
		console.log("likeYN = " +likeYN);
		request.open("Post", "LikeAction.do?imageId="+encodeURIComponent(imageId, true)+"&likeYN="+likeYN);
		//status가 변경될 때마다 호출 한다.
		request.onreadystatechange = likeProcess;
		request.send(null);
	}
	
	function likeProcess() {
		// insertSuccess, insertFail, deleteSuccess, deleteFail 받아옴
		likeStatus = request.responseText;
		console.log("likeStatus = " + likeStatus);
		
		if (request.readyState == 4 && request.status == 200) {
			if(likeStatus == "insertSuccess"){
				$("#like").css("color", "red");
				//좋아요 한 상태 이므로 Y로 변경
				likeYN="Y";
				//좋아요 한 개 추가
				likeCnt = likeCnt+1;
				document.getElementById("total-like-view").innerHTML = "좋아요 " + likeCnt + "개";
			}else if(likeStatus == "deleteSuccess"){
				$("#like").css("color", "black");
				likeYN="N";
				//좋아요 한 개 감소
				likeCnt = likeCnt-1;
				document.getElementById("total-like-view").innerHTML = "좋아요 " + likeCnt + "개";
			}else{
				console.log(likeStatus);
			}
		}
	}
</script>
<script>
	//위시리스트 JSON 정보 저장 테이블
	let wishJson;
	function wishList(){
		request.open("Post", "GetWishInfo.do");
		//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.onreadystatechange = getWishListProcess;
		request.send(null);
	}
	
	function getWishListProcess() {
		// insertSuccess, insertFail, deleteSuccess, deleteFail 받아옴
		wishJson = request.responseText;
		console.log("likeStatus = " + likeStatus);
		
		if (request.readyState == 4 && request.status == 200) {
			bucketJson = JSON.parse(result);
		}
</script>
</head>
<body>
	<div>
	    <section>
			<span onclick="bucketList();">버킷리스트</span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<span onclick="wishList();">위시리스트</span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href = "BucketPostForm.do">등록</a>
	    </section>
	</div>
    <H3>TEST</H3>
	<div>
 		<c:forEach items="${bucketList}" var="bucket">
			<img id="${bucket.bucketId }" src="${bucket.bucketImagePath }" style="width: 100%; max-width: 300px" onclick="startModal(this)"/>
		</c:forEach> 
	</div>
	<div id="modal" class="modal">
		<div id="container">
			<div id="image-box">
				<img class="modal-content" id="modalImg">
			</div>
			<div id="reply-box">
<!-- 				<div id = "reple-profile-fist-box">
					<div id = "reple-profile-second-box">
						<div id = "reple-profile-image-box"><a><img/></a></div>
						<div>
							<div></div>
							<div></div>
						</div>
					</div>
				</div> -->
				<div class = "reple-view">
					<div id="ajax-repl"class = "scrollBlind">
						<div class="repl">
						</div>
					</div>
				</div>
				<div class = "add-view">
					<span class = "add-view-child">
						<i id="like" class="fa fa-heart-o" aria-hidden="true" onclick="likeAction();"></i>
						<i id="add" class="fa fa-plus-circle" aria-hidden="true"></i>
						<i id="delete" class="fa fa-trash-o" aria-hidden="true"></i>
						<i id="update" class="fa fa-pencil-square-o" aria-hidden="true"></i>
					</span>
					<span class = "cnts" id="total-reply-view">
					</span>
					<span id="total-like-view">
					</span>
					<span id="bucket-wDate">
						2019-08-20 13:39:14
					</span>
				</div>
				<div id="reply-post-up">
					<form id="reply-submit">
						<span><textarea id="reply-textArea" rows="3"></textarea></span>
						<span><button type="submit" onclick="buttonClick();">올리기</button></span>
					</form>
				</div>
			</div> 
		</div>
	</div>
</body>
</html>









<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%
	String userid = (String)session.getAttribute("userid");
%>
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
<style>
ul{width:200px;}
li{
    height:50px;
    line-height: 50px;
    text-align: center;
    border-bottom: 1px solid blue;
    background-color: yellow;
}
.scrollBlind{
    width:107%;
    height:100%;
/*     width:230px;
    height:100%; */
    /* 스크롤 생성 위치 */
    overflow-y:scroll;
    background-color: white;
} 
.reple-view{
    width:100%;
    height:70%;
/*     width:200px;
    height:260px;
    position: absolute; */
    /* border:1px solid red; */
    border-bottom:1px solid #f1f1f1;
    
    overflow: hidden;
}
.repl{
    margin-bottom: 20px;
    margin-top: 5px;
    height: 10%;
}
.repl-id{
	display:inline;
	margin:5px;
}
.add-view{
	width:100%;
    height:20%;
    border-bottom:1px solid #f1f1f1;
}
.add-view-child{
    display: block;
    margin: 5px;
}
.add-view-child i{
    font-size: x-large;
    margin: 0px 5px;	 
}
#total-like-view{
    display: block;
    margin: 10px;
}
#reply-post-up textarea{
	width:100%;
	height:10%;
    padding: 0;
    border: 0;
    resize: none;
}
.repl-wDate {
   	display: block;
    margin: 5px;
}
#bucket-wDate{
	display: block;
    margin: 10px;
}
</style>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script src="js/bootstrap.js"></script>
<script>
	var imageId = "";
	//중복 이벤트 발생해서 막기위해 추가함
	var tagCreate = false;
	//리플 개수 저장 변수
	var replyCnt;
	var request = new XMLHttpRequest();
	function startModal(element) {
		imageId = element.id;
		/////////////////////
		console.log("imageId = " + imageId);
		/////////////////////
		document.getElementById("modalImg").src = element.src;
		request.open("Post", "GetReply.do?imageId="+encodeURIComponent(imageId, true));
		request.onreadystatechange = searchProcess;//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.send(null);
	}
	function searchProcess() {
		var tag = "";
		var result = "";
		//4: request finished and response is ready
		//Returns the status-number of a request 200: "OK"		
		if (request.readyState = 4 && request.status == 200) {
			/////////////////////////////////////////////////////////////
			console.log("searchProcess : request.responseText = " + request.responseText);
			/////////////////////////////////////////////////////////////
			result = request.responseText;
			//console.log("result = " + result);
			//해당 게시물에 댓글이 없을 경우 태그 추가없이 모달창만 띄운다.
			//if(result != ""){
				console.log("test");
				if(result != ""){
					tagCreate = true;
					//console.log("result = " + result);
					var bucketJson = JSON.parse(result);
					//리플 개수 bucketJson 데이터 길이로 구함 - Object.keys(객체명).length
					replyCnt = Object.keys(bucketJson).length;
				}
				
//				console.log("result = " + result);
				for (var key in bucketJson){
	 				console.log("key = " + key);
					console.log("result[key] = " + bucketJson[key]); 
					console.log("bucketJson length = " + Object.keys(bucketJson).length);
					tag += '<div class="repl"><h3 class = "repl-id">' + bucketJson[key].reMemberId  + '</h3><span class = "repl-content">' + bucketJson[key].reReplyContent + '</span>' + '<span class = "repl-wDate">' + bucketJson[key].reWriteDate + '</span></div>';
					console.log(tag);
				}
				if(tagCreate){
					//리플 태그 실제로 넣는 부분
					document.getElementById("ajax-repl").innerHTML = tag;
					//리플 개수 태그에 실제로 값 넣는 부분
					document.getElementById("total-like-view").innerHTML = "댓글 " + replyCnt + "개";
					//한 번 태그 만들었으면 모달창 닫을 때까지는 생성 못하게 막음 - 중복 실행되서 강제로 넣음
					tagCreate = false;
				}
				
				document.getElementById("modal").style.display = "block";
			//}else{
				console.log("GetReply에서 result없음")
				//서버에서 받아온 result가 공백이면 댓글 개수가 하나도 없는 경우이므로 replyCnt에 0값을 설정 
				
/* 				if(tagCreate){
					replyCnt = 0;
					document.getElementById("total-like-view").innerHTML = replyCnt + "개";
					document.getElementById("modal").style.display = "block";
					tagCreate = false;
				} */
			//}
		}
	}
		
	window.onclick = function(event) {
		if (event.target == modal) {
			replyCnt = 0;
			tagCreate = true;
			tagAppend = true;
			document.getElementById("reply-textArea").value='';
			console.log("modal close");
			modal.style.display = "none";
			$('.repl').remove();
		}
	}
</script>
<script>
	//이벤트가 두 번 실행되어  강제로 막기위해 사용 - 왜 두 번 실행 되는지 알 수 없음
	
///////////////현재 시간 출력을 위한 함수////////////////////////
	function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
	}

	function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
	}
////////////////////////////////////////////////////
	var tagAppend = false;
	var tag = "";
	var insertSuccess = false;
	//댓글 엔터혹은 게시 버튼 클릭시 댓글 추가
	//쉬프트 엔터는 줄바꿈
	$(function() {
		$('textarea').off().on('keydown', function(event) {
	        if (event.keyCode == 13 && !event.shiftKey){
	        	//엔터키 입력시에만 tag추가 허용
	        	tagAppend=true;
	        	console.log("Endter : tagAppend = " + tagAppend);
	        	console.log("전송");
	        	appendReply();
	        }else if(event.keyCode == 13 && event.shiftKey){
	        	console.log("줄바꿈");
	        }
		});
	});

 	function appendReply(){
		request.open("Post", "AppendReply.do?imageId="+encodeURIComponent(imageId, true)+"&replyCotent="+$('#reply-textArea').val());
		request.onreadystatechange = appendProcess;//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.send(null);
	}
	function appendProcess() {
		tag = "";
		insertSuccess = request.responseText;
		console.log("appendProcess() : insertSuccess = " + insertSuccess);
		
		if (request.readyState = 4 && request.status == 200) {
			if(insertSuccess == "true" && tagAppend == true){
				tag += '<div class="repl"><h3 class = "repl-id">' + '<%=userid%>'  + '</h3><span class = "repl-content">' + $('#reply-textArea').val() + '</span>' + '<span class = "repl-wDate">' + getTimeStamp() + '</span></div>';
				replyCnt = replyCnt+1;
				document.getElementById("total-like-view").innerHTML = "종아요 " + replyCnt + "개";
				console.log("tag = " + tag);
				tagAppend = false; 
				document.getElementById("reply-textArea").value='';
				insertSuccess = false;
			}
			$('#ajax-repl').append(tag);
		}
	}
</script>
<script>
	function likeAction(){
		request.open("Post", "LikeAction.do?imageId="+encodeURIComponent(imageId, true));
		request.onreadystatechange = likeProcess;
		request.send(null);
	}
	
	function likeProcess() {
		// InsertSuccess, InsertFail 받아옴
		requestStatus = request.responseText;
		console.log("likeProcess() : requestStatus = " + requestStatus);
		
		if (request.readyState = 4 && request.status == 200) {
			if(requestStatus == "InsertSuccess"){
				//document.getElementById("total-like-view").innerHTML = "종아요 " + replyCnt + "개";
				$("#like").css("color", "red");
				insertSuccess = false;
			}else{
				console.log('일시적인 오류가 발생했습니다.');
			}
		}
	}
</script>
</head>
<body>
    <section>
		<a href = "BucketPostForm.do">등록</a>
    </section>
    <H3>TEST</H3>
	<div>
 		<c:forEach items="${bucketList}" var="bucket">
			<img id="${bucket.bucketId }" src="${bucket.bucketImagePath }" style="width: 100%; max-width: 300px" onclick="startModal(this)"/>
		</c:forEach> 
	</div>
	<div id="modal" class="modal">
		<div id="container">
			<div id="image-box">
				<img class="modal-content" id="modalImg">
			</div>
			<div id="reply-box">
				<div class = "reple-view">
					<div id="ajax-repl"class = "scrollBlind">
						<div class="repl">
						</div>
					</div>
				</div>
				<div class = "add-view">
					<span class = "add-view-child">
						<i id="like" class="fa fa-heart-o" aria-hidden="true" onclick="likeAction();"></i>
						<i id="add" class="fa fa-plus-circle" aria-hidden="true"></i>
						<i id="delete" class="fa fa-trash-o" aria-hidden="true"></i>
						<i id="update" class="fa fa-pencil-square-o" aria-hidden="true"></i>
					</span>
					<span id="total-like-view">
					</span>
					<span id="bucket-wDate">
						2019-08-20 13:39:14
					</span>
				</div>
				<div id="reply-post-up">
					<form id="reply-submit">
						<span><textarea id="reply-textArea" rows="3"></textarea></span>
						<span><button type="submit" onclick="buttonClick();">올리기</button></span>
					</form>
				</div>
			</div> 
		</div>
	</div>
</body>
</html> --%>












<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%
	String userid = (String)session.getAttribute("userid");
%>
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
<style>
ul{width:200px;}
li{
    height:50px;
    line-height: 50px;
    text-align: center;
    border-bottom: 1px solid blue;
    background-color: yellow;
}
.scrollBlind{
    width:107%;
    height:100%;
/*     width:230px;
    height:100%; */
    /* 스크롤 생성 위치 */
    overflow-y:scroll;
    background-color: white;
} 
.reple-view{
    width:100%;
    height:70%;
/*     width:200px;
    height:260px;
    position: absolute; */
    /* border:1px solid red; */
    border-bottom:1px solid #f1f1f1;
    
    overflow: hidden;
}
.repl{
    margin-bottom: 20px;
    margin-top: 5px;
    height: 10%;
}
.repl-id{
	display:inline;
	margin:5px;
}
.add-view{
	width:100%;
    height:20%;
    border-bottom:1px solid #f1f1f1;
}
.add-view-child i{
	font-size: x-large;
	margin: 5px;
}
#total-like-view{
	display:block;
}
#reply-post-up textarea{
	width:100%;
	height:10%;
    padding: 0;
    border: 0;
    resize: none;
}
.repl-wDate {
   	display: block;
    margin: 5px;
}
</style>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script src="js/bootstrap.js"></script>
<script>
	var imageId = "";
	//중복 이벤트 발생해서 막기위해 추가함
	var tagCreate = false;
	//리플 개수 저장 변수
	var replyCnt;
	var request = new XMLHttpRequest();
	function startModal(element) {
		imageId = element.id;
		/////////////////////
		console.log("imageId = " + imageId);
		/////////////////////
		document.getElementById("modalImg").src = element.src;
		request.open("Post", "GetReply.do?imageId="+encodeURIComponent(imageId, true));
		request.onreadystatechange = searchProcess;//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.send(null);
	}
	function searchProcess() {
		var tag = "";
		var result = "";
		//4: request finished and response is ready
		//Returns the status-number of a request 200: "OK"		
		if (request.readyState = 4 && request.status == 200) {
			/////////////////////////////////////////////////////////////
			console.log("searchProcess : request.responseText = " + request.responseText);
			/////////////////////////////////////////////////////////////
			result = request.responseText;
			//console.log("result = " + result);
			//해당 게시물에 댓글이 없을 경우 태그 추가없이 모달창만 띄운다.
			//if(result != ""){
				console.log("test");
				if(result != ""){
					tagCreate = true;
					//console.log("result = " + result);
					var bucketJson = JSON.parse(result);
					//리플 개수 bucketJson 데이터 길이로 구함 - Object.keys(객체명).length
					replyCnt = Object.keys(bucketJson).length;
				}
				
//				console.log("result = " + result);
				for (var key in bucketJson){
	 				console.log("key = " + key);
					console.log("result[key] = " + bucketJson[key]); 
					console.log("bucketJson length = " + Object.keys(bucketJson).length);
					tag += '<div class="repl"><h3 class = "repl-id">' + bucketJson[key].reMemberId  + '</h3><span class = "repl-content">' + bucketJson[key].reReplyContent + '</span>' + '<span class = "repl-wDate">' + bucketJson[key].reWriteDate + '</span></div>';
					console.log(tag);
				}
				if(tagCreate){
					//리플 태그 실제로 넣는 부분
					document.getElementById("ajax-repl").innerHTML = tag;
					//리플 개수 태그에 실제로 값 넣는 부분
					document.getElementById("total-like-view").innerHTML = "좋아요 " + replyCnt + "개";
					//한 번 태그 만들었으면 모달창 닫을 때까지는 생성 못하게 막음 - 중복 실행되서 강제로 넣음
					tagCreate = false;
				}
				
				document.getElementById("modal").style.display = "block";
			//}else{
				console.log("GetReply에서 result없음")
				//서버에서 받아온 result가 공백이면 댓글 개수가 하나도 없는 경우이므로 replyCnt에 0값을 설정 
				
/* 				if(tagCreate){
					replyCnt = 0;
					document.getElementById("total-like-view").innerHTML = replyCnt + "개";
					document.getElementById("modal").style.display = "block";
					tagCreate = false;
				} */
			//}
		}
	}
		
	window.onclick = function(event) {
		if (event.target == modal) {
			replyCnt = 0;
			tagCreate = true;
			tagAppend = true;
			document.getElementById("reply-textArea").value='';
			console.log("modal close");
			modal.style.display = "none";
			$('.repl').remove();
		}
	}
</script>
<script>
	//이벤트가 두 번 실행되어  강제로 막기위해 사용 - 왜 두 번 실행 되는지 알 수 없음
	
///////////////현재 시간 출력을 위한 함수////////////////////////
	function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
	}

	function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
	}
////////////////////////////////////////////////////
	var tagAppend = false;
	var tag = "";
	var insertSuccess = false;
	//댓글 엔터혹은 게시 버튼 클릭시 댓글 추가
	//쉬프트 엔터는 줄바꿈
	$(function() {
		$('textarea').off().on('keydown', function(event) {
	        if (event.keyCode == 13 && !event.shiftKey){
	        	//엔터키 입력시에만 tag추가 허용
	        	tagAppend=true;
	        	console.log("Endter : tagAppend = " + tagAppend);
	        	console.log("전송");
	        	appendReply();
	        }else if(event.keyCode == 13 && event.shiftKey){
	        	console.log("줄바꿈");
	        }
		});
	});

 	function appendReply(){
		request.open("Post", "AppendReply.do?imageId="+encodeURIComponent(imageId, true)+"&replyCotent="+$('#reply-textArea').val());
		request.onreadystatechange = appendProcess;//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.send(null);
	}
	function appendProcess() {
		tag = "";
		insertSuccess = request.responseText;
		console.log("appendProcess() : insertSuccess = " + insertSuccess);
		
		if (request.readyState = 4 && request.status == 200) {
			if(insertSuccess == "true" && tagAppend == true){
				tag += '<div class="repl"><h3 class = "repl-id">' + '<%=userid%>'  + '</h3><span class = "repl-content">' + $('#reply-textArea').val() + '</span>' + '<span class = "repl-wDate">' + getTimeStamp() + '</span></div>';
				replyCnt = replyCnt+1;
				document.getElementById("total-like-view").innerHTML = "종아요 " + replyCnt + "개";
				console.log("tag = " + tag);
				tagAppend = false; 
				document.getElementById("reply-textArea").value='';
				insertSuccess = false;
			}
			$('#ajax-repl').append(tag);
		}
	}
</script>
</head>
<body>
    <section>
		<a href = "BucketPostForm.do">등록</a>
    </section>
    <H3>TEST</H3>
	<div>
 		<c:forEach items="${bucketList}" var="bucket">
			<img id="${bucket.bucketId }" src="${bucket.bucketImagePath }" style="width: 100%; max-width: 300px" onclick="startModal(this)"/>
		</c:forEach> 
	</div>
	<div id="modal" class="modal">
		<div id="container">
			<div id="image-box">
				<img class="modal-content" id="modalImg">
			</div>
			<div id="reply-box">
				<div class = "reple-view">
					<div id="ajax-repl"class = "scrollBlind">
						<div class="repl">
						</div>
					</div>
				</div>
				<div class = "add-view">
					<span class = "add-view-child">
						<a href="#" id="like" class="#"><i class="fa fa-heart-o" aria-hidden="true"></i></a>
						<a href="#" id="add" class="#"><i class="fa fa-plus-circle" aria-hidden="true"></i></a>
						<a href="#" id="delete" class="#"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
						<a href="#" id="update" class="#"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
					</span>
					<span id="total-like-view">
					</span>
					<span id="bucket-wDate">
					</span>
				</div>
				<div id="reply-post-up">
					<form id="reply-submit">
						<span><textarea id="reply-textArea" rows="3"></textarea></span>
						<span><button type="submit" onclick="buttonClick();">올리기</button></span>
					</form>
				</div>
			</div> 
		</div>
	</div>
</body>
</html> --%>















<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Profile | Vietgram</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navigation">
        <div class="navigation__column">
            <a href="Index.do">
                <img src="images/mylogo.png" />
            </a>
        </div>
        <div class="navigation__column">
            <i class="fa fa-search"></i>
            <input type="text" placeholder="Search">
        </div>
        <div class="navigation__column">
            <ul class="navigations__links">
                <li class="navigation__list-item" id="sign-in" style="display:block;">
                    <a href="LoginForm.do" class="navigation__link">
                        <i class="fa fa-sign-in" aria-hidden="true"></i>Login
                    </a>
                </li>
                <li class="navigation__list-item" id="sign-up" style="display:block;">
                    <a href="#" class="navigation__link">
                       	<i class="fa fa-user-plus" aria-hidden="true"></i>SignUp
                    </a>
                </li>
                <li class="navigation__list-item" id="sign-out" style="display:none;">
                    <a href="#" class="navigation__link" onclick = "logOut()">
                       	<i class="fa fa-sign-out" aria-hidden="true"></i>Logout
                    </a>
                </li>
            </ul>
            <% String userid = (String)session.getAttribute("userid"); %>
            <% if(userid != null){%>
	            <script>
	           		document.getElementById("sign-in").style.display = 'none';
	           		document.getElementById("sign-up").style.display = 'none';
	           		document.getElementById("sign-out").style.display = 'block';
	           	</script>
            <% }else{%>
            	<script>
            		document.getElementById("sign-in").style.display = 'block';
            		document.getElementById("sign-up").style.display = 'block';
            		document.getElementById("sign-out").style.display = 'none';
            	</script>
            <%	}%>
            <script>
            	function logOut(){
            		window.alert("로그아웃 하시겠습니까?");
            		document.location.href = "LogOut.do";
            	}
            </script>
        </div>
    </nav>
    <main id="profile">
        <header class="profile__header">
            <div class="profile__column">
                <img src="images/avatar.jpg" />
            </div>
            <div class="profile__column">
                <div class="profile__title">
                    <h1 class="profile__username">${userid }</h1>
                    <a href="edit-profile.html">Edit profile</a>
                    <i class="fa fa-cog fa-lg"></i>
                </div>
                <ul class="profile__stats">
                    <li class="profile__stat">
                        <span class="stat__number">${bucketList.size() }</span> posts
                    </li>
                    <li class="profile__stat">
                        <span class="stat__number">0</span> followers
                    </li>
                    <li class="profile__stat">
                        <span class="stat__number">0</span> following
                    </li>
                </ul>
                <p class="profile__bio">
                    <span class="profile__full-name">
                        Nicolás Serrano Arévalo
                    </span> Doing whatever and eating Pho Lorem ipsum dolor sit amet consectetur, adipisicing
                    elit. Ducimus suscipit praesentium eveniet quibusdam ipsam omnis fugit. Tempore voluptates ratione recusandae
                    natus illo perspiciatis suscipit, odio consequuntur quasi obcaecati minus! Omnis.
                    <a href="#">serranoarevalo.com</a>
                </p>
            </div>
        </header>
        <section>
        	 <jsp:include page = "../category/topmenu.jsp"></jsp:include>
        </section>
        <br>
        <section>
			<a href = "BucketPostForm.do">등록</a>
        </section>
        <br>
        <section>
        	<jsp:include page="BucketPhotos.jsp"></jsp:include>
        </section>
    </main>
    <footer class="footer">
        <div class="footer__column">
            <nav class="footer__nav">
                <ul class="footer__list">
                    <li class="footer__list-item"><a href="#" class="footer__link">About Us</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Support</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Blog</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Press</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Api</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Jobs</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Privacy</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Terms</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Directory</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Language</a></li>
                </ul>
            </nav>
        </div>
        <div class="footer__column">
            <span class="footer__copyright">© 2017 Vietgram</span>
        </div>
    </footer>
    
</body>
</html> --%>