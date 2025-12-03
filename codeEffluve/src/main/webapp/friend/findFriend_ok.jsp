<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.members.MembersDTO" %>
<jsp:useBean id="fdao" class="com.codeEffluve.friending.FriendingDAO"></jsp:useBean>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>

<%

int m_idx=Integer.parseInt(request.getParameter("m_idx"));
String searchID = request.getParameter("searchID");

MembersDTO mdto = mdao.getMemberInfo(searchID);
if(mdto!=null) {
	String profilepath = mdto.getM_profile();
	int resultIdx = mdto.getM_idx();
	%>
	<script>
		location.href="/codeEffluve/friend/findFriend.jsp?m_idx=<%=m_idx%>&searchID=<%=searchID%>&profilepath=<%=profilepath%>&resultIdx=<%=resultIdx%>";
	</script>
	<%
} else {
	%>
	<script>
		location.href="/codeEffluve/friend/findFriend.jsp?m_idx=<%=m_idx%>&searchID=<%=searchID%>";
	</script>
	<%
}


%>


