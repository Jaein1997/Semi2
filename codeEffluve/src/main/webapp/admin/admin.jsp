<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/admin.css"> 
</head>

<body>
<div id="adminWrapper">

<!-- 왼쪽메뉴 -->
<aside id="adminSidebar">
<h2>관리자 메뉴</h2>
<ul>
	<li><a href="admin.jsp?menu=member">회원관리</a></li>
	<li><a href="admin.jsp?menu=group">그룹관리</a></li>
	<li><a href="admin.jsp?menu=todo">일정관리</a></li>
	<li><a href="admin.jsp?menu=that">댓글관리</a></li>
	<li><a href="admin.jsp?menu=qa">자주묻는질문</a></li>
	<li><a href="admin.jsp?menu=singo">불편사항</a></li>
</ul>
</aside>

<!-- 오른쪽내용 -->
<section id="adminContent">
	<%
	String menu= request.getParameter("menu");
	if(menu == null) menu="member";
	
	if(menu.equals("member")){
		%><%@ include file="memberList.jsp" %><%
	}else if(menu.equals("group")){
		%><%@ include file="groupList.jsp" %><%
	}else if(menu.equals("todo")){
		%><%@ include file="todoList.jsp" %><%
	}else if(menu.equals("that")) {
		%><%@ include file="that.jsp" %><%
	}else if(menu.equals("qa")){
		%><%@ include file="qa.jsp" %><%
	}else if(menu.equals("singo")){
	    %><%@ include file="singo.jsp" %><%
	}
	%>
	</section>
</div>

</main>

<%@include file="/footer.jsp" %>

</body>
</html>