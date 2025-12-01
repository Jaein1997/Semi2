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
ArrayList<GroupsDTO> mygroups=gdao.myGroups(Integer.parseInt(m_idx));
ArrayList<GroupsDTO> myaskedgroups=gdao.myaskedGroups(Integer.parseInt(m_idx));
String g_name=request.getParameter("g_name");
%>
<body>
<h2>그룹 찾기</h2>
<form name="searchgroup">
<fieldset>
<legend>그룹검색</legend>
<input type="hidden" name="m_idx" value="<%=m_idx%>">
<label>그룹이름</label>
<input type="text" name="g_name"><input type="submit" value="검색">
<a href="searchgroup.jsp?m_idx=<%=m_idx %>"><input type="button" value="처음으로"></a>
</form>
</fieldset>
<%
if(g_name==null||g_name.equals("")){
%>
<fieldset>
<legend>그룹목록</legend>
<ul>
	<%
	
		for(int i=0;i<allgroups.size();i++){
			String msg="가입";
			//비공개, 공개 그룹 여부 판정
			if(allgroups.get(i).getApproval().equals("f")){
				//비공개이면 msg를 가입신청으로 변경
				msg="가입신청";
				for(int j=0;j<myaskedgroups.size();j++){
					if(allgroups.get(i).getG_idx()==myaskedgroups.get(j).getG_idx()){
						//이미 가입신청한 그룹이면 가입신청됨으로 변경
						msg="가입신청됨";
					}
				}
			}else{
				//공개그룹일 경우
				for(int j=0;j<mygroups.size();j++){
					if(allgroups.get(i).getG_idx()==mygroups.get(j).getG_idx()){
						//이미 가입된 그룹일 경우 msg를 탈퇴로 변경
						msg="가입됨";
					}
				}
			}
			
			if(msg.equals("가입")||msg.equals("가입신청")){
			%>
			<li>
			<table border=1px;>
				<tr>
					<td><%=allgroups.get(i).getG_name()%></td>
					<td>그룹장:<%=allgroups.get(i).getLeader() %></td>
					<td><a href="groupjoin_ok.jsp?m_idx=<%=m_idx%>&g_idx=<%=allgroups.get(i).getG_idx()%>&join=<%=msg%>"><input type="button" value="<%=msg %>"></a></td>
				</tr>
			
			</table>
			</li>
			<%
			}else{
			%>
			<li>
			<table border=1px;>
				<tr>
					<td><%=allgroups.get(i).getG_name()%></td>
					<td>그룹장:<%=allgroups.get(i).getLeader() %></td>
					<td><%=msg %></td>
				</tr>
				
			</table>
			</li>
			<%
			}
	}%>
	
</ul>
</fieldset>
<%}else{
	%>
	<fieldset>
	<legend>검색된 그룹</legend>
	<ul>
		<%
		ArrayList<GroupsDTO> searchedgroups=gdao.searchedGroup(g_name);
		for(int i=0;i<searchedgroups.size();i++){
			String msg="가입";
			//비공개, 공개 그룹 여부 판정
			if(searchedgroups.get(i).getApproval().equals("f")){
				//비공개이면 msg를 가입신청으로 변경
				msg="가입신청";
				for(int j=0;j<myaskedgroups.size();j++){
					if(searchedgroups.get(i).getG_idx()==myaskedgroups.get(j).getG_idx()){
						//이미 가입신청한 그룹이면 가입신청됨으로 변경
						msg="가입신청됨";
					}
				}
			}else{
				//공개그룹일 경우
				for(int j=0;j<mygroups.size();j++){
					if(searchedgroups.get(i).getG_idx()==searchedgroups.get(j).getG_idx()){
						//이미 가입된 그룹일 경우 msg를 탈퇴로 변경
						msg="가입됨";
					}
				}
			}
			
			if(msg.equals("가입")||msg.equals("가입신청")){
			%>
			<li>
			<table border=1px;>
				<tr>
					<td><%=searchedgroups.get(i).getG_name()%></td>
					<td>그룹장:<%=searchedgroups.get(i).getLeader() %></td>
					<td><a href="groupjoin_ok.jsp?m_idx=<%=m_idx%>&g_idx=<%=searchedgroups.get(i).getG_idx()%>&join=<%=msg%>"><input type="button" value="<%=msg %>"></a></td>
				</tr>
			
			</table>
			</li>
			<%
			}else{
			%>
			<li>
			<table border=1px;>
				<tr>
					<td><%=searchedgroups.get(i).getG_name()%></td>
					<td>그룹장:<%=searchedgroups.get(i).getLeader() %></td>
					<td><%=msg %></td>
				</tr>
				
			</table>
			</li>
			<%
			}
	}%>
		
	</ul>
	</fieldset>
	<%
}%>

</body>
</html>