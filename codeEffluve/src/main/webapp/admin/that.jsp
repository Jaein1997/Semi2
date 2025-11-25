<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
<%@ page import="com.codeEffluve.admin.*" %>

<jsp:useBean id="tdao" class="com.codeEffluve.admin.thatDAO" scope="session" />

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
<h2 style="text-align:center;">댓글 관리</h2>
<table class = "adminTable">
    <tr>
        <th>댓글번호</th>
        <th>댓글내용</th>
        <th>댓글작성자</th>
        <th>댓글작성 시간</th>
        <th>원글번호</th>
        <th>원글제목</th>
        <th>공개범위</th>
        <th>삭제</th>
    </tr>

<%
    ArrayList<thatDTO> arr = tdao.getCommentList();

    if(arr == null || arr.size() == 0){
%>
    <tr>
        <td colspan="8">등록된 댓글이 없습니다.</td>
    </tr>
<%
    } else {
        for(thatDTO dto : arr){
%>

	<tr>
		<td><%=dto.getC_idx() %></td>
		<td><%=dto.getMessage() %></td>
		<td><%=dto.getM_idx() %></td>
		<td><%=dto.getC_time() %></td>
		<td><%=dto.getT_idx() %></td>
		<td><%=dto.getContent() %></td>
		<td><%=dto.getShares() %></td>
	<td>
            <form action="thatListDel.jsp" method="post">
                <input type="hidden" name="c_idx" value="<%=dto.getC_idx()%>">
                <input type="submit" value="삭제" class = "delete-btn">
            </form>
        </td>
    </tr>
<%	
		}
	}
   %>
  </table>




