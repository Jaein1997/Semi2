<%@page import="java.security.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.codeEffluve.todolist.TodolistDTO" %>
<%@ page import="com.codeEffluve.groups.GroupsDTO" %>
<%@ page import="com.codeEffluve.members.*" %>
<%@ page import="com.codeEffluve.comments.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<jsp:useBean id="gpdao" class="com.codeEffluve.grouping.GroupingDAO"></jsp:useBean>
<jsp:useBean id="cdao" class="com.codeEffluve.comments.CommentsDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">

<% 
SimpleDateFormat tf = new SimpleDateFormat("HH:mm");
SimpleDateFormat tf_c = new SimpleDateFormat("yyyy-MM-dd HH:mm");
String id=(String)session.getAttribute("sid");
if(id==null||id.equals("")){
	%>
	<script>
	window.alert("로그인 후 이용하실 수 있습니다.");
	window.location.href="index.jsp";
	</script>
	<%
	return;
}
Calendar today=Calendar.getInstance();

String user_year=request.getParameter("year");
String user_month=request.getParameter("month");
String user_date=request.getParameter("date");

if(user_year!=null&&user_month!=null&&user_date!=null
&&!user_year.equals("")&&!user_month.equals("")&&!user_date.equals("")){
	int year=Integer.parseInt(user_year);
	int month=Integer.parseInt(user_month)-1;
	int date=Integer.parseInt(user_date);
	today.set(year,month,date);
}

String nextday=request.getParameter("day");
if(nextday!=null&&!nextday.equals("")){
	if(nextday.equals("다음날")){
		today.add(Calendar.DATE, 1);
	}else{
		today.add(Calendar.DATE, -1);
	}
}

int year=today.get(Calendar.YEAR);
int month=today.get(Calendar.MONTH)+1;
int date=today.get(Calendar.DATE);
int day_n=today.get(Calendar.DAY_OF_WEEK);
String day="";

switch(day_n) {
	case 1:day="일";break;
	case 2:day="월";break;
	case 3:day="화";break;
	case 4:day="수";break;
	case 5:day="목";break;
	case 6:day="금";break;
	case 7:day="토";break;
}

Calendar nowTime = Calendar.getInstance();
String hour=""+(nowTime.get(Calendar.HOUR_OF_DAY)>9?nowTime.get(Calendar.HOUR_OF_DAY):"0"+nowTime.get(Calendar.HOUR_OF_DAY));
String minute=""+(nowTime.get(Calendar.MINUTE)>9?nowTime.get(Calendar.MINUTE):"0"+nowTime.get(Calendar.MINUTE));
String currentTime = hour+":"+minute;

int idx=tdao.returnM_idx(id);

