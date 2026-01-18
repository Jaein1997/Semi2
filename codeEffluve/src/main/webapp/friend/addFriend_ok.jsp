<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="frdao" class="com.codeEffluve.frapprove.FrapproveDAO"></jsp:useBean>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>

<%
int applicant=Integer.parseInt(request.getParameter("m_idx"));
int approver=Integer.parseInt(request.getParameter("resultIdx"));
String searchID = mdao.getIdStr(approver);
String profilepath = mdao.getProfilePath(approver);

if(frdao.addApproval(applicant, approver)>0) {
	%>
	<script>
		opener.location.reload();
		location.href="/codeEffluve/friend/findFriend.jsp?m_idx=<%=applicant%>&searchID=<%=searchID%>&profilepath=<%=profilepath%>&resultIdx=<%=approver%>";
	</script>
	<%
}
%>