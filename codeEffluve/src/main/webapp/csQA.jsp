<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 (FAQ)</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
</head>
<body>
    <%@include file="/header.jsp" %>
    <main>
        <section>
            <h1 style="text-align: center; margin-bottom: 30px;">자주 묻는 질문 (FAQ) 💡</h1>
            <!-- <p style="text-align: center; color: #555;">궁금한 점을 빠르고 정확하게 해결하세요.</p> -->
            
			<div class="csQA">
				<div class="sub-menu">
						<a href="/codeEffluve/cs.jsp">고객센터</a>
						<a href="/codeEffluve/csQA.jsp" class="selectedSubmenu">자주 묻는 질문 (FAQ)</a>
						<a href="/codeEffluve/csProblem.jsp">불편사항 접수</a>
				</div>
	            <div class="cs-main-content">
	                <div class="faq-item">
	                    <div class="question">
	                        <span>Q1. 회원 가입은 어떻게 하나요?</span>
	                        <span class="toggle-icon">+</span>
	                    </div>
	                    <div class="answer">
	                        <p>A. 상단 메뉴의 '로그인' > '회원가입' 버튼을 통해 간단한 정보 입력 후 가입할 수 있습니다.</p>
	                    </div>
	                </div>
	
	               
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