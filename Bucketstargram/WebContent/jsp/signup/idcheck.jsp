<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function FormClose(n){
		if(n == 1) {
			opener.document.frm.chk.value="idChk";
		} else {
			opener.document.frm.id.value='';
		}
		self.close();
	}
</script>
</head>
<body>
<div align="center">
<%
	boolean chk = (boolean) request.getAttribute("chk"); 
	String fid = request.getParameter("id");  //폼 에 입력한 id
	
	int n = 0;
	if(chk) {
		out.print("<h3>" + fid + "는 이미 사용중인 아이디 입니다.</h3><p>");
	} else {
		out.print("<h3>" + fid + "는 사용 가능합니다. </h3><p>");
		n = 1;
	}
%>

<button name="check" onclick="FormClose(<%= n %>)">확인</button>
</div>
</body>
</html>