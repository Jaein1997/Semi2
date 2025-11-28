<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.codeEffluve.admin.*" %>
<jsp:useBean id="ddao" class="com.codeEffluve.admin.daydelDAO" scope="session" />

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
<h2 style="text-align: center;">일정 관리</h2>

<form method ="get" style ="text-align: right; margin-bottom: 15px;">
<input type = "hidden" name ="menu" value ="todo">

<input type = "text" name = "searchId" placeholder="아이디 검색"
	value ="<%=request.getParameter("searchId") == null ? "" : request.getParameter("searchId")%>"
	style="padding:5px;">
	
	<button type="submit" style ="padding: 5px 10px;">검색</button>
	</form>
	
<table class = "adminTable">
	<tr>
		<th>일정번호</th>
		<th>회원아이디</th>
		<th>일정</th>
		<th>시간</th>
		<th>일정메모</th>
		<th>공개여부</th>
		<th>삭제</th>
	</tr>
	
<%
	String searchId = request.getParameter("searchId");
	ArrayList<daydelDTO> arr = ddao.getTodoList(searchId);
	
	if(arr == null || arr.size() == 0){
%>
	    <tr>
	        <td colspan="7">등록된 일정이 없습니다.</td>
	    </tr>
<%
	    } else {
	        for(daydelDTO dto : arr){
%>

	    <tr>
	        <td><%=dto.getT_idx()%></td>
	        <td><%=dto.getMember_id()%></td>
	        <td><%=dto.getContent()%></td>
	        <td><%=dto.getT_time()%></td>
	        <td><%=dto.getT_memo()%></td>
	        <td><%=dto.getShares()%></td>
			<td>
            <form action="todoListDel.jsp" method="post">
                <input type="hidden" name="t_idx" value="<%=dto.getT_idx()%>">
                <input type="submit" value="삭제" class = "delete-btn">
            </form>
        </td>
	</tr>
<%
			}
	    }
%>
</table>