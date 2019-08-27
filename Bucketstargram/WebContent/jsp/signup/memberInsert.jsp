<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function formCheck(){
		var name = document.frm.name;
		if(name.value == ''){
			alert("성명을 입력하세요.");
			name.focus();
			return false;
		}
		
		var id = document.frm.id;
		if(id.value == '') {
			alert("아이디를 입력하세요.");
			id.focus();
			return false;
		}
		
/* 		var chkId = document.frm.chk;
		if(chkId.value != "idChk") {
			alert("아이디 중복 체크를 하세요")
			return false;
		} */
		
		var pw = document.frm.password;
		if(pw.value =='') {
			alert("패스워드를 입력하세요.");
			pw.focus();
			return false;
		}
		
		var email = document.frm.email;
		if(email.value =='') {
			alert("이메일을 입력하세요.");
			email.focus();
			return false;
		}
		var phone = document.frm.phone;
		if(phone.value =='') {
			alert("번호를 입력하세요.");
			phone.focus();
			return false;
		}
	 	document.frm.submit();
	}

/* 	function openIdChk(){
		var cid = document.frm.id;
		if(cid.value == '') {
			alert("아이디 값을 입력하세요");
			cid.focus();
			return false;
		}
		url = "IdCheck.do?id="+cid.value;
		open(url, "checkForm","location=no, width=500, height=300, resizable=no, scrollvars=no");
	}  */

</script>
</head>
<body>
<div align="center">
		 
		<div><p></div>
		<div align="center"> <h3>회원가입</h3></div>
		<div align="center">
		<form id="frm" name="frm" action="MemberInsert.do" method="post">
			<div>
			<table border="1">
				<tr>
					<th align="center" width="100">성&nbsp;&nbsp;&nbsp;&nbsp;명 </th>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<th align="center">아 이 디 </th>
					<td><input type="text" name="id" size=10>
						<!-- <input type="button" value="중복확인" onclick="openIdChk();">
						<input type="hidden" id="chk" name="chk" value="idUnChk"> -->
					</td>
				</tr>
				<tr>
					<th align="center">패스워드 </th>
					<td><input type="password" name="password"></td>
				</tr>
				<tr>
					<th align="center">이 메 일 </th>
					<td><input type="text" name="email" size="30"></td>
				</tr>
				<tr>
					<th align="center">폰번호 </th>
					<td><input type="text" name="phone" size="20"></td>
				</tr>
			</table></div>
			<div><p></div>
			<div>
			&nbsp;&nbsp;&nbsp;<input type="button" value="회원가입" onclick="formCheck();">&nbsp;&nbsp;&nbsp;
			<input type="button" value="가입취소" onclick="location.href='Index.do'">
			</div>
		</form>
		</div>
</div>
</body>
</html>