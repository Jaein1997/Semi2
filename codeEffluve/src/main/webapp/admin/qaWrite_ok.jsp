<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.codeEffluve.admin.qadelDAO" %>

 <%
	request.setCharacterEncoding("UTF-8");

	String q = request.getParameter("q");
	String a = request.getParameter("a");
	
	qadelDAO dao = new qadelDAO();
	int result = dao.insertQA(q,a);
	
	   if(result > 0){
		   %>
		           <script>
		               alert("등록 되었습니다.");
		               opener.location.reload();
		               window.close();
		           </script>
		   <%
		       } else {
		   %>
		           <script>
		               alert("등록에 실패하였습니다.");
		               location.href="/codeEffluve/admin/qaWrite.jsp";
		           </script>
		   <%
		       }
		   %>