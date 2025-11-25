<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="group" action="groupcheck_ok.jsp">
	<fieldset>
	<legend>그룹명 중복확인</legend>
		<table>
			<tr>
				<th>그룹명:</th>
					<td><input type="text" name="g_name"></td>
					<td><input type="submit" value="중복검사"></td>
			</tr>
		</table>
	</fieldset>
</form>

</body>

</html>