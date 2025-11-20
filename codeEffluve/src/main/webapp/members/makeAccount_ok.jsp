<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
    
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mdto" class="com.codeEffluve.members.MembersDTO"></jsp:useBean>
<jsp:useBean id="mdao" class="com.codeEffluve.members.MembersDAO"></jsp:useBean>

<%
	String savePath1 = request.getRealPath("/");
	String savePath = savePath1+"membersProfiles";  // 저장 경로
	System.out.println(savePath);
	int size = 10 * 1024 * 1024;                 // 10MB
	
	MultipartRequest mr = new MultipartRequest(
	    request,
	    savePath,
	    size,
	    "UTF-8",
	    new DefaultFileRenamePolicy()
	);
	
	mdto.setId( mr.getParameter("id") );
	mdto.setPwd( mr.getParameter("pwd") );
	mdto.setM_name( mr.getParameter("m_name") );
	mdto.setSex( mr.getParameter("sex") );
	Date birthday = Date.valueOf(mr.getParameter("birthday"));
	mdto.setBirthday(birthday);
	mdto.setTel(mr.getParameter("tel"));
	if(mr.getFilesystemName("m_profile")==null) {
		mdto.setM_profile("basic.jpg");
	} else {
		mdto.setM_profile( mr.getFilesystemName("m_profile") );
	}
	
	System.out.println(mdto.getId()+mdto.getPwd()+mdto.getM_name()+mdto.getSex()+mdto.getBirthday()+mdto.getTel()+mdto.getM_profile());
	int count = mdao.makeAccount(mdto);
	String msg = count>0?"회원가입 완료":"오류:회원가입 실패";
%>

<script>
	window.alert('<%=msg%>');
	location.href='/codeEffluve/index.jsp';
</script>
