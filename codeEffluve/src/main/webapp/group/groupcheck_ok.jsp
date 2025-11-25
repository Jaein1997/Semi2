<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<%
String g_name=request.getParameter("g_name");
g_name=gdao.groupCheck(g_name);
if(g_name==null){
	%>
	<script>
	window.alert('그룹명 중복 있음');
	location.href='/codeEffluve/group/groupcheck.jsp';
	</script>
	<%
}else{
	%>
	<script>
	window.alert('그룹명 중복 없음');
	opener.document.creategroup.g_name.value='<%=g_name%>';
	window.self.close();
	</script>
	<%
}
%>