<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.admin.groupdelDAO" %>

<%
    request.setCharacterEncoding("UTF-8");

    int g_idx = Integer.parseInt(request.getParameter("g_idx"));

    groupdelDAO dao = new groupdelDAO();
    int result = dao.deleteGroup(g_idx);

    if(result > 0){
%>
        <script>
            alert("삭제 완료되었습니다.");
            location.href="/codeEffluve/admin/admin.jsp?menu=group";
        </script>
<%
    } else {
%>
        <script>
            alert("삭제 실패했습니다.");
            location.href="/codeEffluve/admin/admin.jsp?menu=group";
        </script>
<%
    }
%>
