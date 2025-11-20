<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복확인</title>
</head>

<body>
	<form name="findID" action="idCheck_ok.jsp">
		<fieldset>
			<legend>ID 중복확인</legend>
			<label>ID</label>
			<input type="text" name="findid" size="45">
			<input type="submit" value="중복확인" id="idbtn">
		</fieldset>
	</form>
</body>

</html>