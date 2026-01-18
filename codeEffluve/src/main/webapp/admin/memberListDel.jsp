<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@page import ="com.codeEffluve.admin.*" %>
  <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<%
int m_idx = Integer.parseInt(request.getParameter("m_idx"));

	adminDAO dao = new adminDAO();
	int result = dao.deleteMember(m_idx);
	
	if(result > 0){
%>
	<script>
		alert("삭제가 완료되었습니다.");
		location.href="admin.jsp?menu=member";
	</script>
<%
	} else{		
%>
	<script>
		alert("삭제 실패하였습니다.");
		location.href="admin.jsp?menu=member";
	</script>
<%
	}
%>