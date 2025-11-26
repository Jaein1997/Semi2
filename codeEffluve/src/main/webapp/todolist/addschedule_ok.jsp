<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="tdto" class="com.codeEffluve.todolist.TodolistDTO"></jsp:useBean>
<jsp:setProperty property="*" name="tdto"/>
<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<%
String date=request.getParameter("date");
String time=request.getParameter("time");
String setTime="";
if(date!=null&&time!=null){
	setTime=date+" "+time;
}
int t_idx=tdao.insertTodolist(tdto, setTime);
String g_idx_s=request.getParameter("g_idx");
if(g_idx_s!=null){
	int g_idx=Integer.parseInt(g_idx_s);
	int g_result=tdao.groopingTodolist(t_idx, g_idx);	
}
if(t_idx>0){
	%>
	<script>
	window.alert("일정이 등록되었습니다.");
	location.href="../private.jsp";
	</script>
	<%
}else{
	%>
	<script>
	window.alert("일정 등록에 실패했습니다.");
	location.href="../private.jsp";
	</script>
	<%
}
%>