<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.admin.*" %> 
<%@ page import="java.util.*" %>

<jsp:useBean id="qdao" class="com.codeEffluve.admin.qadelDAO" scope="page" /> 
<%
    Object loginCheck = session.getAttribute("sid"); 
    
    if (loginCheck == null) {
        String loginUrl = "/codeEffluve/members/logIn.jsp"; 
        
        out.println("<script>");
        out.println("  alert('로그인이 필요한 서비스입니다.');");
        out.println("  window.open('" + loginUrl + "', 'loginWin', 'width=450,height=350,scrollbars=no');");
        out.println("</script>");
        
        return; 
    }
%>
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
            
            <div class="csQA">
                <div class="sub-menu">
                    <a href="/codeEffluve/cs.jsp">고객센터</a>
                    <a href="/codeEffluve/csQA.jsp" class="selectedSubmenu">자주 묻는 질문 (FAQ)</a>
                    <a href="/codeEffluve/csProblem.jsp">불편사항 접수</a>
                </div>
                <div class="cs-main-content">
                    <%
                      
                        ArrayList<qadelDTO> faqList = qdao.getQAList();
                        
                        if(faqList == null || faqList.isEmpty()){
                    %>
                            <p style="text-align: center;">등록된 FAQ가 없습니다.</p>
                    <%
                        } else {
                            int qNum = 1;
                            for(qadelDTO dto : faqList){
                    %>
                                <div class="faq-item" data-qid="<%=dto.getQ_idx()%>"> 
                                    <div class="question">
                                        <span>Q<%=qNum++%>. <%=dto.getQ()%></span>
                                        <span class="toggle-icon">+</span>
                                    </div>
                                    <div class="answer">
                                        <p>A. <%=dto.getA()%></p>
                                    </div>
                                </div>
                    <%
                            }
                        }
                    %>
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
                
                const q_idx = faqItem.dataset.qid;

              
                if (faqItem.classList.contains('active')) {
                    incrementViewCount(q_idx); 
                }
            });
        });
        
     
        function incrementViewCount(q_idx) {
        
            if (!q_idx) return; 

            const xhr = new XMLHttpRequest();
           
            xhr.open('POST', '/codeEffluve/admin/viewCountUpdate.jsp', true); 
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            
            xhr.send('q_idx=' + q_idx);

            
        }
    </script>
</body>
</html>