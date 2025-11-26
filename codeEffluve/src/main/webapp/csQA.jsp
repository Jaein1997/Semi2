<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.admin.*" %> <%-- qadelDAO와 qadelDTO를 사용하기 위해 임포트 --%>
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
  
    .faq-item.active .answer { max-height: 200px; padding: 15px; } 
</style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <main>
        <section>
            <h1>자주 묻는 질문 (FAQ) 💡</h1>
            <p style="text-align: center; color: #555;">궁금한 점을 빠르고 정확하게 해결하세요.</p>
            
            <div class="qa-container">
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
                            <div class="faq-item">
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