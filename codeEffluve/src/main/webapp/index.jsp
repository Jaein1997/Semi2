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
%>

</head>
<body>
   <header>
      <%
   if(sname==null) {
      %>
      <div>
      <a href="/codeEffluve/members/makeAccount.jsp">회원가입</a> | <a href="" id="loginButton">로그인</a>
      </div>
      <%
   } else {
      %>
      <div>
<<<<<<< HEAD
      <label><%=sname %>님 로그인 중</label> | <a href="/codeEffluve/members/logOut.jsp">로그아웃</a>
=======
      <label><%=sname %>님 로그인 중</label> | <a href="/codeEffluve/members/logOut.jsp">로그아웃</a> | <a href="/codeEffluve/members/myPage.jsp" >마이페이지</a>
>>>>>>> a7c82f3df5a1cf7e37efd7a2d6aedcecb26907a0
      </div>
   <%
   }
   %>
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
<script>
   var loginButton = document.getElementById("loginButton");
   loginButton.onclick = function() {
      window.open('/codeEffluve/members/logIn.jsp', 'logInpopup', 'width=370,height=300,top=100px,left=700px');
   };
</script>
</html>
