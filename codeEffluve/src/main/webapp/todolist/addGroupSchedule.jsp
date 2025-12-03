<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.form-buttons {
    display: flex;
    justify-content: flex-end; 
    margin-top: 15px; 
    gap: 10px; 
}
.scheduleAddTable {
	border-spacing: 0px;
	width: 100%;
}

.scheduleAddTable th {
	background-color: #FAF7F9;
	width: 85px;
	font-weight: 500;
	text-align: right;
	padding: 5px;
	border-right: 1px solid #D8CDD2;
	border-bottom: 1px solid #D8CDD2;
}

.scheduleAddTable td {
	background-color: white;
	text-align: left;
	padding: 5px;
	border-bottom: 1px solid #D8CDD2;
}

.scheduleAddTable td input[type="text"] {
	width: 100%;
	height: 100%;
	border: 0px;
	font-size: 16px;
}

.scheduleAddTable td input[type="text"]:focus {
	outline: none;
}

.scheduleAddTable td textarea {
	width: 100%;
	height: 100%;
	border: 0px;
	font-size: 16px;
	font-family: sans-serif;
	resize: none;
}

.scheduleAddTable td textarea:focus {
	outline: none;
}

.scheduleAddTable td input[type="date"] {
	flex: 1 1 0;
	height: 100%;
	font-size: 16px;
	border: 0px;
	font-family: sans-serif;
	border-right: 1px solid #D8CDD2;
	padding-right: 10px;
}

.scheduleAddTable td input[type="time"] {
	flex: 1 1 0;
	height: 100%;
	font-size: 16px;
	border: 0px;
	font-family: sans-serif;
	padding-left: 10px;
}

.scheduleAddTable td input[type="radio"] {
	margin-left: 15px;
	accent-color: #1E8A8A;
}

.scheduleAddTable td input[type="radio"]:first-child {
	margin-left: 0px;
}

.scheduleAddTable #groupSel {
	margin-left: 5px;
	display: flex;
	width: 100px;
	height: 25px;
	box-sizing: border-box;
	border: 1px solid #1E8A8A;
	border-top-left-radius: 8px;
	border-bottom-left-radius: 8px;
}

.scheduleAddTable #groupSel:disabled {
	border: 1px solid #888888;
}
#bt {
	
	height: 25px;
	box-sizing: border-box;
	background-color: #6D1044;
	color: white;
	border: 0px;
	border-top-right-radius: 8px;
	border-top-left-radius: 8px;
	border-bottom-right-radius: 8px;
	border-bottom-left-radius: 8px;
	cursor: pointer;
	justify-content: flex-end;
}
.h3Div {
	text-align: center;
}
</style>
</head>
<%
String g_idx = request.getParameter("g_idx");
String m_idx = request.getParameter("m_idx");
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));
String currentTime = request.getParameter("currentTime");
%>
<body>
	<form name="newschedule" action="addGroupSchedule_ok.jsp">
		<div class="h3Div">
			<h3>일정 추가</h3>
		</div>
		<table class="scheduleAddTable">
			<tr>
				<th>일정 이름</th>
				<td><input type="text" name="content" required></td>
			</tr>
			<tr>
				<th>시작 날짜</th>
				<td>
					<div style="display: flex; flex-direction: row;">
						<input type="date" name="date" value="<%=year%>-<%=month < 10 ? "0" + month : month%>-<%=date < 10 ? "0" + date : date%>" required> 
						<input type="time" name="time" value="<%=currentTime%>" required>
					</div>
				</td>
			</tr>
			<tr>
				<th>메모</th>
				<td><textarea name="t_memo"></textarea></td>
			</tr>

		</table>
		
		<div class="form-buttons" style="display:flex;">
				<input type="hidden" name="m_idx" value="<%=m_idx%>"> 
				<input type="hidden" name="shares" value="group"> 
				<input type="hidden" name="g_idx" value="<%=g_idx%>">
				<input type="hidden" name="year" value="<%=year%>"> 
				<input type="hidden" name="month" value="<%=month%>"> 
				<input type="hidden" name="day" value="<%=date%>"> 
				<input type="submit" id="bt" value="등록하기"> 
				<input type="reset" id="bt" value="초기화">
			</div>

	</form>
</body>
</html>