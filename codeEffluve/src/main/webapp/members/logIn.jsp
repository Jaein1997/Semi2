<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 팝업 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	div {
		display:flex;
		flex-direction: column;
		justify-content: center;
	}
	table {
		margin: 0 auto;
	}
	input[type="submit"] {
		display:block;
		margin: 0 auto;
	}
</style>
</head>
<body>
	<div style = "border:2px solid gray; width:350px; height:250px;">
        <h2 style="text-align:center;">로 그 인</h2>
    
    	<form name="logIn" action="logIn_ok.jsp">
    		<table>
					<tr>
						<th>ID</th>
						<%
						String id = "";
						Cookie cks[] = request.getCookies();
						if(cks!=null) {
							for(Cookie temp:cks) {
								if(temp.getName().equals("savedID")) {
									id = temp.getValue();
								}
							}
						}
						%>
						<td><input type="text" name="id" value="<%=id%>"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="pwd"></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="rememberID" value="remem" <%= id.length()>0?"checked":"" %>>아이디 저장</td>
					</tr>
			</table>
    		
    		<br>
    		<input type="submit" value="로그인">
    	
    	</form>
    </div>
</body>
</html>