
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
    <div class="dateHeader">
        <h2>
            <a href="private.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>&day=이전날">◀</a>
            <%=year %>년 <%=month %>월 <%=date %>일 (<%=day %>)
            
            <input type="date" id="calendar" class="calendar-input" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
    		<button type="button" id="calendarBtn" class="calendar-btn"><img src="/codeEffluve/img/calendar.png" alt="날짜선택"></button>
        	<a href="private.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>&day=다음날">▶</a>
        </h2>
    </div>
    
    <section id="schedule">
        
        <div class="myschedule">
                
                <% 
                String dbdate=year+"-"+(month<10?"0"+month:month)+"-"+(date<10?"0"+date:date);
                int idx=tdao.returnM_idx(id);
                ArrayList<TodolistDTO> arr=tdao.showTodolist(idx,dbdate);
                %>
                <ul>
                
                <%
                for(int i=0;i<(arr==null?0:arr.size());i++){
                %>
                <form action="todolist/editRangeofTodolist_ok.jsp">
                	<li>
                		<div class="myScheduleUnit">
                			<input type="checkbox" id="complete">
                			<a href="private.jsp?t_idx=<%=arr.get(i).getT_idx() %>&arr_idx=<%=i %>&year=<%=year %>&month=<%=month %>&date=<%=date %>" id="schedule_a"><%= arr.get(i).getContent()+"("+arr.get(i).getT_time().getHours()+":"+arr.get(i).getT_time().getMinutes()+")"%></a>
		                    <span id="memo_span"><%= arr.get(i).getT_memo() %></span>
		                    <div id="shares_div">
		                    	<div <%= arr.get(i).getShares().equals("public")?"id='publicUnitBtn_selected'":"id='publicUnitBtn'" %>>
		                    		<a href="todolist/editRangeofTodolist_ok.jsp?t_idx=<%=arr.get(i).getT_idx()%>&shares=public&year=<%=year%>&month=<%=month%>&day=<%=date%>">공개</a>
		                    	</div>
		                    	<div <%= arr.get(i).getShares().equals("private")?"id='privateUnitBtn_selected'":"id='privateUnitBtn'" %>>
		                    		<a href="todolist/editRangeofTodolist_ok.jsp?t_idx=<%=arr.get(i).getT_idx()%>&shares=private&year=<%=year%>&month=<%=month%>&day=<%=date%>">비공개</a>
		                    	</div>
		                    	<div <%= arr.get(i).getShares().equals("group")?"id='groupUnitBtn_selected'":"id='groupUnitBtn'" %>>
		                    		<a href="todolist/editRangeofTodolist_ok.jsp?t_idx=<%=arr.get(i).getT_idx()%>&shares=group&year=<%=year%>&month=<%=month%>&day=<%=date%>">그룹</a>
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
		                        	<input type="submit" value="변경">
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
		                        	<input type="submit" value="변경" disabled>
		                    	</div>
		                    	
		                    	<%
		                    }
		                    
		                    %>
		                    <a href="todolist/deleteTodolist_ok.jsp?t_idx=<%=arr.get(i).getT_idx()%>&year=<%=year %>&month=<%=month %>&day=<%=date %>" id="deleteUnitBtn_a">×</a>
                		</div>
	                	
                    </li>
                </form>
                <%
                }
                %>
                
                </ul>
            </div>
        
        <div class="right-column">
            
            <div class="add-schedule">
                <fieldset>
                <%if(request.getParameter("arr_idx")==null){ %>
                    <h3>일정 추가</h3>
                    <form name="newschedule" action="todolist/addschedule_ok.jsp">
                    	<input type="hidden" name="m_idx" value="<%=idx%>">
                        <label>일정 이름</label>
                        <input type="text" name="content"><br>
                        
                        <label>시작 날짜</label>
                        <br>
                        
                 		<input type="date" name="date" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
                        <input type="time" name="time" value="<%=currentTime%>"><br>

                        <br>
                        
                        <label>메모</label>
                        <textarea name="t_memo"></textarea><br>
                        
                        <select id="range" name="shares">
                            <option value="private">비공개</option>
                            <option value="group">그룹공개</option>
                            <option value="public">전체공개</option>
                        	</select>
                       		 <select id="group" name="g_idx" multiple size="1" disabled>
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
                        	<input type="button" id="creategroup" value="그룹만들기" disabled>
                        <div class="form-buttons">
                        	<input type="hidden" name="year" value="<%=year%>">
                        	<input type="hidden" name="month" value="<%=month%>">
                        	<input type="hidden" name="day" value="<%=date%>">
                            <input type="submit" value="등록하기">
                            <input type="reset" value="초기화">
                        </div>
                    </form>
                    <%}else{
                    	
                    	int arr_idx=Integer.parseInt(request.getParameter("arr_idx"));
                    	year=arr.get(arr_idx).getT_time().getYear()+1900;
                    	month=arr.get(arr_idx).getT_time().getMonth()+1;
                    	date=arr.get(arr_idx).getT_time().getDate();
                    	int hours=arr.get(arr_idx).getT_time().getHours();
                    	int minutes=arr.get(arr_idx).getT_time().getMinutes();
                    	currentTime=""+(hours<10?"0"+hours:hours)+":"+(minutes<10?"0"+minutes:minutes);
                    	%>
                    	<h3>일정 수정</h3>
                        <form name="editschedule" action="todolist/editschedule_ok.jsp">
                        	<input type="hidden" name="t_idx" value="<%=arr.get(arr_idx).getT_idx()%>">
                            <label>일정 이름</label>
                            <input type="text" name="content" value="<%=arr.get(arr_idx).getContent()%>"><br>
                            
                            <label>시작 날짜</label>
                            <br>
                            
                     		<input type="date" name="date" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
                            <input type="time" name="time" value="<%=currentTime%>"><br>

                            <br>
                            
                            <label>메모</label>
                            <textarea name="t_memo"><%=arr.get(arr_idx).getT_memo()%></textarea><br>
                            <select id="range" name="shares">
                            <%
                            String option=arr.get(arr_idx).getShares();
                            ArrayList<GroupsDTO> g_arr=gdao.myGroups(idx);
                      		 ArrayList<GroupsDTO> tgroup=tdao.groupsofTodolist(arr.get(arr_idx).getT_idx());
                            switch(option){
                            case "private":%>
                            <option value="private" selected>비공개</option>
                            <option value="group">그룹공개</option>
                            <option value="public">전체공개</option>
                            </select>
                       		 <select id="group" name="g_idx" multiple size="1" disabled>
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
                        	<input type="button" id="creategroup" value="그룹만들기" disabled>
                            <%break;
                            case "group":%>
                            <option value="private">비공개</option>
                            <option value="group" selected>그룹공개</option>
                            <option value="public">전체공개</option>
                            </select>
                       		 <select id="group" name="g_idx" multiple size="1">
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
                        	<input type="button" id="creategroup" value="그룹만들기">
                            <%break;
                            case "public":%>
                            <option value="private">비공개</option>
                            <option value="group">그룹공개</option>
                            <option value="public" selected>전체공개</option>
                            </select>
                       		 <select id="group" name="g_idx" multiple size="1" disabled>
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
							<input type="button" id="creategroup" value="그룹만들기" disabled>
                            <%break;
                            }
                            %>
                        	<input type="hidden" name="year" value="<%=year%>">
                        	<input type="hidden" name="month" value="<%=month%>">
                        	<input type="hidden" name="day" value="<%=date%>">
                        	
                            <div>
                                <input type="submit" value="수정하기">
                                <input type="reset" value="초기화">
                                <a href="private.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>"><input type="button" value="취소"></a>
                            </div>
                        </form>
                        <%
                    }%>
                </fieldset>
            </div>
            <%
            if(request.getParameter("t_idx")!=null){
            %>
            <article class="comments">
				<h2>댓글</h2>
				<div id="commentList">
					<ul>
					<%
					int selectedT_idx = request.getParameter("t_idx")!=null?Integer.parseInt(request.getParameter("t_idx")):0;
					ArrayList<CommentsDTO> cdtoLists =cdao.getComments(selectedT_idx);
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
					<form action="/codeEffluve/comments/writeComment_ok(private).jsp">
						<img src="/codeEffluve/img/chat.png" alt="사진" style="width:30px; height: 30px; margin-right: 7px;">
						<span>댓글</span>
						<input type="text" name="message">
						<input type="hidden" name="id" value="<%=id%>">
						<input type="hidden" name="t_idx" value="<%=selectedT_idx%>">
						<input type="hidden" name="year" value="<%=year%>">
                       	<input type="hidden" name="month" value="<%=month%>">
                        <input type="hidden" name="day" value="<%=date%>">
						<input type="submit" value="작성">
					</form>
				</div>
				
			</article>
            <%} %>
        </div>
	</section>
