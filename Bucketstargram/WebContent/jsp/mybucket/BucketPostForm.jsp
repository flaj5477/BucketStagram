<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
	<form action="BucketPostAction.do" method="post" enctype="multipart/form-data">
		<br>
		버킷 제목 : <input type="text" name="bucketTitle">
		<br>
		버킷 내용 : <input type="text" name="bucketContent">
		<br>
		버킷 타입 : <select name="bucketType">
					<option value ="여행">여행</option>
					<option value ="운동">운동</option>
					<option value ="음식">음식</option>
					<option value ="배움">배움</option>
					<option value ="문화">문화</option>
					<option value ="쇼핑">쇼핑</option>
					<option value ="생활">생활</option>
				</select>
		버킷 사진 : <input type="file" id="getfile" name="getfile">
		<br>
		<input type="submit" value="전송">
 		<a id="download" download="thumbnail.jpg" target="_blank" style="display:none">
    		<img id="thumbnail" src="" width="100" alt="썸네일영역 (클릭하면 다운로드 가능)">
		</a> 
	</form>
	
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
            document.querySelector('#thumbnail').src = dataURI;
            $('#download').css("display", "block");
            
            //썸네일 이미지를 다운로드할 수 있도록 링크 설정
            document.querySelector('#download').href = dataURI;
        };
    }; 
};
</script>	
</body>
</html>