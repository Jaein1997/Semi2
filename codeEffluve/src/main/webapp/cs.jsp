<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/cs.css"> 
</head>
<body>
    
    <%@include file="/header.jsp" %>

	<main>
		<section>

			<h1 style="text-align: center; margin-block-start: 10px; margin-block-end: 20px;">고객센터 💬</h1>
			<div id="cs">
				<div class="sub-menu">
					<a href="/codeEffluve/cs.jsp" class="selectedSubmenu">고객센터</a>
					<a href="/codeEffluve/csQA.jsp">자주 묻는 질문 (FAQ)</a>
					<a href="/codeEffluve/csProblem.jsp">불편사항 접수</a>
				</div>

				<div class="cs-main-content">
					<h3>무엇을 도와드릴까요?</h3>
					<p>life effluve를 이용해 주셔서 감사합니다. 서비스 이용 중 궁금한 점이나 불편한 점이 있으시면 언제든지 문의해 주세요.</p>
	
					<h4>✨ 빠른 문제 해결</h4>
					<p>가장 먼저 <a href="/codeEffluve/csQA.jsp">[자주 묻는 질문(FAQ)]</a>을 확인하시면 궁금증을 빠르게 해소할 수 있습니다. 이미 답변이 등록되어 있을 수 있습니다.</p>
	
					<h4>🚨 시스템 오류 및 개선 제안</h4>
					<p>사용 중 버그를 발견하거나 서비스 개선을 위한 좋은 아이디어가 있다면 <a href="/codeEffluve/csProblem.jsp">[불편사항 접수]</a>를 통해 상세 내용을 알려주세요. 확인 후 신속하게 처리하겠습니다.</p>
	
					<div class="contact-info">
						<strong>📞 운영 시간 안내</strong>
						<br> 이메일 문의: support@effluve.com<br>
						운영 시간: 평일 10:00 ~ 18:00 (주말 및 공휴일 휴무)
					</div>
				</div>
			
			</div>
			
		</section>
	</main>

	<%@include file="/footer.jsp" %>
    
</body>
</html>