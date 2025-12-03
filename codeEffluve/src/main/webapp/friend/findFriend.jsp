<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>

<jsp:useBean id="fdao" class="com.codeEffluve.friending.FriendingDAO"></jsp:useBean>

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
	<h2>친구 찾기</h2>
	<form name="searchgroup" action="findFriend_ok.jsp">
		<div>
			<input type="hidden" name="m_idx" value="<%=m_idx%>">
			<input type="text" name="searchID" placeholder="아이디 입력" value="<%=searchID%>"><input type="submit" value="검색">
		</div>
		
	</form>
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
				if(fdao.isFriend(m_idx, resultIdx)) {
					%>
					<span>이미 친구입니다.</span>
					<%
				} else {
					%>
					<input type="submit" value="친구신청">
					<%
				}
				%>
			</form>
			
		</div>
		<%
		}
		%>

</body>
</html>