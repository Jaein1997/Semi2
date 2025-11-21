<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.codeEffluve.admin.*" %>
<jsp:useBean id="sdao" class="com.codeEffluve.admin.singoDAO" scope="session" />

<style>
.check-btn {
	  padding: 6px 12px;
    background-color: rgb(160, 40, 90);
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 13px;
}

</style>

/*<h2 style="text-align: center;">일정 관리</h2>
<table border ="1" cellspacing="0" width="800px" style ="margin: 0px auto; text-align: center;">
	<tr>
		<th>일정번호</th>
		<th>회원번호</th>
		<th>일정</th>
		<th>시간</th>
		<th>일정메모</th>
		<th>공개여부</th>
		<th>삭제</th>
	</tr>
	
<%
	// ArrayList<daydelDTO> arr = sdao.getTodoList();
	
//	if(arr == null || arr.size() == 0){
%>
	    <tr>
	        <td colspan="7">등록된 일정이 없습니다.</td>
	    </tr>
<%
	//    } else {
