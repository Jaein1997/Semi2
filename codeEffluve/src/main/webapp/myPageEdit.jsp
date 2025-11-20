<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve - 내 정보 수정</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
    
    .profile_section {
        width: 250px; 
        margin-right: 30px;
        display: flex;
        flex-direction: column; 
        align-items: center; 
        gap: 10px; 
    }

    .profile_image_display_area {
        width: 250px;
        height: 250px;
        border: 1px solid #ddd;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        background-color: #f7f7f7;
        box-sizing: border-box; 
    }

   
    .profile_image_display_area img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    
    .profile_image_display_area .placeholder_text {
        color: #666;
        font-size: 1.2em;
        text-align: center;
    }

  
    .upload_photo_button {
        width: 100%; 
        padding: 10px 15px;
        background-color: #007BFF;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 5px;
        font-size: 1em;
        box-sizing: border-box;
    }
</style>
</head>
<body>
    <%@include file="header.jsp" %>
	
	<main>
		<div class="main_content_area" style="width: 800px; margin: 30px auto; display: flex; justify-content: space-between;">
        
            <div class="profile_section">
                <div class="profile_image_display_area">
                    <img id="currentProfileImage" src="" alt="현재 프로필" style="display: none;"> 
                    <span id="profilePlaceholder" class="placeholder_text">프로필사진</span>
                </div>
                <input type="file" name="m_profile_upload" id="m_profile_upload_hidden" style="display: none;">
                <input type="button" value="사진 업로드" id="uploadPhotoButton" class="upload_photo_button">
                <input type="hidden" name="old_m_profile" value="${editMember.mProfile}">
            </div>
            
        
            <div class="member_info_container" style="width: 500px;">
                
                <form name="memberUpdateForm" action="privateUpdate.do" method="post" enctype="multipart/form-data">
                
                    <table style="width: 100%; margin-top: 20px; border-collapse: collapse;">
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">아이디</th>
                            <td style="border: 1px solid #ccc; background-color: #eee; padding: 5px 10px;">
                                <input type="text" name="id" value="${editMember.id}" readonly style="width: 90%; border: none; background-color: transparent;">
                                <input type="hidden" name="mIdx" value="${editMember.mIdx}">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">이름</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="text" name="m_name" value="${editMember.mName}" required style="width: 90%; border: none;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">현재 비밀번호</th>
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
                            <th style="width: 100px; text-align: left; padding: 5px 0;">성별</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <label><input type="radio" name="sex" value="남" ${editMember.sex eq '남' ? 'checked' : ''}> 남</label>
                                <label><input type="radio" name="sex" value="여" ${editMember.sex eq '여' ? 'checked' : ''}> 여</label>
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">생년월일</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="date" name="birthday" value="${editMember.birthday}" required style="width: 90%; border: none;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">연락처</th>
                            <td style="border: 1px solid #ccc; padding: 5px 10px;">
                                <input type="text" name="tel" value="${editMember.tel}" style="width: 90%; border: none;">
                            </td>
                        </tr>
                        
                   
                        </table>
                    
                    <div style="text-align: right; margin-top: 20px;">
                        
                        <input type="button" value="수정 완료" 
                               onclick="location.href='myPageEdit_ok.jsp';" 
                               style="padding: 10px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
                        
                        <input type="button" value="취소" onclick="location.href='myPage.jsp'"
                                style="padding: 10px 15px; background-color: #f44336; color: white; border: none; cursor: pointer;">
                    </div>
                    
                </form>
            </div>
        </div>
        
        <script>
         
            window.onload = function() {
                const currentProfileImage = document.getElementById('currentProfileImage');
                const profilePlaceholder = document.getElementById('profilePlaceholder');
                const oldProfileFileName = document.memberUpdateForm.old_m_profile.value; 
               
              // 실제 이미지가 있다면 표시, 없다면 placeholder 표시
                if (oldProfileFileName && oldProfileFileName !== "null" && oldProfileFileName !== "") {
                    currentProfileImage.src = 'uploads/profile/' + oldProfileFileName;
                    currentProfileImage.style.display = 'block';
                    profilePlaceholder.style.display = 'none';
                } else {
                    currentProfileImage.style.display = 'none';
                    profilePlaceholder.style.display = 'flex'; 
                }

              
                document.getElementById('uploadPhotoButton').onclick = function() {
                    document.getElementById('m_profile_upload_hidden').click();
                };
                
            
                document.getElementById('m_profile_upload_hidden').onchange = function() {
                    const fileInput = this;
                    
                    if (fileInput.files.length > 0) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            currentProfileImage.src = e.target.result;
                            currentProfileImage.style.display = 'block';
                            profilePlaceholder.style.display = 'none';
                        }
                        reader.readAsDataURL(fileInput.files[0]);
                    } else {
                     
                        if (oldProfileFileName && oldProfileFileName !== "null" && oldProfileFileName !== "") {
                             currentProfileImage.src = 'uploads/profile/' + oldProfileFileName;
                             currentProfileImage.style.display = 'block';
                             profilePlaceholder.style.display = 'none';
                        } else {
                            currentProfileImage.style.display = 'none';
                            profilePlaceholder.style.display = 'flex';
                        }
                    }
                };

              
                document.memberUpdateForm.onsubmit = function() {
                    const currentPwd = document.memberUpdateForm.currentPwd.value;
                    
                    if (currentPwd.length === 0) {
                        alert('정보 수정을 위해 현재 비밀번호를 입력해야 합니다.');
                        return false;
                    }
                    
                   
                    return false; 
                };
            }; 
        </script>
		</main>
	
	<%@include file="footer.jsp" %>
</body>
</html>
