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
		String userid = (String)session.getAttribute("userid");
	%>
	
	<script type="text/javascript">
		alert("<%=userid %>님 환영합니다. 회원가입에 성공했습니다.");
		document.location.href = "Index.do";
	</script>
</body>
</html>