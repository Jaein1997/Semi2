<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
	#profileImg {
		width: 200px;
		height: 200px;
	}
</style>
<script>
	function openCheck() {
		window.open('idCheck.jsp', 'idCheck', 'width=450, height=300');
		
	}
</script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<main>
		<section>
			<h2>회원가입</h2>
			<form name="makeAccount" action="makeAccount_ok.jsp" method="post" enctype="multipart/form-data">
				<img src="http://localhost:9090/codeEffluve/membersProfiles/basic.jpg" alt="basic" id="profileImg">
				<input type="file" name="m_profile">
				<table>
					<tr>
						<th>ID</th>
						<td><input type="text" name="id" readonly></td>
						<td><input type="button" value="중복확인" id="checkbtn"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="pwd"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="m_name"></td>
					</tr>
					<tr>
						<th>성별</th>
						<td><input type="radio" name="sex" value="m" checked>남성<input type="radio" name="sex" value="f">여성</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input type="date" name="birthday"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" name="tel"></td>
					</tr>
					<tr>
						<td colspan="3" align="center">
							<input type="submit" value="가입">
							<input type="button" value="취소" id="backbtn">
						</td>
					</tr>
					
					
				</table>
			</form>
		</section>
	</main>
	
	<%@include file="/footer.jsp" %>
</body>

<script>
	var backbtn = document.getElementById("backbtn");
	backbtn.onclick = function() {
		location.href='/codeEffluve/index.jsp';
	}
	
	var checkbtn = document.getElementById("checkbtn");
	checkbtn.onclick= function() {
		openCheck();
		
	}
</script>
</html>