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
<table border="1" cellspacing="0" width="800px" style="margin:0 auto; text-align:center;">
    <tr>
        <th>질문 번호</th>
        <th>질문</th>
        <th>답변</th>
        <th>조회수</th>
        <th>삭제</th>
    </tr>

<%
    ArrayList<qadelDTO> list = qdao.getQAList();

    if(list == null || list.size() == 0){
%>
    <tr>
        <td colspan="5">등록된 질문이 없습니다.</td>
    </tr>
<%
    } else {
        for(qadelDTO dto : list){
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
<div style="width:800px; margin:10px auto; text-align:right;">
    <button onclick="openWritePopup()"
            style="padding:8px 14px; background-color:rgb(109, 16, 68); color:white; border:none; border-radius:8px; cursor:pointer;">
        글쓰기
    </button>
</div>

<script>
function openWritePopup() {
    window.open(
        'qaWrite.jsp', 'qaWrite', 'width=500,height=400,left=600,top=200'
    );
}
</script>

