<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gpdao" class="com.codeEffluve.grouping.GroupingDAO"></jsp:useBean>
<%

String g_idx_s=request.getParameter("g_idx");
String m_idx_s=request.getParameter("m_idx");
String join=request.getParameter("join");
String g_leader=request.getParameter("g_leader");

int g_idx=Integer.parseInt(g_idx_s);
int m_idx=Integer.parseInt(m_idx_s);
int result=0;
if(join.equals("가입")){
	result=gpdao.joinmember(m_idx, g_idx);
}else if(join.equals("가입신청")){
	result=gpdao.askjoin(g_idx, m_idx);
}else if(join.equals("수락")){
	result=gpdao.joinmember(m_idx, g_idx);
	gpdao.cancel(m_idx, g_idx);
}else if(join.equals("거절")){
	result=gpdao.cancel(m_idx, g_idx);
}else{
	result=gpdao.goodbyemember(m_idx, g_idx);
}

if(join.equals("수락")||join.equals("거절")){
	%>
	<script>
	window.alert('<%=join%>완료');
	opener.location.reload();
	window.self.close();
	</script>
	<%
}
if(result>0&&join.equals("가입")){
	%>
	<script>
	window.alert('<%=join%>완료');
	opener.location.reload();
	window.self.close();
	</script>
	<%
}else if(result>0&&join.equals("가입신청")){
	%>
	<script>
	window.alert('<%=join%>완료');
	opener.location.reload();
	window.self.close();
	</script>
	<%
}else if(result>0&&join.equals("탈퇴")){
	%>
	<script>
	window.alert('<%=join%>완료');
	window.location.href="../group.jsp";
	</script>
	<%
}else if(result>0&&join.equals("탈퇴처리")){
	%>
	<script>
	window.alert('<%=join%>완료');
	opener.location.reload();
	window.location.href="managemember.jsp?m_idx=<%=g_leader%>&g_idx=<%=g_idx%>";
	</script>
	<%
}else{
	%>
	<script>
	window.alert('처리실패');
	window.location.href="../group.jsp";
	</script>
	<%
}
%>