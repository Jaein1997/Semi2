
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.codeEffluve.comments.CommentsDTO" %>
<%@ page import="com.codeEffluve.todolist.TodolistDTO" %>
<%@ page import="com.codeEffluve.groups.GroupsDTO" %>


<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>
<jsp:useBean id="cdao" class="com.codeEffluve.comments.CommentsDAO"></jsp:useBean>
<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<jsp:useBean id="gdao" class="com.codeEffluve.groups.GroupsDAO"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/private.css">
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

if(user_year!=null&&user_month!=null
&&!user_year.equals("")&&!user_month.equals("")){
	int year=Integer.parseInt(user_year);
	int month=Integer.parseInt(user_month)-1;
	int date = 1;
	if (user_date != null && !user_date.equals("")) {
	    date = Integer.parseInt(user_date);
	}
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

int selectedT_idx = request.getParameter("t_idx")!=null?Integer.parseInt(request.getParameter("t_idx")):0;
String viewOption = "";
if(request.getParameter("viewOption")!=null) {
	viewOption = request.getParameter("viewOption");
} else {
	viewOption = "ud";
}

String mdMode = "";
if(request.getParameter("mdMode")!=null) {
	mdMode = request.getParameter("mdMode");
} else {
	mdMode = "daily";
}
%>
</head>
<body>
	<%@include file="header.jsp" %>
	<main>
    
    
    <section id="schedule">
    	<div class="left-column">
    		<%
        	String dbdate=year+"-"+(month<10?"0"+month:month)+"-"+(date<10?"0"+date:date);
            int idx=tdao.returnM_idx(id);
            ArrayList<TodolistDTO> arr=tdao.showTodolist(idx,dbdate);
        	if (mdMode.equals("daily")) { %>
    		<div class="dateHeader">
    			<div id="mORd">
    				<a href="/codeEffluve/private.jsp?mdMode=daily" style="margin:0px !important;box-sizing: border-box;"><button <%=mdMode.equals("daily")?"class='dailyBtnSelected'":"class='dailyBtn'" %> id="dailyBtn">일별보기</button></a>
    				<a href="/codeEffluve/private.jsp?mdMode=monthly" style="margin:0px !important;"><button <%=mdMode.equals("monthly")?"class='monthlyBtnSelected'":"class='monthlyBtn'" %> id="monthlyBtn">월별보기<img src="/codeEffluve/img/calendar_mini.png" alt="날짜선택" style="width:16px;height:auto;"></button></a>
    			</div>
		        <h2>
		            <a href="private.jsp?viewOption=<%=viewOption %>&year=<%=year %>&month=<%=month %>&date=<%=date %>&day=이전날">◀</a>
		            <%=year %>년 <%=month %>월 <%=date %>일 (<%=day %>)
		            
		            <input type="date" id="calendar" class="calendar-input" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
		    		<button type="button" id="calendarBtn" class="calendar-btn"><img src="/codeEffluve/img/calendar.png" alt="날짜선택"></button>
		        	<a href="private.jsp?viewOption=<%=viewOption %>&year=<%=year %>&month=<%=month %>&date=<%=date %>&day=다음날">▶</a>
		        </h2>
		        <form name="fm">
		        	<select name="viewOption" id="myscheduleOption">
	        			<option value="ud" <%=viewOption.equals("ud")?"selected":"" %>>미완료 일정</option>
	        			<option value="d" <%=viewOption.equals("d")?"selected":"" %>>완료된 일정</option>
	        			<option value="all" <%=viewOption.equals("all")?"selected":"" %>>모든 일정</option>
	        		</select>
		        </form>
		        
    		</div>
        
        	
        	<div class="myschedule">
        		
                
                <% 
                
               
                %>
                
                <ul>
                
                <%
                for(int i=0;i<(arr==null?0:arr.size());i++){
                	if(viewOption.equals("ud") && arr.get(i).getStatus().equals("d")) {
                		continue;
                	} else if(viewOption.equals("d") && arr.get(i).getStatus().equals("ud")) {
                		continue;
                	}
                	String content = arr.get(i).getContent();
                	String hours = arr.get(i).getT_time().getHours()<10?"0"+arr.get(i).getT_time().getHours():""+arr.get(i).getT_time().getHours();
                	String mins = arr.get(i).getT_time().getMinutes()<10?"0"+arr.get(i).getT_time().getMinutes():""+arr.get(i).getT_time().getMinutes();
                %>
                
                	<li <%=selectedT_idx==arr.get(i).getT_idx()?"class='myScheduleUnit_selected'":"class='myScheduleUnit'" %>>
                		<form action="todolist/editRangeofTodolist_ok.jsp">
                		<div>
                			<input type="checkbox" class="complete" value="<%=arr.get(i).getT_idx()%>" <%= (arr.get(i).getStatus()).equals("ud")?"":"checked"%>>
                			<span id="schedule_time"><%="("+hours+":"+mins+")" %></span><a href="private.jsp?viewOption=<%=viewOption%>&t_idx=<%=arr.get(i).getT_idx() %>&arr_idx=<%=i %>&year=<%=year %>&month=<%=month %>&date=<%=date %>" id="schedule_a">
                				<span><%=content %></span>
                			</a>
		                    <span id="memo_span"><%= arr.get(i).getT_memo() %></span>
		                    <div id="shares_div">
		                    	<div <%= arr.get(i).getShares().equals("public")?"id='publicUnitBtn_selected'":"id='publicUnitBtn'" %>>
		                    		<a href="todolist/editRangeofTodolist_ok.jsp?viewOption=<%=viewOption %>&t_idx=<%=arr.get(i).getT_idx()%>&shares=public&year=<%=year%>&month=<%=month%>&day=<%=date%>">공개</a>
		                    	</div>
		                    	<div <%= arr.get(i).getShares().equals("private")?"id='privateUnitBtn_selected'":"id='privateUnitBtn'" %>>
		                    		<a href="todolist/editRangeofTodolist_ok.jsp?viewOption=<%=viewOption %>&t_idx=<%=arr.get(i).getT_idx()%>&shares=private&year=<%=year%>&month=<%=month%>&day=<%=date%>">비공개</a>
		                    	</div>
		                    	<div <%= arr.get(i).getShares().equals("group")?"id='groupUnitBtn_selected'":"id='groupUnitBtn'" %>>
		                    		<a href="todolist/editRangeofTodolist_ok.jsp?viewOption=<%=viewOption %>&t_idx=<%=arr.get(i).getT_idx()%>&shares=group&year=<%=year%>&month=<%=month%>&day=<%=date%>">그룹</a>
		                    	</div>
		                    </div>
		                    <% if(arr.get(i).getShares().equals("group")){
		                    	%>
		                    	<div class="groupList_div">
			                    	<select id="group" name="g_idx" multiple size="1">
		                       		 <%
		                       		 ArrayList<GroupsDTO> g_arr=gdao.myGroups(idx);
		                       		 ArrayList<GroupsDTO> tgroup=tdao.groupsofTodolist(arr.get(i).getT_idx());
		                       		 
		                       		 if(g_arr!=null){
		                       			 for(int j=0;j<g_arr.size();j++){
											String selected="";
											for(int k=0;k<(tgroup!=null?tgroup.size():0);k++){
												if(g_arr.get(j).getG_idx()==tgroup.get(k).getG_idx()){
													selected="selected";
												}
											}
		                       			 %>
		                       			 <option value="<%=g_arr.get(j).getG_idx()%>" <%=selected %>><%=g_arr.get(j).getG_name() %></option>
		                       			 <%
		                       			 }
		                       		 }
		                       		 %>
		                        	</select>
		                        	<input type="hidden" name="t_idx" value="<%=arr.get(i).getT_idx()%>">
		                        	<input type="hidden" name="shares" value="group">
		                        	<input type="hidden" name="viewOption" value="<%=viewOption %>">
		                        	<input type="hidden" name="year" value="<%=year%>">
		                        	<input type="hidden" name="month" value="<%=month%>">
		                        	<input type="hidden" name="day" value="<%=date%>">
		                        	
		                        	<input type="submit" value="변경" class="groupListChangeBtn">
		                    	</div>
		                    	<%
		                    } else {
		                    	%>
		                    	<div class="groupList_div_disabled">
			                    	<select id="group" name="g_idx" multiple size="1" disabled>
		                       		 <%
		                       		 ArrayList<GroupsDTO> g_arr=gdao.myGroups(idx);
		                       		 ArrayList<GroupsDTO> tgroup=tdao.groupsofTodolist(arr.get(i).getT_idx());
		                       		 
		                       		 if(g_arr!=null){
		                       			 for(int j=0;j<g_arr.size();j++){
											String selected="";
											for(int k=0;k<(tgroup!=null?tgroup.size():0);k++){
												if(g_arr.get(j).getG_idx()==tgroup.get(k).getG_idx()){
													selected="selected";
												}
											}
		                       			 %>
		                       			 <option value="<%=g_arr.get(j).getG_idx()%>" <%=selected %>><%=g_arr.get(j).getG_name() %></option>
		                       			 <%
		                       			 }
		                       		 }
		                       		 %>
		                        	</select>
		                        	<input type="submit" value="변경" class="groupListChangeBtn" disabled>
		                    	</div>
		                    	
		                    	<%
		                    }
		                    
		                    %>
		                    <a href="todolist/deleteTodolist_ok.jsp?viewOption=<%=viewOption %>&t_idx=<%=arr.get(i).getT_idx()%>&year=<%=year %>&month=<%=month %>&day=<%=date %>" id="deleteUnitBtn_a">×</a>
                		</div>
	                	</form>
                    </li>
                
                <%
                }
                %>
                
                </ul>
                
            </div>
    	
		<%} else if (mdMode.equals("monthly")) {
			int prevYear = year;
			int prevMonth = month - 1;
			if (prevMonth < 1) {
			    prevMonth = 12;
			    prevYear--;
			}

			int nextYear = year;
			int nextMonth = month + 1;
			if (nextMonth > 12) {
			    nextMonth = 1;
			    nextYear++;
			}
			%>
			<div class="dateHeader">
    			<div id="mORd">
    				<a href="/codeEffluve/private.jsp?mdMode=daily" style="margin:0px !important;box-sizing: border-box;"><button <%=mdMode.equals("daily")?"class='dailyBtnSelected'":"class='dailyBtn'" %> id="dailyBtn">일별보기</button></a>
    				<a href="/codeEffluve/private.jsp?mdMode=monthly" style="margin:0px !important;"><button <%=mdMode.equals("monthly")?"class='monthlyBtnSelected'":"class='monthlyBtn'" %> id="monthlyBtn">월별보기<img src="/codeEffluve/img/calendar_mini.png" alt="날짜선택" style="width:16px;height:16px;"></button></a>
    			</div>
		        <h2>
		            <a href="private.jsp?mdMode=monthly&year=<%=prevYear%>&month=<%=prevMonth%>">◀</a>
		            <%=year %>년 <%=month %>월
		        	<a href="private.jsp?mdMode=monthly&year=<%=nextYear%>&month=<%=nextMonth%>">▶</a>
		        </h2>
		        
    		</div>
			<div class="myscheduleMonthly">

					<table id="monthlyTable">
						<thead>
							<tr>
								<th>SUN</th>
								<th>MON</th>
								<th>TUE</th>
								<th>WED</th>
								<th>THU</th>
								<th>FRI</th>
								<th>SAT</th>
							</tr>
						</thead>
						<tbody>
							<%
							Calendar realToday = Calendar.getInstance();
							int todayYear = realToday.get(Calendar.YEAR);
							int todayMonth = realToday.get(Calendar.MONTH) + 1;
							int todayDate = realToday.get(Calendar.DATE);
							int calYear = year;
							int calMonth = month;
							Calendar cal = Calendar.getInstance();
							cal.set(calYear, calMonth-1, 1);
							int firstDay = cal.get(Calendar.DAY_OF_WEEK);  // 1일이 무슨 요일인지
							int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 이번달 며칠까지 있는지
							int dayNum = 1;
							int x = (firstDay-1+lastDay)%7 == 0 ? 0 : 1;
							int weeks = (firstDay-1+lastDay)/7 + x;
							for (int week = 0; week < weeks; week++) {
							%>
							<tr style="height: <%=100/weeks %>%;">
								<%
								for (int dow = 1; dow <= 7; dow++) {
									int cellNum = week * 7 + dow;
									if (cellNum<firstDay || dayNum>lastDay) {
										%>
										<td style="background-color:#E7E1E4;">&nbsp;</td>
										<%
									} else {
										boolean isToday = (dayNum==todayDate && calMonth==todayMonth && calYear==todayYear);
										
										%>
										<td <%=isToday ? "class='todayCell'" : ""%>>
											<div>
											<a href="/codeEffluve/private.jsp?mdMode=daily&year=<%=calYear %>&month=<%=calMonth %>&date=<%=dayNum %>" id="dayNumA"><%=dayNum%></a>
											<ul>
											<%
											String getCelldate=year+"-"+(month<10?"0"+month:month)+"-"+(dayNum<10?"0"+dayNum:dayNum);
								            ArrayList<TodolistDTO> cellArr=tdao.showTodolist(idx,getCelldate);
								            for(int j = 0; j<cellArr.size(); j++) {
											%>
												<li>
												<%
												String hours = cellArr.get(j).getT_time().getHours()<10?"0"+cellArr.get(j).getT_time().getHours():""+cellArr.get(j).getT_time().getHours();
							                	String mins = cellArr.get(j).getT_time().getMinutes()<10?"0"+cellArr.get(j).getT_time().getMinutes():""+cellArr.get(j).getT_time().getMinutes();
												%>
												<span style="font-size: 12px; color:#444444; font-weight:450;"><%=hours+":"+mins%></span>
												<a <%=(cellArr.get(j).getStatus()).equals("d")?"style='color:#999999; text-decoration: line-through !important;'":"style='color:black;'"%> href="/codeEffluve/private.jsp?mdMode=monthly&t_idx=<%=cellArr.get(j).getT_idx() %>&year=<%=calYear %>&month=<%=calMonth %>&date=<%=dayNum %>&arr_idx=<%=j%>">
                									<%=cellArr.get(j).getContent() %>
                								</a>
												</li>
											<%} %>
											</ul>
											</div>
										</td>
										<%
										dayNum++;
									}
								}
								%>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				<%
				}
				%>
        </div>
        <div class="right-column">
            
            <div class="add-schedule">
                <%
                if (request.getParameter("arr_idx") == null) {
                %>
                <form name="newschedule" action="todolist/addschedule_ok.jsp">
                	<div class="h3Div">
                		<h3>일정 추가</h3>
                		<div class="form-buttons">
                        	<input type="hidden" name="year" value="<%=year%>">
                        	<input type="hidden" name="month" value="<%=month%>">
                        	<input type="hidden" name="day" value="<%=date%>">
                            <input type="submit" value="등록하기">
                            <input type="reset" value="초기화">
                        </div>
                	</div>
                    
                    
                    	<input type="hidden" name="m_idx" value="<%=idx%>">
                    	<table class="scheduleAddTable">
                    		<tr>
                    			<th>일정 이름</th>
                    			<td><input type="text" name="content" required></td>
                    		</tr>
                    		<tr>
                    			<th>시작 날짜</th>
                    			<td>
                    				<div style="display: flex; flex-direction: row;">
	                    				<input type="date" name="date" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>" required>
	                        			<input type="time" name="time" value="<%=currentTime%>" required>
                        			</div>
                        		</td>
                    		</tr>
                    		<tr>
                    			<th>메모</th>
                    			<td><textarea name="t_memo"></textarea></td>
                    		</tr>
                    		<tr>
                    			<th>공개범위</th>
                    			<td style="display:flex; flex-direction: row;">
                    				<input type="radio" name="shares" value="public" id="pubRadio">전체공개
			                        <input type="radio" name="shares" value="private" id="priRadio" checked>비공개
			                        <input type="radio" name="shares" value="group" id="groRadio">그룹공개
			                        <div style="display:flex; flex-direction: row;">
			                        	<select id="groupSel" name="g_idx" multiple size="1" disabled>
			                       		 <%
			                       		ArrayList<GroupsDTO> g_arr=gdao.myGroups(idx);
			                        		 
			                        		 if(g_arr!=null){
			                        			 for(int j=0;j<g_arr.size();j++){
			                        			 %>
			                        			 <option value="<%=g_arr.get(j).getG_idx()%>"><%=g_arr.get(j).getG_name() %></option>
			                        			 <%
			                        			 }
			                        		 }
			                       		 %>
			                        	</select>
			                        	<input type="button" id="creategroup" value="그룹생성" disabled>
			                        </div>
			                        
                    			</td>
                    		</tr>
                    	</table>
                        
                        
                        
                       		 
                        	
                        
                    </form>
                    <%}else{
                    	
                    	int arr_idx=Integer.parseInt(request.getParameter("arr_idx"));
                    	year=arr.get(arr_idx).getT_time().getYear()+1900;
                    	month=arr.get(arr_idx).getT_time().getMonth()+1;
                    	date=arr.get(arr_idx).getT_time().getDate();
                    	int hours=arr.get(arr_idx).getT_time().getHours();
                    	int minutes=arr.get(arr_idx).getT_time().getMinutes();
                    	currentTime=""+(hours<10?"0"+hours:hours)+":"+(minutes<10?"0"+minutes:minutes);
                    	String option=arr.get(arr_idx).getShares();
                    	ArrayList<GroupsDTO> g_arr=gdao.myGroups(idx);
                  		ArrayList<GroupsDTO> tgroup=tdao.groupsofTodolist(arr.get(arr_idx).getT_idx());
                    	%>
                    	<form name="editschedule" action="todolist/editschedule_ok.jsp">
                    	<div class="h3Div">
                    		<h3>일정 수정</h3>
                    		 <div>
                    		 	<a href="todolist/deleteTodolist_ok.jsp?mdMode=<%=mdMode%>&viewOption=<%=viewOption %>&t_idx=<%=arr.get(arr_idx).getT_idx()%>&year=<%=year %>&month=<%=month %>&day=<%=date %>"><input type="button" value="삭제"></a>
                                <input type="submit" value="수정">
                                <input type="reset" value="초기화">
                                <a href="private.jsp?mdMode=<%=mdMode%>&viewOption=<%=viewOption %>&year=<%=year %>&month=<%=month %>&date=<%=date %>"><input type="button" value="취소"></a>
                            </div>
                    	</div>
                    	
                        
                        	<input type="hidden" name="t_idx" value="<%=arr.get(arr_idx).getT_idx()%>">
                            <table class="scheduleAddTable">
                            	<tr>
	                    			<th>일정 이름</th>
	                    			<td><input type="text" name="content" value="<%=arr.get(arr_idx).getContent()%>"></td>
	                    		</tr>
	                    		<tr>
	                    			<th>시작 날짜</th>
	                    			<td>
	                    				<div style="display: flex; flex-direction: row;">
	                    					<input type="date" name="date" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
	                        				<input type="time" name="time" value="<%=currentTime%>">
	                    				</div>
	                    				
	                        		</td>
	                    		</tr>
	                    		<tr>
	                    			<th>메모</th>
	                    			<td><textarea name="t_memo"><%=arr.get(arr_idx).getT_memo()%></textarea></td>
	                    		</tr>
	                    		<tr>
	                    			<th>공개 여부</th>
	                    			<td style="display:flex; flex-direction: row;">
	                    				<input type="radio" name="shares" value="public" id="pubRadio" <%=option.equals("public")?"checked":"" %>>전체공개
						                <input type="radio" name="shares" value="private" id="priRadio" <%=option.equals("private")?"checked":"" %>>비공개
						                <input type="radio" name="shares" value="group" id="groRadio" <%=option.equals("group")?"checked":"" %>>그룹공개
						                <div style="display:flex; flex-direction: row;">
						                	<select id="groupSel" name="g_idx" multiple size="1"  <%=option.equals("group")?"":"disabled" %> <%=option.equals("group")?"checked":"" %>>
				                       		 <%
				                       		
				                       		 if(g_arr!=null){
				                       			 for(int j=0;j<g_arr.size();j++){
													String selected="";
													for(int k=0;k<(tgroup!=null?tgroup.size():0);k++){
														if(g_arr.get(j).getG_idx()==tgroup.get(k).getG_idx()){
															selected="selected";
														}
													}
				                       			 %>
				                       			 <option value="<%=g_arr.get(j).getG_idx()%>" <%=selected %>><%=g_arr.get(j).getG_name() %></option>
				                       			 <%
				                       			 }
				                       		 }
				                       		 %>
				                        	</select>
				                        	<input type="button" id="creategroup" value="그룹생성" <%=option.equals("group")?"":"disabled" %>>
						                </div>
			                            
	                    			</td>
	                    		</tr>
                            </table>
                            
                            
                        	<input type="hidden" name="year" value="<%=year%>">
                        	<input type="hidden" name="month" value="<%=month%>">
                        	<input type="hidden" name="day" value="<%=date%>">
                        	<input type="hidden" name="viewOption" value="<%=viewOption%>">
                        	<input type="hidden" name="mdMode" value="<%=mdMode%>">
                            
                        </form>
                        <%
                    }%>
            </div>
            <article class="comments">
				<h3>댓글</h3>
				<div id="commentList">
					<ul>
					<%
					
					ArrayList<CommentsDTO> cdtoLists =cdao.getComments(selectedT_idx);
					String arr_idx = request.getParameter("arr_idx");
					if(cdtoLists==null || cdtoLists.size()==0) {
						
					} else {
						SimpleDateFormat tf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
						for(CommentsDTO temp:cdtoLists) {
							String profileStr = mdao.getProfilePath(temp.getM_idx());
							String profilePath = request.getContextPath() + "/membersProfiles/" + profileStr;
							id = mdao.getIdStr(temp.getM_idx());
							String message = temp.getMessage();
							Timestamp c_time = temp.getC_time();
							String timeStr = (c_time != null) ? tf.format(c_time) : "";
							
							%>
							
								<li id="privateListCommentUnit">
									<div id="profile_id_time">
										<img src="<%=profilePath %>" alt="사진" id="commentProfile">
										<span id="commentId"><%=id%></span>
										<a href="/codeEffluve/comments/deleteComment_ok(private).jsp?viewOption=<%=viewOption%>&arr_idx=<%=arr_idx %>&t_idx=<%=selectedT_idx %>&c_idx=<%=temp.getC_idx() %>" class="delComment">×</a>
									</div>
									<div class="commentRow">
										<span id="commentMessage"><%=message%></span>
										<span id="commentTime"><%=timeStr%></span>
									</div>

								</li>
							<%
						}
					}
					%>
					</ul>
				</div>
				
				<!-- 댓글입력창 -->
				
				<div class="writeComment">
					<form action="/codeEffluve/comments/writeComment_ok(private).jsp">
						<img src="/codeEffluve/img/chat.png" alt="사진" style="width:20px; height: 20px; margin-right: 7px;">
						<span>댓글</span>
						<input type="text" name="message" <%=selectedT_idx==0?"class='disabledMessage' disabled":"" %>>
						<input type="hidden" name="id" value="<%=id%>">
						<input type="hidden" name="t_idx" value="<%=selectedT_idx%>">
						<input type="hidden" name="year" value="<%=year%>">
                       	<input type="hidden" name="month" value="<%=month%>">
                        <input type="hidden" name="day" value="<%=date%>">
                        <%
                       	arr_idx = request.getParameter("arr_idx");
                        %>
                        <input type="hidden" name="arr_idx" value="<%=arr_idx%>">
                        <input type="hidden" name="viewOption" value="<%=viewOption%>">
						<input type="submit" value="작성" <%=selectedT_idx==0?"class='disabledSubmit' disabled":"" %>>
					</form>
				</div>
				
			</article>
        </div>
	</section>
</main>
	<%@include file="footer.jsp" %>
</body>
<script>

/* 캘린더 버튼 눌렀을 때 날짜선택창 띄우는 거 */
var calendar = document.getElementById("calendar");
var calendarBtn = document.getElementById("calendarBtn");

calendarBtn.onclick = function() {
    if (calendar.showPicker) {
        calendar.showPicker();
    } else {
        calendar.focus();
    }
};

calendar.onchange = function() {
    const selectedDate = calendar.value;
    if (!selectedDate) return;

    const dateParts = selectedDate.split('-');
    const year = parseInt(dateParts[0], 10);
    const month = parseInt(dateParts[1], 10);
    const date = parseInt(dateParts[2], 10);
    window.location.href =
        "private.jsp?viewOption=<%=viewOption%>&year=" + year + "&month=" + month + "&date=" + date;
};

var pubRadio = document.getElementById("pubRadio");
var priRadio = document.getElementById("priRadio");
var groRadio = document.getElementById("groRadio");
var groupSel = document.getElementById("groupSel");
var creategroup=document.getElementById("creategroup");

pubRadio.onclick = function () {
	if(groRadio.checked==false) {
		groupSel.disabled=true;
		creategroup.disabled=true;
	}
};
priRadio.onclick = function () {
	if(groRadio.checked==false) {
		groupSel.disabled=true;
		creategroup.disabled=true;
	}
};
groRadio.onclick = function () {
	if(groRadio.checked==false) {
		groupSel.disabled=true;
		creategroup.disabled=true;
	} else {
		groupSel.disabled=false;
		creategroup.disabled=false;
	}
};
creategroup.onclick=function(){
	window.open("group/creategroup.jsp?m_idx=<%=idx%>","create","width=400px, height=500px");
};


var complete = document.getElementsByClassName("complete");
for (var i = 0; i < complete.length; i++) {
	complete[i].onclick = function() {
		if (this.checked) {
			location.href = "/codeEffluve/todolist/doneTodolist_ok.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&viewOption=<%=viewOption%>&t_idx="+ this.value;
		} else {
			location.href = "/codeEffluve/todolist/undoneTodolist_ok.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&viewOption=<%=viewOption%>&t_idx="+ this.value;
		}
	};
}

var myscheduleOption = document.getElementById("myscheduleOption");
myscheduleOption.onchange = function() {
	var viewoption = document.fm.viewOption.value;
	location.href='/codeEffluve/private.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&viewOption='+viewoption;
}
</script>
</html>