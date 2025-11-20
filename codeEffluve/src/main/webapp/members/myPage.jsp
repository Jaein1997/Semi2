<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.members.MembersDTO" %>
<%@ page import="com.codeEffluve.members.MembersDAO" %>
<%@ page import="java.sql.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
  
    #profileImg { 
        width: 150px; 
        height: 150px; 
        border-radius: 50%; 
        object-fit: cover; 
    }
    
  
    .profile-layout {
        display: flex; 
        align-items: flex-start; 
        width: 800px; 
        margin: 20px auto; 
    }
    
   
    table { 
        width: 60%; 
        margin: 0 0 0 30px; 
        border-collapse: collapse; 
        
        border: 1px solid #ccc;
    }
    th, td { 
        padding: 10px; 
        border: 1px solid #ccc; 
    }
    th {
        width: 30%; 
    }
    
    
    .action-buttons { 
        text-align: right; 
        width: 800px; 
        margin: 10px auto;
    }
    .action-buttons button { padding: 10px 20px; margin: 0 5px; cursor: pointer; }
</style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <main>
        <section>
            
            <%
                String sid = (String)session.getAttribute("sid");
                MembersDTO member = null;

                if (sid == null) {
            %>
                <script>
                    alert('로그인 후 이용해 주세요.');
                    location.href='/codeEffluve/members/login.jsp';
                </script>
            <%
                    return;
                }
                
                MembersDAO dao = MembersDAO.getInstance();
                member = dao.getMemberInfo(sid); 

                if (member == null) {
                    session.invalidate();
            %>
                <script>
                    alert('회원 정보 조회 중 오류가 발생했습니다. 다시 로그인해 주세요.');
                    location.href='/codeEffluve/members/login.jsp';
                </script>
            <%
                    return;
                }
                
                session.setAttribute("loginMember", member);
            %>

            <h2><%=member.getM_name()%> 님의 마이페이지</h2>
            
            <div class="profile-layout">
                <img id="profileImg" src="/codeEffluve/membersProfiles/<%=member.getM_profile()%>" alt="프로필">

                <table>
                    <tr><th>ID</th><td><%=member.getId()%></td></tr>
                    <tr><th>이름</th><td><%=member.getM_name()%></td></tr>
                    <tr><th>성별</th><td><%=member.getSex()%></td></tr>
                    <tr><th>생년월일</th><td><%=member.getBirthday()%></td></tr>
                    <tr><th>전화번호</th><td><%=member.getTel()%></td></tr>
                </table>
            </div>
            
            <div class="action-buttons">
                <a href="/codeEffluve/members/myPageEdit.jsp"><button>정보 수정</button></a>
                <a href="/codeEffluve/members/deleteAccount.jsp"><button>회퇴 탈퇴</button></a>
            </div>
            
        </section>
    </main>
    <%@include file="/footer.jsp" %>
</body>
</html>