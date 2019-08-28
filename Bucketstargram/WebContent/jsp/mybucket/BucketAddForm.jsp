<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<%
	String imagePath = (String)request.getAttribute("imagePath");
	String bucketTitle = (String)request.getAttribute("bucketTitle");
	String bucketContent = (String)request.getAttribute("bucketContent");
	String bucketMemberId = (String)request.getAttribute("bucketMemberId");
	
	System.out.println("이미지 경로: " + imagePath);
	//자바스크립트가 백슬러시 하나 일경우 인식 못하고 깨지는 현상 때문에 치환함
	String replaceImagePath = imagePath.replace("\\", "\\\\");
%>



</head>
<body>
<form action="" id="buckt_add_form" method="post" enctype="multipart/form-data" onsubmit="bucketAdd();">
	<br>
	버킷	제목: <input type="text" id="bucketTitle" name="bucketTitle" placeholder="<%=bucketTitle %>">
	<br>
	<c:choose>
		<c:when test="${bucketContent eq null}">
		버킷 내용: <input type="text" id="bucketContent" name="bucketContent" placeholder="">
			<br>	
		</c:when>
		<c:otherwise>
		버킷	내용: <input type="text" id="bucketContent" name="bucketContent" placeholder="<%=bucketContent %>">
			<br>			
		</c:otherwise>	
	</c:choose>
	버킷 타입 : <select id="bucketType" name="bucketType">
					<option value ="여행">여행</option>
					<option value ="운동">운동</option>
					<option value ="음식">음식</option>
					<option value ="배움">배움</option>
					<option value ="문화">문화</option>
					<option value ="쇼핑">쇼핑</option>
					<option value ="생활">생활</option>
			 	</select>
	버킷 사진: <input type="file" id="getfile" accept="image/*">
	<br>
	<input type="submit" value="전송">
	<h4 id="image_owner_alarm"  style="color:red;"><%=bucketMemberId %>님 사진을 그대로 사용중입니다.</h4>
	<a id="download" download="thumbnail.jpg" target="_blank">
   		<img id="thumbnail" src="<%=imagePath %>" width="100" alt="썸네일영역 (클릭하면 다운로드 가능)">
	</a>
</form>
<script>
	let oriImagePath = "<%=replaceImagePath%>";
	function bucketAdd(){
		$('#bucketTitle').val();
		let bucketTitle = $('#bucketTitle').val();
		let bucketContent = $('#bucketContent').val();
		let thumImagePath = $('#thumbnail').attr("src");
		let bucketType = $("#bucketType option:selected").val();
		let frmActionValue;
		
		console.log("bucketTitle = " + bucketContent);
		console.log("bucketContent = " + bucketContent);
		console.log("thumImagePath = " + thumImagePath);
		
		if(oriImagePath != thumImagePath){
			frmActionValue = "BucketPostAction.do";
			$("#buckt_add_form").attr("action", frmActionValue);
		}else{
			//이미지를 바꿨을 경우 멀티 리퀘스트폼이 아닌 서버에서 해당 이미지 경로의 이미지를 복사하여 나의 버킷에 추가 되도록 구현
			frmActionValue = document.location.href = "BucketAddAction.do?imagePath=" + 
					encodeURIComponent(thumImagePath, true) + "&bucketTitle=" + bucketTitle + 
					"&bucketContent=" + bucketContent + "&ownerId=" + "<%=bucketMemberId%>" +
					"&bucketType=" + bucketType;
			$("#buckt_add_form").attr("action", frmActionValue);
		}
	};
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