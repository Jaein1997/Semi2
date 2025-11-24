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

</style>
<h2 style="text-align:center;">그룹 관리</h2>
<table border ="1" cellspacing="0" width="800px" style ="margin: 0px auto; text-align: center;">
    <tr>
        <th>번호</th>
        <th>그룹명</th>
        <th>그룹메모</th>
        <th>그룹프로필</th>
        <th>리더</th>
        <th>삭제</th>
    </tr>

<%
    ArrayList<groupdelDTO> arr = gdao.getGroupList();

    if(arr == null || arr.size() == 0){
%>
    <tr>
        <td colspan="6">등록된 그룹이 없습니다.</td>
    </tr>
<%
    } else {
        for(groupdelDTO dto : arr){
%>

    <tr>
        <td><%=dto.getG_idx()%></td>
        <td><%=dto.getG_name()%></td>
        <td><%=dto.getG_memo()%></td>
        <td>
            <img src="/codeEffluve/membersProfiles/<%=dto.getG_profile()%>" 
                 class="profile-img" alt="profile">
        </td>
        <td><%=dto.getLeader()%></td>
        <td>
            <form action="groupListDel.jsp" method="post">
                <input type="hidden" name="g_idx" value="<%=dto.getG_idx()%>">
                <input type="submit" value="삭제" class = "delete-btn">
            </form>
        </td>
    </tr>

<%
        } 
    } 
%>
</table>
