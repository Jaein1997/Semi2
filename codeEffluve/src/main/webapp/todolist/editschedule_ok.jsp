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
String viewOption = request.getParameter("viewOption");
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
int result=tdao.editTodolist(tdto, setTime);
String[] g_idx_s=request.getParameterValues("g_idx");
if(g_idx_s!=null){
	tdao.groopDelete(tdto.getT_idx());
	for(int i=0;i<g_idx_s.length;i++){
		int g_idx=Integer.parseInt(g_idx_s[i]);
		int g_result=tdao.groopingTodolist(tdto.getT_idx(), g_idx);	
	}
	
}else{
	tdao.groopDelete(tdto.getT_idx());
}
if(result>0){
	%>
	<script>
	//window.alert("일정이 수정되었습니다.");
	location.href="../private.jsp<%=msg%>&viewOption=<%=viewOption%>";
	</script>
	<%
}else{
	%>
	<script>
	window.alert("일정 수정에 실패했습니다.");
	location.href="../private.jsp<%=msg%>&viewOption=<%=viewOption%>";
	</script>
	<%
}
%>