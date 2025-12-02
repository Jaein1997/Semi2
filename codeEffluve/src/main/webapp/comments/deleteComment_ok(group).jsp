<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="cdao" class="com.codeEffluve.comments.CommentsDAO"></jsp:useBean>

<%

int c_idx = Integer.parseInt(request.getParameter("c_idx"));
int g_idx = Integer.parseInt(request.getParameter("g_idx"));

cdao.deleteComment(c_idx);
%>

<script>
	location.href='/codeEffluve/group.jsp?g_idx=<%=g_idx%>';
</script>