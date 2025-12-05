<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*"%>
 <%@ page import="com.codeEffluve.admin.*" %>
 
 <jsp:useBean id="adminDao" class="com.codeEffluve.admin.adminDAO" scope="session" />
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<style>
/* 페이지 영역 */
.pagest {
    margin-top: 25px;
    text-align: center;
}

.pagest a {
    display: inline-block;
    margin: 0 6px;
    text-decoration: none;
    font-size: 14px;
}

/* 숫자 버튼 스타일 */
.pagest a.page-num {
    padding: 6px 12px;
    border-radius: 8px;
    border: 1.5px solid rgb(109, 16, 68);
    color: rgb(109, 16, 68);
    transition: 0.15s;
}

.pagest a.page-num:hover {
    background-color: rgb(109, 16, 68);
    color: white;
}

/* 현재 페이지 활성화 */
.pagest a.active {
    background-color: rgb(109, 16, 68);
    color: white !important;
    border: 1.5px solid rgb(109, 16, 68);
}

/* 화살표 아이콘 스타일 */
.pagest a.arrow {
    font-size: 18px;
    color: rgb(109, 16, 68);
    padding: 5px 2px; 
    border: none;  
}

.pagest a.arrow:hover {
    color: rgb(160, 40, 90);
}

.delete-btn {
	  padding: 6px 12px;
    background-color: rgb(109, 16, 68);
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 13px;
}

.search-wrapper {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 15px;
}

/* 검색창 */
.search-input {
    padding: 7px 12px;
    border: 1.5px solid rgb(109, 16, 68);
    border-right: none;  
    border-radius: 8px 0 0 8px;
    font-size: 13px;
    outline: none;
    width: 180px;
}

/* 검색 버튼 */
.search-btn {
    border-radius: 0 8px 8px 0; 
    padding: 7px 14px;
    background-color: rgb(109, 16, 68);
    color: white;
	border: none;
}

</style>
<section>
<h2 style="text-align:center;">회원 관리</h2>

<%
    int cp = request.getParameter("cp") == null ? 1 : Integer.parseInt(request.getParameter("cp"));

	int pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
	
    int ls = pageSize;

    String searchId = request.getParameter("searchId");

    ArrayList<adminDTO> arr = adminDao.getMemberList(searchId, cp, ls);

    int totalCnt = adminDao.getTotalCount(searchId);
    int totalPage = (int)Math.ceil(totalCnt / (double)ls);
    
    int blockSize = 5; // 5개씩 보이게 만든 페이지 수
    int clickBlock = (int)Math.ceil(cp / (double)blockSize);
    int startPage = (clickBlock - 1) * blockSize + 1;
    int endPage = startPage + blockSize - 1;

    if(endPage > totalPage) endPage = totalPage;
%>

<form method ="get" class = "search-wrapper">
<input type = "hidden" name ="menu" value ="member">

<input type = "text" name = "searchId" placeholder="아이디 검색" class = "search-input"
	value ="<%=request.getParameter("searchId") == null ? "" : request.getParameter("searchId")%>">
	
	<button type="submit" class = "search-btn">검색</button>
	<select name="pageSize" onchange="this.form.submit()" style="margin-right:10px; border-radius: 8px 8px 8px 8px; border: 2px solid rgb(109, 16, 68);">
        <option value="5"  <%=pageSize==5?"selected":""%>>5개씩</option>
        <option value="10" <%=pageSize==10?"selected":""%>>10개씩</option>
        <option value="15" <%=pageSize==15?"selected":""%>>15개씩</option>
        <option value="20" <%=pageSize==20?"selected":""%>>20개씩</option>
    </select>
	</form>
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
<div class="pagest">
   <!-- 왼쪽  -->
    <% if(startPage > 1) { %>
        <a class ="arrow" 
        href="/codeEffluve/admin/admin.jsp?menu=member&cp=<%=startPage - 1%>&pageSize=<%=pageSize %><%
            if(searchId != null && !searchId.equals("")){ %>&searchId=<%=searchId%><% } %>">
            ◀
        </a>
    <% } %>

    <!-- 페이지 번호 -->
    <%
        for(int i = startPage; i <= endPage; i++){
            String active = (i == cp) ? "active" : "";
    %>
        <a class="page-num <%=active%>"
           href="/codeEffluve/admin/admin.jsp?menu=member&cp=<%=i%>&pageSize=<%=pageSize %><%
                if(searchId != null && !searchId.equals("")){ %>&searchId=<%=searchId%><% } %>">
           <%=i%>
        </a>
    <% } %>

    <!-- 오른쪽 -->
    <% if(endPage < totalPage) { %>
        <a class ="arrow" 
        href="/codeEffluve/admin/admin.jsp?menu=member&cp=<%=endPage + 1%>&pageSize=<%=pageSize %><%
            if(searchId != null && !searchId.equals("")){ %>&searchId=<%=searchId%><% } %>">
            ▶
        </a>
    <% } %>
</div>
</section>
</html>