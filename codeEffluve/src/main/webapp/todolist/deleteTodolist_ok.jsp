<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<%
String t_idx_s=request.getParameter("t_idx");
int t_idx=0;
if(t_idx_s!=null||t_idx_s.equals("")){
	t_idx=Integer.parseInt(t_idx_s);
}

int result=tdao.deleteTodolist(t_idx);
if(result>0){
	%>
	<script>
	window.alert("일정이 삭제되었습니다.");
	location.href="../private.jsp";
	</script>
	<%
}else{
	%>
	<script>
	window.alert("일정 삭제에 실패했습니다.");
	location.href="../private.jsp";
	</script>
	<%
}
%>