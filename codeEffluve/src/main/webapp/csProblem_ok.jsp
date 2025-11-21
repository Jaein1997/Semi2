<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.codeEffluve.cs.CsDAO" %>
<%
   
    request.setCharacterEncoding("UTF-8");
    
    String msg = "";

    String writerId = request.getParameter("writerId");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String category = request.getParameter("category"); 

    
    if (writerId == null || writerId.trim().isEmpty() ||
        title == null || title.trim().isEmpty() || 
        content == null || content.trim().isEmpty()) {
        
        msg = "필수 항목(ID, 제목, 내용)을 입력하지 않으셨습니다.";
        response.setContentType("text/html; charset=UTF-8");
        out.println("<script>alert('" + msg + "'); history.back();</script>");
        return;
    }

    CsDAO dao = CsDAO.getInstance();
    int result = 0;
    
    try {
        
        result = dao.insertProblem(writerId, title, content); 
        
    } catch (Exception e) {
        e.printStackTrace();
        msg = "서버 오류로 인해 접수에 실패했습니다. 잠시 후 다시 시도해 주세요.";
    }

   
    response.setContentType("text/html; charset=UTF-8");
    if (result > 0) {
        msg = "불편사항(신고)이 성공적으로 접수되었습니다.";
        out.println("<script>alert('" + msg + "'); location.href='cs.jsp';</script>"); 
    } else {
        if (msg.isEmpty()) {
            msg = "DB 저장 과정에서 오류가 발생했습니다. (ID가 유효한 회원인지 확인 필요)";
        }
        out.println("<script>alert('" + msg + "'); history.back();</script>");
    }
%>