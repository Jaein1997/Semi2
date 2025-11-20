<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>

<%
	if(request.getParameter("findid")==null || request.getParameter("findid").equals("")) {
%>
	<script>
		window.alert('검색할 ID를 입력하세요.');
		location.href='idCheck.jsp';
	</script>
<%
	} else {
	String idFind = request.getParameter("findid");
	int count = mdao.idCheck(idFind);
	
	if (count>0) {
%>
	<script>
		alert('이미 존재하는 ID 입니다.');
		location.href='idCheck.jsp';
	</script>
<%
	} else {
%>
	<script>0
		alert('사용 가능한 ID입니다.');
		opener.document.memberJoin.id.value = '<%=idFind%>';
		window.self.close();
	</script>
<%
	}
}
%>