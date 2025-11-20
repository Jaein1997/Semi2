<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
session.removeAttribute("sname");
session.removeAttribute("sid");
response.sendRedirect("/codeEffluve");

%>
<script>
location.href="/codeEffluve/index.jsp";
</script>