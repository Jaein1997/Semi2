<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/creategroup.css">
</head>
<%
String m_idx=request.getParameter("m_idx");
%>
<body>
<form name="creategroup" action="creategroup_ok.jsp"method = "post" enctype = "multipart/form-data">
<fieldset>
<legend>그룹정보입력</legend>
<input type="hidden" name="m_idx" value="<%=m_idx%>">

<label>그룹이름
<input type="text" name="g_name" readonly><input type="button" id="groupcheck" value="중복검사">
</label><br>

<label>그룹프로필
<input type="file" name="g_profile"><br>
</label>

<label>그룹설명<br>
<textarea name="g_memo"></textarea>
</label><br>

<label>공개여부
<input type="radio" name="approval" value="t">공개
<input type="radio" name="approval" value="f" checked>비공개
</label><br>

<input type="submit" value="그룹만들기">
<input type="reset" value="초기화">

</fieldset>
</form>
<script>
	var back=document.getElementById('groupcheck');
	back.onclick=function(){
		window.open('groupcheck.jsp','groupCheck','width=400, height=300');	
	};
    </script>
</body>
</html>