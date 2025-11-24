<%@page import="java.security.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.codeEffluve.todolist.TodolistDTO" %>
<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
main {
    margin: 0 auto;
}
.header {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}
#schedule {
    display: flex;
    gap: 20px;
    justify-content: space-between;
}
.myschedule {
    flex: 2; 
}
.right-column {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 20px;
}
.add-schedule {
    flex-grow: 1;
}
.comments {
    flex-grow: 0; 
}
.comments fieldset > div { 
    display: block;
}
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
    <div class="header">
        <h2>
            <a href="private.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>&day=이전날"><<</a>
            <%=year %>년 <%=month %>월 <%=date %>일 <%=day %>요일
            <a href="private.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>&day=다음날">>></a>
        </h2>
        <div>
            <input type="date" id="calendar" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
        </div>    
    </div>
    
    <section id="schedule">
        
        <div class="myschedule">
            
            <fieldset>
                
                <% 
                String dbdate=year+"-"+(month<10?"0"+month:month)+"-"+(date<10?"0"+date:date);
                int idx=tdao.returnM_idx(id);
                ArrayList<TodolistDTO> arr=tdao.showTodolist(idx,dbdate);
                for(int i=0;i<(arr==null?0:arr.size());i++){
                	%>
                	<table>
                    <tr>
                    	<td><a href="private.jsp?arr_idx=<%=i %>&year=<%=year %>&month=<%=month %>&date=<%=date %>"><%= arr.get(i).getContent()+"("+arr.get(i).getT_time().getHours()+":"+arr.get(i).getT_time().getMinutes()+")"%></a></td>
                        <td><%= arr.get(i).getT_memo() %></td>
                        <td>공개범위:<%= arr.get(i).getShares() %></td>
                        <td>그룹</td>
                        <td><a href="todolist/deleteTodolist_ok.jsp?t_idx=<%=arr.get(i).getT_idx()%>">삭제</a></td>
                    </tr>
                </table>
                <%
                }%>
                
            </fieldset>
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
                        <select id="group" name="group" disabled>
                            <option>그룹선택</option>
                        </select>
                        <div class="form-buttons">
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
                            <option value="private">비공개</option>
                            <option value="group">그룹공개</option>
                            <option value="public">전체공개</option>
                        	</select>
                       		 <select id="group" name="group" disabled>
                            <option>그룹선택</option>
                            <option>그룹1</option>
                            <option>그룹2</option>
                            <option>그룹3</option>
                            <option>그룹4</option>
                            <option>그룹5</option>
                        	</select>
                        	<input type="button" id="creategroup" value="그룹만들기" disabled>
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
            
            <div class="comments">
                <fieldset>
                    <h3>댓글</h3>
                    <div>
                        <input type="text" placeholder="댓글 입력">
                        <button>등록</button>
                    </div>
                </fieldset>
            </div>
            
        </div>
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
</script>
</html>