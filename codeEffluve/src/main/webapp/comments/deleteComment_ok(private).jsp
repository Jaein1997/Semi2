<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="cdao" class="com.codeEffluve.comments.CommentsDAO"></jsp:useBean>

<%
int c_idx = Integer.parseInt(request.getParameter("c_idx"));
int t_idx = Integer.parseInt(request.getParameter("t_idx"));
String viewOption = request.getParameter("viewOption");
String arr_idx = request.getParameter("arr_idx");

cdao.deleteComment(c_idx);
%>

<script>
	location.href='/codeEffluve/private.jsp?viewOption=<%=viewOption%>&arr_idx=<%=arr_idx%>&t_idx=<%=t_idx%>';
</script>