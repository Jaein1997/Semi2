<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="frdao" class="com.codeEffluve.frapprove.FrapproveDAO"></jsp:useBean>
<jsp:useBean id="fdao" class="com.codeEffluve.friending.FriendingDAO"></jsp:useBean>

<%
int approver = Integer.parseInt(request.getParameter("approver"));
int applicant = Integer.parseInt(request.getParameter("applicant"));

if(frdao.acceptApproval(applicant, approver)>0) {
	if(fdao.addFriend(approver,applicant)>0) {
		%>
		<script>
			location.href="/codeEffluve/friend/approveFriend.jsp?m_idx=<%=approver%>";
		</script>
		<%
	}
}
%>