String g_idx_s=request.getParameter("g_idx");
int g_idx=0;
if(g_idx_s!=null){
	g_idx=Integer.parseInt(g_idx_s);
}
ArrayList<GroupsDTO> mygroups=gdao.myGroups(idx);
if(mygroups.size()==0){
	GroupsDTO gdto=new GroupsDTO();
	gdto.setG_idx(0);
	gdto.setG_memo("예시 그룹입니다.");
	gdto.setG_name("예시 그룹");
	gdto.setG_profile("basic_group.jpg");
	gdto.setM_idx(0);
	mygroups.add(gdto);
}
%>
</head>
<body>
	<%@include file="header.jsp" %>
	<main>
		<section id="groupPage">
			<div class="dateHeader">
				<h2>
					<a href="group.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&day=이전날">◀</a>
					<%=year%>년
					<%=month%>월
					<%=date%>일
					<%=day%>요일 <a
						href="group.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&day=다음날">▶</a>
				</h2>
				<div>
					<input type="date" id="calendar"
						value="<%=year%>-<%=month < 10 ? "0" + month : month%>-<%=date < 10 ? "0" + date : date%>">
				</div>
				
				<div class="groupPageSwitch">
				<%
				
				if(mygroups==null||mygroups.size()==0){
					%>
					<input type="button" id="creategroup" value="그룹만들기">
					<%
				}else{
				%>
					<select id="selectedgroup">
					<% for(int i=0;i<mygroups.size();i++){%>
						<option value="<%=mygroups.get(i).getG_idx()%>" <%=g_idx==mygroups.get(i).getG_idx()?"selected":"" %>><%=mygroups.get(i).getG_name() %></option>
					<%} %>
					</select>
					<input type="button" id="creategroup" value="그룹만들기">
					<input type="button" id="searchgroup" value="그룹찾기">
				<%
				}
				%>
				</div>
			</div>
			<div class="groupMain">
				<div class="groupSchedule">
				<%
				String dbdate=year+"-"+(month<10?"0"+month:month)+"-"+(date<10?"0"+date:date);
				ArrayList<TodolistDTO> tarr=gdao.groupTodolist(g_idx==0?g_idx=mygroups.get(0).getG_idx():g_idx, dbdate);
				
				if(tarr==null||tarr.size()==0){
					%>
					등록된 일정이 없습니다.
					<%
					
				}else{
					String mprofilePath = request.getContextPath() + "/membersProfiles/";
					for(int i=0;i<tarr.size();i+=2){
					%>
					<div class="schedule_left">
						<div class="groupScheduleUser">
							<img src="<%=mprofilePath+tarr.get(i).getM_profile()%>" alt="사진" class="groupScheduleUserImg">
							<span class="groupScheduleUserID"><%=tarr.get(i).getId() %></span>
						</div>
						<div class="groupScheduleUnit">
							<input type="checkbox">
							<span><%=tarr.get(i).getContent() %></span>
							<span><%=tf.format(tarr.get(i).getT_time())%></span>
							<%
								ArrayList<CommentsDTO> carr=cdao.getComments(tarr.get(i).getT_idx());
							%>
							<span><label onclick="toggleCommentForm('writeComment<%=tarr.get(i).getT_idx()%>')" style="cursor: pointer;">
							[<%=carr.size() %>]
							</label></span>
						</div>
						
						<div class="groupComment">
							<ul>
							<%for(int j=0;j<carr.size();j++) {
								%>
								<li>
								<span><%=carr.get(j).getId() %>:</span>
								<span class="groupCommentMessage"><%=carr.get(j).getMessage() %></span>
								<span class="groupCommentTime"><%=tf_c.format(carr.get(j).getC_time()) %></span>
								<span></span>
								</li>

								<%
							}%>
								
							</ul>
						</div>
						<div class="writeComment" id="writeComment<%=tarr.get(i).getT_idx()%>" style="display: none;">
							<form action="/codeEffluve/comments/writeComment_ok(group).jsp">
							<img src="/codeEffluve/img/chat.png" alt="사진" style="width:30px; height: 30px; margin-right: 7px;">
							<span>댓글</span>
							<input type="text" name="message">
							<input type="hidden" name="id" value="<%=id%>">
							<input type="hidden" name="t_idx" value="<%=tarr.get(i).getT_idx()%>">
							<input type="hidden" name="year" value="<%=year%>">
							<input type="hidden" name="month" value="<%=month%>">
							<input type="hidden" name="day" value="<%=date%>">
							<input type="hidden" name="g_idx" value="<%=g_idx==0?mygroups.get(0).getG_idx():g_idx %>">
							<input type="submit" value="작성">
							</form>
						</div>
					</div>
					<%
					if(i+1<tarr.size()){
						%>
						<div class="schedule_right">
							<div class="groupScheduleUser">
								<img src="<%=mprofilePath+tarr.get(i+1).getM_profile()%>" alt="사진" class="groupScheduleUserImg">
								<span class="groupScheduleUserID"><%=tarr.get(i+1).getId() %></span>
							</div>
							<div class="groupScheduleUnit">
								<input type="checkbox">
								<span><%=tarr.get(i+1).getContent() %></span>
								<span><%=tf.format(tarr.get(i+1).getT_time()) %></span>
								<%
								carr=cdao.getComments(tarr.get(i+1).getT_idx());
								%>
								<span>
								<label onclick="toggleCommentForm('writeComment<%=tarr.get(i+1).getT_idx()%>')" style="cursor: pointer;">[<%=carr.size() %>]</span>
								</label>
							</div>
							<div class="groupComment">
								<ul>
									<%for(int j=0;j<carr.size();j++) {
										%>
										<li><span><%=carr.get(j).getId() %>:</span>
										<span class="groupCommentMessage"><%=carr.get(j).getMessage() %></span>
										<span class="groupCommentTime"><%=tf_c.format(carr.get(j).getC_time()) %></span>
										</li>
		
										<%
									}%>
								</ul>
							</div>
							<div class="writeComment" id="writeComment<%=tarr.get(i+1).getT_idx()%>" style="display: none;">
							<form action="/codeEffluve/comments/writeComment_ok(group).jsp">
							<img src="/codeEffluve/img/chat.png" alt="사진" style="width:30px; height: 30px; margin-right: 7px;">
							<span>댓글</span>
							<input type="text" name="message">
							<input type="hidden" name="id" value="<%=id%>">
							<input type="hidden" name="t_idx" value="<%=tarr.get(i+1).getT_idx()%>">
							<input type="hidden" name="year" value="<%=year%>">
							<input type="hidden" name="month" value="<%=month%>">
							<input type="hidden" name="day" value="<%=date%>">
							<input type="hidden" name="g_idx" value="<%=g_idx==0?mygroups.get(0).getG_idx():g_idx %>">
							<input type="submit" value="작성">
							</form>
						</div>
						</div>
						<%
						}
					}
					
				}
				%>
					
				</div>

				<div class="groupProfileArea">
					<%
					GroupsDTO selectedgroup=null;
					if(g_idx==0){
						selectedgroup=mygroups.get(0);
					}else{
						selectedgroup=gdao.selectedGroup(g_idx);
					}
					
					String gprofilePath = request.getContextPath() + "/groupProfiles/";
					if(selectedgroup!=null){
						gprofilePath+=selectedgroup.getG_profile()==null?"basic_group.jpg":selectedgroup.getG_profile();
					%>
					<div id="groupImgAndName">
						<img src="<%=gprofilePath%>" alt="사진" id="groupProfile">
						<div id="groupInfo">
							<span class="groupName"><%=selectedgroup.getG_name() %></span>
							<span class="groupMemo"><%=selectedgroup.getG_memo() %></span>
						</div>

					</div>
					<div class="groupingList">
						<div class="groupingListTitle">
							<span>그룹 멤버</span>
						</div>
						<%
						ArrayList<MembersDTO> groupmems=null;
						if(g_idx==0){
							groupmems=gpdao.membersInGroup(mygroups.get(0).getG_idx());
						}else{
							groupmems=gpdao.membersInGroup(g_idx);
						}
						String leader="";
						for(int i=0;i<groupmems.size();i++){
							if(selectedgroup.getM_idx()==groupmems.get(i).getM_idx()){
								leader=groupmems.get(i).getM_name();
							}
						}
						%>
						<div class="groupingListMembers">
							<ul>
								<li class="groupLeader">그룹장:<%=leader %></li>
								<%for(int i=0;i<groupmems.size();i++){
									if(!(selectedgroup.getM_idx()==groupmems.get(i).getM_idx())){
									%>
									<li class="groupMember"><%=groupmems.get(i).getM_name() %></li>
									<%
									}
								}%>
							</ul>
						</div>
						
					</div>
					<%}else{
						
					}%>
				</div>
			</div>
		</section>
	</main>
	<%@include file="footer.jsp" %>
