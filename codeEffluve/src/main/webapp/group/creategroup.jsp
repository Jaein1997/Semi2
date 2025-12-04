<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
fieldset{
	border-radius: 10px;
	border: 1px solid #6D1044;
}
fieldset input[type=button],fieldset input[type=submit],fieldset input[type=reset]{
	height: 25px;
	box-sizing: border-box;
	background-color: #6D1044;
	color: white;
	border: 0px;
	cursor: pointer;
	margin: 1px 1px 1px 1px;
}
fieldset input[type=file]{
	height: 25px;
	background-color: #6D1044;
	color: white;
	border: 0px;
	cursor: pointer;
	width: 170px;
}
fieldset input,textarea{
	border-radius: 8px;
	border: 1px solid #6D1044;
}
fieldset textarea{
	width:330px;
	height:50px;
}


</style>
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