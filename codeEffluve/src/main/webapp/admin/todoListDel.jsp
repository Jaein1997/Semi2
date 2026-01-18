<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.admin.daydelDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

	int t_idx = Integer.parseInt(request.getParameter("t_idx"));
	
	daydelDAO dao = new daydelDAO();
	int result = dao.deleteTodo(t_idx);
	
	   if(result > 0){
		   %>
		           <script>
		               alert("삭제 완료되었습니다.");
		               location.href="/codeEffluve/admin/admin.jsp?menu=todo";
		           </script>
		   <%
		       } else {
		   %>
		           <script>
		               alert("삭제 실패했습니다.");
		               location.href="/codeEffluve/admin/admin.jsp?menu=todo";
		           </script>
		   <%
		       }
		   %>