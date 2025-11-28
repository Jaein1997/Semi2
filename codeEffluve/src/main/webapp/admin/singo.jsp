<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.codeEffluve.admin.*" %>
<jsp:useBean id="sdao" class="com.codeEffluve.admin.singoDAO" scope="session" />

<style>
.check-btn {
     padding: 6px 12px;
    background-color: rgb(109, 16, 68);
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 13px;
}
</style>
<h2 style="text-align: center;">불편사항</h2>


<form method ="get" style ="text-align: right; margin-bottom: 15px;">
<input type = "hidden" name ="menu" value ="singo">

<input type = "text" name = "searchId" placeholder="아이디 검색"
	value ="<%=request.getParameter("searchId") == null ? "" : request.getParameter("searchId")%>"
	style="padding:5px;">
	
	<button type="submit" style ="padding: 5px 10px;">검색</button>
	</form>

<table class = "adminTable">
   <tr>
      <th>불편사항번호</th>
      <th>회원아이디</th>
      <th>제목</th>
      <th>내용</th>
      <th>작성 시간</th>
      <th>확인 여부</th>
   </tr>
   
      
<%
	String searchId = request.getParameter("searchId");
   ArrayList<singoDTO> arr = sdao.getsingoList(searchId);
      if(arr == null || arr.size() == 0) {
%>
   <tr>
      <td colspan="6">등록된 불편사항이 없습니다.</td>
   </tr>
<%      
   }else {
      for(singoDTO dto : arr) {
%>   

   <tr>
      <td><%=dto.getS_idx()%></td>
      <td><%=dto.getSingoja()%></td>
      <td><%=dto.getTitle() %></td>
      <td><%=dto.getContent()%></td>
      <td><%=dto.getS_date() %></td>
      <td>
         <%if(dto.getStatus().equals("N")) {%>
         <form action = "singoStatus_ok.jsp" method="post">
            <input type = "hidden" name="s_idx" value="<%=dto.getS_idx()%>">
            <input type = "submit" value="확인 전" class="check-btn">
         </form>
      <%} else { %>
      <span style="color:green; font-weight : bold;">확인 완료</span>
      <% }%>
      </td>
   </tr>   
   <%   
      }
   }
%>
</table>
