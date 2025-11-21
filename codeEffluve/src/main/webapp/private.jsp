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
main {
    width: 1200px; /* 전체 너비 설정 (필요에 따라 조정) */
    margin: 0 auto; /* 중앙 정렬 */
}

/* 헤더 영역 스타일 */
.header {
    display: flex;
    justify-content: space-between; /* 날짜와 달력 선택을 양 끝으로 배치 */
    align-items: center;
    margin-bottom: 20px;
}

/* 2단 레이아웃을 위한 Flexbox 설정 */
#schedule {
    display: flex; /* Flexbox 활성화 */
    gap: 20px; /* 두 칼럼 사이의 간격 */
}

/* 좌측 칼럼 (일정 목록) */
.myschedule {
    flex: 2; /* 예를 들어 전체 너비의 약 60~65%를 차지하도록 설정 */
    min-width: 600px; /* 최소 너비 지정 */
}

/* 우측 칼럼 (일정 추가/댓글) */
#schedule-details {
    flex: 1; /* 나머지 공간 (약 35~40%)을 차지하도록 설정 */
    min-width: 350px; /* 최소 너비 지정 */
}

/* 개별 일정 항목 스타일 */
.schedule-item {
    display: flex;
    justify-content: space-between; /* 정보와 제어 영역을 양 끝으로 배치 */
    border: 1px solid black;
    padding: 10px;
    margin-bottom: 10px;
}

/* 일정 제어 영역 내부의 테이블 스타일 (rowspan 구현을 위해 사용) */
.control-table {
    border-collapse: collapse;
    height: 100%; /* 부모 높이만큼 확장 */
}
.control-table td {
    padding: 2px 5px;
    text-align: center;
    vertical-align: middle;
    border: 1px solid #ddd;
    font-size: 12px;
}

/* 버튼 및 셀렉트 박스 크기 조정 */
.control-table button, .control-table select {
    width: 100%;
    min-height: 25px;
    font-size: 12px;
    border: none;
}

/* 일정 추가/댓글 영역 스타일 */
.add-schedule-form, .comment-section {
    border: 1px solid black;
    padding: 15px;
    margin-bottom: 10px;
}

/* 메모장과 버튼 레이아웃 조정 */
#memo {
    width: 100%;
    height: 80px;
}
.form-buttons {
    display: flex;
    justify-content: flex-end; /* 버튼을 우측에 배치 */
    gap: 5px;
    margin-top: 10px;
}

</style>
<% 
String name=(String)session.getAttribute("sname");
if(name==null||name.equals("")){
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
        
        <div class="calendar-select-box">
            <input type="date" id="calendar" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
        </div>
    </div>
    
    <section id="schedule">
        
        <div class="myschedule">
            
            <fieldset class="schedule-item">
                <div class="schedule-info">
                    <input type="checkbox">
                    <span>학원 가기(9:00~)</span>
                </div>
                
                <table class="control-table">
                    <tr>
                        <td rowspan="3"><button class="btn public">공개</button></td>
                        <td rowspan="3"><button class="btn private">비공개</button></td>
                        <td>그룹</td>
                        <td rowspan="3"><button class="btn delete">x</button></td>
                    </tr>
                    <tr>
                        <td>그룹1</td>
                    </tr>
                    <tr>
                        <td>그룹2</td>
                    </tr>
                </table>
            </fieldset>
            </div>
        
        <div id="schedule-details">
            
            <fieldset class="add-schedule-form">
                <h3>일정 추가</h3>
                <form>
                    <label for="event-name">일정 이름</label>
                    <input type="text" id="event-name"><br>
                    
                    <label>시작 날짜</label>
                    <input type="checkbox" name="all-day">
                    <label>하루 종일</label><br>
                    
                    <input type="date" id="calendar2" value="<%=year%>-<%=month<10?"0"+month:month%>-<%=date<10?"0"+date:date%>">
                    <input type="text" value="시간 입력" size="4"><br>
                    
                    <label for="memo">메모</label>
                    <textarea id="memo"></textarea><br>
                    
                    <div class="form-buttons">
                        <button>등록하기</button>
                        <button>수정하기</button>
                        <button>초기화</button>
                    </div>
                </form>
            </fieldset>

            <fieldset class="comment-section">
                <h3>댓글</h3>
                <div class="comments-list">
                    <p>hong: ㅋㅋㅋㅋㅋ</p>
                    <p>hong: ㅋㅋㅋㅋㅋ</p>
                    </div>
                <div class="comment-input-area">
                    <input type="text" placeholder="댓글 입력">
                    <button>등록</button>
                </div>
            </fieldset>
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
</script>
</html>