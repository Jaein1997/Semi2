<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>

<%
int t_idx = Integer.parseInt(request.getParameter("t_idx"));
String viewOption = request.getParameter("viewOption");

String previousPage=request.getHeader("Referer");

previousPage=previousPage.substring(previousPage.lastIndexOf("/")+1,previousPage.indexOf("?"));

if(viewOption==null||viewOption.equals("")){
	
}else{
	previousPage+="?viewOption="+viewOption;
}
String year_s=request.getParameter("year");
String month_s=request.getParameter("month");
String date_s=request.getParameter("date");
String msg="";
if(year_s!=null&&month_s!=null&date_s!=null){
	previousPage+="&year="+year_s+"&month="+month_s+"&date="+date_s;
}
tdao.undoneTodolist(t_idx);

%>

<script>
	location.href='/codeEffluve/<%=previousPage%>';
</script>