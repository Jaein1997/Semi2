<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*"%>
 <%@ page import="com.codeEffluve.admin.*" %>
 <jsp:useBean id="adminDao" class="com.codeEffluve.admin.adminDAO" scope="session" />
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<style>
.delete-btn {
	  padding: 6px 12px;
    background-color: rgb(109, 16, 68);
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 13px;
}

</style>
<section>
<h2 style="text-align:center;">회원 관리</h2>
<table class = "adminTable">
	<tr>
	<th>번호</th>
	<th>아이디</th>
	<th>이름</th>
	<th>성별</th>
	<th>생일</th>
	<th>전화번호</th>
	<th>프로필</th>
	<th>삭제</th>
	</tr>
	
<%
	ArrayList<adminDTO> arr = adminDao.getMemberList();
	if(arr == null || arr.size() ==0){
%>
	<tr>
		<td colspan="8">등록된 회원이 없습니다.</td>
	</tr>
<%
	} else{
		for(adminDTO dto : arr){
%>			
	<tr>
		<td><%=dto.getM_idx()%></td>
		<td><%=dto.getId() %></td>
		<td><%=dto.getM_name() %></td>
		<td><%=dto.getSex()%></td>
		<td><%=dto.getBirthday()%></td>
		<td><%=dto.getTel()%></td>
       <td>
    <img src="/codeEffluve/membersProfiles/<%=dto.getM_profile()%>" class ="table-profile-img">
</td>

		<td>
		<form method ="post" action="memberListDel.jsp">
		<input type="hidden" name="m_idx" value="<%=dto.getM_idx() %>">
		<input type="submit" value="삭제" class = "delete-btn">
		</form>
		</td>
<%	
		}
	}
%>
</table>
</section>
</html>