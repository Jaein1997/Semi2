<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
    
    .sub-menu {
        width: 1000px; 
        margin: 0 auto;
        padding-top: 10px;
        display: flex; 
        justify-content: flex-start;
    }
    .sub-menu table {
        border-collapse: collapse;
        width: 250px; 
    }
    .sub-menu td {
        border: 1px solid #000;
        padding: 10px 15px;
        text-align: left;
    
        cursor: pointer; 
        transition: background-color 0.2s;
    }
    
    .sub-menu a {
        text-decoration: none;
        color: #000;
        display: block; 
        font-weight: 600; 
    }

  
    .sub-menu td:hover,
    .sub-menu a:hover td { 
        background-color: #E0E7FF; 
    }
    
   
    .cs-main-content {
        width: 700px; 
        padding: 20px 40px;
        margin-left: 50px; 
        border-left: 1px solid #ddd; 
    }
    .cs-main-content h3 {
        color: #333;
        font-size: 1.8em;
        margin-top: 0;
        border-bottom: 2px solid #5C6BC0; 
        padding-bottom: 10px;
    }
    .cs-main-content p {
        color: #555;
        line-height: 1.6;
        margin-bottom: 20px;
    }
    .contact-info {
        background-color: #f9f9f9;
        padding: 15px;
        border-radius: 8px;
        border: 1px dashed #ccc;
    }

</style>
</head>
<body>
    
    <%@include file="/header.jsp" %>
    
    <main>
        <section>
            
            <h1 style="text-align: center; margin-bottom: 30px; color: #5C6BC0;">고객센터 (Customer Service) 💬</h1>
            
            <div class="sub-menu">
                
                <table>
                    <tr>
                        <td>
                            <a href="csQA.jsp">자주 묻는 질문 (FAQ)</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="csProblem.jsp">불편사항 접수</a>
                        </td>
                    </tr>
                </table>
               
                <div class="cs-main-content">
                    <h3>무엇을 도와드릴까요?</h3>
                    <p>
                        **life effluve**를 이용해 주셔서 감사합니다. 서비스 이용 중 궁금한 점이나 불편한 점이 있으시면 언제든지 문의해 주세요.
                    </p>
                    
                    <h4>✨ 빠른 문제 해결</h4>
                    <p>
                        가장 먼저 **[자주 묻는 질문(FAQ)]**을 확인하시면 궁금증을 빠르게 해소할 수 있습니다. 이미 답변이 등록되어 있을 수 있습니다.
                    </p>
                    
                    <h4>🚨 시스템 오류 및 개선 제안</h4>
                    <p>
                        사용 중 버그를 발견하거나 서비스 개선을 위한 좋은 아이디어가 있다면 **[불편사항 접수]**를 통해 상세 내용을 알려주세요. 확인 후 신속하게 처리하겠습니다.
                    </p>

                    <div class="contact-info">
                        <strong>📞 운영 시간 안내</strong><br>
                        이메일 문의: support@effluve.com<br>
                        운영 시간: 평일 10:00 ~ 18:00 (주말 및 공휴일 휴무)
                    </div>
                </div>
                
            </div>
            
            
        </section>
    </main>
    
    <%@include file="/footer.jsp" %>
    
</body>
</html>