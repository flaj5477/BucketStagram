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
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<%	
	String userId = (String)session.getAttribute("userid");
	String ownerId = (String)session.getAttribute("ownerId");
%>
<script>
var userId = "<%=userId%>";
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

window.addEventListener('focus', function() {
}, false);

$( document ).ready(function(){
	//$(top.document).find(".poptrox-popup").css({"width":"1200px", "height":"800px"});
	if(likeYN == "Y"){
		tag = "<i class='fa fa-heart' style='color:red;' aria-hidden='true'></i>";
		document.getElementById("like").innerHTML = tag; 
	}else{
		tag = "<i class='fa fa-heart-o' aria-hidden='true'></i>";
		document.getElementById("like").innerHTML = tag;
	}
	
	//버킷의 소유자와 사용자 아이디가 동일할 경우 좋아요 클릭 방지
	//동일할 경우 수정, 삭제, 도전중 유무 클릭 가능
	console.log("bucketMemberId = " + bucketMemberId)
	console.log("userId = " + "<%= userId%>");
	if(bucketMemberId == '<%= userId%>'){
		console.log("사용자가 등록한 버킷입니다.")	
		$("#like").css("display", "none");
		$("#add").css("display", "none");
		$("#completion").css("display", "inline-block");
		$("#update").css("display", "inline-block");
		$("#delete").css("display", "inline-block");
	}else{
		console.log("사용자가 등록한 버킷이 아닙니다.")
		//비로그인 사용자 때문에
		if(userId == "null"){
			console.log("비로그인 사용자 처리 시작.")
			$("#like").css("display", "none");
			$("#add").css("display", "none");
			$("#completion").css("display", "none");
			$("#update").css("display", "none");
			$("#delete").css("display", "none");
			$("#reply-textArea").attr("disabled",true);
			$("#reply-textArea").attr("placeholder","----- Login Please -----");
			$("#reply-textArea").css({"text-align": "center", "font-weight": "bolder"});
			$("#reply-sub").html('<i class="fa fa-sign-in" aria-hidden="true" onclick = "login();"></i>');
		}else{
			$("#like").css("display", "inline-block");
			$("#add").css("display", "inline-block");
			$("#completion").css("display", "none");
			$("#update").css("display", "none");
			$("#delete").css("display", "none");			
		}
	}
	
	if(completionYN == "completion"){
		tag = "<i class='fa fa-check-circle' aria-hidden='true' style='color:blue;' onclick='completeAction();'></i>";
		document.getElementById("completion").innerHTML = tag;
	}else if(completionYN == "challenging"){
		tag = "<i class='fa fa-check-circle-o' aria-hidden='true' style='color:black;' onclick='completeAction();'></i>"
		document.getElementById("completion").innerHTML = tag;
	}
	autoScrollDown();
});	
//댓글 달거나 게시글 눌렀을 때 최신 댓글이 보이도록 하는 함수
function autoScrollDown(){
	$("#reply-scrol-div").scrollTop($("#reply-scrol-div")[0].scrollHeight);				
}
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
			tag = "<i class='fa fa-heart' style='color:red;' aria-hidden='true'></i>";
			document.getElementById("like").innerHTML = tag;
			//좋아요 한 상태 이므로 Y로 변경
			likeYN="Y";
			//좋아요 한 개 추가
			likeCnt = likeCnt+1;
			document.getElementById("total-like-view").innerHTML = "좋아요 " + likeCnt + "개";
			//wishList();
		}else if(likeStatus == "deleteSuccess"){
			tag = "<i class='fa fa-heart-o' style='color:black;' aria-hidden='true'></i>";
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
		var reResult = request.responseText;
		resultArray = reResult.split("/");
		var insertSuccess = resultArray[0];
		var reUserImageId = resultArray[1];
		console.log("DB작업 성공(T)실패(F) => " + insertSuccess);
		console.log("reUserImageId = " + reUserImageId);
		
		if(insertSuccess == "true"){	
			 tag = '<div>' +
						'<div class="repl">' +
							'<div class="photo__header" style="margin-top: 10px; padding: 0px;">' +		
								'<img src="' + reUserImageId  + '" class="photo__avatar" style="width: 2em; height: 2em;margin-top: 15px;">' +			
									'<a href="#" onclick="parent.location=MyBucket.do">' +
										'<h3 class="repl-id" style="font-size: 20px;display:inline-block">' + '<%=userId%>' + '</h3>' +
									'</a>' +
								'<span class="repl-content" style="margin-left: 10px;margin-top: 10px;">' + $('#reply-textArea').val() + '</span>' +
							'</div>' +
							'<span style="font-size: medium; margin-left: 60px;    display: flow-root;">' + getTimeStamp() + '</span>' +
						'</div>' +
					'</div>';
			// replyCnt : 댓글 입력시 총 댓글 갯수 증가 시키기 위해 존재
			replyCnt = replyCnt+1;
			document.getElementById("total-reply-view").innerHTML = "댓글 " + replyCnt + "개";
			console.log("tag = " + tag);
			document.getElementById("reply-textArea").value='';
		}else{
			console.log("DB작업 실패");
		}
		$('#bucket_repl').append(tag);
		autoScrollDown();
	}
}

