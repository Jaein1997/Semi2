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
ArrayList<TodolistDTO> tdtoLists = tdao.pubLists();
int defT_idx = 0;
if(tdtoLists!=null && tdtoLists.size()>0) {
	defT_idx = tdtoLists.get(0).getT_idx(); // default todolist 선택
}
int selectedT_idx = request.getParameter("t_idx")!=null?Integer.parseInt(request.getParameter("t_idx")):defT_idx; // 선택한 todolist Parameter
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
				
				if(tdtoLists==null || tdtoLists.size()==0) {
					%>
					<div id="emptyLists">
						앗! 오늘은 공개된 일정이 없습니다.
					</div>
					
					<%
				} else {
					%>
					<ul>
					<%
					SimpleDateFormat tf = new SimpleDateFormat("HH:mm");
					for(TodolistDTO temp:tdtoLists) {
						Timestamp t_time = temp.getT_time();
						String timeStr = (t_time != null) ? tf.format(t_time) : "";
						String id = mdao.getIdStr(temp.getM_idx());
						String content = temp.getContent();
						int t_idx = temp.getT_idx();
						%>
						
							<li class=<%=t_idx==selectedT_idx?"publicListUnit_selected":"publicListUnit" %>>
								<a href="/codeEffluve/public.jsp?t_idx=<%=t_idx%>">
									<span style="width:25%; border-right:1px solid #888888; white-space: nowrap; overflow: hidden;text-overflow: ellipsis;"><%=id%></span>
									<span style="width:60%; padding-left: 15px; white-space: nowrap; overflow: hidden;text-overflow: ellipsis;"><%=content%></span>
									<span style="width:15%; text-align: right; border-left:1px solid #888888;"><%=timeStr%></span>
								</a>
							</li>
						
						
						<%
					}
					%>
					</ul>
					<%
				}
				
				%>
				</div>
				
			</article>
			<article id="commentArea">
				<h2>댓글</h2>
				<div>
					<ul>
					<%
					
					ArrayList<CommentsDTO> cdtoLists =cdao.getComments(selectedT_idx);
					if(cdtoLists==null || cdtoLists.size()==0) {
						
					} else {
						SimpleDateFormat tf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
						for(CommentsDTO temp:cdtoLists) {
							String profileStr = mdao.getProfilePath(temp.getM_idx());
							String profilePath = request.getContextPath() + "/membersProfiles/" + profileStr;
							String id = mdao.getIdStr(temp.getM_idx());
							String message = temp.getMessage();
							Timestamp c_time = temp.getC_time();
							String timeStr = (c_time != null) ? tf.format(c_time) : "";
							
							%>
							
								<li id="publicListCommentUnit">
									<div id="profile_id_time">
										<img src="<%=profilePath %>" alt="사진" id="commentProfile">
										<div style="display:flex; flex-direction:column">
											<span id="commentId"><%=id%></span>
											<span id="commentTime"><%=timeStr%></span>
										</div>
									</div>
									<span id="commentMessage"><%=message%></span>
								</li>
							
							
							<%
						}
					}
					%>
					</ul>
				</div>
				
				<!-- 댓글입력창 -->
				
				<div class="writeComment">
					<form action="/codeEffluve/comments/writeComment_ok.jsp">
						<input type="text" name="message">
						<input type="hidden" name="id" value="<%=sid%>">
						<input type="hidden" name="t_idx" value="<%=selectedT_idx%>">
						<input type="submit" value="작성">
					</form>
				</div>
				
			</article>
		</section>
	
	</main>
	
	<%@include file="footer.jsp" %>
</body>
</html>