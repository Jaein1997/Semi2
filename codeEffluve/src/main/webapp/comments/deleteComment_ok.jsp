<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="cdao" class="com.codeEffluve.comments.CommentsDAO"></jsp:useBean>

<%
int c_idx = Integer.parseInt(request.getParameter("c_idx"));
int t_idx = Integer.parseInt(request.getParameter("t_idx"));

cdao.deleteComment(c_idx);
%>

<script>
	location.href='/codeEffluve/public.jsp?t_idx=<%=t_idx%>';
</script>