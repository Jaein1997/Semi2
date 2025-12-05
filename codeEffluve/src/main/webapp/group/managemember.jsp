<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.groups.*" %>
<%@ page import="com.codeEffluve.members.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/managemember.css">
</head>
<%
int m_idx=Integer.parseInt(request.getParameter("m_idx"));
int g_idx=Integer.parseInt(request.getParameter("g_idx"));
ArrayList<MembersDTO> groupmembers=gdao.groupmembers(g_idx);

String m_name=request.getParameter("m_name");

%>
<body>
<form name="searchgroup">
<fieldset>
<legend>멤버 검색</legend>
<input type="hidden" name="g_idx" value="<%=g_idx%>">
<input type="hidden" name="m_idx" value="<%=m_idx%>">
<label>멤버 이름</label>
<input type="text" name="m_name"><input type="submit" value="검색">
<a href="managemember.jsp?m_idx=<%=m_idx %>&g_idx=<%=g_idx%>"><input type="button" value="처음으로"></a>
</form>
</fieldset>
<%
if(m_name==null||m_name.equals("")){
%>
<fieldset>
<legend>멤버목록</legend>
<table>
	<tr>
		<th>ID</th>
		<th>이름</th>
		<th>탈퇴처리</th>
		<th>승격</th>
	</tr>
	
	<%
	for(int i=0;i<groupmembers.size();i++){
		%>
		<tr>
			<td><%=groupmembers.get(i).getId() %></td>
			<td><%=groupmembers.get(i).getM_name() %></td>
			<%if(groupmembers.get(i).getM_idx()==m_idx){
				%>
				<td>
				그룹장
				</td>
				<%
			}else{
				%>
				<td>
				<a href="groupjoin_ok.jsp?g_idx=<%=g_idx%>&m_idx=<%=groupmembers.get(i).getM_idx()%>&join=탈퇴처리&g_leader=<%=m_idx%>"><input type="button" value="탈퇴처리"></a>
				</td>
				<td>
				<a href="beleader_ok.jsp?g_idx=<%=g_idx%>&m_idx=<%=groupmembers.get(i).getM_idx()%>"><input type="button" value="승격"></a>
				</td>
				<%
			}
			%>
		</tr>
		<%
	}
		%>
</table>
</fieldset>
<%}else{
	ArrayList<MembersDTO> searchedmembers=gdao.searchedmember(g_idx, m_name);
	%>
<fieldset>
<legend>검색된 멤버</legend>
<table>
	
	<%
	if(searchedmembers.size()==0){
		%>
		검색된 멤버가 없습니다.
		<%
	}else{
		%>
		<tr>
		<th>ID</th>
		<th>이름</th>
		<th>탈퇴처리</th>
		<th>승격</th>
		</tr>
		<%
		
	for(int i=0;i<searchedmembers.size();i++){
		%>
		<tr>
			<td><%=searchedmembers.get(i).getId() %></td>
			<td><%=searchedmembers.get(i).getM_name() %></td>
			<%if(searchedmembers.get(i).getM_idx()==m_idx){
				%>
				<td>
				그룹장
				</td>
				<%
			}else{
				%>
				<td>
				<a href="groupjoin_ok.jsp?g_idx=<%=g_idx%>&m_idx=<%=searchedmembers.get(i).getM_idx()%>&join=탈퇴처리&g_leader=<%=m_idx%>"><input type="button" value="탈퇴처리"></a>
				</td>
				<td>
				<a href="beleader_ok.jsp?g_idx=<%=g_idx%>&m_idx=<%=searchedmembers.get(i).getM_idx()%>"><input type="button" value="승격"></a>
				</td>
				<%
			}
			%>
		</tr>
		<%
	}
}
		%>
</table>
</fieldset>
<%
}%>

</body>
</html>