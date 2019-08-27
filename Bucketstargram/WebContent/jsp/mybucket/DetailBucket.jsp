<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/css/styles.css">
<%
	String userId = (String)session.getAttribute("userid");
	String ownerId = (String)session.getAttribute("ownerId");
%>
<script>
//클릭한 버킷의 id값 
var bucketId = "${bucket.bucketId}";
//리플 개수 저장 변수
var replyCnt = Number("${bucket.bucketReplyCnt}");
//좋아요 개수 저장 변수
var likeCnt = Number("${bucket.bucketLike}");
//해당 사용자가 보려는 버킷에 좋아요 유무 판단 변수(Y/N)
var likeYN = "${bucket.bucketLiketYN}";
//해당 버킷이 진행 중인지 완료 했는지 판단 변수 => default = "challenging"
var completionYN = "challenging";
//버킷 이미지 경로
var imagePath = "${bucket.bucketImagePath}"; 
//버킷 제목 저장 변수
let bucketTitle = "${bucket.bucketTitle}";
//버킷 내용 저장 변수
let bucketContent = "${bucket.bucketContents}"; 
//버킷 소요주 아이디 저장 변수
let bucketMemberId = "${bucket.bucketMemberId}";
//stirng으로 넘어온 데이터를 json객체로 파싱 후 저장할 변수
var bucketJson;
//파라미터 변수
let param;
//서버로부터 전송받은 String으로 변환된 bucketJson 데이터를 저장할 변수
var result;
//댓글 내용 html에 생성하기 위해 사용될 태크 저장 변수
var tag;
var request = new XMLHttpRequest();
	
$( document ).ready(function(){
	if(likeYN == "Y"){
		tag = "<i class='fa fa-heart' style='color:red;' aria-hidden='true' onclick='likeAction();'></i>";
		document.getElementById("like").innerHTML = tag; 
	}else{
		tag = "<i class='fa fa-heart-o' aria-hidden='true' onclick='likeAction();'></i>";
		document.getElementById("like").innerHTML = tag;
	}
});
</script>
<script>
function likeAction(){
	console.log("--- likeAction() 호출 ---")
	//param = "imageId=" + encodeURIComponent(imageId, true) + "&likeYN=" + likeYN;
	request.open("Post", "LikeAction.do?bucketId="+encodeURIComponent(bucketId, true)+"&likeYN="+likeYN);
	//서버와의 통신 status가 변경될 때마다 likeProcess가 호출 된다.
	request.onreadystatechange = likeProcess;
	request.send(null);
}

function likeProcess() {
	
	if (request.readyState == 4 && request.status == 200) {
		// insertSuccess, insertFail, deleteSuccess, deleteFail 받아옴
		likeStatus = request.responseText;
		console.log("likeYN = " + likeYN);
		tag="";
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
			//wishList();
		}else if(likeStatus == "deleteSuccess"){
			tag = "<i class='fa fa-heart-o' aria-hidden='true' onclick='likeAction();'></i>";
			document.getElementById("like").innerHTML = tag;
			likeYN="N";
			//좋아요 한 개 감소
			likeCnt = likeCnt-1;
			document.getElementById("total-like-view").innerHTML = "좋아요 " + likeCnt + "개";
			//wishList();
		}else{
			console.log("DB작업 실패");
		}
	}
}
</script>
<script>
///////////////현재 시간 출력을 위한 함수/////////////////////////////////////////
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
/////////////////////////////////////////////////////////////////////////

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
	let replyContent = $('#reply-textArea').val();
	request.open("Post", "AppendReplyAction.do?bucketId="+encodeURIComponent(bucketId, true)+"&replyCotent="+replyContent+"&ownerId="+"<%=ownerId%>");
	//성공적으로 요청하는 동작이 끝났으면 searchProcess 실행
	request.onreadystatechange = appendProcess;
	request.send(null);
}
function appendProcess() {
	
	if (request.readyState == 4 && request.status == 200) {
		tag = "";
		var insertSuccess = request.responseText;
		console.log("DB작업 성공(T)실패(F) => " + insertSuccess);
		
		if(insertSuccess == "true"){
			tag += '<div class="repl"><a href="OtherBucket.do?ownerId='+'<%=userId%>'+'"><h3 class = "repl-id"  style="display:inline-block">' + '<%=userId%>'  + '</h3></a><span class = "repl-content">' + $('#reply-textArea').val() + '</span>' + '<div class = "repl-wDate">' + getTimeStamp() + '</div></div>';
			// replyCnt : 댓글 입력시 총 댓글 갯수 증가 시키기 위해 존재
			replyCnt = replyCnt+1;
			document.getElementById("total-reply-view").innerHTML = "댓글 " + replyCnt + "개";
			console.log("tag = " + tag);
			document.getElementById("reply-textArea").value='';
		}else{
			console.log("DB작업 실패");
		}
		$('#bucket_repl').append(tag);
	}
}	
</script>
<style>
div::-webkit-scrollbar { 
    display: none !important;
}
</style>
</head>
<body>
	<div class="photo" >
		<div  style="display:inline-block;">
			<img src="${bucket.bucketImagePath }" align="left" width="600" height="800">
		</div>
		<div style="margin-left:10px;height:780px;width:550px;display:inline-block;font-size: 30px;overflow-y: scroll;">
			<div class="photo__header">
				<img src="images/avatar.jpg" class="photo__avatar">
				<div class="photo__user-info">
					<span class="photo__author">사용자 아이디</span> 
					<span class="photo__location">${bucket.bucketMemberId}</span>
				</div>
			</div>
			<div>
				<div id="bucket_repl" class="bucket_repl">
					<c:forEach items="${replyList}" var="reply">
						<div class="repl">
							<a href="OtherBucket.do?ownerId=${reply.reMemberId }"><h3 class = "repl-id" style="display:inline-block">${reply.reMemberId }</h3></a>
							<span class="repl-content">${reply.reReplyContents }</span>
							<div>${reply.reWriteDate }</div><br>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div>
			<div class="photo__actions">
				<span id="like" onclick="likeAction()"><i class="fa fa-heart-o fa-lg"></i></span> 
				<span id="complete"><i class="fa fa-check-circle-o" aria-hidden="true" onclick="completeAction();"></i></span>
				<span id="delete"><i class="fa fa-trash-o" aria-hidden="true" onclick="deleteAction();"></i></span>
				<span id="update"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></span>
				<span id="chat"><i class="fa fa-comment-o fa-lg" onclick="$('#reply-textArea').focus();"></i></span>
				<br>
				<span id="total-like-view">좋아요 ${bucket.bucketLike}개</span>
				<br> 
				<span id="total-reply-view">댓글 ${bucket.bucketReplyCnt }개</span>
				<br>
				<span id="bucket-wDate">${bucket.bucketWriteDate } 작성...</span>
			</div>
		</div>
		<div>
			<div class="photo__add-comment-container">
				<textarea id="reply-textArea" name="comment" placeholder="Add a comment..."></textarea>
				<i class="fa fa-ellipsis-h"></i>
			</div>
		</div>
	</div>
</body>
</html>