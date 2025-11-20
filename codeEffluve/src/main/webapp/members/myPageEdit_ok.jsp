<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.Date" %>
<%@ page import="com.codeEffluve.members.MembersDTO" %>
<%@ page import="com.codeEffluve.members.MembersDAO" %>
<%@ page import="com.codeEffluve.javasecur.JavaDataSecurModule" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
request.setCharacterEncoding("UTF-8");


String msg = "회원 정보 수정 실패: 오류 발생";
MembersDAO dao = MembersDAO.getInstance();

MembersDTO loginMember = (MembersDTO) session.getAttribute("loginMember"); 

if (loginMember == null) {
    response.setContentType("text/html; charset=UTF-8");
    out.println("<script>alert('로그인 후 이용해 주세요.'); location.href='/codeEffluve/members/login.jsp';</script>");
    return;
}


String SAVE_DIR = "membersProfiles";
String applicationPath = application.getRealPath("/");
String savePath = applicationPath + SAVE_DIR;
int MAX_POST_SIZE = 10 * 1024 * 1024; 

MultipartRequest multi = null;

try {
    
    multi = new MultipartRequest(
        request, 
        savePath, 
        MAX_POST_SIZE, 
        "UTF-8", 
        new DefaultFileRenamePolicy()
    );

    
    int mIdx = loginMember.getM_idx(); 
    String currentPwd = multi.getParameter("currentPwd");
    String newPwd = multi.getParameter("newPwd");
    String newPwdCheck = multi.getParameter("newPwdCheck");
    
   
    if (newPwd != null && !newPwd.isEmpty() && !newPwd.equals(newPwdCheck)) {
        msg = "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.";
        response.setContentType("text/html; charset=UTF-8");
        out.println("<script>alert('" + msg + "'); history.back();</script>");
        return;
    }

    String encryptedCurrentPwd = JavaDataSecurModule.getSHA256(currentPwd);
    boolean isAuthenticated = dao.checkPassword(mIdx, encryptedCurrentPwd); 

    if (!isAuthenticated) {
        msg = "현재 비밀번호가 일치하지 않아 수정에 실패했습니다.";
        response.setContentType("text/html; charset=UTF-8");
        out.println("<script>alert('" + msg + "'); history.back();</script>");
        return;
    }

  
    MembersDTO dto = new MembersDTO();
    dto.setM_idx(mIdx); 
    

    if (newPwd != null && !newPwd.isEmpty()) {
        String encryptedNewPwd = JavaDataSecurModule.getSHA256(newPwd);
        dto.setPwd(encryptedNewPwd);
    } else {
        dto.setPwd(loginMember.getPwd()); 
    }
    
   
    dto.setM_name(multi.getParameter("m_name"));
    
   
    String sexParam = multi.getParameter("sex");
    if (sexParam == null || sexParam.isEmpty()) {
       
        dto.setSex(loginMember.getSex()); 
    } else {
        dto.setSex(sexParam);
    }
    
    dto.setBirthday(Date.valueOf(multi.getParameter("birthday"))); 
    dto.setTel(multi.getParameter("tel"));
    
    
    String uploadedFile = multi.getFilesystemName("m_profile_upload");
    String finalProfile;
    if (uploadedFile != null) {
        finalProfile = uploadedFile;
    } else {
        finalProfile = loginMember.getM_profile(); 
    }
    dto.setM_profile(finalProfile);

   
    int result = dao.updateMember(dto); 

    if (result > 0) {
       
        MembersDTO updatedMember = dao.getMemberInfo(loginMember.getId());
        session.setAttribute("loginMember", updatedMember);
        
        response.setContentType("text/html; charset=UTF-8");
        out.println("<script>alert('회원 정보 수정 완료'); location.href='myPage.jsp';</script>");
        return; 
    } else {
       
        msg = "DB 업데이트에 실패했습니다.";
    }
    
} catch (Exception e) {
    e.printStackTrace();
    msg = "서버 처리 중 오류 발생: " + e.getMessage();
}


response.setContentType("text/html; charset=UTF-8");
out.println("<script>alert('" + msg + "'); history.back();</script>");
%>