<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="cdao" class="com.codeEffluve.comments.CommentsDAO"></jsp:useBean>

<%
String year_s=request.getParameter("year");
String month_s=request.getParameter("month");
String date_s=request.getParameter("day");
String msg="";
if(year_s!=null&&month_s!=null&date_s!=null){
	msg="&year="+year_s+"&month="+month_s+"&date="+date_s;
}

int c_idx = Integer.parseInt(request.getParameter("c_idx"));
int g_idx = Integer.parseInt(request.getParameter("g_idx"));

cdao.deleteComment(c_idx);
%>

<script>
	location.href='/codeEffluve/group.jsp?g_idx=<%=g_idx+msg%>';
</script>