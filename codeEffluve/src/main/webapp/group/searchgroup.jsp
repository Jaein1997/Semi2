<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.groups.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
String m_idx=request.getParameter("m_idx");
ArrayList<GroupsDTO> allgroups=gdao.allGroup();
%>
<body>
<h2>그룹 찾기</h2>
<form name="searchgroup" action="searchgroup_ok.jsp" method = "post" enctype = "multipart/form-data">
<fieldset>
<legend>그룹검색</legend>
<input type="hidden" name="m_idx" value="<%=m_idx%>">
<label>그룹이름</label>
<input type="text" name="g_name"><input type="submit" value="검색">
</fieldset>
<fieldset>
<legend>그룹목록</legend>
<ul>
	<%for(int i=0;i<allgroups.size();i++){
		%>
		<li><%=allgroups.get(i).getG_name()%><a href="groupjoin_ok.jsp?m_idx=<%=m_idx%>&g_idx=<%=allgroups.get(i).getG_idx()%>">가입</a></li>
		<%
	}%>
	
</ul>
</fieldset>
</form>
</body>
</html>