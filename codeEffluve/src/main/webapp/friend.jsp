<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>
<jsp:useBean id="chdao" class="com.codeEffluve.chat.ChatDAO"></jsp:useBean>
<jsp:useBean id="fdao" class="com.codeEffluve.friending.FriendingDAO"></jsp:useBean>
<jsp:useBean id="fadao" class="com.codeEffluve.frapprove.FrapproveDAO"></jsp:useBean>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.codeEffluve.chat.ChatDTO" %>

<!DOCTYPE html>

<%
String sid = "";
int sidx = 0;
if(session.getAttribute("sid")==null || session.getAttribute("sid").equals("")) {
	%>
	<script>
	window.alert("로그인 후 이용하실 수 있습니다.");
	window.location.href="index.jsp";
	</script>
	<%
	return;
} else {
	sid = (String)session.getAttribute("sid");
	sidx = mdao.getMemberMidx(sid);
}

int sf = 0;
String sfid = "";
String profilePath = "";
if(request.getParameter("sf")==null || request.getParameter("sf").equals("")) {
	sf = 0;
} else {
	sf = Integer.parseInt(request.getParameter("sf"));
	sfid = mdao.getIdStr(sf);
	profilePath = mdao.getProfilePath(sf);
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
		<section id="friend">
			<article id="friendsArea">
				<h1>내 친구 목록</h1>
				<div id="friendsDiv">
					<div id="addFriendDiv">
						<button id="findFriend">친구찾기</button>
						<button id="approveFriend">받은신청</button>
					</div>
					<ul>
						<%
						ArrayList<Integer> friendsList = fdao.viewFriends(sidx);
						if (friendsList != null && !friendsList.isEmpty()) {
						    for (int i = 0; i < friendsList.size(); i++) {
						        int friendIdx = friendsList.get(i);
						        String friendId = mdao.getIdStr(friendIdx);
						        String friendProfile = mdao.getProfilePath(friendIdx);
						%>
						        <li>
							        <a href="/codeEffluve/friend.jsp?sf=<%=friendIdx%>">
							        	<img src="/codeEffluve/membersProfiles/<%=friendProfile%>" alt="프로필" id="friendProfile">
							        	<span><%=friendId %></span>
							        </a>
						        </li>
						<%
						    }
						} else {
						%>
						    <li>등록된 친구가 없습니다.</li>
						<%
						}
						%>
					</ul>
				</div>
			</article>
			<article id="chatArea">
				<div id="chatDiv">
					<h2>채팅</h2>
					<div id="messageDivv">
					
					<%
					if(sf!=0) {
						ArrayList<ChatDTO> chatList = chdao.getChatList(sidx, sf);
						if(chatList.size()!=0) {
						Timestamp ts_firstDay = chatList.get(0).getChattime();
						int chatyear_firstDay = ts_firstDay.getYear()+1900;
						int chatmonth_firstDay = ts_firstDay.getMonth()+1;
						int chatdate_firstDay = ts_firstDay.getDate();
						int chatday_firstDay = ts_firstDay.getDay();
						String chatday_firstDay_s = "";
						switch(chatday_firstDay) {
						case 0: chatday_firstDay_s="일";break;
						case 1: chatday_firstDay_s="월";break;
						case 2: chatday_firstDay_s="화";break;
						case 3: chatday_firstDay_s="수";break;
						case 4: chatday_firstDay_s="목";break;
						case 5: chatday_firstDay_s="금";break;
						case 6: chatday_firstDay_s="토";break;
						}
						%>
							<h3><%=chatyear_firstDay%>년 <%=chatmonth_firstDay%>월 <%=chatdate_firstDay%>일 (<%=chatday_firstDay_s%>)</h3>
						<%
							for(int i=0; i<chatList.size(); i++) {
								Timestamp ts = chatList.get(i).getChattime();
								int chatyear = ts.getYear()+1900;
								int chatmonth = ts.getMonth()+1;
								int chatdate = ts.getDate();
								int chatday = ts.getDay();
								String chatday_s = "";
								switch(chatday) {
								case 0: chatday_s="일";break;
								case 1: chatday_s="월";break;
								case 2: chatday_s="화";break;
								case 3: chatday_s="수";break;
								case 4: chatday_s="목";break;
								case 5: chatday_s="금";break;
								case 6: chatday_s="토";break;
								}
								if(chatyear!=chatyear_firstDay || chatmonth!=chatmonth_firstDay || chatdate!=chatdate_firstDay) {
									chatyear_firstDay = chatyear;
									chatmonth_firstDay = chatmonth;
									chatdate_firstDay = chatdate;
									chatday_firstDay = chatday;
									%>
									<h3><%=chatyear%>년 <%=chatmonth%>월 <%=chatdate%>일 (<%=chatday_s%>)</h3>
									<%
								}
								String chathour=ts.getHours()>9?Integer.toString(ts.getHours()):"0"+ts.getHours();
								String chatmin=ts.getMinutes()>9?Integer.toString(ts.getMinutes()):"0"+ts.getMinutes();
								String message = chatList.get(i).getMessage();
								%>
								<div class="todayDiv">
									
									<ul>
										<%
										if(chatList.get(i).getSender()==sf) {
											%>
											<li class='leftChat'>
											<img src="/codeEffluve/membersProfiles/<%=profilePath %>" alt="프로필" class="chatingProfile">
											<span id="messageUnit"><%=message %></span>
											<span id="chattimeUnit"><%=chathour %>:<%=chatmin %></span>
											</li>
											<%
										} else {
											%>
											<li class='rightChat'>
											<span id="chattimeUnit"><%=chathour %>:<%=chatmin %></span>
											<span id="messageUnit"><%=message %></span>
											</li>
											<%
										}
										%>
									</ul>
								</div>
								<%
							}
						} else {
							%>새로운 대화를 시작해보세요!<%
						}
					} else {
						%>
						친구를 선택하세요
						<%
					}
					%>
					
					</div>
					<div id="writeChatDiv">
						<form action="/codeEffluve/chat/writeChat_ok.jsp">
							<img src="/codeEffluve/img/chat.png" alt="사진" style="width:30px; height: 30px; margin-right: 7px;">
							<span>채팅</span>
							<input type="text" name="message">
							<input type="hidden" name="sender" value="<%=sidx%>">
							<input type="hidden" name="receiver" value="<%=sf%>">
							<input type="submit" value="전송">
						</form>
					</div>
				</div>
				
			</article>
		</section>
	
	</main>
	
	<%@include file="footer.jsp" %>
</body>
<script>
window.addEventListener('load', function() {
    var messageDivv = document.getElementById('messageDivv');
    messageDivv.scrollTop = messageDivv.scrollHeight;
    
});

var findFriend = document.getElementById("findFriend");
var approveFriend = document.getElementById("approveFriend");
findFriend.onclick = function() {
	window.open('friend/findFriend.jsp?m_idx=<%=sidx%>','findFriend','width=400px, height=500px');
}
approveFriend.onclick = function() {
	window.open('friend/approveFriend.jsp?m_idx=<%=sidx%>','approveFriend','width=400px, height=500px');
}

</script>

</html>