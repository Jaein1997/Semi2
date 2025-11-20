<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve - 회원 탈퇴</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
    .delete-container {
        width: 500px;
        margin: 50px auto;
        padding: 30px;
        border: 1px solid #ddd;
        border-radius: 8px;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
    }
    .warning {
        color: #f44336; 
        font-weight: bold;
        margin-bottom: 20px;
        border: 1px solid #f44336;
        padding: 15px;
        background-color: #fff0f0;
        border-radius: 4px;
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .form-group input[type="password"] {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .button-area {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 20px;
    }
    .delete-btn {
        padding: 10px 15px;
        background-color: #f44336;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 4px;
        font-weight: bold;
    }
    .cancel-btn {
        padding: 10px 15px;
        background-color: #ccc;
        color: #333;
        border: none;
        cursor: pointer;
        border-radius: 4px;
    }
</style>
</head>
<body>
    <%@include file="header.jsp" %>
	
	<main>
		<div class="delete-container">
            <h2>회원 탈퇴</h2>
            
            <div class="warning">
                ⚠️ **주의:** 회원 탈퇴 시, 사용자님의 모든 일정, 댓글, 그룹 정보가 영구적으로 삭제되며 복구할 수 없습니다. 정말로 탈퇴하시려면 비밀번호를 입력하고 '탈퇴하기' 버튼을 눌러주세요.
            </div>
            
          
            <form name="deleteForm" action="memberDelete.do" method="post" onsubmit="return confirmDeletion()">
                
                <input type="hidden" name="mIdx" value="${sessionScope.loginMember.mIdx}">

                <div class="form-group">
                    <label for="pwd">비밀번호 확인:</label>
                    <input type="password" id="pwd" name="pwd" required placeholder="본인 확인을 위해 비밀번호를 입력해주세요.">
                </div>

                <div class="button-area">
                    <input type="button" value="취소" class="cancel-btn" onclick="location.href='myPage.jsp'">
                    <input type="submit" value="탈퇴하기" class="delete-btn">
                </div>
            </form>
        </div>
        
        <script>
            function confirmDeletion() {
                const password = document.getElementById('pwd').value;
                
                if (password.trim() === "") {
                    alert('비밀번호를 입력해야 탈퇴할 수 있습니다.');
                    return false;
                }
             
                return confirm('정말로 탈퇴하시겠습니까? 모든 정보가 영구 삭제됩니다.');
            }
        </script>
	</main>
	
	<%@include file="footer.jsp" %>
</body>
</html>