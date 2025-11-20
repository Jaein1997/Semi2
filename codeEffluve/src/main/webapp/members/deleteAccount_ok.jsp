<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.codeEffluve.members.MembersDTO" %>
<%@ page import="com.codeEffluve.members.MembersDAO" %>
<%@ page import="com.codeEffluve.javasecur.JavaDataSecurModule" %>

<%
request.setCharacterEncoding("UTF-8");


String msg = "회원 탈퇴 처리 실패";
MembersDAO dao = MembersDAO.getInstance();


MembersDTO loginMember = (MembersDTO) session.getAttribute("loginMember");

if (loginMember == null) {
   
    response.setContentType("text/html; charset=UTF-8");
    out.println("<script>alert('로그인 세션이 만료되었습니다. 다시 로그인해 주세요.'); location.href='/codeEffluve/index.jsp';</script>");
    return;
}


int mIdx = loginMember.getM_idx();

String currentPwd = request.getParameter("pwd"); 

if (currentPwd == null || currentPwd.isEmpty()) {
    msg = "비밀번호를 입력해 주세요.";
    response.setContentType("text/html; charset=UTF-8");
    out.println("<script>alert('" + msg + "'); history.back();</script>");
    return;
}


String encryptedPwd = JavaDataSecurModule.getSHA256(currentPwd);


boolean isAuthenticated = dao.checkPassword(mIdx, encryptedPwd); 

if (isAuthenticated) {
    try {
       
        int result = dao.deleteMember(mIdx); 

        if (result > 0) {
            
            session.invalidate(); 
            msg = "회원 탈퇴가 완료되었습니다. 이용해 주셔서 감사합니다.";
            
            
            response.setContentType("text/html; charset=UTF-8");
            out.println("<script>alert('" + msg + "'); location.href='/codeEffluve/index.jsp';</script>");
            return;
        } else {
            
            msg = "회원 탈퇴 처리 중 DB 오류가 발생했습니다.";
        }
    } catch (Exception e) {
        e.printStackTrace();
        msg = "서버 처리 중 예기치 않은 오류가 발생했습니다.";
    }
} else {
   
    msg = "비밀번호가 일치하지 않습니다. 다시 확인해주세요.";
}


response.setContentType("text/html; charset=UTF-8");
out.println("<script>alert('" + msg + "'); history.back();</script>");
%>