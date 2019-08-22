<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		boolean insertSuccess = (boolean)request.getAttribute("insertSuccess");
	%>
	
	<%if(insertSuccess) {%>
	<script type="text/javascript">
		document.location.href = "Index.do";
		//등록된 사진을 출력하는 페이지 작성해야됨...
		//생각 나는 것 : include식으로 페이지를 작성하면 어떨까 싶은데.
	</script>
	<%}else{ %>
		
	<%} %>
</body>
</html>