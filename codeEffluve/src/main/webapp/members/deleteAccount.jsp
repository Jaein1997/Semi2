<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<script>
    function validateDelete() {
        const form = document.deleteForm;
        
        if (form.pwd.value.trim() === "") {
            alert("비밀번호를 입력해 주세요.");
            form.pwd.focus();
            return false;
        }

        if (confirm("정말로 탈퇴하시겠습니까? 탈퇴 후 정보는 복구되지 않습니다.")) {
            return true;
        }
        return false;
    }
</script>
</head>
<body>
    <%@include file="/header.jsp" %>
    <main>
        <section>
            <%
                if (session.getAttribute("loginMember") == null) {
                    response.sendRedirect("/codeEffluve/members/login.jsp"); 
                    return;
                }
            %>
            <h2>회원 탈퇴</h2>
            <p style="color: red; font-weight: bold;">
                경고: 탈퇴 시 모든 정보는 삭제되며 복구할 수 없습니다.
            </p>
            <p>회원 탈퇴를 진행하시려면 비밀번호를 다시 한 번 입력해 주세요.</p>
            
            <form name="deleteForm" action="deleteAccount_ok.jsp" method="post" onsubmit="return validateDelete()">
                <table>
                    <tr>
                        <th>비밀번호 확인</th>
                        <td><input type="password" name="pwd" required></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="탈퇴 진행">
                            <input type="button" value="취소" onclick="history.back()">
                        </td>
                    </tr>
                </table>
            </form>
        </section>
    </main>
    <%@include file="/footer.jsp" %>
</body>
</html>