<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.comments.*" %>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>
<jsp:useBean id="cdao" class="com.codeEffluve.comments.CommentsDAO"></jsp:useBean>

<%
int t_idx = request.getParameter("t_idx")!=null?Integer.parseInt(request.getParameter("t_idx")):0;
String message = request.getParameter("message");
String id = request.getParameter("id");
int m_idx = mdao.getMemberMidx(id);

CommentsDTO cdto = new CommentsDTO();
cdto.setM_idx(m_idx);
cdto.setMessage(message);
cdto.setT_idx(t_idx);
int result = cdao.writeComment(cdto);

if (result>0) {
	%>
	<script>
		location.href='/codeEffluve/public.jsp?t_idx=<%=t_idx%>';
	</script>
	<%
} else {
	%>
	<script>
		location.href='/codeEffluve/public.jsp?t_idx=<%=t_idx%>';
	</script>
	<%
}
%>