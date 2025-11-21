<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
</head>
<style>
#leftMenu {
   float:left;
   width:200px;
   min-height:500px;
   padding:20px;
   border-right:1px solid #ccc;
}

#rightContent {
   margin-left:220px;
   padding:20px;
   min-height:500px;
}

</style>
<body>
<%@include file="/header.jsp" %>
<main>
<!-- 왼쪽메뉴 -->
<div id="leftMenu">
<h2>관리자 메뉴</h2>
<ul>
	<li><a href="admin.jsp?menu=member">회원관리</a></li>
	<li><a href="admin.jsp?menu=group">그룹관리</a></li>
	<li><a href="admin.jsp?menu=todo">일정관리</a></li>
	<li><a href="admin.jsp?menu=that">댓글관리</a></li>
	<li><a href="admin.jsp?menu=qa">자주묻는질문</a></li>
	<li><a href="admin.jsp?menu=singo">불편사항</a></li>
</ul>
</div>

<!-- 오른쪽내용 -->
<div id="rightContent">
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
	
				
	}
	%>
</div>

</main>

<%@include file="/footer.jsp" %>

</body>
</html>