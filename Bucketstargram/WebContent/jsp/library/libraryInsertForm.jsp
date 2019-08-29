<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>libraryInsertForm.jsp</title>
<style>
	body{
		background-color: white;
	}
	
	div#wrapper {
		margin: 60px 70px 50px 70px;
	}
</style>
</head>
<body>
	<!-- 라이브러리 아이디 생성해서 넣는 작업해야함 -->
	<!-- 등록후 부모창 리로드 하는 거 하기(form태그에 적으면 됨) -->
	<div id="wrapper">
		<form action="LibInsert.do" id="libInsertFrm" method="post"
			enctype="multipart/form-data">
			<span>제목</span> <span> <input type="text" id="libraryTitle"
				name="libraryTitle">
			</span> <br> <span>타입</span> <span> <select id="libraryType"
				name="libraryType">
					<option value="여행">여행</option>
					<option value="운동">운동</option>
					<option value="음식">음식</option>
					<option value="배움">배움</option>
					<option value="문화">문화</option>
					<option value="야외">야외</option>
					<option value="쇼핑">쇼핑</option>
					<option value="생활">생활</option>
			</select>
			</span> <br>

			<!-- 이미지 넣는 칸 -->
			<span> <input type="file" id="getfile"
				name="getfile" accept="image/*">
			</span><br> <span style="position: fixed">내용</span> <span> <textarea
					id="libraryContent" name="libraryContent" rows=10 cols=20
					style="margin: 0 0 0 40px"></textarea>
			</span> <br> 
			<div style="text-align: right">
				<input id="input_btn" type="submit" value="등록">
			</div>
		</form>
	</div>
</body>
</html>