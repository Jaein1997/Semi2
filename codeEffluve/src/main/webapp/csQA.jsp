<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 (FAQ)</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
  
    .sub-menu {
        width: 1000px; 
        margin: 0 auto;
        padding-top: 10px;
    }
    .sub-menu table {
        border-collapse: collapse;
        width: 250px; 
    }
    .sub-menu td {
        border: 1px solid #000;
        padding: 8px 10px;
        text-align: left;
    }
    .current-menu {
        background-color: #FFFF99; 
    }
    .sub-menu a {
        text-decoration: none;
        color: #000;
        display: block; 
    }
    .sub-menu a:hover td {
        background-color: #f0f0f0; 
    }
    
   
    .qa-container { width: 800px; margin: 30px auto; }
    .faq-item { margin-bottom: 10px; border: 1px solid #ddd; border-radius: 5px; overflow: hidden; }
    .question { background-color: #f7f7f7; padding: 15px; cursor: pointer; font-weight: bold; display: flex; justify-content: space-between; align-items: center; transition: background-color 0.3s; }
    .question:hover { background-color: #eee; }
    .answer { background-color: #fff; padding: 0 15px; max-height: 0; overflow: hidden; transition: max-height 0.4s ease-out, padding 0.4s ease-out; }
    .answer p { padding: 15px 0; margin: 0; border-top: 1px solid #eee; }
    .toggle-icon { font-size: 1.2em; transition: transform 0.4s; }
    .faq-item.active .toggle-icon { transform: rotate(45deg); }
    .faq-item.active .answer { max-height: 200px; padding: 0 15px; }
</style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <main>
        <section>
            <h1>자주 묻는 질문 (FAQ) 💡</h1>
            <p style="text-align: center; color: #555;">궁금한 점을 빠르고 정확하게 해결하세요.</p>
            
        
            
            <div class="qa-container">
                
                <%-- FAQ 항목 1 --%>
                <div class="faq-item">
                    <div class="question">
                        <span>Q1. 회원 가입은 어떻게 하나요?</span>
                        <span class="toggle-icon">+</span>
                    </div>
                    <div class="answer">
                        <p>A. 상단 메뉴의 '로그인' > '회원가입' 버튼을 통해 간단한 정보 입력 후 가입할 수 있습니다.</p>
                    </div>
                </div>

                <%-- FAQ 항목 2 --%>
                <div class="faq-item">
                    <div class="question">
                        <span>Q2. 일정 공유는 어디까지 가능한가요?</span>
                        <span class="toggle-icon">+</span>
                    </div>
                    <div class="answer">
                        <p>A. '공개 일정', '내 일정', '그룹 일정' 기능을 통해 개인 일정부터 그룹원과의 일정까지 자유롭게 공유 및 관리할 수 있습니다.</p>
                    </div>
                </div>
            </div>
            
        </section>
    </main>
    <%@include file="/footer.jsp" %>

    <script>
        document.querySelectorAll('.question').forEach(item => {
            item.addEventListener('click', event => {
                const faqItem = item.closest('.faq-item');
                faqItem.classList.toggle('active');
            });
        });
    </script>
</body>
</html>