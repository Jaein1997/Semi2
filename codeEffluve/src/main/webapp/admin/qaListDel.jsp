<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.admin.qadelDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

	int q_idx = Integer.parseInt(request.getParameter("q_idx"));
	
	qadelDAO dao = new qadelDAO();
	int result = dao.deleteQA(q_idx);
	
	   if(result > 0){
		   %>
		           <script>
		               alert("삭제 완료되었습니다.");
		               location.href="admin.jsp?menu=qa";
		           </script>
		   <%
		       } else {
		   %>
		           <script>
		               alert("삭제 실패했습니다.");
		               location.href="admin.jsp?menu=qa";
		           </script>
		   <%
		       }
		   %>