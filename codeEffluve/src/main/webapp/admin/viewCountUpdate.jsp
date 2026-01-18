<%-- /codeEffluve/admin/viewCountUpdate.jsp --%>
<%@ page language="java" contentType="text/plain; charset=UTF-8" %>
<%@ page import="com.codeEffluve.admin.qadelDAO" %> 
<%@ page import="java.lang.NumberFormatException" %>

<%
 
    String q_idxStr = request.getParameter("q_idx");
    
    if (q_idxStr == null) {
        response.setStatus(400); 
        out.print("ERROR: No q_idx parameter.");
        return;
    }
    
    int q_idx;
    try {
        q_idx = Integer.parseInt(q_idxStr);
    } catch (NumberFormatException e) {
        response.setStatus(400); 
        out.print("ERROR: Invalid q_idx format.");
        return;
    }
    
   
    qadelDAO dao = new qadelDAO();
    int result = dao.updateViewCount(q_idx);

   
    if (result > 0) {
        out.print("SUCCESS");
    } else {
        response.setStatus(500); 
        out.print("ERROR: DB update failed.");
    }
%>