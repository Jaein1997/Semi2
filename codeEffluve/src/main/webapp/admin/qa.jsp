<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.codeEffluve.admin.*" %>

<jsp:useBean id="qdao" class="com.codeEffluve.admin.qadelDAO" scope="session" />

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
<h2 style="text-align:center;">자주 묻는 질문</h2>



<%
    int cp = request.getParameter("cp") == null ?
             1 : Integer.parseInt(request.getParameter("cp"));
    int ls = 10;

    String searchId = request.getParameter("searchId");

    ArrayList<qadelDTO> arr = qdao.getQAList(searchId, cp, ls);

    int totalCnt = qdao.getTotalCount(searchId);
    int totalPage = (int)Math.ceil(totalCnt / (double)ls);
%>

<table class = "adminTable">
    <tr>
        <th>질문 번호</th>
        <th>질문</th>
        <th>답변</th>
        <th>조회수</th>
        <th>삭제</th>
    </tr>

<%
    if(arr == null || arr.size() == 0){
%>
    <tr>
        <td colspan="5">등록된 질문이 없습니다.</td>
    </tr>
<%
    } else {
        for(qadelDTO dto : arr){
%>
    <tr>
        <td><%=dto.getQ_idx()%></td>
        <td><%=dto.getQ()%></td>
        <td><%=dto.getA()%></td>
        <td><%=dto.getViewcount()%></td>
        <td>
            <form action="qaListDel.jsp" method="post">
                <input type="hidden" name="q_idx" value="<%=dto.getQ_idx()%>">
                <input type="submit" class="delete-btn" value="삭제">
            </form>
        </td>
    </tr>
<%
        }
    }
%>
</table>
<div style="width:100%; margin:10px auto; text-align:right;"> 
    <button onclick="openWritePopup()"
            style="padding:8px 14px; background-color:rgb(109, 16, 68); color:white; border:none; border-radius:8px; cursor:pointer;">
        글쓰기
    </button>
</div>
<div style="text-align:center; margin-top:20px;">
<%
    for(int i = 1; i <= totalPage; i++){
%>
    <a href="/codeEffluve/admin/admin.jsp?menu=qa&cp=<%=i%><%
        if(searchId != null && !searchId.equals("")) { %>&searchId=<%=searchId%><% }
    %>">
        <%=i%>
    </a>
<%
    }
%>
</div>
<script>
function openWritePopup() {
    window.open(
        'qaWrite.jsp', 'qaWrite', 'width=500,height=400,left=600,top=200'
    );
}
</script>

