<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.members.MembersDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<script>
    // 이미지 미리보기 함수
    function setThumbnail(event) {
        var reader = new FileReader();
        reader.onload = function(event) {
            document.getElementById("profileImg").src = event.target.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    function validateEditForm() {
        const form = document.editForm;
        
        // 1. 현재 비밀번호 필수 검증
        if (form.currentPwd.value.trim() === "") {
            alert("정보 수정을 위해 현재 비밀번호를 입력해야 합니다.");
            form.currentPwd.focus();
            return false;
        }
        
        // 2. 새 비밀번호와 새 비밀번호 확인 일치 검증
        const newPwd = form.newPwd.value.trim();
        const newPwdCheck = form.newPwdCheck.value.trim();

        if (newPwd !== newPwdCheck) {
            alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
            form.newPwdCheck.focus();
            return false;
        }

        return true;
    }
    
    function onlyNum(input) {
		var value = input.value;
		var result = "";

		for (var i = 0; i < value.length; i++) {
			var ch = value.charAt(i);

			if (ch >= '0' && ch <= '9') {
				result += ch;
			}
		}

		if (value != result) {
			input.value = result;
		}
	}
</script>
</head>
<body>
    <%@include file="/header.jsp" %>
    <main>
        <section id="myPageEdit">
            <%
                
                MembersDTO member = (MembersDTO)session.getAttribute("loginMember");

                if (member == null) {
                  
                    response.sendRedirect("myPage.jsp"); 
                    return;
                }
            %>

            <h2>회원 정보 수정</h2>
            <form name="editForm" 
                  action="/codeEffluve/members/myPageEdit_ok.jsp" 
                  method="post" 
                  enctype="multipart/form-data" 
                  onsubmit="return validateEditForm()">
                <div id="editDiv">
                
	                <div id="editProfile">
		                <img id="profileImg" src="/codeEffluve/membersProfiles/<%=member.getM_profile()%>" alt="현재 프로필">
		                <input type="file" name="m_profile_upload" onchange="setThumbnail(event)">
	                </div>
	                
	                
	                <table>
	                    <tr><th>ID</th><td><input type="text" name="id" value="<%=member.getId()%>" readonly></td></tr>
	                    
	                    <tr><th><span style="color: #D92A0D;">*</span>&nbsp;현재 비밀번호 확인</th><td><input type="password" name="currentPwd" required placeholder="정보 수정을 위해 반드시 입력"></td></tr>
	                    
	                    <tr><th>새 비밀번호</th><td><input type="password" name="newPwd" placeholder="변경할 경우에만 입력"></td></tr>
	                    <tr><th>새 비밀번호 확인</th><td><input type="password" name="newPwdCheck" placeholder="새 비밀번호를 다시 입력"></td></tr>
	                    
	                    <tr><th>이름</th><td><input type="text" name="m_name" value="<%=member.getM_name()%>" required></td></tr>
	                    <tr><th>성별</th>
	                        <td>
	                            <input type="radio" name="sex" value="m" <%=member.getSex().equals("m") ? "checked" : ""%>>남성
	                            <input type="radio" name="sex" value="f" <%=member.getSex().equals("f") ? "checked" : ""%>>여성
	                            <input type="radio" name="sex" value="n" <%=member.getSex().equals("n") ? "checked" : ""%>>선택안함
	                        </td>
	                    </tr>
	                    <tr><th>생년월일</th><td><input type="date" name="birthday" value="<%=member.getBirthday()%>" required></td></tr>
	                    <tr><th>전화번호</th><td><input type="text" name="tel" value="<%=member.getTel()%>" oninput="onlyNum(this)"></td></tr>
	                    
	                </table>
                </div>
                <div id="editBtnDiv">
					<input type="submit" value="수정 완료">
                    <input type="button" value="취소" onclick="history.back()">
                </div>
            </form>
        </section>
    </main>
    <%@include file="/footer.jsp" %>
</body>
</html>