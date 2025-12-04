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
<fieldset>
<legend>그룹정보수정</legend>
<form name="creategroup" action="editgroup_ok.jsp" method = "post" enctype = "multipart/form-data">

<input type="hidden" name="g_idx" value="<%=g_idx%>">
<input type="hidden" name="m_idx" value="<%=m_idx%>">
<label>그룹이름수정</label>
<input type="text" name="g_name" value="<%=gdto.getG_name() %>" readonly><input type="button" id="groupcheck" value="중복검사"><br>
<label>그룹프로필</label>
<input type="file" name="g_profile" value="<%=gdto.getG_profile()%>"><br>
<label>그룹설명</label>
<textarea name="g_memo"><%=gdto.getG_memo()%></textarea><br>
<label>공개여부</label>
<input type="radio" name="approval" value="t" <%=gdto.getApproval().equals("t")?"checked":"" %>>공개
<input type="radio" name="approval" value="f" <%=gdto.getApproval().equals("f")?"checked":"" %>>비공개<br>
<input type="submit" value="수정하기">
<input type="reset" value="초기화">
<a href="deletegroup_ok.jsp?g_idx=<%=g_idx%>"><input type="button" value="그룹삭제"></a>
</form>
</fieldset>

<%if(gdto.getApproval().equals("f")){
	%>
	<fieldset id="askinglist">
	<legend>가입신청목록</legend>
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
	</fieldset>
	<%
	}
	}%>

</form>
<script>
	var back=document.getElementById('groupcheck');
	back.onclick=function(){
		window.open('groupcheck.jsp','groupCheck','width=400, height=300');	
	};
	var askinglist=document.getElementById('askinglist');
	if(askinglist==null){
		window.resizeTo(420,340);
	};
</script>
</body>
</html>