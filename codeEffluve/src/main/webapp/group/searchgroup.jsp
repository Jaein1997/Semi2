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
<style>
h2{
	text-align:center;
}
fieldset{
	border-radius: 10px;
	border: 1px solid #6D1044;
}
fieldset input[type=button],fieldset input[type=submit]{
	height: 25px;
	box-sizing: border-box;
	background-color: #6D1044;
	color: white;
	border: 0px;
	cursor: pointer;
	margin: 1px 1px 1px 1px;
}
fieldset input{
	border-radius: 8px;
}
fieldset table{
	width: 350px;
}
fieldset th{
	border-bottom: 2px solid #6D1044;
}
fieldset td{
	border-bottom: 1px solid #6D1044;
	text-align: center;
}
</style>
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
<table>
	<%if(allgroups==null||allgroups.size()==0){
		
	}else{
		%>
		<tr>
			<th>그룹명</th>
			<th>그룹장</th>
			<th>상태</th>
		</tr>
		<%
	}%>
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
						msg="가입신청취소";
					}
				}
				for(int j=0;j<mygroups.size();j++){
					if(allgroups.get(i).getG_idx()==mygroups.get(j).getG_idx()){
						//이미 가입된 그룹일 경우 msg를 탈퇴로 변경
						msg="가입됨";
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
			
			if(msg.equals("가입")||msg.equals("가입신청")||msg.equals("가입신청취소")){
			%>
				<tr>
					<td><%=allgroups.get(i).getG_name()%></td>
					<td><%=allgroups.get(i).getLeader() %></td>
					<td><a href="groupjoin_ok.jsp?m_idx=<%=m_idx%>&g_idx=<%=allgroups.get(i).getG_idx()%>&join=<%=msg%>"><input type="button" value="<%=msg %>"></a></td>
				</tr>
			<%
			}else{
			%>
				<tr>
					<td><%=allgroups.get(i).getG_name()%></td>
					<td><%=allgroups.get(i).getLeader() %></td>
					<td><%=msg %></td>
				</tr>
			<%
			}
	}%>
	
</table>
</fieldset>
<%}else{
	%>
	<fieldset>
	<legend>검색된 그룹</legend>
	<table>
		<%
		ArrayList<GroupsDTO> searchedgroups=gdao.searchedGroup(g_name);
		if(searchedgroups==null||searchedgroups.size()==0){
			
		}else{
			%>
			<tr>
				<th>그룹명</th>
				<th>그룹장</th>
				<th>상태</th>
			</tr>
			<%
		}
		for(int i=0;i<searchedgroups.size();i++){
			String msg="가입";
			//비공개, 공개 그룹 여부 판정
			if(searchedgroups.get(i).getApproval().equals("f")){
				//비공개이면 msg를 가입신청으로 변경
				msg="가입신청";
				for(int j=0;j<myaskedgroups.size();j++){
					if(searchedgroups.get(i).getG_idx()==myaskedgroups.get(j).getG_idx()){
						//이미 가입신청한 그룹이면 가입신청됨으로 변경
						msg="가입신청취소";
					}
				}
				for(int j=0;j<mygroups.size();j++){
					if(searchedgroups.get(i).getG_idx()==mygroups.get(j).getG_idx()){
						//이미 가입된 그룹일 경우 msg를 탈퇴로 변경
						msg="가입됨";
					}
				}
			}else{
				//공개그룹일 경우
				for(int j=0;j<mygroups.size();j++){
					if(searchedgroups.get(i).getG_idx()==mygroups.get(j).getG_idx()){
						//이미 가입된 그룹일 경우 msg를 탈퇴로 변경
						msg="가입됨";
					}
				}
			}
			
			if(msg.equals("가입")||msg.equals("가입신청")||msg.equals("가입신청취소")){
			%>
				<tr>
					<td><%=searchedgroups.get(i).getG_name()%></td>
					<td><%=searchedgroups.get(i).getLeader() %></td>
					<td><a href="groupjoin_ok.jsp?m_idx=<%=m_idx%>&g_idx=<%=searchedgroups.get(i).getG_idx()%>&join=<%=msg%>"><input type="button" value="<%=msg %>"></a></td>
				</tr>
			<%
			}else{
			%>
				<tr>
					<td><%=searchedgroups.get(i).getG_name()%></td>
					<td><%=searchedgroups.get(i).getLeader() %></td>
					<td><%=msg %></td>
				</tr>
			<%
			}
	}%>
	</table>
	</fieldset>
	<%
}%>

</body>
</html>