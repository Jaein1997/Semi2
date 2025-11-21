<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 팝업 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
	body {
		background:white;
		display: flex;
		padding-left: 0px;
		padding-right: 0px;
		justify-content: center;
	}
</style>
</head>
<body>
	<div id="loginDiv">
        <h2 style="text-align:center; color: rgb(109, 16, 68)">로 그 인</h2>
    
    	<form name="logIn" action="logIn_ok.jsp">
    		<table id="loginTable">
					<tr>
						
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
						<td><input type="text" name="id" value="<%=id%>" placeholder="아이디" required></td>
					</tr>
					<tr>
						<td><input type="password" name="pwd" placeholder="비밀번호" required></td>
					</tr>
			</table>
					<input type="checkbox" name="rememberID" value="remem" <%= id.length()>0?"checked":"" %>>아이디 저장
			
    		
    		<br>
    		<input type="submit" value="로그인">
    	
    	</form>
    </div>
</body>
</html>