<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.members.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>
<jsp:useBean id="gdto" class="com.codeEffluve.groups.GroupsDTO"></jsp:useBean>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<jsp:useBean id="gpdao" class="com.codeEffluve.grouping.GroupingDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/managegroup.css">
</head>
<%
int g_idx=Integer.parseInt(request.getParameter("g_idx"));
int m_idx=Integer.parseInt(request.getParameter("m_idx"));
String id=(String)session.getAttribute("sid");

if(m_idx!=mdao.getMemberMidx(id)){
	%>
	<script>
	window.alert("그룹장이 아닙니다!")
	window.self.close();
	</script>
	<%
}
gdto=gdao.selectedGroup(g_idx);
ArrayList<MembersDTO> whoasked=gpdao.whohasasked(g_idx);
%>

<body>


		<div id="editGroupDiv">
		<form name="editgroup" action="editgroup_ok.jsp" method = "post" enctype = "multipart/form-data">
			<h2 style="text-align:center; color: rgb(109, 16, 68);">그룹 정보 수정</h2>
			<input type="hidden" name="g_idx" value="<%=g_idx%>">
			<input type="hidden" name="m_idx" value="<%=m_idx%>">
			
			<table>
				<tr>
					<td><img src="/codeEffluve/img/groupIcon.png" alt="그룹"><input type="text" name="g_name" value="<%=gdto.getG_name() %>" placeholder="그룹이름" required readonly><input type="button" value="중복확인" id="groupcheck"></td>
				</tr>
				<tr>
					<td>
						<img src="/codeEffluve/img/pencil.png" alt="그룹"><input type="text" name="g_memo" value="<%=gdto.getG_memo()%>" placeholder="한줄소개" required>
					</td>
				</tr>
				<tr>
					<td>
					<span>그룹 프로필</span>
					<%
					String nowProfile = (gdto.getG_profile() == null || gdto.getG_profile().equals("")) ? "basic_group.jpg" : gdto.getG_profile();
					%>
				        <img src="<%=request.getContextPath()%>/groupProfiles/<%=nowProfile%>"
				             alt="현재 그룹 프로필"
				             class="groupProfilePreview">
				
				        <input type="file" name="g_profile"><br>
					</td>
				</tr>
				<tr>
					<td>
						<span>공개 여부</span>
						<input type="radio" name="approval" value="t" <%=gdto.getApproval().equals("t")?"checked":"" %>>공개
						<input type="radio" name="approval" value="f" <%=gdto.getApproval().equals("f")?"checked":"" %>>비공개
						
					</td>
				</tr>
			</table>
			<div style="margin-top:20px; display: flex; flex-direction: row; justify-content: center; gap: 10px;">
				<input type="submit" value="수정">
				<input type="reset" value="초기화">
				<a href="deletegroup_ok.jsp?g_idx=<%=g_idx%>"><input type="button" value="그룹삭제"></a>
			</div>
			
		</form>
		</div>
	
	
<%if(gdto.getApproval().equals("f")){
	%>
	<div id="askinglist">
	<h2 style="text-align:center; color: rgb(109, 16, 68);">가입 신청 목록</h2>
	<%if(whoasked.size()==0){
		%>
		신청한 회원이 없습니다.
		<%
	}else{%>
	<table>
		<tr>
			<th>ID</th>
			<th>이름</th>
			<th>수락</th>
			<th>거절</th>
		<tr>
	<%for(int i=0;i<whoasked.size();i++) {
		%>
		<tr>
			<td><%=whoasked.get(i).getId() %></td>
			<td><%=whoasked.get(i).getM_name() %></td>
			<td><a href="groupjoin_ok.jsp?m_idx=<%=whoasked.get(i).getM_idx()%>&g_idx=<%=g_idx%>&join=수락"><input type="button" value="수락"></a></td>
			<td><a href="groupjoin_ok.jsp?m_idx=<%=whoasked.get(i).getM_idx()%>&g_idx=<%=g_idx%>&join=거절"><input type="button" value="거절"></a></td>
		</tr>
		<%
	}
	%>
		
	</table>
	</div>
	<%
	}
	}%>

</form>
<script>
	var back=document.getElementById('groupcheck');
	back.onclick=function(){
		window.open('groupcheck.jsp','groupCheck','width=500,height=200,top=150px,left=700px');	
	};
	var askinglist=document.getElementById('askinglist');
	if(askinglist==null){
		window.resizeTo(500,490);
	};
</script>
</body>
</html>