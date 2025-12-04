<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
<%@ page import="com.codeEffluve.frapprove.FrapproveDTO" %>

<jsp:useBean id="fdao" class="com.codeEffluve.friending.FriendingDAO"></jsp:useBean>
<jsp:useBean id="frdao" class="com.codeEffluve.frapprove.FrapproveDAO"></jsp:useBean>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
	body {
		padding-left: 20px !important;
		padding-right: 20px !important;
	}
</style>
</head>
<%
int m_idx=Integer.parseInt(request.getParameter("m_idx"));
%>
<body>
	<div id="approveFriendDiv">
		<h2>받은 친구 신청</h2>
		<table id="frapproveTable">
			<thead>
				<tr>
					<th>번호</th>
					<th>프로필</th>
					<th>아이디</th>
					<th>수락</th>
				</tr>
			</thead>
			<tbody>
				<%
				ArrayList<FrapproveDTO> frdtoList = frdao.selectApproval(m_idx);
				if(frdtoList==null || frdtoList.size()==0) {
					
				} else {
					for(int i=0; i<frdtoList.size(); i++) {
						int applicantIdx = frdtoList.get(i).getApplicant();
						%>
						<tr>
							<td><%=i+1 %></td>
							<td><img src="/codeEffluve/membersProfiles/<%=mdao.getProfilePath(applicantIdx) %>"></td>
							<td><%=mdao.getIdStr(applicantIdx) %></td>
							<td>
								<div id="frapproveBtnsDiv">
									<form action="approveFriend_ok.jsp">
										<input type="hidden" name="approver" value="<%=m_idx%>">
										<button type="submit" name="applicant" value="<%=applicantIdx%>">수락</button>
									</form>
									<form action="disapprove_ok.jsp">
										<input type="hidden" name="approver" value="<%=m_idx%>">
										<button type="submit" name="applicant" value="<%=applicantIdx%>">거절</button>
									</form>
								</div>
							</td>
						</tr>
						<%
					}
					
				}
				%>
				<tr>
					
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>