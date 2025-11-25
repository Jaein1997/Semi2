<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gdto" class="com.codeEffluve.groups.GroupsDTO"></jsp:useBean>
<jsp:setProperty property="*" name="gdto"/>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<%

int result=gdao.createGroup(gdto);
if(result>2){
	%>
	<script>
	window.alert("그룹이 생성되었습니다.");
	opener.location.reload();
	self.close();
	
	</script>
	
	<%
}else{
	%>
	<script>
	window.alert("그룹 생성에 실패했습니다.");
	self.close();
	</script>
	<%
	}%>
	