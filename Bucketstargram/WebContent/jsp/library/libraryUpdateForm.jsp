<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>libraryUpdateForm.jsp</title>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%
	String imagePath = (String)request.getAttribute("imagePath");
	String libraryTitle = (String)request.getAttribute("libraryTitle");
	String libraryContent = (String)request.getAttribute("libraryContent");
	String libraryType = (String)request.getAttribute("libraryType");
	String libraryId = (String)request.getAttribute("libraryId");
	
	System.out.println("수정 폼 : " + imagePath);
	System.out.println("수정 폼 : " + libraryId);
	
	//자바스크립트가 백슬러시 하나 일경우 인식 못하고 깨지는 현상 때문에 치환함
	String replaceImagePath = imagePath.replace("\\", "\\\\");
%>
<style>
	body{
	width: 350px;
    height: 350px;
    padding: 25px 25px 0 25px;
    text-align: center;
    font-size: larger;
    background-color: white;
	}
	input{
		font-size: large;
	}
	select{
		font-size: 20px;
	}
</style>
</head>
<body>
<form action="" id="lib_update_frm" target="_parent" method="post" enctype="multipart/form-data" onsubmit="libUpdate();">
	<br>
	library제목: <input type="text" id="libraryTitle" name="libraryTitle">
	<br>
	
	<c:choose>
		<c:when test="${libraryContent eq null}">
		library내용: <textarea rows="5" cols="30" id="libraryContent" name="libraryContent" placeholder=""></textarea>
			<br>	
		</c:when>
		<c:otherwise>
		library내용: <textarea rows="5" cols="30" id="libraryContent" name="libraryContent" placeholder="<%=libraryContent %>"></textarea>
			<br>			
		</c:otherwise>	
	</c:choose>
	
	library타입 : <select id="libraryType" name="libraryType">
					<option value ="여행">여행</option>
					<option value ="운동">운동</option>
					<option value ="음식">음식</option>
					<option value ="배움">배움</option>
					<option value ="문화">문화</option>
					<option value ="쇼핑">쇼핑</option>
					<option value ="야외">야외</option>
					<option value ="생활">생활</option>
			 	</select>
	<input type="file" id="getfile" accept="image/*">
	<br>
	<input type="submit" value="전송">
	<a id="download" download="thumbnail.jpg" target="_blank">
   		<img id="thumbnail" src="<%=imagePath %>" width="100" alt="썸네일영역 (클릭하면 다운로드 가능)">
	</a>
</form>
<script>
	let oriImagePath = "<%=replaceImagePath%>";
	function libUpdate(){
		$('#libraryTitle').val();
		let libraryTitle = $('#libraryTitle').val();
		let libraryContent = $('#libraryContent').val();
		let thumImagePath = $('#thumbnail').attr("src");
		let libraryType = $("#libraryType option:selected").val();
		
		let frmActionValue;
		
		console.log("libraryTitle = " + $('#libraryTitle').val());
		console.log("libraryContent = " + libraryContent);
		console.log("thumImagePath = " + thumImagePath);
		
		if(oriImagePath != thumImagePath){
			console.log(encodeURIComponent(thumImagePath, true));
			frmActionValue = "libraryUpdate.do";	//form의 타겟이 부모에서 실행!
			$("#lib_update_frm").attr("action", frmActionValue);
		}else{
			//이미지를 바꿨을 경우 멀티 리퀘스트폼이 아닌 서버에서 해당 이미지 경로의 이미지를 복사하여 라이브러리 수정 되도록 구현
			frmActionValue = document.location.href = "libraryUpdate.do?imagePath=" + 
			encodeURIComponent(thumImagePath, true) + "&libraryTitle=" + libraryTitle + 
			"&libraryContent=" + libraryContent + "&libraryId=" + "<%=libraryId%>" +
			"&libraryType=" + libraryType;
		$("#lib_update_frm").attr("action", frmActionValue);
		 } 
	};
	
	//input 태그 초기화
	$(document).ready(function() {
			$("#libraryTitle").val("${libraryTitle}");
			$("#libraryContent").val("${libraryContent}");
			$("#libraryType").val("${libraryType}").prop("selected", true);
	});
</script>
<script type="text/javascript">
	var file = document.querySelector('#getfile');
	
	file.onchange = function () { 
	    var fileList = file.files ;
	    
	    // 읽기
	    var reader = new FileReader();
	    reader.readAsDataURL(fileList [0]);
	
	    //로드 한 후
	    reader.onload = function  () {
	        //로컬 이미지를 보여주기
	        /* document.querySelector('#preview').src = reader.result; */
	        
	        //썸네일 이미지 생성
	        var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
	        tempImage.src = reader.result; //data-uri를 이미지 객체에 주입
	        tempImage.onload = function() {
	            //리사이즈를 위해 캔버스 객체 생성
	            var canvas = document.createElement('canvas');
	            var canvasContext = canvas.getContext("2d");
	            
	            //캔버스 크기 설정
	            canvas.width = 100; //가로 100px
	            canvas.height = 100; //세로 100px
	            
	            //이미지를 캔버스에 그리기
	            canvasContext.drawImage(this, 0, 0, 100, 100);
	            //캔버스에 그린 이미지를 다시 data-uri 형태로 변환
	            var dataURI = canvas.toDataURL("image/jpeg");
	            
	            //썸네일 이미지 보여주기
	            oriImagePath = $('#thumbnail').attr("src");
	            document.querySelector('#thumbnail').src = dataURI;
	            $('#download').css("display", "block");
	            $('#image_owner_alarm').css("display", "none");
	            
	            //썸네일 이미지를 다운로드할 수 있도록 링크 설정
	            document.querySelector('#download').href = dataURI;
	        };
	    }; 
	}; 
</script>	
</body>
</html>