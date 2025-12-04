<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String sname = (String)session.getAttribute("sname");
	String sprofile = (String)session.getAttribute("sprofile");
	String sprofilePath = request.getContextPath() + "/membersProfiles/" + sprofile;
%>
<header>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/header.css"> 
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
		<a href="/codeEffluve/members/logOut.jsp">로그아웃</a> | <label>환영합니다, <%=sname %>님!</label> <a href="/codeEffluve/members/myPage.jsp" ><img src="<%=sprofilePath %>" alt="basic" id="miniProfile"></a>
		</div>
	<%
	}
	%>
		
		<div id="headerLogoDiv">
			<a href="/codeEffluve/public.jsp" class="titleLogo"><img src="/codeEffluve/img/leLogo1.png" alt="leLogo1"><h1>Life Effluve</h1></a>
		</div>
		

	
	<nav>
		<ul>
			<%
			String selectedPage = "public.jsp";
			String path=request.getRequestURI();
			int lidx=path.lastIndexOf("/");
			selectedPage=path.substring(lidx+1);
			%>
			<li <%=selectedPage.equals("public.jsp")?"class='selectedPage'":"" %>><a href="/codeEffluve/public.jsp">공개 일정</a></li>
			<li <%=selectedPage.equals("private.jsp")?"class='selectedPage'":"" %>><a href="/codeEffluve/private.jsp">내 일정</a></li>
			<li <%=selectedPage.equals("group.jsp")?"class='selectedPage'":"" %>><a href="/codeEffluve/group.jsp">그룹 일정</a></li>
			<li <%=selectedPage.equals("friend.jsp")?"class='selectedPage'":"" %>><a href="/codeEffluve/friend.jsp">친구</a></li>
			<li <%=selectedPage.equals("cs.jsp")||selectedPage.equals("csProblem.jsp")||selectedPage.equals("csQA.jsp")?"class='selectedPage'":"" %>><a href="/codeEffluve/cs.jsp">고객센터</a></li>
		</ul>
	</nav>
</header>

<script>
	var loginButton = document.getElementById("loginButton");
	loginButton.onclick = function() {
		window.open('/codeEffluve/members/logIn.jsp', 'logInpopup', 'width=500,height=350,top=100px,left=700px');
	};
</script>