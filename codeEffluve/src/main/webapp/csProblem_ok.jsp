<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.codeEffluve.cs.CsDAO" %>
<%
    // 0. 인코딩 및 파라미터 설정
    request.setCharacterEncoding("UTF-8");
    
    String msg = "";

    String writerId = request.getParameter("writerId");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String category = request.getParameter("category"); // ⚠️ 이 값은 DB에 저장되지 않습니다!

    // 필수 항목 체크
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
        // 1. DAO 호출: singo 테이블에 맞게 ID, 제목, 내용을 전달
        result = dao.insertProblem(writerId, title, content); 
        
    } catch (Exception e) {
        e.printStackTrace();
        msg = "서버 오류로 인해 접수에 실패했습니다. 잠시 후 다시 시도해 주세요.";
    }

    // 2. 결과 처리
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