<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<footer style="height: 100px">
		<a href="javascript:goList(1)">1</a> <a href="javascript:goList(2)">2</a>
		<a href="javascript:goList(3)">3</a> <a href="javascript:goList(4)">4</a>
		<a href="javascript:goList(5)">5</a> <a href="javascript:goList(6)">6</a>
	</footer>

	<form name="pagefrm" action="LibraryForm.do">
		<input type="hidden" name="page" value="1"> <input
			type="hidden" name="type" value="${param.type}">
	</form>

	<script>
		function goList(p) {
			document.pagefrm.page.value = p;
			document.pagefrm.submit();
		}
	</script>


</body>
</html>