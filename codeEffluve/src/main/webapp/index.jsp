<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">

<script>
	function mouseOver() {
		
	}
</script>
</head>
<body>
	<header>
		<div>
			<a href="#">회원가입</a> | <a href="#" id="loginButton">로그인</a>
		</div>
	</header>
	
	<main>
		<img src="http://localhost:9090/codeEffluve/img/leLogo2.png" alt="leLogo2" id="leLogo2"> 
		<div class="indexMenu">
			<a href="/codeEffluve/public.jsp"><img src="http://localhost:9090/codeEffluve/img/internet.png" alt="public" onmouseover="mouseOver();">공개 일정</a>
			<a href="/codeEffluve/private.jsp"><img src="http://localhost:9090/codeEffluve/img/profile.png" alt="private">내 일정</a>
			<a href="/codeEffluve/group.jsp"><img src="http://localhost:9090/codeEffluve/img/people.png" alt="group">그룹 일정</a>
			<a href="/codeEffluve/cs.jsp"><img src="http://localhost:9090/codeEffluve/img/headset.png" alt="cs">고객센터</a>
		</div>
	</main>
	
	<%@include file="footer.jsp" %>
</body>
</html>