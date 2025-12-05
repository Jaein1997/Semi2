<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.codeEffluve.admin.*" %>

<jsp:useBean id="qdao" class="com.codeEffluve.admin.qadelDAO" scope="session" />

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
</style>
<h2 style="text-align:center;">자주 묻는 질문</h2>

<%
int cp = request.getParameter("cp") == null ? 1 : Integer.parseInt(request.getParameter("cp"));

int pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request.getParameter("pageSize"));

int ls = pageSize;

String searchQ = request.getParameter("searchQ");

ArrayList<qadelDTO> arr = qdao.getQAList(searchQ, cp, ls);

int totalCnt = qdao.getTotalCount(searchQ);
int totalPage = (int)Math.ceil(totalCnt / (double)ls);

int blockSize = 5; // 5개씩 보이게 만든 페이지 수
int clickBlock = (int)Math.ceil(cp / (double)blockSize);
int startPage = (clickBlock - 1) * blockSize + 1;
int endPage = startPage + blockSize - 1;

if(endPage > totalPage) endPage = totalPage;
%>
 	<div style="text-align:right; margin-bottom:15px;">
    <form method="get" action="/codeEffluve/admin/admin.jsp">
        <input type="hidden" name="menu" value="qa">
        <input type="hidden" name="cp" value="<%=cp%>">
        <% if(searchQ != null && !searchQ.equals("")) { %>
            <input type="hidden" name="searchQ" value="<%=searchQ%>">
        <% } %>

        <select name="pageSize" onchange="this.form.submit()" style="margin-right:10px; border-radius: 8px 8px 8px 8px; border: 2px solid rgb(109, 16, 68);">
            <option value="5"  <%=pageSize==5?"selected":""%>>5개씩</option>
            <option value="10" <%=pageSize==10?"selected":""%>>10개씩</option>
            <option value="15" <%=pageSize==15?"selected":""%>>15개씩</option>
            <option value="20" <%=pageSize==20?"selected":""%>>20개씩</option>
        </select>
    </form>
</div>

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
<div class="pagest">
   <!-- 왼쪽  -->
    <% if(startPage > 1) { %>
        <a class ="arrow" 
        href="/codeEffluve/admin/admin.jsp?menu=qa&cp=<%=startPage - 1%>&pageSize=<%=pageSize %><%
            if(searchQ != null && !searchQ.equals("")){ %>&searchQ=<%=searchQ%><% } %>">
            ◀
        </a>
    <% } %>

    <!-- 페이지 번호 -->
    <%
        for(int i = startPage; i <= endPage; i++){
            String active = (i == cp) ? "active" : "";
    %>
        <a class="page-num <%=active%>"
           href="/codeEffluve/admin/admin.jsp?menu=qa&cp=<%=i%>&pageSize=<%=pageSize %><%
                if(searchQ != null && !searchQ.equals("")){ %>&searchQ=<%=searchQ%><% } %>">
           <%=i%>
        </a>
    <% } %>

    <!-- 오른쪽 -->
    <% if(endPage < totalPage) { %>
        <a class ="arrow" 
        href="/codeEffluve/admin/admin.jsp?menu=that&cp=<%=endPage + 1%>&pageSize=<%=pageSize %><%
            if(searchQ != null && !searchQ.equals("")){ %>&searchQ=<%=searchQ%><% } %>">
            ▶
        </a>
    <% } %>
</div>
<script>
function openWritePopup() {
    window.open(
        'qaWrite.jsp', 'qaWrite', 'width=500,height=400,left=600,top=200'
    );
}
</script>

