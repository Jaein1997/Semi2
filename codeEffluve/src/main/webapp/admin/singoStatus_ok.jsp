<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import= "com.codeEffluve.admin.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	int s_idx = Integer.parseInt(request.getParameter("s_idx"));
	singoDAO dao = new singoDAO();
	
	int result = dao.updatestatus(s_idx);
	
	if(result > 0) {
%>
<script>
	alert("확인 완료 처리되었습니다.");
	location.href="admin.jsp?menu=singo";
</script>
<%
	}else {
		
%>

<script>
	alert("처리에 실패했습니다.");
	location.href="admin.jsp?menu=singo";
</script>
<%
}
%>