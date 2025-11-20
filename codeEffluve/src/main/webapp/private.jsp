<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
section{
	display:flex;
}
table{
	border:1px;
}

</style>
<% 
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
%>
</head>
<body>
	<%@include file="header.jsp" %>
	<main>
	<h2>
	<a href="private.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>&day=이전날"><<</a>
	<%=year %>년 <%=month %>월 <%=date %>일 <%=day %>요일
	<a href="private.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>&day=다음날">>></a>
	</h2>
	
	<input type="date" id="calendar" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
		<section>
			<fieldset>
				<table>
					<tr>
						<td>일정</td>
						<td></td>
						<td></td>
						<td></td>
						<td>공개</td>
						<td>비공개</td>
						<td>그룹</td>
						<td>x</td>
					</tr>
				</table>
			
			</fieldset>
			<fieldset>
				<form>
				일정추가
				</form>
			</fieldset>
		</section>
	</main>
	<%@include file="footer.jsp" %>
</body>
<script>
var calendar=document.getElementById("calendar")
calendar.onchange=function(){
    const selectedDate = calendar.value; 
    const dateParts = selectedDate.split('-');
    const year = parseInt(dateParts[0]);
    const month = parseInt(dateParts[1]); 
    const date = parseInt(dateParts[2]);
    window.location.href = "private.jsp?year=" + year + "&month=" + month + "&date=" + date;
}
</script>
</html>