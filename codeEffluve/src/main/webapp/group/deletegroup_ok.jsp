<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<%

String g_idx_s=request.getParameter("g_idx");
int g_idx=Integer.parseInt(g_idx_s);
String id=(String)session.getAttribute("sid");
int userIdx=mdao.getMemberMidx(id);
int result=gdao.deletegroup(g_idx, userIdx);

if(result>0){
	%>
	<script>
	window.alert('그룹 삭제 완료');
	opener.location.reload();
	window.self.close();
	</script>
	<%
}else{
	%>
	<script>
	window.alert('잘못된 접근입니다');
	opener.location.reload();
	window.self.close();
	</script>
	<%
}%>