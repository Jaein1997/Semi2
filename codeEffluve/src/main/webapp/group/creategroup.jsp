<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/creategroup.css">
</head>
<%
String m_idx=request.getParameter("m_idx");
%>
<body>
	<form name="creategroup" action="creategroup_ok.jsp"method = "post" enctype = "multipart/form-data">
		<div id="createGroupDiv">
			<h2 style="text-align:center; color: rgb(109, 16, 68);">그룹 정보 입력</h2>
			<input type="hidden" name="m_idx" value="<%=m_idx%>">
			
			<table>
				<tr>
					<td><img src="/codeEffluve/img/groupIcon.png" alt="그룹"><input type="text" name="g_name" placeholder="그룹이름" required readonly><input type="button" value="중복확인" id="groupcheck"></td>
				</tr>
				<tr>
					<td>
						<img src="/codeEffluve/img/pencil.png" alt="그룹"><input type="text" name="g_memo" placeholder="한줄소개" required>
					</td>
				</tr>
				<tr>
					<td>
					<span>그룹 프로필</span>
					<input type="file" name="g_profile"><br>
					</td>
				</tr>
				<tr>
					<td>
						<span>공개 여부</span>
						<input type="radio" name="approval" value="t">공개
						<input type="radio" name="approval" value="f" checked>비공개
						
					</td>
				</tr>
			</table>
			<div style="margin-top:30px;">
				<input type="submit" value="그룹만들기">
				<input type="reset" value="초기화">
			</div>
			
		
		</div>
	</form>

</body>
<script>
	var back=document.getElementById('groupcheck');
	back.onclick=function(){
		window.open('groupcheck.jsp','groupCheck','width=500,height=200,top=150px,left=700px');	
	};
</script>
</html>