</main>
	<%@include file="footer.jsp" %>
</body>
<script>

var calendar = document.getElementById("calendar");
var calendarBtn = document.getElementById("calendarBtn");

// 📅 버튼 클릭하면 브라우저 기본 날짜 선택창 띄우기
calendarBtn.onclick = function() {
    if (calendar.showPicker) {   // 크롬/엣지 등 최신 브라우저
        calendar.showPicker();
    } else {
        // 혹시 showPicker 없으면 포커스만이라도
        calendar.focus();
    }
};

// 날짜 선택 후 페이지 이동
calendar.onchange = function() {
    const selectedDate = calendar.value;
    if (!selectedDate) return;

    const dateParts = selectedDate.split('-');
    const year = parseInt(dateParts[0], 10);
    const month = parseInt(dateParts[1], 10);
    const date = parseInt(dateParts[2], 10);
    window.location.href =
        "private.jsp?year=" + year + "&month=" + month + "&date=" + date;
};
/*
var calendar=document.getElementById("calendar")
calendar.onchange=function(){
    const selectedDate = calendar.value; 
    const dateParts = selectedDate.split('-');
    const year = parseInt(dateParts[0]);
    const month = parseInt(dateParts[1]); 
    const date = parseInt(dateParts[2]);
    window.location.href = "private.jsp?year=" + year + "&month=" + month + "&date=" + date;
}
*/

var select=document.getElementById("range");
var group=document.getElementById("group");
var creategroup=document.getElementById("creategroup");
select.onchange=function(){
	const selectedrange=select.value;
	if(selectedrange==="group"){
		group.removeAttribute('disabled');
		creategroup.removeAttribute('disabled');
	}else{
		group.setAttribute('disabled','disabled');
		creategroup.setAttribute('disabled','disabled');
	}
}
creategroup.onclick=function(){
	window.open("group/creategroup.jsp?m_idx=<%=idx%>","create","width=400px, height=500px");
}
</script>
</html>