<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	
		<div>
		<a href="/memberJoin.jsp">회원가입</a> | <a href="" id="loginButton">로그인</a>
		</div>
		
		<a href="/codeEffluve/public.jsp" class="titleLogo"><img src="http://localhost:9090/codeEffluve/img/leLogo1.png" alt="leLogo1"><h1>Life Effluve</h1></a>

	
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
			<li <%=selectedPage.equals("cs.jsp")?"class='selectedPage'":"" %>><a href="/codeEffluve/cs.jsp">고객센터</a></li>
		</ul>
	</nav>
</header>