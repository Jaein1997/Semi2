<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

String t_idx_s=request.getParameter("t_idx");
int t_idx=0;
if(t_idx_s!=null||t_idx_s.equals("")){
	t_idx=Integer.parseInt(t_idx_s);
}

int result=tdao.deleteTodolist(t_idx);
if(result>0){
	%>
	<script>
	//window.alert("일정이 삭제되었습니다.");
	location.href="../private.jsp<%=msg%>&viewOption=<%=viewOption%>";
	</script>
	<%
}else{
	%>
	<script>
	window.alert("일정 삭제에 실패했습니다.");
	location.href="../private.jsp<%=msg%>&viewOption=<%=viewOption%>";
	</script>
	<%
}
%>