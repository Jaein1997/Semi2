<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="tdto" class="com.codeEffluve.todolist.TodolistDTO"></jsp:useBean>
<jsp:setProperty property="*" name="tdto"/>
<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<%
String year_s=request.getParameter("year");
String month_s=request.getParameter("month");
String date_s=request.getParameter("day");
String msg="";
if(year_s!=null&&month_s!=null&date_s!=null){
	msg="?year="+year_s+"&month="+month_s+"&date="+date_s;
}

String date=request.getParameter("date");
String time=request.getParameter("time");
String setTime="";
if(date!=null&&time!=null){
	setTime=date+" "+time;
}
int t_idx=tdao.insertTodolist(tdto, setTime);

String[] g_idx_s=request.getParameterValues("g_idx");
if(g_idx_s!=null){
	for(int i=0;i<g_idx_s.length;i++){
		int g_idx=Integer.parseInt(g_idx_s[i]);
		int g_result=tdao.groopingTodolist(t_idx, g_idx);	
	}
	
}
if(t_idx>0){
	%>
	<script>
	//window.alert("일정이 등록되었습니다.");
	location.href="../private.jsp<%=msg%>";
	</script>
	<%
}else{
	%>
	<script>
	window.alert("일정 등록에 실패했습니다.");
	location.href="../private.jsp<%=msg%>";
	</script>
	<%
}
%>