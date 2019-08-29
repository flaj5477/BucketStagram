<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<!-- Bootstrap -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- font awesome -->
    <link rel="stylesheet" href="assets/css/font-awesome.min.css" media="screen" title="no title" charset="utf-8">
    <!-- Custom style -->
    <link rel="stylesheet" href="assets/css/signup.css" media="screen" title="no title" charset="utf-8">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
     <script>
	function formCheck(){
		var id = document.frm.id;
		if(id.value == '' || id.value.length < 4) {
			alert("아이디를 4자 이상 입력하세요.");
			id.focus();
			return false;
		}
		
		var password = document.frm.password;
		if(password.value == '' || password.value.length < 4) {
			alert("패스워드를 4자 이상 입력하세요");
			password.focus();
			return false;
		}
		var pw2 = document.frm.pw2;
		if(password.value != pw2.value) {
			alert("패스워드가 일치하지 않습니다.");
			pw2.focus();
			return false;
		}
		
		var name = document.frm.name;
		if(name.value == ''){
			alert("이름을 입력하세요.");
			name.focus();
			return false;
		}
		
		
  		var chkId = document.frm.chk;
		if(chkId.value != "idChk") {
			alert("아이디 중복 체크를 하세요")
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
	function openIdChk(){
		var cid = document.frm.id;
		if(cid.value == '' || cid.value.length < 4) {
			alert("아이디를 4자 이상 입력하세요.");
			cid.focus();
			return false;
		}
		url = "IdCheck.do?id="+cid.value;
		open(url, "checkForm","location=no, width=500, height=300, resizable=no, scrollvars=no");
	} 
	</script> 
  </head>
<body>
	<div id="wrapper" style = 'text-align: center; margin-top :25px;' >
		<header id="header">

			<span class="logo">
				<a href="Index.do">
				<img style= ' width :30%; height:auto;'  src="images/logo2.png" 
			 /></a>
			</span>			
	 </header>
	</div>  
<article class="container">
        <div class="page-header">
          <h1>회원가입 <small>을 환영합니다.</small></h1>
        </div>
        <div class="col-md-6 col-md-offset-3">
          <form id="frm" name ="frm" action="MemberInsert.do" method="post" enctype="multipart/form-data"><!-- enctype="multipart/form-data" -->
            <div class="form-group"><i class="fa fa-user"></i>
              <label for="username">아이디</label>
              <div class="input-group">
                <input name = "id" type="text" class="form-control"  placeholder="4자리 이상 입력하세요">
                <span class="input-group-btn">
                  <button type="button" class="btn btn-success" onclick="openIdChk();">아이디 중복확인
                  <i class="fa fa-mail-forward	 spaceLeft"></i></button>
                  <input type="hidden" id="chk" name="chk" value="idUnChk">
                </span>
              </div>
            </div>
       
            <div class="form-group"><i class="fa fa-unlock-alt"></i>
              <label for="InputPassword1">비밀번호</label>
              <input name ="password" type="password" class="form-control"  placeholder="비밀번호">
            </div>
            <div class="form-group"><i class="fa fa-unlock-alt"></i>
              <label for="InputPassword2">비밀번호 확인</label>
              <input name="pw2" type="password" class="form-control"  placeholder="비밀번호 확인">
              <p class="help-block">비밀번호 확인을 위해 다시한번 입력 해 주세요</p>
            </div>
            <div class="form-group"><i class="fa fa-address-book-o"></i>
              <label for="username">이름</label>
              <input name="name"type="text" class="form-control" placeholder="이름을 입력해 주세요">
            </div>
            <div class="form-group"><i class="fa fa-envelope"></i>
            <label for="InputEmail">이메일</label>
              <input name = "email" type="email" class="form-control"  placeholder="이메일 주소">
            </div>
     		<div class="form-group"><i class="fa fa-phone"></i>	
              <label for="username">전화번호</label>
              <input name ="phone" type="tel" class="form-control"   placeholder="번호를 입력해 주세요">
            </div>
            <div class="form-group"><i class="fa fa-camera-retro"></i>
              <label for="username">프로필사진</label>
              <input name ="img" type="file" class="form-control">
            </div> 
  
                        <div class="form-group text-center">
             <button type="button" class="btn btn-info"  onclick="formCheck();">회원가입<i class="fa fa-check spaceLeft"></i> </button>
              <button type="button" class="btn btn-warning" onclick="location.href='Index.do'" >가입취소<i class="fa fa-times spaceLeft"></i></button>
            </div>
          </form>
        </div>
	</article>
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="assets/js/bootstrap.min.js"></script>
</body>
</html>