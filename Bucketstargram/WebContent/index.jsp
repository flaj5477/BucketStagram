<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Profile | Vietgram</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/styles.css">	
</head>
<body>
	<jsp:include page = "jsp/category/topmenu.jsp"/>
<!--	<jsp:include page = "jsp/category/footer.jsp"/>
	<jsp:include page="jsp/category/nav.jsp"/>
	<jsp:include page="jsp/category/main.jsp"/>
 -->
</body>
</html>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Profile | Vietgram</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/styles.css">	
</head>
<body>
    <nav class="navigation">
        <div class="navigation__column">
            <a href="Index.do">
                <img src="images/mylogo.png" />
            </a>
        </div>
        <div class="navigation__column">
            <i class="fa fa-search"></i>
            <input type="text" placeholder="Search">
        </div>
        <div class="navigation__column">
            <ul class="navigations__links">
                <li class="navigation__list-item" id="sign-in" style="display:block;">
                    <a href="LoginForm.do" class="navigation__link">
                        <i class="fa fa-sign-in" aria-hidden="true"></i>Login
                    </a>
                </li>
                <li class="navigation__list-item" id="sign-up" style="display:block;">
                    <a href="#" class="navigation__link">
                       	<i class="fa fa-user-plus" aria-hidden="true"></i>SignUp
                    </a>
                </li>
                <li class="navigation__list-item" id="sign-out" style="display:none;">
                    <a href="#" class="navigation__link" onclick = "logOut()">
                       	<i class="fa fa-sign-out" aria-hidden="true"></i>Logout
                    </a>
                </li>
            </ul>
            <% String userid = (String)session.getAttribute("userid"); %>
            <% if(userid != null){%>
	            <script>
	           		document.getElementById("sign-in").style.display = 'none';
	           		document.getElementById("sign-up").style.display = 'none';
	           		document.getElementById("sign-out").style.display = 'block';
	           	</script>
            <% }else{%>
            	<script>
            		document.getElementById("sign-in").style.display = 'block';
            		document.getElementById("sign-up").style.display = 'block';
            		document.getElementById("sign-out").style.display = 'none';
            	</script>
            <%	}%>
            <script>
            	function logOut(){
            		window.alert("로그아웃 하시겠습니까?");
            		document.location.href = "LogOut.do";
            	}
            </script>
        </div>
    </nav>
    <main id="profile">
        <header class="profile__header">
            <div class="profile__column">
                <img src="images/avatar.jpg" />
            </div>
            <div class="profile__column">
                <div class="profile__title">
                    <h1 class="profile__username">${userid }</h1>
                    <a href="edit-profile.html">Edit profile</a>
                    <i class="fa fa-cog fa-lg"></i>
                </div>
                <ul class="profile__stats">
                    <li class="profile__stat">
                        <span class="stat__number">333</span> posts
                    </li>
                    <li class="profile__stat">
                        <span class="stat__number">1234</span> followers
                    </li>
                    <li class="profile__stat">
                        <span class="stat__number">36</span> following
                    </li>
                </ul>
                <p class="profile__bio">
                    <span class="profile__full-name">
                        Nicolás Serrano Arévalo
                    </span> Doing whatever and eating Pho Lorem ipsum dolor sit amet consectetur, adipisicing
                    elit. Ducimus suscipit praesentium eveniet quibusdam ipsam omnis fugit. Tempore voluptates ratione recusandae
                    natus illo perspiciatis suscipit, odio consequuntur quasi obcaecati minus! Omnis.
                    <a href="#">serranoarevalo.com</a>
                </p>
            </div>
        </header>
		<jsp:include page = "jsp/category/topmenu.jsp"></jsp:include>
    </main>
    <footer class="footer">
        <div class="footer__column">
            <nav class="footer__nav">
                <ul class="footer__list">
                    <li class="footer__list-item"><a href="#" class="footer__link">About Us</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Support</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Blog</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Press</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Api</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Jobs</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Privacy</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Terms</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Directory</a></li>
                    <li class="footer__list-item"><a href="#" class="footer__link">Language</a></li>
                </ul>
            </nav>
        </div>
        <div class="footer__column">
            <span class="footer__copyright">© 2017 Vietgram</span>
        </div>
    </footer>
    
</body>
</html> --%>