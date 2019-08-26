<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>회원가입 </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/styles.css"> 
    <style>
 #c { 
  margin-left: 10px;
  border: 0;
  color: white;
  font-weight: 600;
  border-radius: 3px;
  background-color: var(--fd-blue);
  font-size: 14px;
  padding: 7px 25px;
    }
 #s {  
 margin-left: 235px;
  border: 0;
  color: white;
  font-weight: 600;
  border-radius: 3px;
  background-color: var(--fd-blue);
  font-size: 14px;
  padding: 7px 25px;
 } 
    
    </style>
    <script>
	function formCheck(){
		var id = document.frm.id;
		if(id.value == '') {
			alert("아이디를 입력하세요.");
			id.focus();
			return false;
		}
		
		var pw = document.frm.password;
		if(pw.value =='') {
			alert("패스워드를 입력하세요.");
			pw.focus();
			return false;
		}
		
		var name = document.frm.name;
		if(name.value == ''){
			alert("성명을 입력하세요.");
			name.focus();
			return false;
		}
		
		
/*  		var chkId = document.frm.chk;
		if(chkId.value != "idChk") {
			alert("아이디 중복 체크를 하세요")
			return false;
		} */
		
		
		
/* 	  	var email = document.frm.email;
		if(email.value =='') {
			alert("이메일을 입력하세요.");
			email.focus();
			return false;
		}  */
		
	/* 	var phone = document.frm.phone;
		if(phone.value =='') {
			alert("번호를 입력하세요.");
			phone.focus();
			return false;
		}   */
		
	 	document.frm.submit();
	}
	</script>
</head>
<body>
 <main id="edit-profile">
        <div class="edit-profile__container">
            <header class="edit-profile__header">
                <div class="edit-profile__avatar-container">
                </div>
                <h4 class="edit-profile__username">회 원 가 입 </h4>
            </header>
            <form id="frm" name ="frm" action="MemberInsert.do" method="post" class="edit-profile__form" >
                <div class="form__row">
                    <label for="id" class="form__label">아이디 :</label>	
                    <input name="id" type="text" class="form__input" />
                </div>
                <div class="form__row">
                    <label for="password" class="form__label">비밀번호 :</label>
                    <input name="password" type="password" class="form__input" />
                </div>
                <div class="form__row">
                    <label for="name" class="form__label">이름 :</label>
                    <input name="name" type="text" class="form__input" />
                </div>
                <div class="form__row">
                    <label for="email" class="form__label">이메일 :</label>
                    <input name="email" type="email" class="form__input" />
                </div>
                <div class="form__row">
                    <label for="phone" class="form__label">전화번호 :</label>
                    <input name="phone" type="tel" class="form__input" />
                </div>
              
			<input id= "s" type="button" value="회원가입" onclick="formCheck();"  >
			<input id= "c" type="button" value="가입취소" onclick="location.href='Index.do'"  >
            </form>
        </div>
    </main>
</body>
</html>