<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/groupcheck.css">
<style>
body {
		background:#FAF7F9;
		display: flex;
		padding-left: 0px;
		padding-right: 0px;
		justify-content: center;
}
</style>

</head>
<body>

	<div id="groupCheckDiv">
		<form name="group" action="groupcheck_ok.jsp">
			<h2 style="text-align:center; color: rgb(109, 16, 68)">그룹명 중복확인</h2>
			<div>
				<input type="text" name="g_name" maxlength="20" id="findgroup">
				<input type="submit" value="중복확인" id="groupbtn">
			</div>
			
		</form>
	</div>

</body>

</html>