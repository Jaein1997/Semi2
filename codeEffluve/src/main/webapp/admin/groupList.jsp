<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.codeEffluve.admin.*" %>

<jsp:useBean id="gdao" class="com.codeEffluve.admin.groupdelDAO" scope="session" />

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

.search-wrapper {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 15px;
}

.search-input {
    padding: 7px 12px;
    border: 1.5px solid rgb(109, 16, 68);
    border-right: none;  
    border-radius: 8px 0 0 8px;
    font-size: 13px;
    outline: none;
    width: 180px;
}

.search-btn {
    border-radius: 0 8px 8px 0; 
    padding: 7px 14px;
    background-color: rgb(109, 16, 68);
    color: white;
    border: none;
}
</style>

<h2 style="text-align:center;">그룹 관리</h2>

<%
int cp = request.getParameter("cp") == null ? 1 : Integer.parseInt(request.getParameter("cp"));

int pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request.getParameter("pageSize"));

int ls = pageSize;

    String searchId = request.getParameter("searchId");

    ArrayList<groupdelDTO> arr = gdao.getGroupList(searchId, cp, ls);

    int totalCnt = gdao.getTotalCount(searchId);
    int totalPage = (int)Math.ceil(totalCnt / (double)ls);
%>

<form method ="get" class="search-wrapper">
    <input type="hidden" name="menu" value="group">

    <input type="text" name="searchId" placeholder="아이디 검색" class="search-input"
           value="<%=request.getParameter("searchId") == null ? "" : request.getParameter("searchId")%>">

    <button type="submit" class="search-btn">검색</button>
    <select name="pageSize" onchange="this.form.submit()" style="margin-right:10px; border-radius: 8px 8px 8px 8px; border: 2px solid rgb(109, 16, 68);">
        <option value="5"  <%=pageSize==5?"selected":""%>>5개씩</option>
        <option value="10" <%=pageSize==10?"selected":""%>>10개씩</option>
        <option value="15" <%=pageSize==15?"selected":""%>>15개씩</option>
        <option value="20" <%=pageSize==20?"selected":""%>>20개씩</option>
    </select>
</form>

<table class="adminTable">
    <tr>
        <th>번호</th>
        <th>그룹명</th>
        <th>그룹메모</th>
        <th>그룹프로필</th>
        <th>리더</th>
        <th>삭제</th>
    </tr>

<%
    if(arr == null || arr.size() == 0){
%>
    <tr><td colspan="6">등록된 그룹이 없습니다.</td></tr>
<%
    } else{
        for(groupdelDTO dto : arr){
%>

    <tr>
        <td><%=dto.getG_idx()%></td>
        <td><%=dto.getG_name()%></td>
        <td><%=dto.getG_memo()%></td>
        <td><img src="/codeEffluve/groupProfiles/<%=dto.getG_profile()%>" class="table-profile-img"></td>
        <td><%=dto.getLeader_id()%></td>
        <td>
            <form action="groupListDel.jsp" method="post">
                <input type="hidden" name="g_idx" value="<%=dto.getG_idx()%>">
                <input type="submit" value="삭제" class="delete-btn">
            </form>
        </td>
    </tr>

<%
        }
    }
%>
</table>

<div style="text-align:center; margin-top:20px;">
<%
    for(int i = 1; i <= totalPage; i++){
%>
    <a href="/codeEffluve/admin/admin.jsp?menu=group&cp=<%=i%><%
        if(searchId != null && !searchId.equals("")) { %>&searchId=<%=searchId%><% }
    %>">
        <%=i%>
    </a>
<%
    }
%>
</div>
