<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.codeEffluve.groups.GroupsDTO" %>
<%@ page import="com.codeEffluve.groups.GroupsDAO" %>

<%
request.setCharacterEncoding("UTF-8");

String SAVE_DIR ="groupProfiles";
String applicationPath = application.getRealPath("/");
String savePath = applicationPath + SAVE_DIR;
int maxSize = 10 * 1024 * 1024;

MultipartRequest multi = null;

try {
	multi = new MultipartRequest(
			request,
			savePath,
			maxSize,
			"UTF-8",
			new DefaultFileRenamePolicy()
			);
			
	GroupsDTO dto = new GroupsDTO();
	dto.setG_idx(Integer.parseInt(multi.getParameter("g_idx")));
	dto.setM_idx(Integer.parseInt(multi.getParameter("m_idx")));
	dto.setG_name(multi.getParameter("g_name"));
	dto.setApproval(multi.getParameter("approval"));
	if(multi.getParameter("g_memo")==null || multi.getParameter("g_memo").equals("")) {
		dto.setG_memo("-");
	} else {
		dto.setG_memo(multi.getParameter("g_memo"));
	}
	
	
	//파일명
	String uploadFile = multi.getFilesystemName("g_profile");
	GroupsDAO dao = new GroupsDAO();
	GroupsDTO origin = dao.selectedGroup(Integer.parseInt(multi.getParameter("g_idx")));

	if (uploadFile == null) {
	    uploadFile = origin.getG_profile();
	}
	dto.setG_profile(uploadFile);
	
	int result = dao.updateGroup(dto);
	
	if(result > 0) {
%>
<script>
	alert("그룹 수정 완료!");
	opener.location.reload();
	window.self.close()
</script>
<%		
	} else {
%>
<script>
	alert("그룹 수정 실패!");
	opener.location.reload();
	window.self.close()
</script>	
<%
}

} catch(Exception e) {
	e.printStackTrace();
%>
<script>
	alert("파일 업로드 중 오류 발생");
	window.location.reload();
</script>	
<%
}
%>