<%@page import="co.bucketstargram.dto.BucketDto"%>
<%@page import="java.util.ArrayList"%>
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
	//현재 보고 있는 버킷의 소유자 ID 저장 변수
	String ownerId = (String)session.getAttribute("ownerId");
%>
<!-- 로딩 화면 스타일 -->
<style>
#loading {
 width: 100%;  
 height: 100%;  
 top: 0px;
 left: 0px;
 position: fixed;  
 display: block;  
 opacity: 0.7;  
 background-color: #fff;  
 z-index: 99;  
 text-align: center; } 
  
#loading-image {  
 position: absolute;  
 top: 50%;  
 left: 50%; 
 z-index: 100; }
</style>
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
#reple-view{
    width:100%;
    height:60%;
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
#add-view{
	width:100%;
    height:30%;
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
#reply-post-up-view{
	width:100%;
	height:10%;
}
.repl-wDate {
   	display: block;
    margin: 5px;
}
#bucket-wDate{
	display: block;
    margin: 10px;
}
a {
	text-decoration: none;
	color: black;
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
	//해당 버킷이 진행 중인지 완료 했는지 판단 변수 => default = "challenging"
	var completionYN = "challenging";
	//이미지 경로
	var imagePath;
	//버킷 제목 저장 변수
	let bucketTitle;
	//버킷 내용 저장 변수
	let bucketContent; 
	//
	let bucketMemberId;
	//댓글 내용 html에 생성하기 위해 사용될 태크 저장 변수
	var tag;
	
	var request = new XMLHttpRequest();
	
	function startModal(element) {
		//로딩 이미지 on
		document.getElementById("loading").style.display = "block";
		//태그 초기화
		tag = "";
		//modal창 사진으로 클릭한 사진이 올라오도록 작업
		document.getElementById("modalImg").src = element.src;
		//버킷의 id 저장
		imageId = element.id;
		console.log("-------------------- " + imageId + " --------------------");
		
		request.open("Post", "GetBucketInfo.do?imageId="+encodeURIComponent(imageId, true));
		//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.onreadystatechange = searchProcess;
		request.send(null);
	}
	function searchProcess() {
		var result = "";
		//4: request finished and response is ready
		//Returns the status-number of a request 200: "OK"		
		if (request.readyState == 4 && request.status == 200) {
			console.log("--- Modal Ajax Request 호출 성공 ---");
			//로딩 이미지 off
			document.getElementById("loading").style.display = "none";
			
			//서버의 string 타입 결과 데이터 저장
			result = request.responseText;
			//console.log(result);
			//Stirng -> JSON객체 파싱
			bucketJson = JSON.parse(result);
			//댓글 갯수 세팅
			replyCnt = bucketJson.reply.length;
			//좋아요 갯수 세팅
			likeCnt = Number(bucketJson.bucket.bucket_like);
			//좋아요 유무 세팅
			likeYN = bucketJson.bucket.likeYN;
			//완료 유무 세팅
			completionYN = bucketJson.bucket.bucket_compliation;
			//이미지 패스 세팅
			imagePath = bucketJson.bucket.bucketImagePath;
			//제목 세팅
			bucketTitle = bucketJson.bucket.bucket_title;
			//내용 세팅
			bucketContent = bucketJson.bucket.bucket_contents;
			//
			bucketMemberId = bucketJson.bucket.bucketMemberId;
			for (var key=0 ; key<replyCnt ; key++){
				//댓글 정보 태크 작업 부분
				if(bucketJson.reply[key].reMemberId == "<%=userid%>"){
					tag += '<div class="repl"><a href="MyBucket.do"><h3 class = "repl-id">' + bucketJson.reply[key].reMemberId  + '</h3></a><span class = "repl-content">' + bucketJson.reply[key].reReplyContents + '</span>' + '<span class = "repl-wDate">' + bucketJson.reply[key].reWriteDate + '</span></div>';
				}else{
					tag += '<div class="repl"><a href="OtherBucket.do?ownerId='+bucketJson.reply[key].reMemberId+'"><h3 class = "repl-id">' + bucketJson.reply[key].reMemberId  + '</h3></a><span class = "repl-content">' + bucketJson.reply[key].reReplyContents + '</span>' + '<span class = "repl-wDate">' + bucketJson.reply[key].reWriteDate + '</span></div>';					
				}
			}
			//리플 태그 실제로 넣는 부분
			document.getElementById("ajax-repl").innerHTML = tag;
			//리플 개수 정보 태그에 삽입
			document.getElementById("total-reply-view").innerHTML = "댓글 " + replyCnt + "개";
			//좋아요 개수 정보 태그에 삽입
			document.getElementById("total-like-view").innerHTML = "좋아요 " + likeCnt + "개";
			//로그인한 사용자가 해당 버킷에 이미 좋아요를 했을 경우 빨간색으로 표시
			if(likeYN == "Y"){
				tag = "<i class='fa fa-heart' style='color:red;' aria-hidden='true' onclick='likeAction();'></i>";
				document.getElementById("like").innerHTML = tag; 
			}else{
				tag = "<i class='fa fa-heart-o' aria-hidden='true' onclick='likeAction();'></i>";
				document.getElementById("like").innerHTML = tag;
			}
			
			if(completionYN == "completion"){
				tag = "<i class='fa fa-check-circle' aria-hidden='true' style='color:blue;' onclick='completeAction();'></i>";
				document.getElementById("complete").innerHTML = tag;
			}else if(completionYN == "challenging"){
				tag = "<i class='fa fa-check-circle-o' aria-hidden='true' style='color:black;' onclick='completeAction();'></i>"
				document.getElementById("complete").innerHTML = tag;
			}
			//버킷의 소유자와 사용자 아이디가 동일할 경우 좋아요 클릭 방지
			//동일할 경우 수정, 삭제, 도전중 유무 클릭 가능
			if(bucketJson.bucket.bucketMemberId == "<%= userid%>"){
				$("#like").css("display", "none");
				$("#complete").css("display", "inline-block");
				$("#update").css("display", "inline-block");
				$("#delete").css("display", "inline-block");
			}else{
				$("#like").css("display", "inline-block");
				$("#complete").css("display", "none");
				$("#update").css("display", "none");
				$("#delete").css("display", "none");
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
	tag = "";
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
		request.open("Post", "AppendReplyAction.do?imageId="+encodeURIComponent(imageId, true)+"&replyCotent="+$('#reply-textArea').val());
		//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
		request.onreadystatechange = appendProcess;
		request.send(null);
	}
	function appendProcess() {
		
		if (request.readyState == 4 && request.status == 200) {
			tag = "";
			insertSuccess = request.responseText;
			console.log("DB작업 성공(T)실패(F) => " + insertSuccess);
			if(insertSuccess == "true"){
				tag += '<div class="repl"><a href="OtherBucket.do?ownerId='+'<%=userid%>'+'"><h3 class = "repl-id">' + '<%=userid%>'  + '</a></h3><span class = "repl-content">' + $('#reply-textArea').val() + '</span>' + '<span class = "repl-wDate">' + getTimeStamp() + '</span></div>';
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
		console.log("--- likeAction() 호출 ---")
		request.open("Post", "LikeAction.do?imageId="+encodeURIComponent(imageId, true)+"&likeYN="+likeYN);
		//서버와의 통신 status가 변경될 때마다 likeProcess가 호출 된다.
		request.onreadystatechange = likeProcess;
		request.send(null);
	}
	
	function likeProcess() {
		
		if (request.readyState == 4 && request.status == 200) {
			// insertSuccess, insertFail, deleteSuccess, deleteFail 받아옴
			likeStatus = request.responseText;
			console.log("likeStatus = " + likeStatus);
			//DB작업이 완료되고 좋아요를 하는 상태일 경우 사랑표 빨간색으로 변경 및 좋아요 갯수 추가
			if(likeStatus == "insertSuccess"){
				//좋아요를 할 경우 
				tag = "<i class='fa fa-heart' style='color:red;' aria-hidden='true' onclick='likeAction();'></i>";
				document.getElementById("like").innerHTML = tag;
				//좋아요 한 상태 이므로 Y로 변경
				likeYN="Y";
				//좋아요 한 개 추가
				likeCnt = likeCnt+1;
				document.getElementById("total-like-view").innerHTML = "좋아요 " + likeCnt + "개";
				wishList();
			}else if(likeStatus == "deleteSuccess"){
				tag = "<i class='fa fa-heart-o' aria-hidden='true' onclick='likeAction();'></i>";
				document.getElementById("like").innerHTML = tag;
				likeYN="N";
				//좋아요 한 개 감소
				likeCnt = likeCnt-1;
				document.getElementById("total-like-view").innerHTML = "좋아요 " + likeCnt + "개";
				wishList();
			}else{
				console.log("DB작업 실패");
			}
		}
	}
</script>
<script>
	//위시리스트 JSON 저장 변수
	let wishJson;
	//버킷의 갯수 저장 변수
	let bucketCtn;
	//myBucketList 출력해주는 태그 저장 변수
	let myBucketCloneTag;
	
	function wishList(){
		console.log("--- wishList() 호출 ---");
		document.getElementById("loading").style.display = "block";
		//wishList 호출 시 mybucketList 이미지 태그들 복사
		myBucketCloneTag = $('#bucket-list').html();
		request.open("Post", "WishListAction.do");
		//성공적으로 요청이 끝났으면 getWishListProcess 실행
		request.onreadystatechange = getWishListProcess;
		request.send(null);
	}
	
	function getWishListProcess() {
		
		if (request.readyState == 4 && request.status == 200) {
			console.log("--- wishList Ajax 응답 성공 ---")
			document.getElementById("loading").style.display = "none";
			wishJson = request.responseText;
			//console.log("wishJson = " + wishJson);
			
			//서버로 부터 받은 string 형태의 json 데이터를 json객체로 파싱
			wishBucketJson = JSON.parse(wishJson);
			//버킷 갯수 저장
			wishBucketCtn = wishBucketJson.bucket.length;
			//태그 초기화
			tag = "";
			
			for (var key=0 ; key<wishBucketCtn ; key++){
				//댓글 정보 태크 생성 작업 부분
				tag += '<img id="' + wishBucketJson.bucket[key].bucketId + '" src="' + wishBucketJson.bucket[key].bucketImagePath + '" style="width: 300px; max-width: 300px" onclick="startModal(this)" />';
			}
			
			document.getElementById("bucket-list").innerHTML = tag;
		}
	}
	
	//위시리스트 리스트 출력 해주는 태그들 복사 저장 변수
	//let wishCloneTag;
	
	function bucketList(){
		console.log("--- bucketList() 호출 ---");
		//위시리스트 출력 태그들 복사
		//wishCloneTag = $('#bucket-list').html();
		
		//myBucketCloneTag => 위시리스트 이벤트 function시작 시점에 저장됨
		document.getElementById("bucket-list").innerHTML = myBucketCloneTag;
	}
</script>
<script>
	
	function deleteAction(){
		if(confirm("삭제하시겠습니까?")){
			location.href = "DeleteAction.do?bucketId="+imageId;
			return true;
		} else {
			return false;
		}
	}
	
	function completeAction(){
		console.log("--- CompleteAction() 호출 ---")
		request.open("Post", "CompletionAction.do?imageId="+encodeURIComponent(imageId, true)+"&completionYN="+completionYN);
		//서버와의 통신 status가 변경될 때마다 likeProcess가 호출 된다.
		request.onreadystatechange = completionProcess;
		request.send(null);
	}
	
	function completionProcess() {
		////completion, challenging, deleteFail
		
		if (request.readyState == 4 && request.status == 200) {
			console.log("--- CompleteAction Ajax 통신 성공 ---")
			completionResult = request.responseText;
			console.log("CompletionResult = " + completionResult);
			//DB작업이 완료되고 버킷 수행 완료를 한 경우 색깔 변경
			completionYN = completionResult;
			if(completionYN == "completion"){
				tag = "<i class='fa fa-check-circle' aria-hidden='true' style='color:blue;' onclick='completeAction();'></i>";
				document.getElementById("complete").innerHTML = tag;
				console.log("--- Completion 표시 완료 ---")
			}else if(completionYN == "challenging"){
				tag = "<i class='fa fa-check-circle-o' aria-hidden='true' style='color:black;' onclick='completeAction();'></i>"
				document.getElementById("complete").innerHTML = tag;
				console.log("--- Challenging... 표시 완료 ---")
			}else{
				console.log(completionResult);
			}
		}
	}
</script>
<script>
	function addAction(){
		if(confirm("버킷리스트에 추가하시겠습니까?")){
			document.location.href = "BucketAddForm.do?imagePath=" + encodeURIComponent(imagePath, true) + "&bucketTitle=" + bucketTitle + "&bucketContent=" +  bucketContent + "&bucketMemberId="+bucketMemberId;
			return true;
		} else {
			return false;
		}
	}
</script>
<script type="text/javascript">
//로딩 화면 감추기
$(window).on('load', function() {    
     $('#loading').hide();  
    });
</script>
</head>
<body>
	<div id="loading" style="display:none;"><img id="loading-image" src="images/loading.gif" alt="Loading..." /></div>
	<div>
	    <section>
			<span onclick="bucketList();">버킷리스트</span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<span onclick="wishList();">위시리스트</span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href = "BucketPostForm.do">등록</a>
	    </section>
	</div>
    <H3>TEST</H3>
	<div id="bucket-list">
 		<c:forEach items="${bucketList}" var="bucket">
			<img id="${bucket.bucketId }" src="${bucket.bucketImagePath }" style="width: 300px; max-width: 300px" onclick="startModal(this)"/>
		</c:forEach> 
	</div>
	<div id="modal" class="modal">
		<div id="container">
			<div id="image-box">
				<img class="modal-content" id="modalImg">
			</div>
			<div id="reply-box">
				<div id = "reple-view">
					<div id="ajax-repl"class = "scrollBlind">
						<div class="repl">
						</div>
					</div>
				</div>
				<div id = "add-view">
					<span class = "add-view-child">
						<span id="like"><i class="fa fa-heart-o" aria-hidden="true" onclick="likeAction();"></i></span>
						<span id="complete"><i class="fa fa-check-circle-o" aria-hidden="true" onclick="completeAction();"></i></span>
						<span id="delete"><i class="fa fa-trash-o" aria-hidden="true" onclick="deleteAction();"></i></span>
						<span id="update"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></span>
						<span id="add"><i class="fa fa-plus" aria-hidden="true" onclick="addAction();"></i></span>
						<span id="chat"><i class="fa fa-commenting-o" aria-hidden="true" onclick="$('#reply-textArea').focus();"></i></span>
					</span>
					<span class = "cnts" id="total-reply-view">
					</span>
					<span id="total-like-view">
					</span>
					<span id="bucket-wDate">
					</span>
				</div>
				<div id="reply-post-up-view">
					<div style="margin-left: 10px; margin-right: 10px; margin-top: 8px;">
						<textarea id="reply-textArea" aira-label = "댓글 달기..." placeholder="댓글 달기..." style="resize: none; width:100%; padding:0; border:0"></textarea>
					</div>
				</div>
			</div> 
		</div>
	</div>
</body>
</html>