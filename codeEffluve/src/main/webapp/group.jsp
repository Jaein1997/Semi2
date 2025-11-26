<%@page import="java.security.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.codeEffluve.todolist.TodolistDTO" %>
<%@ page import="com.codeEffluve.groups.GroupsDTO" %>
<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>


</style>
<% 
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

%>
</head>
<body>
	<%@include file="header.jsp" %>
	<main>
		<section id="groupPage">
			<div class="dateHeader">
				<h2>
					<a
						href="private.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&day=이전날">◀</a>
					<%=year%>년
					<%=month%>월
					<%=date%>일
					<%=day%>요일 <a
						href="private.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&day=다음날">▶</a>
				</h2>
				<div>
					<input type="date" id="calendar"
						value="<%=year%>-<%=month < 10 ? "0" + month : month%>-<%=date < 10 ? "0" + date : date%>">
				</div>
			</div>
			<div class="groupMain">
				<div class="groupSchedule">
					<div class="schedule_left">
						<div class="groupScheduleUser">
							<%
							String mprofilePath = request.getContextPath() + "/membersProfiles/" + "basic.jpg";
							%>
							<img src="<%=mprofilePath%>" alt="사진" class="groupScheduleUserImg">
							<span class="groupScheduleUserID">thdus1821</span>
						</div>
						<div class="groupScheduleUnit">
							<input type="checkbox"><span>학원가기</span><span>09:00</span>
						</div>
						<div class="groupComment">
							<ul>
								<li><span>thdus1821 : </span><span>ㅋㅋㅋ</span><span class="groupCommentTime">08:37</span>
								</li>
								<li><span>thdus1821 : </span><span>ㅋㅋㅋㅋㅋ</span><span class="groupCommentTime">08:39</span>
								</li>
							</ul>
						</div>
					</div>

					<div class="schedule_right">
						<div class="groupScheduleUser">
							<img src="<%=mprofilePath%>" alt="사진" class="groupScheduleUserImg">
							<span class="groupScheduleUserID">thdus1821</span>
						</div>
						<div class="groupScheduleUnit">
							<input type="checkbox"><span>운동하기</span><span>19:00</span>
						</div>
						<div class="groupComment">
							<ul>
								<li><span>thdus1821 : </span><span>힘들다</span><span class="groupCommentTime">08:40</span>
								</li>
								<li><span>thdus1821 : </span><span>가기싫다</span><span class="groupCommentTime">08:41</span>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="groupProfileArea">
					<%
					String gprofilePath = request.getContextPath() + "/groupProfiles/" + "basic_group.jpg";
					%>
					<div id="groupImgAndName">
						<img src="<%=gprofilePath%>" alt="사진" id="groupProfile">
						<div id="groupInfo">
							<span>그룹이름</span> <span>그룹소개말</span>
						</div>

					</div>

					<ul>
						<li>그룹장</li>
						<li>그룹원1</li>
						<li>그룹원2</li>
					</ul>
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
</script>
</html>