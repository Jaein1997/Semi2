<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*"%>
 <%@ page import="com.codeEffluve.admin.*" %>
 <jsp:useBean id="adminDao" class="com.codeEffluve.admin.adminDAO" scope="session" />
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<h2>회원 관리</h2>
<style>
</style>
<table border ="1" cellspacing="0" width="800px" style ="margin: 0px auto; text-align: center;">
	<tr>
	<th>번호</th>
	<th>아이디</th>
	<th>비밀번호</th>
	<th>이름</th>
	<th>성별</th>
	<th>생일</th>
	<th>전화번호</th>
	<th>프로필</th>
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
		<td><%=dto.getPwd() %></td>
		<td><%=dto.getM_name() %></td>
		<td><%=dto.getSex()%></td>
		<td><%=dto.getBirthday()%></td>
		<td><%=dto.getTel()%></td>
		<td><%=dto.getM_profile()%></td>
		<td>
		<% // if(dto.get) %>
		<td>
		<form method ="post" action="memberListDel.jsp">
		<input type="hidden" name="m_idx" value="<%=dto.getM_idx() %>">
		<input type="submit" value="삭제">
		</form>
<%	
		}
	}
%>
</table>
</html>