function deleteAction(){
	if(confirm("삭제하시겠습니까?")){
		parent.location.href = "DeleteAction.do?bucketId="+bucketId;
		return true;
	} else {
		return false;
	}
}

function completeAction(){
	console.log("--- CompleteAction() 호출 ---")
	request.open("Post", "CompletionAction.do?bucketId="+encodeURIComponent(bucketId, true)+"&completionYN="+completionYN);
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
			document.getElementById("completion").innerHTML = tag;
			console.log("--- Completion 표시 완료 ---")
		}else if(completionYN == "challenging"){
			tag = "<i class='fa fa-check-circle-o' aria-hidden='true' style='color:black;' onclick='completeAction();'></i>"
			document.getElementById("completion").innerHTML = tag;
			console.log("--- Challenging... 표시 완료 ---")
		}else{
			console.log(completionResult);
		}
	}
}

function addAction(){
	if(userId == null){
		if(confirm("로그인이 필요합니다. 로그인  하시겠습니까?")){
			document.location.href = "LoginForm.do";
			return true;
		} else {
			return false;
		}
	}else{
		if(confirm("버킷리스트에 추가하시겠습니까?")){
			//parent.location.href = "BucketAddForm.do?bucketId=" + encodeURIComponent(bucketId, true) + "&bucketTitle=" + bucketTitle + "&bucketContent=" +  bucketContent + "&bucketMemberId="+bucketMemberId;
			//버킷 추가시 iframe창 크기 감소 - 부모 태그로 접근해서 줄임
			$(top.document).find(".poptrox-popup").css({"width":"400px", "height":"400px"});
			document.location.href = "BucketAddForm.do?bucketId=" + encodeURIComponent(bucketId, true) + "&bucketTitle=" + bucketTitle + "&bucketContent=" +  bucketContent + "&bucketMemberId="+bucketMemberId;
	
			return true;
		} else {
			return false;
		}
	}
}

function updateAction(){
	
}

