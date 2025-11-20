<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Life Effluve - 내 정보 조회</title> 
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
</head>
<body>
    
   
    <%@include file="header.jsp" %>
	
	<main>
		<div class="main_content_area" style="width: 800px; margin: 30px auto; display: flex; justify-content: space-between;">
        
            <div class="profile_image_area" style="width: 250px; height: 250px; border: 1px solid #ddd; display: flex; align-items: center; justify-content: center; overflow: hidden; background-color: #f7f7f7;">
                
                <img src="uploads/profile/${member.mProfile}" alt="현재 프로필" style="width: 100%; height: 100%; object-fit: cover; display: none;"> 
                <span style="color: #666; font-size: 1.2em;">프로필 사진</span>
            </div>
        
            <div class="member_info_container" style="width: 500px;">
                
             
                <form name="memberViewForm" action="#" method="post">
                
                    <table style="width: 100%; margin-top: 20px; border-collapse: collapse;">
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">아이디</th>
                            <td style="border: 1px solid #ccc; background-color: #eee; padding: 5px 10px;">
                                <input type="text" name="id" value="${member.id}" readonly style="width: 90%; border: none; background-color: transparent;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">이름</th>
                            <td style="border: 1px solid #ccc; background-color: #eee; padding: 5px 10px;">
                                <input type="text" name="m_name" value="${member.mName}" readonly style="width: 90%; border: none; background-color: transparent;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">비밀번호</th>
                            <td style="border: 1px solid #ccc; background-color: #eee; padding: 5px 10px;">
                                <span style="color: #666;">미표시</span>
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">성별</th>
                            <td style="border: 1px solid #ccc; background-color: #eee; padding: 5px 10px;">
                                <span style="color: #666;">${member.sex}</span> 
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">생년월일</th>
                            <td style="border: 1px solid #ccc; background-color: #eee; padding: 5px 10px;">
                                
                                <input type="text" name="birthday" value="${member.birthday}" readonly style="width: 90%; border: none; background-color: transparent;">
                            </td>
                        </tr>
                        <tr style="height: 40px;">
                            <th style="width: 100px; text-align: left; padding: 5px 0;">연락처</th>
                            <td style="border: 1px solid #ccc; background-color: #eee; padding: 5px 10px;">
                                <input type="text" name="tel" value="${member.tel}" readonly style="width: 90%; border: none; background-color: transparent;">
                            </td>
                        </tr>
                   
                    </table>
                    
                    <div style="text-align: right; margin-top: 20px;">
                        
                       
                        <input type="button" value="수정하기" onclick="location.href='myPageEdit.jsp'"
                                style="padding: 10px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
                        
                        <input type="button" value="탈퇴하기" onclick="location.href='deleteAccount.jsp'"
                                style="padding: 10px 15px; background-color: #f44336; color: white; border: none; cursor: pointer;">
                    </div>
                    
                </form>
            </div>
        </div>
		</main>
	
	<%@include file="footer.jsp" %>
</body>
</html>