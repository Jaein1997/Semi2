<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>

<%
int t_idx = Integer.parseInt(request.getParameter("t_idx"));
String viewOption = request.getParameter("viewOption");
tdao.undoneTodolist(t_idx);

%>

<script>
	location.href='/codeEffluve/private.jsp?viewOption=<%=viewOption%>';
</script>
