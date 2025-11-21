<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>

<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String remem = request.getParameter("rememberID");
	
	
	int loginCode = mdao.loginCheck(id, pwd);
	
	switch(loginCode) {
	case -1:
		%>
		<script>
			window.alert('에러: 로그인 에러');
			location.href='/codeEffluve/member/login.jsp';
		</script>
		<%
		break;
	case 1:
	case 2:
		%>
		<script>
			window.alert('아이디와 비밀번호를 확인하세요.');
			location.href='/codeEffluve/members/logIn.jsp';
		</script>
		<%
		break;
	case 3:
		String infos[] = mdao.getUserInfo(id);
		String name = infos[0];
		String profile = infos[1];
		session.setAttribute("sid", id);
		session.setAttribute("sname", name);
		session.setAttribute("sprofile", profile);
		
		Cookie ck;
		if(remem==null) {
			ck = new Cookie("savedID", "");
			ck.setMaxAge(0);		// 삭제와 같은 기능
			
		} else {
			ck = new Cookie("savedID", id);
			ck.setMaxAge(60*60*24*30);
		}
		response.addCookie(ck);
		%>
		<script>
			window.alert('<%=name%>님 환영합니다!');
			opener.location.reload();
			window.self.close();
		</script>
		<%
		break;
	default:
		break;
	}
%>