function login(){
	if(confirm("로그인이 필요합니다. 로그인  하시겠습니까?")){
		$(top.document).find(".poptrox-popup").css({"width":"1200px", "height":"700px"});
		document.location.href = "LoginForm.do?bucketId="+bucketId+"&ownerId="+bucketMemberId;
		
		return true;
	} else {
		return false;
	}
}
</script>
<style>
::-webkit-scrollbar { 
    display: none !important;
}
.repl-content, .photo__user-info, .photo__author{
	font-family: 'Nanum Pen Script', cursive;font-size: 30px;
}
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
a:hover { color: blue; text-decoration: underline;}
</style>
<!-- 
<script>
function test(){
	window.self.close();	
}
</script> -->
</head>
<body>
	<div class="photo" >
		<div  style="display:inline-block;">
			<img src="${bucket.bucketImagePath }" align="left" width="750px" height="799px" >
		</div>
		<div id="chat_scrol_div" style="margin-right: 10px;height:800px;width:400px;display:inline-block;font-size: 30px;float:right;">
			<div class="#" style="border-bottom: 1px solid #e6e6e6;display: flex;">
				<div style="display: inline-block; padding: 20px 0px;">
					<div><img src="${userImagePath} " class="photo__avatar" style="width: 2em; height: 2em; border-radius: 100%;"></div>
					<div class="photo__user-info">
						<c:set var="userId" value="<%=userId %>" />
						<c:choose>
		 					<c:when test="${bucket.bucketMemberId eq userId}">
								<a href="MyBucket.do"><span class="photo__location">${bucket.bucketMemberId}</span></a>
							</c:when>
							<c:otherwise>
								<a href="#" onclick="parent.location='OtherBucket.do?ownerId=${bucket.bucketMemberId}';">
									${bucket.bucketMemberId}
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<span class="photo__author" style="max-height: 130px;overflow-y: scroll;margin-left:20px;align-self: center;display:inline-block;font-family: 'Nanum Pen Script', cursive;font-size: 30px;">
					${bucket.bucketContents}
				</span>
			</div>
			<div id="reply-scrol-div" style="height:300px;min-height:500px;overflow-y: scroll;">
				<div id="bucket_repl" class="bucket_repl" >
					<c:set var="userId" value="<%=userId %>" />
					<c:forEach items="${replyList}" var="reply">
						<c:choose>
							<c:when test="${reply.reMemberId eq userId}">
							<div>
							<!-- style="border: 1px solid; padding-bottom: 8px; padding-left: 14px; padding-top: 5px; border-radius: 14px; height: 71px; margin-bottom: 5px;" -->
								<div class="repl">
									<div class="photo__header" style="margin-top: 10px; padding: 0px;">
										<c:choose>
											<c:when test="${empty reply.reMemberImagePath }">
												<img src="images/profile/temp.jpg" class="photo__avatar" style="width: 2em; height: 2em;margin-top: 15px;">
											</c:when>
											<c:otherwise>
												<img src="${reply.reMemberImagePath} " class="photo__avatar" style="width: 2em; height: 2em;margin-top: 15px;">											
											</c:otherwise>
										</c:choose>
										<a href="#" onclick="parent.location='MyBucket.do'">
											<h3 class = "repl-id" style="font-size: 20px;display:inline-block">${reply.reMemberId }</h3>
										</a>
										<span class="repl-content" style="margin-left: 10px;margin-top: 10px;">${reply.reReplyContents }</span>
									</div>
									<span style="font-size: medium; margin-left: 60px;    display: flow-root;">${reply.reWriteDate }</span>
								</div>
								</div>							
							</c:when>
							<c:otherwise>
							<div>
								<div class="repl">
									<div class="photo__header" style="margin-top: 10px; padding: 0px;" >
										<c:choose>
											<c:when test="${empty reply.reMemberImagePath }">
												<img src="images/profile/temp.jpg" class="photo__avatar" style="width: 2em; height: 2em;margin-top: 15px;">
											</c:when>
											<c:otherwise>
												<img src="${reply.reMemberImagePath} " class="photo__avatar" style="width: 2em; height: 2em;margin-top: 15px;">											
											</c:otherwise>
										</c:choose>
										<a href="#" onclick="parent.location='OtherBucket.do?ownerId=${reply.reMemberId}';">
										<h3 class = "repl-id" style="font-size: 20px; display:inline-block;">${reply.reMemberId }</h3></a>
										<span class="repl-content" style="margin-left: 10px;margin-top: 10px;">${reply.reReplyContents }</span>
									</div>
									<span style="font-size: medium; margin-left: 60px;     display: flow-root;">${reply.reWriteDate }</span>
								</div>
							</div>	
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
			</div>
			<div>
				<div class="photo__actions" style="border-top: 1px solid #e6e6e6; padding: 13px 0px; margin: 0px;">
					<div>
						<span id="like" onclick="likeAction()" style="cursor:pointer;"><i class="fa fa-heart-o fa-lg" ></i></span> 
						<span id="add"  onclick="addAction();" style="cursor:pointer;" ><i class="fa fa-plus" aria-hidden="true"></i></span>
						<span id="completion" onclick="completeAction();" style="cursor:pointer;"> <i class="fa fa-check-circle-o" aria-hidden="true"></i></span>
						<span id="delete" onclick="deleteAction();" style="cursor:pointer;"><i class="fa fa-trash-o" aria-hidden="true"></i></span>
						<span id="update" onclick="updateAction();"style="cursor:pointer;"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></span>
						<span id="chat" onclick="$('#reply-textArea').focus();" style="cursor:pointer;font-size:30px;vertical-align: 15%"><i class="fa fa-comment-o fa-lg"></i></span>
					</div>
					<div style="font-family: 'Nanum Pen Script', cursive;font-size: 30px;">
						<span id="total-like-view" style="color: red;">좋아요</span><span style="font-weight: bold; font-size: larger;"> ${bucket.bucketLike}</span><span>개</span>
						<span id="total-reply-view" style="color: green;">댓글</span><span style="font-weight: bold; font-size: larger;"> ${bucket.bucketReplyCnt }</span><span>개</span>
						<br>
						<span id="bucket-wDate">${bucket.bucketWriteDate } 버킷리스트 시작...</span>
					</div>
				</div>
			</div>
			<div>
				<div class="photo__add-comment-container" style = "margin:0px; padding:0px">
					<textarea id="reply-textArea" name="comment" placeholder="Add a comment..." rosw="2" style="height: 25px; margin-top: 13px; font-size: 18px;"></textarea>
					<span id="reply-sub"><i class="fa fa-ellipsis-h"></i></span>
				</div>
			</div>
	</div>
</div>
</body>
</html>