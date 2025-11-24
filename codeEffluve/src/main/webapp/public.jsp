<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.codeEffluve.todolist.TodolistDTO" %>
<%@ page import="com.codeEffluve.comments.CommentsDTO" %>
<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>
<jsp:useBean id="cdao" class="com.codeEffluve.comments.CommentsDAO"></jsp:useBean>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>

<%
String sid = "";
if(session.getAttribute("sid")==null || session.getAttribute("sid").equals("")) {
	
} else {
	sid = (String)session.getAttribute("sid");
}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
</head>
<body>
	<%@include file="header.jsp" %>
	<main>
		<section id="public">
			<article id="publicListArea">
				<h1>오늘의 공개된 일정</h1>
				<div>
				<%
				ArrayList<TodolistDTO> tdtoLists = tdao.pubLists();
				if(tdtoLists==null || tdtoLists.size()==0) {
					
				} else {
					SimpleDateFormat tf = new SimpleDateFormat("HH:mm");
					for(TodolistDTO temp:tdtoLists) {
						Timestamp t_time = temp.getT_time();
						String timeStr = (t_time != null) ? tf.format(t_time) : "";
						String id = mdao.getIdStr(temp.getM_idx());
						String content = temp.getContent();
						int t_idx = temp.getT_idx();
						%>
						<ul>
							<li class="publicListUnit"><a href="/codeEffluve/public.jsp?t_idx=<%=t_idx%>"><%=id%> : <%=content%>(<%=timeStr%>)</a></li>
						</ul>
						
						<%
					}
					
				}
				%>
				</div>
				
			</article>
			<article id="commentArea">
				<h2>댓글</h2>
				<div>
					<%
					int t_idx = request.getParameter("t_idx")!=null?Integer.parseInt(request.getParameter("t_idx")):0;
					ArrayList<CommentsDTO> cdtoLists =cdao.getComments(t_idx);
					if(cdtoLists==null || cdtoLists.size()==0) {
						
					} else {
						SimpleDateFormat tf = new SimpleDateFormat("MM-dd HH:mm");
						for(CommentsDTO temp:cdtoLists) {
							String id = mdao.getIdStr(temp.getM_idx());
							Timestamp c_time = temp.getC_time();
							String timeStr = (c_time != null) ? tf.format(c_time) : "";
							String message = temp.getMessage();
							%>
							<ul>
								<li class="publicListCommentUnit"><%=id%> : <%=message%>(<%=timeStr%>)</li>
							</ul>
							
							<%
						}
					}
					%>
					
				</div>
				<form action="/codeEffluve/comments/writeComment_ok.jsp">
					<div class="writeComment">
						<input type="text" name="message">
						<input type="hidden" name="id" value="<%=sid%>">
						<input type="hidden" name="t_idx" value="<%=t_idx%>">
						<input type="submit" value="작성">
					</div>
				</form>
			</article>
		</section>
	
	</main>
	
	<%@include file="footer.jsp" %>
</body>
</html>