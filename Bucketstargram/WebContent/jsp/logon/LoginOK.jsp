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
		String userId = (String)session.getAttribute("userid");
		String bucketId = request.getParameter("bucketId");
		String ownerId = request.getParameter("ownerId");
	%>
	
<script type="text/javascript">
	let userId='<%=userId%>';
	let bucketId='<%=bucketId%>';
	let ownerId='<%=ownerId%>';
	console.log("bucketId = " + bucketId);
	console.log("ownerId = " + ownerId);
	if(bucketId == "null" || bucketId == ""){
		document.location.href = "Index.do";		
	}else{
		document.location.href = "DetailMyBucket.do?bucketMemberId="+ownerId+"&bucketId="+bucketId;

	}
/* 		window.history.go(-2);
		location.reload();  */
		
</script>
</body>
</html>