<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
</head>
<body>
	<header>
		<div>
			<a href="/memberJoin.jsp">회원가입</a> | <a href="" id="loginButton">로그인</a>
		</div>
	</header>
	
	<main>
		<img src="http://localhost:9090/codeEffluve/img/leLogo2.png" alt="leLogo2"> 
		<div>
			<a href="#">내 일정</a>
			<a href="#">공개 일정</a>
			<a href="#">그룹 일정</a>
			<a href="#">고객센터</a>
		</div>
	</main>
	
	<%@include file="footer.jsp" %>
</body>
</html>