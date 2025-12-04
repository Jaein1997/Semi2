<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>

<jsp:useBean id="fdao" class="com.codeEffluve.friending.FriendingDAO"></jsp:useBean>
<jsp:useBean id="frdao" class="com.codeEffluve.frapprove.FrapproveDAO"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
</head>
<%
int m_idx=Integer.parseInt(request.getParameter("m_idx"));
String searchID = "";
if(request.getParameter("searchID")!=null) {
	searchID = request.getParameter("searchID");
}
%>
<body>
	<div id="searchFriendDiv">
		<h2>친구 찾기</h2>
		<form name="searchgroup" action="findFriend_ok.jsp">
			<div>
				<input type="hidden" name="m_idx" value="<%=m_idx%>">
				<input type="text" name="searchID" placeholder="아이디 입력" value="<%=searchID%>"><input type="submit" value="검색">
			</div>
			
		</form>
	</div>
		<%
		if(request.getParameter("profilepath")!=null) {
			String profilepath = request.getParameter("profilepath");
			int resultIdx = Integer.parseInt(request.getParameter("resultIdx"));
		%>
		<div id="findResultDiv">
			<img alt="프로필" src="/codeEffluve/membersProfiles/<%=profilepath %>">
			<span><%=searchID %></span>
			<form action="addFriend_ok.jsp">
				<input type="hidden" name="m_idx" value="<%=m_idx%>">
				<input type="hidden" name="resultIdx" value="<%=resultIdx %>">
				<%
				if(m_idx==resultIdx) {
					%>
					<span style="color:#D92A0D;">나와는 친구를 할 수 없습니다.</span>
					<%				
				} else if(!frdao.isApprove(m_idx,resultIdx) && !fdao.isFriend(m_idx, resultIdx)) {
					%>
					<input type="submit" value="친구신청">
					<%
				}
				%>
			</form>
			<%
			if(fdao.isFriend(m_idx, resultIdx)) {
				%>
				<form action="deleteFriend_ok.jsp">
					<span style="color:#1E8A8A;">이미 친구입니다.</span>
					<input type="hidden" name="applicant" value="<%=m_idx%>">
    				<input type="hidden" name="approver" value="<%=resultIdx %>">
					<input type="submit" class="deleteFriend" value="친구끊기">
				</form>
				<span id="deleteWarning">* 친구를 끊으면 채팅 내용도 사라집니다.</span>
				<%
			}
			if(frdao.isApprove(m_idx, resultIdx)) {
				%>
				<form action="cancelApprove_ok.jsp">
					<span style="color:#1E8A8A;">수락 대기중</span>
					<input type="hidden" name="applicant" value="<%=m_idx%>">
    				<input type="hidden" name="approver" value="<%=resultIdx %>">
					<input type="submit" class="cancelApproval" value="신청취소">
				</form>
				
				<%
			} 
			%>
			
		</div>
		<%
		}
		%>

</body>
</html>