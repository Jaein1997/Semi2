<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="chdao" class="com.codeEffluve.chat.ChatDAO"></jsp:useBean>

<%
int sender = Integer.parseInt(request.getParameter("sender"));
int receiver = Integer.parseInt(request.getParameter("receiver"));
String message = request.getParameter("message");
int result = chdao.writeChat(sender, receiver, message);

if(result>0) {
	%>
	<script>
		location.href='/codeEffluve/friend.jsp?sf=<%=receiver%>';
	</script>
	<%
} else {
	%>
	<script>
		window.alert('채팅 전송 오류');
		location.href='/codeEffluve/friend.jsp?sf=<%=receiver%>';
	</script>
	<%
}
%>