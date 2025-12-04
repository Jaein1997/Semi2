<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>

<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">

<%
    String sname = (String)session.getAttribute("sname");
	String sprofile = (String)session.getAttribute("sprofile");
	String sprofilePath = request.getContextPath() + "/membersProfiles/" + sprofile;
%>

</head>
<body>
	<header>
		<%
   if(sname==null) {
      %>
		<div>
			<a href="/codeEffluve/members/makeAccount.jsp">회원가입</a> | <a href=""
				id="loginButton">로그인</a>
		</div>
		<%
   } else {
      %>
		<div>
			<a href="/codeEffluve/members/logOut.jsp">로그아웃</a> | <label>환영합니다, <%=sname %>님!</label> <a href="/codeEffluve/members/myPage.jsp"><img
				src="<%=sprofilePath %>"
				alt="basic" id="miniProfile"></a>
		</div>
		<%   }
   %>
	</header>

	<main style="background-color: transparent !important; border: 0px;">
		<img src="/codeEffluve/img/leLogoGif.gif"
			alt="leLogo2" id="leLogo2">
		<div class="indexMenu">
			<a href="/codeEffluve/public.jsp">
				<img src="/codeEffluve/img/internet.png" alt="public" onmouseover="mouseOver();">공개 일정</a>
			<a href="/codeEffluve/private.jsp">
				<img src="/codeEffluve/img/profile.png" alt="private">내 일정</a>
			<a href="/codeEffluve/group.jsp">
				<img src="/codeEffluve/img/people.png" alt="group">그룹 일정</a>
			<a href="/codeEffluve/friend.jsp">
				<img src="/codeEffluve/img/friends.png" alt="friend">친구</a>
			<a href="/codeEffluve/cs.jsp">
				<img src="/codeEffluve/img/headset.png" alt="cs">고객센터</a>
		</div>
	</main>

	<%@include file="footer.jsp"%>
</body>
<script>
    var loginButton = document.getElementById("loginButton");
    loginButton.onclick = function() {
       window.open('/codeEffluve/members/logIn.jsp', 'logInpopup', 'width=500,height=350,top=100px,left=700px');
    };
</script>
</html>