</body>
<script>
	var calendar = document.getElementById("calendar")
	calendar.onchange = function() {
		const selectedDate = calendar.value;
		const dateParts = selectedDate.split('-');
		const year = parseInt(dateParts[0]);
		const month = parseInt(dateParts[1]);
		const date = parseInt(dateParts[2]);
		window.location.href = "group.jsp?year=" + year + "&month=" + month
				+ "&date=" + date;
	}
	
	var selectedgroup=document.getElementById("selectedgroup")
	selectedgroup.onchange=function(){
	    window.location.href = "group.jsp?g_idx="+selectedgroup.value+"&year=<%=year%>"+"&month=<%=month%>"+"&date=<%=date%>";
	}
	var creategroup=document.getElementById("creategroup");
	creategroup.onclick=function(){
		window.open("group/creategroup.jsp?m_idx=<%=idx%>&from","create","width=400px, height=500px");
	}
	var searchgroup=document.getElementById("searchgroup");
	searchgroup.onclick=function(){
		window.open("group/searchgroup.jsp?m_idx=<%=idx%>&from","create","width=400px, height=500px");
	}
	
	function toggleCommentForm(elementId) {
	    var formDiv = document.getElementById(elementId);
	    
	    if (formDiv.style.display === 'none' || formDiv.style.display === '') {
	        formDiv.style.display = 'block';
	    } else {
	        formDiv.style.display = 'none';
	    }
	}
</script>
</html>