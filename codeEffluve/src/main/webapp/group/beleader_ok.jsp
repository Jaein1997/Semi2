<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<%

String g_idx_s=request.getParameter("g_idx");
String m_idx_s=request.getParameter("m_idx");
int g_idx=Integer.parseInt(g_idx_s);
int m_idx=Integer.parseInt(m_idx_s);

int result=gdao.changeleader(g_idx, m_idx);


if(result>0){
	%>
	<script>
	window.alert('그룹장 변경완료');
	opener.location.reload();
	window.self.close();
	</script>
	<%
}%>
