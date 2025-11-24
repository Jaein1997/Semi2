<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>그룹 생성</h2>
<form action="creategroup_ok.jsp">
<fieldset>
<legend>그룹정보입력</legend>
<label>그룹이름</label>
<input type="text" name="g_name" readonly><input type="button" id="groupcheck" value="중복검사"><br>
<label>그룹프로필</label>
<input type="file"><br>
<input type="submit" value="등록하기">
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