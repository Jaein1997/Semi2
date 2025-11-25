<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   
    Object loginCheck = session.getAttribute("sid"); 
    
    if (loginCheck == null) {
    
        String loginUrl = "/codeEffluve/members/logIn.jsp"; 
        
        out.println("<script>");
        out.println("  alert('로그인이 필요한 서비스입니다.');");
       
        out.println("  window.open('" + loginUrl + "', 'loginWin', 'width=450,height=350,scrollbars=no');");
        out.println("</script>");
        
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>불편사항 접수</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
   
    .problem-form-container { width: 600px; margin: 30px auto; }
    .problem-form-container table { width: 100%; border-collapse: collapse; }
    .problem-form-container th, .problem-form-container td { 
        padding: 10px; 
        border-bottom: 1px solid #eee;
        text-align: left;
    }
    .problem-form-container th { width: 150px; background-color: #f7f7f7; font-weight: normal; }
    .problem-form-container input[type="text"], 
    .problem-form-container textarea, 
    .problem-form-container select {
        width: 95%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box; 
    }
    .problem-form-container textarea { height: 150px; resize: vertical; }
    .submit-area { text-align: center; padding-top: 20px; }
    .submit-area button {
        padding: 10px 30px;
        background-color: #5C6BC0; 
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 1em;
        transition: background-color 0.3s;
    }
    .submit-area button:hover { background-color: #3F51B5; }
</style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <main>
        <section>
            <h1>불편사항 접수 📝</h1>
            <p style="text-align: center; color: #555;">사용 중 불편했던 점을 상세히 알려주시면 빠르게 해결하겠습니다.</p>
            
            <div class="problem-form-container">
                <form action="csProblem_ok.jsp" method="post" name="problemForm">
                    <table>
                        <tr>
                            <th>작성자 ID</th>
                            <td>
                                <% String sessionId = (String)session.getAttribute("sid");%>
                                <input type="text" name="writerId" value="<%= sessionId != null ? sessionId : "비회원" %>" readonly>
                            </td>
                        </tr>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" required placeholder="문의 제목을 입력해주세요."></td>
                        </tr>
                        <tr>
                            <th>문의 유형</th>
                            <td>
                                <select name="category" required>
                                    <option value="">-- 유형 선택 --</option>
                                    <option value="BUG">시스템 오류/버그</option>
                                    <option value="FUNCTION">기능 개선 제안</option>
                                    <option value="ETC">기타 문의</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td><textarea name="content" required placeholder="불편사항을 구체적으로 설명해주세요. (발생 시간, 환경 등)"></textarea></td>
                        </tr>
                    </table>
                    
                    <div class="submit-area">
                        <button type="submit">접수하기</button>
                    </div>
                </form>
            </div>
            
        </section>
    </main>
    <%@include file="/footer.jsp" %>
</body>
</html>