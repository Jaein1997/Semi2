<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.admin.thatDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

	int c_idx = Integer.parseInt(request.getParameter("c_idx"));
	
	thatDAO dao = new thatDAO();
	int result = dao.deleteThat(c_idx);
	
	   if(result > 0){
		   %>
		           <script>
		               alert("삭제 완료되었습니다.");
		               location.href="/codeEffluve/admin/admin.jsp?menu=that";
		           </script>
		   <%
		       } else {
		   %>
		           <script>
		               alert("삭제 실패했습니다.");
		               location.href="/codeEffluve/admin/admin.jsp?menu=that";
		           </script>
		   <%
		       }
		   %>