<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gdto" class="com.codeEffluve.groups.GroupsDTO"></jsp:useBean>
<jsp:setProperty property="*" name="gdto"/>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<%

int result=tdao.insertTodolist(tdto, setTime);
if(result>0){
	%>
	<script>
	window.alert("그룹이 생성되었습니다.");
	location.href="../private.jsp";
	</script>
	
	<%
}else{
	%>
	<script>
	window.alert("그룹 생성에 실패했습니다.");
	location.href="../private.jsp";
