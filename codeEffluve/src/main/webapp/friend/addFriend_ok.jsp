<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="frdao" class="com.codeEffluve.frapprove.FrapproveDAO"></jsp:useBean>

<%
int applicant=Integer.parseInt(request.getParameter("m_idx"));
int approver=Integer.parseInt(request.getParameter("resultIdx"));

if(frdao.addApproval(applicant, approver)>0) {
	%>
	<script>
		window.alert("친구신청 완료");
	</script>
	<%
}
%>