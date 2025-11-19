<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve - 내 정보 수정</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
</head>
<body>
    <%@include file="header.jsp" %>
	
	<main>
		<div class="main_content_area" style="width: 800px; margin: 30px auto; display: flex; justify-content: space-between;">
        
            <div class="profile_image_area" style="width: 250px; height: 250px; border: 1px solid #ddd; display: flex; align-items: center; justify-content: center; overflow: hidden; background-color: #f7f7f7;">
                <img src="uploads/profile/example.jpg" alt="현재 프로필" style="width: 100%; height: 100%; object-fit: cover; display: none;"> 
                <span style="color: #666; font-size: 1.2em;">프로필 사진 (수정 가능)</span>
            </div>
        
            <div class="member_info_container" style="width: 500px;">
                
                <form name="memberUpdateForm" action="privateUpdate.do" method="post" enctype="multipart/form-data">
                
                    <table style="width: 100%; margin-top: 20px; border-collapse: collapse;">
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">아이디</th>
                            <td style="border: 1px solid #ccc; background-color: #eee; padding: 5px 10px;">
                                <input type="text" name="id" value="id" readonly style="width: 90%; border: none; background-color: transparent;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">이름*</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="text" name="m_name" value="이름" required style="width: 90%; border: none;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">현재 비밀번호*</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="password" name="currentPwd" required placeholder="정보 수정을 위해 입력하세요" style="width: 90%; border: none;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">새 비밀번호</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="password" name="newPwd" placeholder="새 비밀번호 입력" style="width: 90%; border: none;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">성별*</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <label><input type="radio" name="sex" value="남" checked> 남</label>
                                <label><input type="radio" name="sex" value="여"> 여</label>
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">생년월일*</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="date" name="birthday" value="" required style="width: 90%; border: none;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">연락처</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="text" name="tel" value="" style="width: 90%; border: none;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">프로필 파일</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="file" name="m_profile_upload">
                                <input type="hidden" name="old_m_profile" value="example.jpg">
                            </td>
                        </tr>
                    </table>
                    
                    <div style="text-align: right; margin-top: 20px;">
                        
                        <input type="submit" value="수정 완료"
                                style="padding: 10px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
                        
                        <input type="button" value="취소" onclick="location.href='myPage.jsp'"
                                style="padding: 10px 15px; background-color: #f44336; color: white; border: none; cursor: pointer;">
                    </div>
                    
                </form>
            </div>
        </div>
        
        <script>
            document.memberUpdateForm.onsubmit = function() {
                const newPwd = document.memberUpdateForm.newPwd.value;
                const currentPwd = document.memberUpdateForm.currentPwd.value;
                
                if (currentPwd.length === 0) {
                    alert('정보 수정을 위해 현재 비밀번호를 입력해야 합니다.');
                    return false;
                }
        
              
                return true; 
            };
        </script>
		</main>
	
	<%@include file="footer.jsp" %>
</body>
</html>